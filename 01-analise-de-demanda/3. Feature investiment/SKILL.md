---
name: feature-investment
description: >
  Use esta skill para calcular o retorno sobre investimento de uma demanda interna — horas
  economizadas, custo evitado e risco mitigado — usando a tabela oficial de taxa-hora da Raízen
  por área e perfil. Entrega recomendação de investir, investir com ressalva, ou não investir.
  Gatilhos: "vale a pena investir nisso", "calcular o ROI", "quanto isso custa vs quanto
  economiza", "avaliar o investimento", "essa demanda compensa", "custo benefício do projeto",
  "quanto vamos economizar automatizando isso", "feature investment", "justificar o investimento".
  INPUT: documento do problem-framing (recomendado SEGUIR ou SEGUIR COM RESSALVA) + dados de
  horas/pessoas envolvidas no processo atual + estimativa de esforço de construção.
  OUTPUT: documento de avaliação financeira com recomendação de investir ou não investir.
  Usa a tabela references/tabela-taxa-hora-raizen.xlsx para calcular custo de horas com precisão.
---

# Feature Investment — Avaliação de Investimento Corporativo

Terceira skill do pipeline de Análise de Demanda. Entra depois do problem-framing.

**Objetivo:** decidir se uma demanda merece investimento, com base em custo evitado,
horas economizadas e risco mitigado — não em receita ou métricas de SaaS.

Pipeline:
business-analyst → problem-framing → **feature-investment** → [discovery de processo, se aprovado]

---

## Por que esta skill é diferente de frameworks de ROI de produto

Frameworks de ROI de produto SaaS calculam: receita nova, churn evitado, ARPU, LTV.
Nenhuma dessas métricas existe no seu contexto — você não vende assinatura, não tem clientes
pagantes de um produto digital.

O que existe no seu contexto:
- **Horas de pessoas** gastas hoje em um processo manual, com taxa-hora real e oficial
- **Custo evitado** — multas, demurrage, retrabalho, pagamento postergado
- **Risco mitigado** — operacional, compliance, concentração de conhecimento em uma pessoa
- **Custo de construção** — horas de time de dados/TI para construir a solução

Esta skill usa a tabela oficial `references/tabela-taxa-hora-raizen.xlsx` para transformar
horas em reais com precisão — não estimativa qualitativa.

---

## Inputs necessários

| Input | Obrigatório | Origem |
|---|---|---|
| Recomendação do problem-framing (SEGUIR ou SEGUIR COM RESSALVA) | ✅ | problem-framing |
| Causa raiz identificada | ✅ | problem-framing |
| Quem executa o processo hoje (área + perfil) | ✅ | business-analyst / usuário |
| Horas gastas hoje no processo manual | ✅ | usuário (perguntar se não informado) |
| Frequência do processo (diário, semanal, mensal) | ✅ | usuário |
| Custo evitado conhecido (multas, demurrage, retrabalho) | ⬜ | meeting-extractor (seção Custo do Erro) |
| Estimativa de esforço de construção (área + perfil + horas) | ✅ | usuário (perguntar se não informado) |
| Risco identificado (concentração de conhecimento, compliance) | ⬜ | discovery-process-interno, se já existir |

**Se o problem-framing recomendou NÃO SEGUIR:** esta skill não deve ser usada. Avisar o usuário:

> "O problem-framing recomendou não seguir com essa demanda. Antes de calcular investimento,
> é preciso resolver o que está pendente na recomendação anterior."

---

## Passo 1 — Ler a tabela de taxa-hora

Ler `references/tabela-taxa-hora-raizen.xlsx`. Colunas: Área, Perfil, Taxa hora (R$), Valor mensal (R$).

Esta tabela é a fonte oficial de custo de hora por área e perfil na Raízen. Usar sempre que
calcular custo de horas — nunca estimar taxa-hora manualmente se a área/perfil constar na tabela.

Se a área ou perfil mencionado pelo usuário não constar na tabela, perguntar:
> "A área/perfil [X] não está na tabela de taxa-hora. Você tem o valor, ou devo usar uma
> referência aproximada de um perfil similar?"

---

## Passo 2 — Calcular o Custo do Processo Atual

### 2.1 Custo de horas do processo manual

Fórmula:
```
Custo Mensal do Processo = Horas gastas por mês × Taxa-hora (R$) × Número de pessoas envolvidas
```

Buscar a taxa-hora na tabela pela área e perfil de quem executa o processo hoje.

**Exemplo:**
> Processo de conferência de documentos, executado por 1 Analista Pl da área ETRM, Comercial &
> Lubes, Supply & Trading, gastando 60h/mês.
>
> Taxa-hora (tabela): R$ 128/hora
> Custo Mensal do Processo = 60h × R$ 128 = R$ 7.680/mês
> Custo Anual do Processo = R$ 92.160/ano

### 2.2 Custo evitado adicional

Se houver custo evitado conhecido (vindo do meeting-extractor, seção "Custo do Erro"), somar
ao custo de horas.

**Exemplo:**
> Atraso médio de 2 dias por erro de conferência, 3 erros/mês, custo de demurrage R$ 15.000/dia
> Custo Evitado Potencial = 2 dias × 3 erros × R$ 15.000 = R$ 90.000/mês (se 100% dos erros forem eliminados)

**Importante:** sempre apresentar um cenário conservador (eliminação parcial, não 100%) junto
ao cenário otimista. Nunca assumir eliminação total do erro como cenário base.

### 2.3 Custo total do processo atual

```
Custo Total Atual (anual) = (Custo Mensal do Processo × 12) + Custo Evitado Anualizado
```

---

## Passo 3 — Calcular o Custo de Construção

### 3.1 Esforço de construção

Pedir ao usuário (ou estimar junto):
- Área e perfil de quem vai construir (ex: Analista Sr de IA & Dados)
- Horas estimadas de construção

Fórmula:
```
Custo de Construção = Horas de construção × Taxa-hora (R$) da área/perfil responsável
```

**Exemplo:**
> Construção estimada: 120h de um Analista Sr de IA & Dados
> Taxa-hora (tabela): R$ 160/hora
> Custo de Construção = 120h × R$ 160 = R$ 19.200

### 3.2 Custo de manutenção (se aplicável)

Se a solução exigir manutenção contínua, estimar horas mensais de manutenção e calcular
o custo anualizado com a mesma lógica.

```
Custo de Manutenção Anual = Horas de manutenção/mês × 12 × Taxa-hora
```

---

## Passo 4 — Calcular Retorno

### 4.1 Economia líquida anual

```
Economia Líquida Anual = Custo Total Atual (anual) - Custo de Manutenção Anual
```

### 4.2 Payback (tempo de retorno)

```
Payback (meses) = Custo de Construção / (Economia Líquida Anual / 12)
```

### 4.3 ROI

```
ROI = (Economia Líquida Anual - Custo de Construção) / Custo de Construção
```

Apresentar como proporção (ex: "3,8:1") e como percentual (ex: "380% no primeiro ano").

**Alerta obrigatório — ROI conservador abaixo de 1:1:**

Se o ROI do cenário conservador for menor que 1:1 (ou seja, a economia líquida não cobre o
custo de construção dentro do primeiro ano), isso precisa ser **destacado de forma explícita**,
nunca apresentado apenas como um número na tabela.

Um ROI de "0,9:1" lido rápido pode passar a impressão de retorno positivo garantido — não é.
Significa que, no cenário conservador, o investimento ainda não se pagou no primeiro ano.

Quando isso ocorrer, adicionar logo abaixo da tabela de retorno um aviso no formato:

> ⚠️ **No cenário conservador, o retorno é abaixo de 1:1** — o investimento não se paga
> integralmente no primeiro ano só com a economia de horas. A recomendação de investir,
> se houver, depende de outro fator (risco mitigado, valor estratégico, ou confiança de
> que o cenário esperado é mais provável que o conservador) — não apenas do retorno financeiro.

Este alerta é obrigatório sempre que o ROI conservador for < 1:1, mesmo que a recomendação
final seja INVESTIR. A transparência sobre isso é mais importante do que a conclusão.

**Sempre apresentar dois cenários:**

| Cenário | Premissa |
|---|---|
| Conservador | Elimina 50% do problema atual |
| Esperado | Elimina 80% do problema atual |

Nunca apresentar só o cenário otimista — isso é o Pitfall mais comum em avaliação de
investimento e gera decisões infladas.

---

## Passo 5 — Avaliar Valor Não Financeiro

Nem todo valor é financeiro. Avaliar separadamente:

**Risco mitigado**
- O processo depende de uma única pessoa? (concentração de conhecimento)
- Existe exposição a compliance, multa regulatória, ou erro com cliente externo?
- O processo atual já causou algum incidente relevante?

**Valor estratégico**
- Essa solução habilita algo maior depois (plataforma, dado reutilizável)?
- Existe pressão de prazo real (não política) ligada a essa demanda?

Esses fatores podem justificar seguir mesmo com ROI financeiro modesto — mas isso deve ser
**explícito na recomendação**, nunca usado como desculpa genérica para investir sem critério.

---

## Passo 6 — Recomendação

A recomendação é sempre uma das três:

**INVESTIR**
ROI positivo no cenário conservador, payback dentro de um horizonte razoável (até 12 meses
para demandas operacionais, até 24 para demandas estruturais maiores), e/ou risco mitigado
relevante.

**INVESTIR COM RESSALVA**
ROI positivo só no cenário esperado (não no conservador), ou payback longo, mas há valor
estratégico ou de risco que justifica seguir com escopo reduzido ou fase piloto.

**NÃO INVESTIR AGORA**
ROI negativo ou marginal em ambos os cenários, sem risco relevante mitigado, sem valor
estratégico claro. Recomendação de revisitar se o contexto mudar (volume crescer, custo
do erro aumentar).

---

## Estrutura do documento de saída

```markdown
# Avaliação de Investimento — [Nome da Demanda]

## Contexto
[Recomendação do problem-framing + causa raiz, em 2-3 linhas]

## Custo do Processo Atual

| Item | Valor |
|---|---|
| Horas/mês no processo manual | [X]h |
| Taxa-hora (área/perfil) | R$ [X] |
| Custo mensal do processo | R$ [X] |
| Custo evitado potencial (se aplicável) | R$ [X]/mês |
| **Custo total atual (anual)** | **R$ [X]** |

## Custo de Construção

| Item | Valor |
|---|---|
| Horas de construção | [X]h |
| Taxa-hora (área/perfil responsável) | R$ [X] |
| **Custo de construção** | **R$ [X]** |
| Custo de manutenção anual (se aplicável) | R$ [X] |

## Retorno — Dois Cenários

| | Conservador (50%) | Esperado (80%) |
|---|---|---|
| Economia líquida anual | R$ [X] | R$ [X] |
| Payback | [X] meses | [X] meses |
| ROI | [X]:1 | [X]:1 |

[Se ROI conservador < 1:1, incluir aqui:]
> ⚠️ **No cenário conservador, o retorno é abaixo de 1:1** — o investimento não se paga
> integralmente no primeiro ano só com a economia de horas. [Completar com o fator que
> justifica seguir mesmo assim, se a recomendação for INVESTIR ou INVESTIR COM RESSALVA.]

## Valor Não Financeiro
- Risco mitigado: [descrição]
- Valor estratégico: [descrição, se houver]

## Recomendação

**[INVESTIR / INVESTIR COM RESSALVA / NÃO INVESTIR AGORA]**

[Justificativa em 3-5 linhas]

## Próximo Passo Sugerido
[Se INVESTIR: avançar para discovery-process-interno / Se NÃO: o que precisaria mudar para revisitar]
```

---

## Armadilhas comuns (adaptado para contexto corporativo interno)

**Confundir economia bruta com economia líquida**
Esquecer o custo de manutenção infla o retorno. Sempre subtrair manutenção da economia anual.

**Ignorar o payback**
ROI de 5:1 com payback de 3 anos pode ser pior que ROI de 2:1 com payback de 4 meses,
dependendo da urgência e do horizonte de planejamento da área.

**Superestimar adoção/eliminação do problema**
Assumir que a solução elimina 100% do erro ou retrabalho é a causa mais comum de ROI inflado.
Sempre usar o cenário conservador como base de decisão, não o esperado.

**Usar "valor estratégico" como desculpa**
Se não há nenhum risco ou benefício específico nomeado, "é estratégico" não é justificativa —
é ausência de critério. Definir exatamente o que está sendo mitigado ou habilitado.

**Esquecer o custo de quem mantém depois**
Solução sem dono de manutenção definido gera custo invisível que aparece meses depois,
geralmente como um novo "incêndio" para o time de dados resolver.

**Comparar áreas/perfis de taxa-hora incorretamente**
Usar a taxa-hora errada (perfil Jr quando quem executa é Sr) distorce o cálculo de forma
significativa. Sempre confirmar o perfil real antes de calcular.

---

## Checklist de qualidade

- [ ] Taxa-hora usada vem da tabela oficial `references/tabela-taxa-hora-raizen.xlsx`
- [ ] Se área/perfil não consta na tabela, foi perguntado ao usuário em vez de estimado
- [ ] Custo do processo atual inclui horas + custo evitado, quando aplicável
- [ ] Custo de construção inclui manutenção, se a solução exigir
- [ ] Dois cenários apresentados (conservador 50% / esperado 80%) — nunca só um
- [ ] Se ROI conservador < 1:1, alerta explícito incluído — não apenas o número na tabela
- [ ] Payback calculado e apresentado junto ao ROI
- [ ] Valor não financeiro avaliado separadamente, com risco ou benefício nomeado especificamente
- [ ] Recomendação é uma das três opções formais
- [ ] Nenhuma métrica de SaaS (MRR, ARPU, churn, LTV) usada em nenhum cálculo