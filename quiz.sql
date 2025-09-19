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
  pontuacao_geral INT NOT NULL DEFAULT 0,
  criadoEm TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY IDX_email (email),
  UNIQUE KEY IDX_apelido (apelido)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS usuarios_pontuacao_log (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  idUsuario INT NOT NULL,
  pontuacao_antiga INT NOT NULL,
  pontuacao_nova INT NOT NULL,
  alterado_por VARCHAR(255),
  data_acao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `idx_idUsuario` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELIMITER //
DROP TRIGGER IF EXISTS log_before_update_pontuacao_usuario //

CREATE TRIGGER log_before_update_pontuacao_usuario
BEFORE UPDATE ON usuarios
FOR EACH ROW
BEGIN
    IF OLD.pontuacao_geral <> NEW.pontuacao_geral THEN
        INSERT INTO usuarios_pontuacao_log (idUsuario, pontuacao_antiga, pontuacao_nova, alterado_por)
        VALUES (OLD.idUsuario, OLD.pontuacao_geral, NEW.pontuacao_geral, USER());
    END IF;
END //
DELIMITER ;

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

DELIMITER //

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

DELIMITER //

DELIMITER //

DROP PROCEDURE IF EXISTS AlterarSenha //
CREATE PROCEDURE AlterarSenha(IN p_idUsuario INT, IN p_novaSenha VARCHAR(255))
BEGIN
    UPDATE usuarios
    SET senha = p_novaSenha
    WHERE idUsuario = p_idUsuario;
END //

DELIMITER //

DELIMITER //

DROP PROCEDURE IF EXISTS MediaPontuacaoPorDisciplina //

CREATE PROCEDURE MediaPontuacaoPorDisciplina()
BEGIN
    SELECT
        d.nome AS disciplina,
        -- Calcula o total de respostas corretas para a disciplina
        COUNT(CASE WHEN ru.correta = 1 THEN 1 END) AS total_acertos,
        -- Conta quantos questionários únicos foram respondidos para a disciplina
        COUNT(DISTINCT r.idResultado) AS total_questionarios_respondidos,
        -- Calcula a média de acertos por questionário respondido. Usa IFNULL para retornar 0 se não houver respostas.
        IFNULL(
            (COUNT(CASE WHEN ru.correta = 1 THEN 1 END) / COUNT(DISTINCT r.idResultado)),
            0
        ) AS media_acertos_por_questionario
    FROM disciplina d
    -- LEFT JOIN para incluir disciplinas mesmo que não tenham questionários ou resultados associados
    LEFT JOIN questionario q ON d.idDisciplina = q.idDisciplina
    LEFT JOIN resultado r ON q.idQuestionario = r.idQuestionario
    LEFT JOIN respostas_usuario ru ON r.idResultado = ru.idResultado
    -- Agrupa os resultados por disciplina para calcular as métricas
    GROUP BY d.idDisciplina, d.nome
    -- Ordena para mostrar as disciplinas com melhor desempenho primeiro
    ORDER BY media_acertos_por_questionario DESC;
END //

DELIMITER ;

CREATE OR REPLACE VIEW ranking AS
SELECT 
    u.idUsuario,
    u.pontuacao_geral,
    RANK() OVER (ORDER BY u.pontuacao_geral DESC) AS posicao
FROM usuarios u ORDER BY posicao LIMIT 10;

DELIMITER //

DROP TRIGGER IF EXISTS after_insert_resultado //

CREATE TRIGGER after_insert_resultado
AFTER INSERT ON resultado
FOR EACH ROW
BEGIN
    DECLARE totalAcertos INT;
    DECLARE totalErros INT;
    DECLARE tempoMedio FLOAT;
    DECLARE tentativas INT;

    SELECT COUNT(*) INTO totalAcertos
    FROM respostas_usuario
    WHERE idUsuario = NEW.idUsuario AND idQuestao IN (
        SELECT idQuestao FROM questoes WHERE idDisciplina = (
            SELECT idDisciplina FROM questionario WHERE idQuestionario = NEW.idQuestionario
        )
    ) AND correta = 1;

    SELECT COUNT(*) INTO totalErros
    FROM respostas_usuario
    WHERE idUsuario = NEW.idUsuario AND idQuestao IN (
        SELECT idQuestao FROM questoes WHERE idDisciplina = (
            SELECT idDisciplina FROM questionario WHERE idQuestionario = NEW.idQuestionario
        )
    ) AND correta = 0;

    SELECT AVG(tempoSegundos) INTO tempoMedio
    FROM resultado
    WHERE idUsuario = NEW.idUsuario AND idQuestionario = NEW.idQuestionario;

    SELECT COUNT(*) INTO tentativas
    FROM resultado
    WHERE idUsuario = NEW.idUsuario AND idQuestionario = NEW.idQuestionario;

    INSERT INTO usuarios_questionarios (idUsuario, idQuestionario, total_acertos, total_erros, tempo_medio_segundos, tentativas)
    VALUES (NEW.idUsuario, NEW.idQuestionario, totalAcertos, totalErros, tempoMedio, tentativas)
    ON DUPLICATE KEY UPDATE
        total_acertos = totalAcertos,
        total_erros = totalErros,
        tempo_medio_segundos = tempoMedio,
        tentativas = tentativas;

    UPDATE usuarios
    SET pontuacao_geral = pontuacao_geral + COALESCE((
        SELECT SUM(correta) FROM respostas_usuario WHERE idResultado = NEW.idResultado
    ), 0)
    WHERE idUsuario = NEW.idUsuario;
END //

DELIMITER ;

DELIMITER //

DROP PROCEDURE IF EXISTS MelhorResultadoUsuarioPorDisciplina //

CREATE PROCEDURE MelhorResultadoUsuarioPorDisciplina(IN p_idUsuario INT)
BEGIN
    -- Utiliza uma CTE (Common Table Expression) para primeiro calcular a pontuação de cada tentativa.
    -- Isso organiza a consulta, tornando-a mais legível.
    WITH PontuacaoPorResultado AS (
        SELECT
            idResultado,
            -- Conta o número de acertos (onde correta = 1) para cada resultado.
            COUNT(CASE WHEN correta = 1 THEN 1 END) AS pontuacao
        FROM respostas_usuario
        GROUP BY idResultado
    )
    -- A consulta principal junta as informações para apresentar o resultado final.
    SELECT
        u.apelido,
        d.nome AS disciplina,
        -- MAX() encontra a maior pontuação entre todas as tentativas do usuário na mesma disciplina.
        MAX(pr.pontuacao) AS maior_pontuacao
    FROM usuarios u
    -- Junta as tabelas para conectar o usuário aos seus resultados, questionários e disciplinas.
    JOIN resultado r ON u.idUsuario = r.idUsuario
    JOIN PontuacaoPorResultado pr ON r.idResultado = pr.idResultado
    JOIN questionario q ON r.idQuestionario = q.idQuestionario
    JOIN disciplina d ON q.idDisciplina = d.idDisciplina
    -- Filtra os resultados para o usuário específico passado como parâmetro.
    WHERE u.idUsuario = p_idUsuario
    -- Agrupa os dados para que a função MAX() funcione por disciplina.
    GROUP BY u.apelido, d.nome
    -- Ordena para mostrar as disciplinas com as maiores pontuações primeiro.
    ORDER BY maior_pontuacao DESC;
END //

DELIMITER ;
    
