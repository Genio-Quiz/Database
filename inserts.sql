
INSERT INTO curso (nome) VALUES
('Engenharia de Software'),
('Direito'),
('Medicina'),
('Administração'),
('Psicologia'),
('Arquitetura'),
('Educação Física'),
('Ciência da Computação'),
('Design Gráfico'),
('Engenharia Civil');


INSERT INTO disciplina (nome, idCurso) VALUES
('Banco de Dados', 1),
('Programação Web', 1),
('Direito Penal', 2),
('Direito Civil', 2),
('Anatomia Humana', 3),
('Fisiologia', 3),
('Gestão Financeira', 4),
('Psicologia Clínica', 5),
('Estruturas de Dados', 8),
('Inteligência Artificial', 8);


INSERT INTO questionario (nome, idDisciplina) VALUES
('Prova Banco de Dados - Módulo 1', 1),
('Prova Programação Web - Fundamentos', 2),
('Simulado Direito Penal Parte I', 3),
('Simulado Direito Civil Parte II', 4),
('Quiz Anatomia - Sistema Ósseo', 5),
('Quiz Fisiologia - Sistema Nervoso', 6),
('Avaliação Gestão Financeira Básica', 7),
('Estudo de Caso Psicologia Clínica', 8),
('Exercícios Estruturas de Dados', 9),
('Quiz Inteligência Artificial', 10);


INSERT INTO questoes (dificuldade, enunciado, idDisciplina) VALUES

('FACIL', 'O que é uma chave primária?', 1),
('MEDIO', 'Diferença entre chave primária e estrangeira?', 1),
('DIFICIL', 'Explique normalização até 3FN.', 1),
('FACIL', 'O que é SQL?', 1),
('MEDIO', 'Para que serve um índice?', 1),


('FACIL', 'O que significa HTML?', 2),
('MEDIO', 'Explique a diferença entre HTTP e HTTPS.', 2),
('DIFICIL', 'Explique o conceito de REST.', 2),
('FACIL', 'O que é CSS?', 2),
('MEDIO', 'Qual a função do JavaScript no front-end?', 2),


('FACIL', 'O que é crime doloso?', 3),
('MEDIO', 'Quais são os elementos do tipo penal?', 3),
('DIFICIL', 'Explique a teoria finalista da ação.', 3),
('FACIL', 'Defina crime culposo.', 3),
('MEDIO', 'Qual a diferença entre tentativa e consumação?', 3),


('FACIL', 'O que é pessoa natural?', 4),
('MEDIO', 'Diferença entre pessoa física e jurídica.', 4),
('DIFICIL', 'Explique o conceito de capacidade civil.', 4),
('FACIL', 'O que é domicílio civil?', 4),
('MEDIO', 'Qual a diferença entre bens móveis e imóveis?', 4),


('FACIL', 'Quantos ossos possui o corpo humano adulto?', 5),
('MEDIO', 'Qual a função do esqueleto axial?', 5),
('DIFICIL', 'Nome dos ossos do antebraço.', 5),
('FACIL', 'Onde fica o fêmur?', 5),
('MEDIO', 'Diferença entre ossos longos e curtos.', 5),


('FACIL', 'Qual órgão controla os batimentos cardíacos?', 6),
('MEDIO', 'Explique a função do cerebelo.', 6),
('DIFICIL', 'O que é homeostase?', 6),
('FACIL', 'Função dos neurônios motores.', 6),
('MEDIO', 'Explique sinapse elétrica e química.', 6),


('FACIL', 'O que é fluxo de caixa?', 7),
('MEDIO', 'Diferença entre ativo e passivo.', 7),
('DIFICIL', 'Explique o conceito de valor presente líquido (VPL).', 7),
('FACIL', 'O que é capital de giro?', 7),
('MEDIO', 'Qual a diferença entre receita e lucro?', 7),


('FACIL', 'Defina psicologia clínica.', 8),
('MEDIO', 'Explique transferência e contratransferência.', 8),
('DIFICIL', 'Explique o inconsciente segundo Freud.', 8),
('FACIL', 'O que é uma entrevista clínica?', 8),
('MEDIO', 'Explique diagnóstico diferencial.', 8),


('FACIL', 'O que é uma pilha (stack)?', 9),
('MEDIO', 'Complexidade da busca binária.', 9),
('DIFICIL', 'Explique árvores balanceadas.', 9),
('FACIL', 'O que é uma fila (queue)?', 9),
('MEDIO', 'Diferença entre array e lista encadeada.', 9),


('FACIL', 'O que é aprendizado supervisionado?', 10),
('MEDIO', 'Explique aprendizado não supervisionado.', 10),
('DIFICIL', 'Defina redes neurais convolucionais.', 10),
('FACIL', 'O que é regressão linear?', 10),
('MEDIO', 'Explique overfitting em modelos de IA.', 10);


INSERT INTO alternativas (texto, estaCorreta, idQuestao) VALUES

('Identificador único que identifica cada registro na tabela', 1, 1),
('Um campo que aceita valores duplicados', 0, 1),
('Um índice secundário', 0, 1),
('Um campo sempre nulo', 0, 1),


('PK identifica; FK referencia PK de outra tabela', 1, 2),
('PK e FK são sinônimos', 0, 2),
('FK é sempre única, PK não', 0, 2),
('PK é usada só em bancos NoSQL', 0, 2),


('Processo de organizar tabelas para reduzir redundância até 3ª forma normal', 1, 3),
('Técnica de indexação para performance', 0, 3),
('Modelo físico de backup', 0, 3),
('Conjunto de views pré-definidas', 0, 3),


('Linguagem de consulta para gerenciar dados relacionais', 1, 4),
('Sistema operacional para bancos', 0, 4),
('Protocolo de rede', 0, 4),
('Um framework de front-end', 0, 4),


('Acelerar buscas e consultas em colunas indexadas', 1, 5),
('Garantir integridade referencial', 0, 5),
('Armazenar dados em coluna extra', 0, 5),
('Substituir uma tabela', 0, 5),


('Linguagem de marcação para estruturar páginas web', 1, 6),
('Linguagem de programação back-end', 0, 6),
('Banco de dados relacional', 0, 6),
('Sistema de versionamento', 0, 6),


('HTTPS usa TLS/SSL para criptografar tráfego entre cliente e servidor', 1, 7),
('HTTP é a versão criptografada de HTTPS', 0, 7),
('HTTPS não funciona em navegadores', 0, 7),
('HTTP usa sempre porta 443', 0, 7),


('Estilo arquitetural para APIs que usa recursos e verbos HTTP', 1, 8),
('Banco de dados relacional específico', 0, 8),
('Framework de UI', 0, 8),
('Protocolo de transmissão de arquivos', 0, 8),


('Folha de estilos que define aparência de elementos HTML', 1, 9),
('Linguagem de banco de dados', 0, 9),
('Serviço de hospedagem', 0, 9),
('Servidor HTTP', 0, 9),


('Adicionar comportamento dinâmico e manipular o DOM', 1, 10),
('Gerenciar tabelas SQL no cliente', 0, 10),
('Substituir HTML na renderização', 0, 10),
('Compilar código nativo para o navegador', 0, 10),


('Crime praticado com intenção (dolo) de causar o resultado', 1, 11),
('Crime sem intenção, por imprudência', 0, 11),
('Crime que não tem vítima', 0, 11),
('Apenas infração administrativa', 0, 11),


('Conduta, tipicidade, antijuridicidade e culpabilidade', 1, 12),
('Ação, vítima e sentença', 0, 12),
('Prova, réu e defesa', 0, 12),
('Competência, mérito e apelação', 0, 12),


('Concepção que destaca o elemento volitivo do agente na ação', 1, 13),
('Teoria que trata só da pena', 0, 13),
('Modelo de organização judiciária', 0, 13),
('Regra de prescrição de crime', 0, 13),


('Crime ocorrido por imprudência, negligência ou imperícia', 1, 14),
('Crime com intenção deliberada', 0, 14),
('Crime sem lesão a bem jurídico', 0, 14),
('Apenas infração cível', 0, 14),


('Tentativa é quando o crime não se consuma por circunstâncias alheias; consumação é quando o resultado ocorre', 1, 15),
('Tentativa é sempre punida mais que consumação', 0, 15),
('Consumação ocorre antes da ação', 0, 15),
('Não há diferença jurídica entre as duas', 0, 15),


('Pessoa natural é o indivíduo, pessoa física', 1, 16),
('Pessoa natural é uma empresa', 0, 16),
('Pessoa natural é um tipo de contrato', 0, 16),
('Pessoa natural é um bem móvel', 0, 16),


('Pessoa física é indivíduo; pessoa jurídica é entidade legal como empresa', 1, 17),
('Pessoa física é sempre uma empresa', 0, 17),
('Pessoa jurídica não pode ter direitos', 0, 17),
('São termos usados apenas em direito penal', 0, 17),


('Capacidade civil é aptidão para adquirir direitos e contrair obrigações', 1, 18),
('Capacidade civil é o domicílio do indivíduo', 0, 18),
('Capacidade civil é o tipo de imóvel', 0, 18),
('Capacidade civil refere-se a sucessão testamentária apenas', 0, 18),


('Local onde a pessoa estabelece sua residência com ânimo definitivo', 1, 19),
('Endereço da faculdade', 0, 19),
('Lugar onde se guarda bens móveis', 0, 19),
('Sinônimo de nacionalidade', 0, 19),


('Móveis podem ser deslocados; imóveis são fixos ao solo', 1, 20),
('Imóveis sempre são veículos', 0, 20),
('Móveis são sempre consumíveis', 0, 20),
('Imóveis são apenas prédios públicos', 0, 20),


('206 ossos aproximadamente', 1, 21),
('150 ossos', 0, 21),
('300 ossos', 0, 21),
('98 ossos', 0, 21),


('Sustentação e proteção de órgãos vitais como cérebro e coração', 1, 22),
('Produção hormonal', 0, 22),
('Sistema de circulação de sangue', 0, 22),
('Órgãos do sistema digestivo', 0, 22),


('Rádio e ulna', 1, 23),
('Fêmur e tíbia', 0, 23),
('Clavícula e escápula', 0, 23),
('Mandíbula e maxila', 0, 23),


('Na coxa, é o osso mais longo do corpo', 1, 24),
('No antebraço', 0, 24),
('No crânio', 0, 24),
('No pé', 0, 24),


('Longos têm comprimento predominante; curtos são aproximadamente cúbicos', 1, 25),
('Curto significa menor em densidade apenas', 0, 25),
('Longos não sustentam peso', 0, 25),
('Diferença é apenas química', 0, 25),


('Nó sinusal no coração regula batimentos', 1, 26),
('Pulmão controla batimentos', 0, 26),
('Rim controla batimentos', 0, 26),
('Fígado controla batimentos', 0, 26),


('Coordenação motora, postura e equilíbrio', 1, 27),
('Produção de insulina', 0, 27),
('Filtração sanguínea', 0, 27),
('Regulação de glicose apenas', 0, 27),


('Manutenção do ambiente interno estável no organismo', 1, 28),
('Processo de digestão exclusiva', 0, 28),
('Termo de anatomia óssea', 0, 28),
('Apenas regulação hormonal do fígado', 0, 28),


('Transmitir comandos do sistema nervoso central aos músculos', 1, 29),
('Produzir hormônios', 0, 29),
('Armazenar memória de longo prazo', 0, 29),
('Transportar oxigênio no sangue', 0, 29),


('Sinapse elétrica usa gap junctions; sinapse química usa neurotransmissores', 1, 30),
('Ambas são sempre químicas', 0, 30),
('Sinapse elétrica é exclusiva do fígado', 0, 30),
('Sinapse química não envolve receptores', 0, 30),


('Registro sistemático das entradas e saídas de caixa de uma empresa', 1, 31),
('Relatório de RH', 0, 31),
('Documento fiscal apenas', 0, 31),
('Plano de marketing', 0, 31),


('Ativo são bens/recursos; passivo são obrigações/dívidas', 1, 32),
('Ativo é sempre dinheiro em caixa; passivo é lucro', 0, 32),
('Passivo são produtos em estoque apenas', 0, 32),
('Ativo é sinônimo de despesa', 0, 32),


('Métrica que traz fluxos futuros ao valor presente descontando pela taxa', 1, 33),
('Índice de satisfação do cliente', 0, 33),
('Tipo de imposto sobre lucro', 0, 33),
('Formato de arquivo financeiro', 0, 33),


('Recursos necessários para financiar as operações de curto prazo', 1, 34),
('Capital investido em máquinas apenas', 0, 34),
('Capital destinado só a expansão internacional', 0, 34),
('Somente o capital do sócio majoritário', 0, 34),


('Receita é o total de vendas; lucro é o que sobra após custos e despesas', 1, 35),
('Lucro é antes dos impostos; receita é depois', 0, 35),
('Receita é somente vendas à vista', 0, 35),
('Lucro é sempre maior que receita', 0, 35),


('Ramo da psicologia voltado ao diagnóstico e tratamento de transtornos mentais', 1, 36),
('Área que estuda só comportamento organizacional', 0, 36),
('Especialidade médica em ortopedia', 0, 36),
('Ramo que trata apenas de psicopedagogia', 0, 36),


('Transferência é reação do paciente ao terapeuta; contratransferência é do terapeuta ao paciente', 1, 37),
('São técnicas de medicação', 0, 37),
('Termos de avaliação escolar', 0, 37),
('Referem-se apenas a diagnóstico diferencial', 0, 37),


('Parte da mente que contém desejos, memórias e impulsos fora da consciência', 1, 38),
('Sinônimo de consciência plena', 0, 38),
('Termo biológico para cérebro', 0, 38),
('Conceito exclusivo de behaviorismo', 0, 38),


('Entrevista estruturada para obter informações sobre queixa e história do paciente', 1, 39),
('Exame físico completo', 0, 39),
('Procedimento cirúrgico', 0, 39),
('Método de fisioterapia', 0, 39),


('Processo de distinguir entre possíveis causas de sintomas semelhantes', 1, 40),
('Lista de medicações', 0, 40),
('Sinônimo de prescrição', 0, 40),
('Avaliação apenas de sinais vitais', 0, 40),


('Estrutura LIFO (último a entrar, primeiro a sair)', 1, 41),
('Estrutura FIFO', 0, 41),
('Tabela de dispersão', 0, 41),
('Árvore binária', 0, 41),


('O(log n) em um vetor ordenado', 1, 42),
('O(n^2)', 0, 42),
('O(n!)', 0, 42),
('O(1)', 0, 42),


('Árvores que mantêm altura balanceada para operações eficientes (ex: AVL, Red-Black)', 1, 43),
('Árvores sem raízes', 0, 43),
('Tipo de lista ligada', 0, 43),
('Estrutura de filas', 0, 43),


('Estrutura FIFO (primeiro a entrar, primeiro a sair)', 1, 44),
('Estrutura LIFO', 0, 44),
('Tabela hash', 0, 44),
('Grafo direcionado', 0, 44),


('Array tem acesso indexado O(1); lista encadeada tem inserção removendo referência O(1)', 1, 45),
('Array é sempre dinâmico; lista sempre estática', 0, 45),
('Listas encadeadas não usam ponteiros', 0, 45),
('Array não permite leitura', 0, 45),


('Aprendizado usando dados rotulados para treinar modelos', 1, 46),
('Aprendizado sem dados', 0, 46),
('Técnica de compressão de imagens', 0, 46),
('Rede neural que não precisa de treino', 0, 46),


('Descoberta de padrões em dados não rotulados', 1, 47),
('Treinamento com rótulos explícitos', 0, 47),
('Processo de deployment em produção', 0, 47),
('Avaliação de performance apenas', 0, 47),


('Arquitetura para processamento de dados com topologia de grade, ex: imagens', 1, 48),
('Rede que só usa regressão linear', 0, 48),
('Modelo exclusivo de séries temporais', 0, 48),
('Banco de dados para imagens', 0, 48),


('Modelo que estima relação linear entre variáveis dependente e independentes', 1, 49),
('Algoritmo de clustering', 0, 49),
('Rede neural convolucional', 0, 49),
('Técnica de visualização apenas', 0, 49),


('Quando o modelo se ajusta demais aos dados de treino e perde generalização', 1, 50),
('Quando o modelo não aprende nada', 0, 50),
('Situação ideal de generalização', 0, 50),
('Fenômeno exclusivo de regressão linear', 0, 50);


INSERT INTO usuarios (email, apelido, senha, admin, pontuacao) VALUES
('ana.silva@email.com',        'ana.silva',     'senha123',   0, 120),
('joao.souza@email.com',       'joao.souza',    '123senha',   0, 300),
('maria.oliveira@email.com',   'maria.olive',   'pass123',    0, 250),
('carlos.santos@email.com',    'carlos.santos', 'abc123',     0, 400),
('admin@app.com',              'admin',         'admin123',   1, 0),
('lucas.mendes@email.com',     'lucas.m',       'senha456',   0, 150),
('fernanda.lima@email.com',    'fernanda.l',    'senha789',   0, 220),
('rafael.alves@email.com',     'rafael.alves',  'mypassword', 0, 180),
('patricia.martins@email.com', 'patricia.m',    'secure123',  0, 200),
('gustavo.costa@email.com',    'gustavo.c',     'qwerty123',  0, 320),
('bruno.nascimento@email.com', 'bruno.n',       'bruno123',   0, 75),
('isabela.nogueira@email.com', 'isabela.n',     'isabela1',   0, 95);


INSERT INTO resultado (tempoSegundos, dataExecucao, idUsuario, idQuestionario) VALUES
(380, '2025-09-01 09:10:00', 1, 1),
(420, '2025-09-01 10:00:00', 2, 2),
(510, '2025-09-02 11:20:00', 3, 3),
(295, '2025-09-02 14:05:00', 4, 4),
(330, '2025-09-03 08:30:00', 5, 5),
(600, '2025-09-03 16:40:00', 6, 6),
(470, '2025-09-04 12:15:00', 7, 7),
(385, '2025-09-04 18:50:00', 8, 8),
(360, '2025-09-05 09:00:00', 9, 9),
(540, '2025-09-05 20:10:00',10,10),
(420, '2025-09-06 11:11:00',11,1),
(310, '2025-09-06 15:30:00',12,2);


INSERT INTO respostas_usuario (idUsuario, idQuestao, idAlternativa, correta, idResultado) VALUES

(1, 1,  3, 0, 1),
(1, 2,  6, 0, 1),
(1, 3,  9, 1, 1),
(1, 4,  16,0, 1),
(1, 5,  18,0, 1),


(2, 6,  21,1, 2),
(2, 7,  27,0, 2),
(2, 8,  30,0, 2),
(2, 9,  36,0, 2),
(2,10,  37,1, 2),


(3,11,  42,0, 3),
(3,12,  45,1, 3),
(3,13,  51,0, 3),
(3,14,  53,1, 3),
(3,15,  60,0, 3),


(4,16,  61,1, 4),
(4,17,  68,0, 4),
(4,18,  70,0, 4),
(4,19,  73,1, 4),
(4,20,  79,0, 4),


(5,21,  82,0, 5),
(5,22,  85,1, 5),
(5,23,  92,0, 5),
(5,24,  93,1, 5),
(5,25,  99,0, 5),


(6,26,  101,1, 6),
(6,27,  108,0, 6),
(6,28,  110,0, 6),
(6,29,  115,0, 6),
(6,30,  117,1, 6),


(7,31,  124,0, 7),
(7,32,  125,1, 7),
(7,33,  130,0, 7),
(7,34,  135,0, 7),
(7,35,  137,1, 7),


(8,36,  142,0, 8),
(8,37,  147,0, 8),
(8,38,  149,1, 8),
(8,39,  156,0, 8),
(8,40,  157,1, 8),


(9,41,  161,1, 9),
(9,42,  168,0, 9),
(9,43,  170,0, 9),
(9,44,  175,0, 9),
(9,45,  180,0, 9),


(10,46, 182,0,10),
(10,47, 185,1,10),
(10,48, 192,0,10),
(10,49, 195,0,10),
(10,50, 198,0,10),


(11,1,   1,1,11),
(11,2,   7,0,11),
(11,3,  12,0,11),
(11,4,  14,0,11),
(11,5,  20,0,11),


(12,6,  23,0,12),
(12,7,  25,1,12),
(12,8,  32,0,12),
(12,9,  34,0,12),
(12,10, 39,0,12);
