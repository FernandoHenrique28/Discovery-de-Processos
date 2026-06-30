---
name: discovery-process-interno
description: Conduz um ciclo completo de discovery interno a partir de transcrições de reuniões, entrevistas com stakeholders e análise de processos existentes. Gera um Documento de Discovery de Processo crítico, apontando falhas antes de qualquer automação.
intent: >-
  Guiar times de dados e produto por um ciclo estruturado de discovery interno — desde o mapeamento do processo atual até a validação de hipóteses de melhoria — produzindo um documento crítico que expõe falhas, gargalos e riscos antes de qualquer decisão de automação ou desenvolvimento. Diferente do discovery externo (focado em clientes), este workflow trabalha com stakeholders de negócio e liderança executiva como fonte primária de evidência.
type: workflow
theme: discovery-interno
best_for:
  - "Mapear e criticar processos internos antes de automatizá-los"
  - "Estruturar o problema de negócio com stakeholders e liderança"
  - "Produzir documento de discovery para aprovação executiva"
  - "Identificar falhas e gargalos em processos de dados e analytics"
scenarios:
  - "O time quer automatizar a apuração de KPIs mas não mapeou o processo atual"
  - "A liderança pediu um relatório antes de aprovar o investimento no projeto"
  - "Existem múltiplas áreas com visões diferentes sobre o mesmo problema"
  - "Suspeita-se que automatizar o processo atual vai apenas acelerar um processo ruim"
estimated_time: "1-2 semanas"
output: "Documento de Discovery de Processo (Confluence)"
---

## Propósito

Conduzir um discovery interno estruturado que responda a pergunta crítica antes de qualquer automação:

> **"Estamos prestes a automatizar um processo bom — ou apenas acelerar um processo ruim?"**

Este workflow transforma transcrições de reuniões, entrevistas com stakeholders e análise de processos em um documento crítico que expõe falhas, contradições e riscos antes de qualquer decisão de desenvolvimento.

---

## Conceitos-chave

### O que é Discovery de Processo Interno?

Discovery interno é a prática de investigar sistematicamente como um processo realmente funciona — não como as pessoas acham que funciona — antes de propor soluções. É especialmente crítico em projetos de dados e automação, onde automatizar um processo mal estruturado gera escala de erro, não escala de valor.

### Por que isso importa antes de automatizar

- **Processos documentados vs processos reais:** O que está no papel raramente é o que acontece na prática
- **Automação de processo ruim = erro em escala:** Velocidade sem qualidade amplifica problemas
- **Stakeholders têm visões parciais:** Cada área enxerga o processo pelo seu próprio ângulo
- **Liderança aprova com base em diagnóstico, não em entusiasmo:** Um documento crítico gera mais confiança do que uma apresentação otimista

### Anti-padrões (o que este workflow evita)

- **Não é levantamento de requisitos:** Discovery precede e informa os requisitos — não os substitui
- **Não é validação de solução:** A solução ainda não existe; estamos entendendo o problema
- **Não é pesquisa com usuário externo:** O foco são stakeholders internos e processos organizacionais
- **Não pula para automação:** Automatizar antes de descobrir é o erro mais comum e mais caro

---

## Fonte de verdade para facilitação

Ao conduzir este workflow como conversa guiada, usar protocolo de facilitação com:
- Uma pergunta por vez, linguagem direta e sem jargão desnecessário
- Progresso explícito (ex: "Fase 2 de 5 — Mapeamento do Processo")
- Opções numeradas para respostas recorrentes
- Pausas explícitas em cada ponto de decisão

---

## Fase 1: Enquadramento do Problema (Dia 1-2)

**Objetivo:** Definir o que está sendo investigado, quem é afetado e o que seria um bom resultado.

### Atividades

**1. Extrair contexto da meeting assessment**
- **Input:** Documento de assessment da reunião de kickoff (se disponível)
- **Extrair:**
  - Problema central declarado
  - Stakeholders e seus papéis
  - Números e métricas mencionados
  - Perguntas em aberto da reunião
  - Contradições identificadas
- **Duração:** 30 minutos
- **Output:** Rascunho de hipótese de problema

**2. Formular hipótese de problema**

Usar o formato:
> "Acreditamos que [persona interna] tem dificuldade com [processo/situação] porque [causa raiz hipotética], o que resulta em [consequência mensurável]."

Exemplo do contexto Nier:
> "Acreditamos que o time de Planejamento Integrado gasta 75% do tempo em apuração manual de KPIs porque não existe uma camada de dados confiável entre os sistemas de origem e as ferramentas de BI, o que resulta em pouco tempo disponível para análise e direcionamento estratégico."

**3. Mapear stakeholders e suas perspectivas**

Para cada stakeholder identificado, registrar:
- Nome e papel no processo
- O que ele acredita ser o problema
- O que ele acredita ser a solução
- Qual é o seu interesse no resultado do projeto
- Grau de influência na decisão final (informado / consultado / aprovador)

### Outputs da Fase 1

- Hipótese de problema estruturada
- Mapa de stakeholders com perspectivas e interesses
- 3-5 perguntas críticas a responder no discovery

### Ponto de decisão 1: Temos contexto suficiente para mapear o processo?

**Se SIM:** Avançar para Fase 2

**Se NÃO:** Coletar antes:
- Transcrições de reuniões anteriores
- Documentação existente do processo (mesmo que desatualizada)
- Dados de performance disponíveis (tempo, volume, erros)
- **Impacto:** +1-2 dias

---

## Fase 2: Mapeamento do Processo Atual (Dia 2-4)

**Objetivo:** Entender como o processo realmente funciona hoje — não como deveria funcionar.

### Atividades

**1. Entrevistar stakeholders de negócio**

Foco em comportamento passado, não em opiniões sobre o futuro:
- "Me descreve como você fez isso na última vez que precisou"
- "Quando dá errado, o que geralmente aconteceu antes?"
- "Quais gambiarras você usa para contornar o que não funciona?"
- "Quanto tempo isso levou da última vez? E na vez anterior?"
- "Quem mais você precisa acionar para conseguir concluir isso?"

**Evitar:**
- "Você usaria X se a gente construísse?" → resposta sempre é sim
- "O que você acha que deveria ser feito?" → vai para solução antes do problema
- "Isso é um problema pra você?" → pergunta diretiva

**2. Mapear o fluxo real do processo**

Para cada etapa do processo:
- O que dispara essa etapa?
- Quem executa?
- Quais sistemas ou ferramentas são usados?
- Qual o output esperado?
- O que pode dar errado?
- Quanto tempo leva em média?
- Existe alguma variação dependendo do contexto?

**3. Identificar handoffs e dependências**

Handoffs entre áreas são onde os processos mais falham:
- Onde o processo passa de uma pessoa/área para outra?
- O que é entregue nesse handoff? (dado, documento, aprovação)
- Existe SLA ou expectativa de prazo?
- O que acontece quando o handoff atrasa ou falha?

**4. Coletar evidências quantitativas**

- Volume: quantas vezes esse processo roda por semana/mês?
- Tempo: quanto leva cada etapa?
- Erros: qual a taxa de retrabalho?
- Dependências: quantas pessoas são necessárias?

### Outputs da Fase 2

- Fluxo do processo atual (As-Is) documentado
- Lista de handoffs e dependências críticas
- Métricas de baseline (tempo, volume, erros)
- Primeiras hipóteses de gargalo

---

## Fase 3: Análise Crítica do Processo (Dia 4-6)

**Objetivo:** Identificar falhas, gargalos e riscos antes de qualquer proposta de solução.

### Atividades

**1. Identificar categorias de problema**

Para cada problema encontrado, classificar:

| Categoria | Descrição | Exemplo |
|-----------|-----------|---------|
| **Gargalo de tempo** | Etapa que consome tempo desproporcional | Apuração manual de KPIs |
| **Dependência frágil** | Processo que depende de uma pessoa ou sistema específico | Só o Leandro sabe fazer X |
| **Dado inconsistente** | Fonte de dados não confiável ou divergente entre áreas | Cada área tem sua métrica de receita |
| **Lógica escondida** | Regra de negócio que existe só na cabeça de alguém | Ajuste manual que ninguém documentou |
| **Automação prematura** | Processo que não deveria existir e está sendo automatizado | Relatório que ninguém lê mas continua sendo gerado |
| **Gap de governança** | Processo sem dono, SLA ou critério de qualidade definido | Ninguém sabe quem é responsável por X |

**2. Aplicar o teste crítico para cada etapa**

Antes de recomendar automação de qualquer etapa, responder:
- Esta etapa gera valor real ou apenas existe por inércia?
- Se automatizarmos como está, o erro vai acontecer mais rápido ou vai desaparecer?
- Existe uma causa raiz que a automação não vai resolver?
- Quem vai manter isso quando a pessoa que construiu sair?

**3. Mapear contradições entre stakeholders**

Stakeholders diferentes frequentemente têm versões diferentes do mesmo processo. Registrar:
- O que A diz que acontece vs o que B diz que acontece
- O que está documentado vs o que realmente ocorre
- O que a liderança acredita vs o que o time operacional vive

**4. Avaliar maturidade de dados**

Para projetos de dados especificamente:
- Os dados de origem são confiáveis? Quem garante?
- Existe definição consensual das métricas entre as áreas?
- Os dados chegam com qual frequência e latência?
- Quais gaps de cobertura existem no Data Lake ou sistemas de origem?
- A lógica de negócio está documentada ou existe só no BI/planilha?

### Outputs da Fase 3

- Mapa de problemas classificados por categoria e severidade
- Lista de contradições entre stakeholders
- Avaliação de maturidade de dados
- Riscos de automatizar o processo atual sem intervenção

---

## Fase 4: Síntese e Priorização (Dia 6-8)

**Objetivo:** Consolidar achados, priorizar problemas e formular recomendações.

### Atividades

**1. Priorizar problemas por impacto e urgência**

Usar matriz simples:
- **Alto impacto + Alta urgência:** Resolver antes de qualquer automação
- **Alto impacto + Baixa urgência:** Planejar resolução paralela à automação
- **Baixo impacto + Alta urgência:** Delegar ou aceitar como risco
- **Baixo impacto + Baixa urgência:** Ignorar por ora

**2. Identificar pré-requisitos para automação**

O que precisa estar resolvido antes de automatizar:
- Qualidade de dados mínima aceitável
- Definições de métricas alinhadas entre áreas
- Processos que precisam ser redesenhados antes de automatizar
- Governança e donos definidos para cada output

**3. Formular recomendações críticas**

Para cada recomendação:
- O que está errado hoje
- Por que automatizar sem resolver isso é arriscado
- O que precisa ser feito antes
- Quem é responsável por fazer
- Como saberemos que está resolvido

**4. Definir quick wins**

Identificar entregas de curto prazo que:
- Geram valor visível para a liderança executiva
- Não dependem de resolver os problemas estruturais primeiro
- Criam momentum e confiança no projeto

### Outputs da Fase 4

- Matriz de priorização de problemas
- Lista de pré-requisitos para automação
- Recomendações críticas com responsáveis
- Quick wins identificados

### Ponto de decisão 2: Os achados validam ou invalidam a hipótese inicial?

**Se VALIDAM:** Avançar para Fase 5 com a hipótese refinada

**Se INVALIDAM:** Reformular hipótese e revisar escopo
- O problema real pode ser diferente do declarado
- **Impacto:** +3-5 dias para nova rodada de entrevistas

---

## Fase 5: Documento de Discovery de Processo (Dia 8-10)

**Objetivo:** Produzir o documento final crítico para aprovação da liderança executiva no Confluence.

### Estrutura do Documento

```
1. Resumo Executivo (meia página)
   - Problema central
   - Principal achado crítico
   - Recomendação de GO / ATENÇÃO / STOP

2. Contexto e Escopo
   - O que foi investigado
   - Quem foi entrevistado
   - Período de análise

3. Como o Processo Funciona Hoje (As-Is)
   - Fluxo mapeado
   - Sistemas e ferramentas envolvidos
   - Métricas de baseline

4. Achados Críticos
   - Problemas por categoria e severidade
   - Contradições identificadas
   - Riscos de automatizar sem intervenção

5. Avaliação de Maturidade de Dados
   - Qualidade das fontes
   - Gaps de cobertura
   - Definições inconsistentes

6. Pré-requisitos para Automação
   - O que deve ser resolvido antes
   - O que pode ser resolvido em paralelo
   - O que pode ser aceito como risco

7. Recomendações
   - Quick wins (impacto imediato)
   - Ações estruturais (fundação)
   - O que NÃO fazer agora e por quê

8. Perguntas em Aberto
   - Decisões que ainda precisam ser tomadas
   - Informações que ainda faltam
   - Responsáveis por cada resposta

9. Próximos Passos
   - Ações com responsável e prazo
   - Critério de sucesso para cada ação
```

### Critério de qualidade do documento

Um bom Documento de Discovery de Processo:
- **É crítico, não otimista:** Expõe o que está errado, não apenas o que pode melhorar
- **É específico:** Cita dados reais, nomes de sistemas, métricas concretas
- **Separa problema de solução:** Não propõe automação antes de entender o problema
- **Tem recomendações acionáveis:** Cada achado tem um responsável e um critério de conclusão
- **É honesto com a liderança:** Não esconde riscos para parecer mais favorável à aprovação

### Publicação no Confluence

- Criar página dentro do espaço do projeto
- Estrutura de labels: `discovery` `processo` `[nome-do-projeto]` `[trimestre]`
- Notificar stakeholders entrevistados para revisão antes da publicação
- Agendar reunião de readout de 30 minutos com a liderança executiva

---

## Resumo End-to-End

```
Semana 1:
├─ Dia 1-2: Enquadramento do Problema
│  ├─ Extrair contexto da meeting assessment
│  ├─ Formular hipótese de problema
│  └─ Mapear stakeholders
│
├─ Dia 2-4: Mapeamento do Processo Atual
│  ├─ Entrevistas com stakeholders de negócio
│  ├─ Mapear fluxo As-Is
│  ├─ Identificar handoffs e dependências
│  └─ Coletar métricas de baseline
│
└─ Dia 4-6: Análise Crítica
   ├─ Classificar problemas por categoria
   ├─ Aplicar teste crítico por etapa
   ├─ Mapear contradições entre stakeholders
   └─ Avaliar maturidade de dados

Semana 2:
├─ Dia 6-8: Síntese e Priorização
│  ├─ Priorizar problemas por impacto/urgência
│  ├─ Definir pré-requisitos para automação
│  ├─ Formular recomendações críticas
│  └─ Identificar quick wins
│
└─ Dia 8-10: Documento de Discovery
   ├─ Redigir documento no Confluence
   ├─ Revisão com stakeholders entrevistados
   └─ Readout de 30 min com liderança executiva
```

**Investimento de tempo:**
- **Rápido:** 1 semana (processo simples, stakeholders alinhados)
- **Típico:** 2 semanas (múltiplas áreas, contradições a resolver)
- **Complexo:** 3 semanas (processo distribuído, dados inconsistentes, muitos stakeholders)

---

## Armadilhas Comuns

### Armadilha 1: Documentar o processo ideal em vez do real
**Sintoma:** Stakeholders descrevem como o processo deveria funcionar
**Consequência:** Discovery não encontra os problemas reais
**Fix:** Sempre perguntar sobre a última vez que fizeram, não sobre como fazem "normalmente"

### Armadilha 2: Aceitar a primeira versão do problema
**Sintoma:** O problema declarado na primeira reunião é tratado como definitivo
**Consequência:** Discovery confirma hipótese errada
**Fix:** Tratar o problema declarado como hipótese e investigar ativamente se está correto

### Armadilha 3: Pressão para já propor a solução
**Sintoma:** Stakeholders ou liderança pedem "e o que vocês vão fazer?" antes do discovery terminar
**Consequência:** Discovery vira teatro para justificar solução já decidida
**Fix:** Deixar explícito no início que o output é um diagnóstico, não uma proposta de solução

### Armadilha 4: Ignorar contradições entre stakeholders
**Sintoma:** Versões conflitantes do processo são "resolvidas" escolhendo uma
**Consequência:** A versão ignorada vira problema durante a implementação
**Fix:** Documentar as contradições explicitamente e resolver com dados ou decisão formal

### Armadilha 5: Recomendar automação de tudo
**Sintoma:** Todo problema identificado recebe "automatizar" como solução
**Consequência:** Automação de processos ruins gera escala de erro
**Fix:** Para cada automação proposta, responder: "o processo está bom o suficiente para ser acelerado?"

---

## Referências

### Skills relacionadas
- `meeting-assessment` — Input primário para a Fase 1 deste workflow
- `data-product-management` — Raciocínio de negócio aplicado aos achados
- `assessment-html-report` — Geração do relatório visual a partir dos outputs

### Frameworks externos
- Teresa Torres, *Continuous Discovery Habits* (2021) — Princípios de discovery adaptados para contexto interno
- Taiichi Ohno — Princípios de mapeamento de fluxo de valor (identificar desperdício antes de otimizar)
- W. Edwards Deming — "Se você não pode descrever o que está fazendo como um processo, você não sabe o que está fazendo"

---

**Tipo:** Workflow
**Nome sugerido:** `discovery-process-interno.md`
**Localização sugerida:** `/skills/workflows/`
**Dependências:** `meeting-assessment`, `data-product-management`, `assessment-html-report`
**Output principal:** Documento de Discovery de Processo no Confluence
