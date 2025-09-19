# 📌 Procedures e Triggers – Banco de Dados do Quiz  

**Legenda de Status**  
- ✅ Concluído  
- ⌛ Em andamento  
- ❌ Não iniciado  

Este documento descreve as **procedures** e **triggers** planejadas para o banco de dados do sistema de quiz.  
O objetivo é **padronizar operações comuns** (cadastro, consulta e relatórios de desempenho) e **garantir regras de negócio** via triggers.  

---

## 🔹 Procedures

### 📥 Registro de Resultados  

| Procedure | Descrição | Status |
|-----------|-----------|--------|
| Registrar Resultado de Questionário | Guardar pontuação obtida, tempo de execução e atualizar score acumulado do usuário. | ✅ (Samuel) |

---

### 📊 Consultas e Relatórios  

| Procedure | Descrição | Status |
|-----------|-----------|--------|
| Ranking Geral de Usuários | Retornar os Top N usuários em ordem de pontuação. | ✅ (Ariel) |
| Ranking por Disciplina | Retornar os usuários com maior pontuação em uma disciplina específica. | ❌ |
| Alterar senha | Pede uma nova senha e altera o campo senha de um usuario especifico. | ✅ (Lucas) |
| Contador de clicks | Adicionar um campo click na tabela questionarios e uma procedure para aumentar em +1 esse contador | ✅ (Lucas) |
| Estatísticas de Questão | Retornar taxa de acerto/erro de uma questão específica. | ⏳ (Samuel) |
| Histórico de Resultados de um Usuário | Listar execuções de quizzes (data, pontuação, tempo). | ✅ (Lucas) |
| Média de Pontuação por Usuário | Calcular a média de pontos obtidos por cada usuário. | ⏳ (Samuel) |
| Média de Pontuação por Disciplina | Identificar disciplinas com maior/menor desempenho médio. | ✅ (Gabriel K.) |
| Top Questões de Revisão | Identificar as questões mais erradas para sugerir revisão. | ✅ (Lucas) |
| Melhor Resultado do Usuário em Cada Disciplina | Mostrar a maior pontuação já alcançada por usuário em cada disciplina. | ⏳ (Gabriel K.) |
=======

---

## 🔹 Triggers Essenciais (Validação e Regras de Negócio)

| Trigger | Função | Status |
|---------|--------|--------|
| Resultados – Garantir Pontuação Válida | Impedir resultados com `pontuacao < 0`, `tempo_segundos < 0` ou `pontuacao > numero de questoes`. | ⌛ (Lucas) |
| Logs – Auditoria de Alterações | Rastrear alterações críticas (ex.: exclusão de usuários, atualizações de score). | ✅ (Rone) |
| Alterações Manuais de Pontuação | Prevenir ou auditar mudanças diretas no score acumulado. | ✅ (Gabriel K.) |

---

📌 **Observação:** Este documento deve ser atualizado conforme novas procedures/triggers forem implementadas ou alteradas.  
