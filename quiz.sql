CREATE database if not exists app_db;
use app_db;



CREATE TABLE if not exists curso (
  idCurso INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE if not exists curso_log (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  acao VARCHAR(10) NOT NULL,
  idCurso INT DEFAULT NULL,
  nome VARCHAR(30) DEFAULT NULL,
  data_acao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DELIMITER //
CREATE TRIGGER log_after_insert_curso
AFTER INSERT ON curso
FOR EACH ROW
BEGIN
  INSERT INTO curso_log (acao, idCurso, nome)
  VALUES ('INSERT', NEW.idCurso, NEW.nome);
END //
DELIMITER ;


DROP TRIGGER IF EXISTS log_after_insert_disciplina;
DROP TABLE IF EXISTS disciplina_log;
DROP TABLE IF EXISTS disciplina;

CREATE TABLE disciplina (
  idDisciplina INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  idCurso INT NOT NULL,
  CONSTRAINT FK_disciplina_curso FOREIGN KEY (idCurso) REFERENCES curso (idCurso) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE disciplina_log (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  acao VARCHAR(10) NOT NULL,
  idDisciplina INT DEFAULT NULL,
  nome VARCHAR(50) DEFAULT NULL,
  idCurso INT DEFAULT NULL,
  data_acao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DELIMITER //
CREATE TRIGGER log_after_insert_disciplina
AFTER INSERT ON disciplina
FOR EACH ROW
BEGIN
  INSERT INTO disciplina_log (acao, idDisciplina, nome, idCurso)
  VALUES ('INSERT', NEW.idDisciplina, NEW.nome, NEW.idCurso);
END //
DELIMITER ;


DROP TABLE IF EXISTS questionario;
CREATE TABLE questionario (
  idQuestionario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  idDisciplina INT NOT NULL,
  CONSTRAINT FK_questionario_disciplina FOREIGN KEY (idDisciplina) REFERENCES disciplina (idDisciplina)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS questoes;
CREATE TABLE questoes (
  idQuestao INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  dificuldade ENUM('FACIL','MEDIO','DIFICIL') NOT NULL,
  enunciado VARCHAR(255) NOT NULL,
  idDisciplina INT DEFAULT NULL,
  CONSTRAINT FK_questoes_disciplina FOREIGN KEY (idDisciplina) REFERENCES disciplina (idDisciplina) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
  idUsuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(50) NOT NULL,
  apelido VARCHAR(20) NOT NULL,
  senha VARCHAR(255) NOT NULL,
  admin TINYINT NOT NULL DEFAULT 0,
  pontuacao INT NOT NULL DEFAULT 0,
  criadoEm TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY IDX_email (email),
  UNIQUE KEY IDX_apelido (apelido)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS resultado;
CREATE TABLE resultado (
  idResultado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  tempoSegundos INT NOT NULL DEFAULT 0,
  dataExecucao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  idUsuario INT NOT NULL,
  idQuestionario INT NOT NULL,
  CONSTRAINT FK_resultado_usuario FOREIGN KEY (idUsuario) REFERENCES usuarios (idUsuario) ON DELETE CASCADE,
  CONSTRAINT FK_resultado_questionario FOREIGN KEY (idQuestionario) REFERENCES questionario (idQuestionario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS alternativas;
CREATE TABLE alternativas (
  idAlternativa INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  texto VARCHAR(255) NOT NULL,
  estaCorreta TINYINT NOT NULL DEFAULT 0,
  idQuestao INT NOT NULL,
  CONSTRAINT FK_alternativas_questao FOREIGN KEY (idQuestao) REFERENCES questoes (idQuestao) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS respostas_usuario;
CREATE TABLE respostas_usuario (
  idResposta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  idUsuario INT NOT NULL,
  idQuestao INT NOT NULL,
  idAlternativa INT NOT NULL,
  correta TINYINT NOT NULL DEFAULT 0,
  idResultado INT NOT NULL,
  CONSTRAINT FK_respostas_usuario_idUsuario FOREIGN KEY (idUsuario) REFERENCES usuarios (idUsuario) ON DELETE CASCADE,
  CONSTRAINT FK_respostas_usuario_idQuestao FOREIGN KEY (idQuestao) REFERENCES questoes (idQuestao) ON DELETE CASCADE,
  CONSTRAINT FK_respostas_usuario_idAlternativa FOREIGN KEY (idAlternativa) REFERENCES alternativas (idAlternativa) ON DELETE CASCADE,
  CONSTRAINT FK_respostas_usuario_idResultado FOREIGN KEY (idResultado) REFERENCES resultado (idResultado) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



DELIMITER //

DROP PROCEDURE IF EXISTS HistoricoResultadosUsuario //

CREATE PROCEDURE HistoricoResultadosUsuario(IN p_idUsuario INT)
BEGIN
    SELECT 
        r.dataExecucao AS data,
        COUNT(CASE WHEN ru.correta = 1 THEN 1 END) AS pontuacao,
        r.tempoSegundos AS tempo,
        q.nome AS questionario
    FROM resultado r
    JOIN questionario q ON r.idQuestionario = q.idQuestionario
    LEFT JOIN respostas_usuario ru ON ru.idResultado = r.idResultado
    WHERE r.idUsuario = p_idUsuario
    GROUP BY r.idResultado, r.dataExecucao, r.tempoSegundos, q.nome
    ORDER BY r.dataExecucao DESC;
END //

DELIMITER //

DROP PROCEDURE IF EXISTS TopQuestoesRevisao //
CREATE PROCEDURE TopQuestoesRevisao()
BEGIN
    SELECT 
        q.idQuestao,
        q.enunciado,
        COUNT(ru.idResposta) AS vezes_errada
    FROM questoes q
    JOIN respostas_usuario ru 
        ON q.idQuestao = ru.idQuestao 
       AND ru.correta = 0
    GROUP BY q.idQuestao, q.enunciado
    ORDER BY vezes_errada DESC
    LIMIT 10;
END //

DELIMITER //

DROP PROCEDURE IF EXISTS RegistrarResultQuestionario //
CREATE PROCEDURE RegistrarResultQuestionario(
    IN p_idUsuario INT,
    IN p_idQuestionario INT,
    IN p_tempoSegundos INT,
    IN p_pontuacaoObtida INT
)
BEGIN
    INSERT INTO resultado (tempoSegundos, idUsuario, idQuestionario)
    VALUES (p_tempoSegundos, p_idUsuario, p_idQuestionario);

    UPDATE usuarios
    SET pontuacao = pontuacao + p_pontuacaoObtida
    WHERE idUsuario = p_idUsuario;
END //

DELIMITER ;

DELIMITER //


ALTER TABLE questionario
ADD COLUMN click INT NOT NULL DEFAULT 0;


DROP PROCEDURE IF EXISTS IncrementarClickQuestionario //
CREATE PROCEDURE IncrementarClickQuestionario(IN p_idQuestionario INT)
BEGIN
    UPDATE questionario
    SET click = click + 1
    WHERE idQuestionario = p_idQuestionario;
END //

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS AlterarSenha //
CREATE PROCEDURE AlterarSenha(IN p_idUsuario INT, IN p_novaSenha VARCHAR(255))
BEGIN
    UPDATE usuarios
    SET senha = p_novaSenha
    WHERE idUsuario = p_idUsuario;
END //

DELIMITER ;
