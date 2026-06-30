---
name: demand-summary
description: >
  Use esta skill para consolidar em um único documento tudo que foi produzido na análise de
  demanda — meeting-extractor, business-analyst, problem-framing e feature-investment, mesmo
  que nem todas as etapas existam. Gera dois formatos: um dossiê completo (HTML/PDF) para
  acompanhamento e arquivo, e um resumo executivo de uma página para enviar ao chefe ou comitê.
  Gatilhos: "juntar tudo em um lugar", "consolidar a análise", "resumo de tudo", "documento
  final da demanda", "PDF com tudo", "dossiê da demanda", "juntar os 4 documentos",
  "demand summary", "visão completa da análise".
  INPUT: qualquer combinação de outputs do meeting-extractor, business-analyst, problem-framing
  e feature-investment — não exige as 4 etapas completas.
  OUTPUT: dois arquivos HTML — dossiê completo (references/demand-summary-full-template.html)
  e resumo executivo de uma página (references/demand-summary-exec-template.html).
---

# Demand Summary — Consolidação da Análise de Demanda

Última etapa do pipeline de Análise de Demanda. Roda depois de qualquer combinação das
quatro etapas anteriores — não exige todas.

Pipeline:
business-analyst → problem-framing → feature-investment → **demand-summary**

---

## Propósito

Cada etapa do pipeline gera um documento markdown separado. Isso é ótimo para trabalho
incremental, mas ruim para consulta rápida ou envio — ninguém vai ler 4 arquivos quando
precisa de visão geral ou apresentar uma decisão.

Esta skill lê o que estiver disponível e gera dois documentos:

- **Dossiê completo** — todas as etapas disponíveis, lado a lado, para você acompanhar
  e ter rastreabilidade de todo o raciocínio
- **Resumo executivo** — uma página, para enviar a quem vai decidir ou ser informado

---

## Princípio de adaptação

A demanda pode parar em qualquer etapa — principalmente quando o `problem-framing`
recomenda NÃO SEGUIR AGORA, o que torna o `feature-investment` desnecessário.

**A skill nunca exige as 4 etapas.** Ela identifica o que está disponível e adapta os
dois documentos de saída automaticamente.

| Etapas disponíveis | O que muda no documento |
|---|---|
| Só meeting-extractor | Dossiê mostra só a origem; resumo executivo não é gerado — ainda não há decisão a comunicar |
| meeting-extractor + business-analyst | Dossiê mostra origem + estruturação; sem recomendação ainda |
| + problem-framing (NÃO SEGUIR AGORA) | Recomendação final = NÃO SEGUIR. Seção de feature-investment omitida. Resumo executivo é gerado, mas comunica a pausa, não um investimento |
| + problem-framing (SEGUIR/RESSALVA) + feature-investment | Conjunto completo — ambos os documentos com todas as seções |

---

## Inputs necessários

| Input | Obrigatório | Origem |
|---|---|---|
| Pelo menos 2 das 4 etapas | ✅ | Skills anteriores |
| Nome da demanda | ✅ | Inferir dos documentos ou perguntar |
| Nome do analista | ✅ | Usuário, se não constar nos documentos |
| Nome do destinatário (só para o resumo executivo) | ✅ se for gerar o executivo | Usuário |

**Se só houver 1 etapa disponível (ex: só meeting-extractor):** avisar o usuário que ainda é
cedo para consolidar — sugerir rodar o `business-analyst` primeiro.

---

## Passo 1 — Identificar o que está disponível

Ler os arquivos fornecidos e identificar quais das 4 etapas existem. Não assumir — se um
documento não foi fornecido, tratar como ausente, mesmo que o usuário mencione informalmente
que "rodou" aquela etapa.

Determinar a **recomendação final** com base na etapa mais avançada disponível:

- Se houver `feature-investment`: a recomendação final é a dele (INVESTIR / INVESTIR COM
  RESSALVA / NÃO INVESTIR AGORA)
- Se não houver `feature-investment` mas houver `problem-framing`: a recomendação final é a
  dele (SEGUIR / SEGUIR COM RESSALVA / NÃO SEGUIR AGORA)
- Se só houver `business-analyst`: não há recomendação ainda — o dossiê é gerado, mas sem
  seção de recomendação, e o resumo executivo não deve ser gerado ainda

**Se houver múltiplas camadas** (como no caso de demandas com camada técnica e camada de
negócio, por exemplo), tratar cada camada com sua própria recomendação dentro do mesmo
documento — não forçar uma recomendação única quando as camadas divergem.

---

## Passo 2 — Gerar o Dossiê Completo

### 2.1 Ler o template

Ler `references/demand-summary-full-template.html`.
**Nunca recriar o CSS. Apenas preencher os slots e remover/adaptar seções conforme a
disponibilidade de etapas.**

### 2.2 Preencher a capa

- `[Nome da Demanda]` → nome consistente em todos os documentos de origem
- `[STATUS FINAL]` → recomendação final identificada no Passo 1
- Classe do status pill: `status-seguir` (verde) se SEGUIR/INVESTIR, `status-ressalva`
  (âmbar) se COM RESSALVA, `status-nao-seguir` (cinza) se NÃO SEGUIR/NÃO INVESTIR
- `[X de 4]` → número de etapas disponíveis

### 2.3 Preencher o TL;DR

4 frases obrigatórias, nessa ordem:
1. O que foi pedido
2. Causa raiz identificada (se o problem-framing existir; senão, omitir a frase)
3. Recomendação final e o porquê em uma linha
4. Próximo passo concreto

### 2.4 Nav de etapas

Marcar `etapa-ativa` para as etapas disponíveis e `etapa-inativa` para as que não existem
neste dossiê. Etapas inativas continuam visíveis — isso comunica visualmente até onde a
análise avançou.

### 2.5 Preencher cada seção disponível

**Etapa 1 (meeting-extractor):** resumo de como a demanda surgiu + grau de confiança da
extração geral. Se não disponível, remover a seção inteira do HTML, não deixar vazia.

**Etapa 2 (business-analyst):** Mapa de Stakeholders (tabela), Critérios de Sucesso,
Principais Requisitos. Se a demanda tiver múltiplas camadas, indicar isso no resumo.

**Etapa 3 (problem-framing):** causa raiz, hipóteses concorrentes (formato Hipótese 1 /
Hipótese 2 / Evidência que falta), e a recomendação com a cor correspondente
(`rec-seguir`, `rec-ressalva`, `rec-nao-seguir`).

Se houver múltiplas camadas com recomendações diferentes, duplicar o bloco de recomendação
para cada camada, identificando claramente qual é qual.

**Etapa 4 (feature-investment):** se não disponível, **remover a seção inteira do HTML** —
não deixar como "não calculado" ou com slots vazios. Se disponível, preencher os dois
cards de cenário (conservador/esperado) e incluir o alerta de ROI < 1:1 se aplicável,
seguindo a mesma regra já definida na skill `feature-investment`.

### 2.6 Dúvidas Pendentes Consolidadas

Reunir as dúvidas pendentes mais críticas de todas as etapas disponíveis em uma lista única
— não duplicar a lista completa de cada etapa, selecionar as que mais bloqueiam o avanço.
Máximo 6 itens. Se houver mais, indicar "+ N outras no documento de origem".

### 2.7 Próximo Passo

Uma frase direta sobre o que vem a seguir no pipeline geral (discovery-process-interno,
ddvp-negocio, ou "aguardar resolução de X" se a recomendação foi negativa).

### 2.8 Salvar

`/mnt/user-data/outputs/dossie-[slug-da-demanda].html`

---

## Passo 3 — Gerar o Resumo Executivo

**Só gerar se houver pelo menos uma recomendação** (problem-framing ou feature-investment).
Se só houver business-analyst, avisar o usuário em vez de gerar um documento sem decisão.

### 3.1 Ler o template

Ler `references/demand-summary-exec-template.html`.
**Nunca recriar o CSS. Apenas preencher os slots.**

### 3.2 Perguntar o destinatário

Se não informado, perguntar antes de gerar:
> "Para quem vai esse resumo executivo — nome e função?"

### 3.3 Preencher

**Contexto:** 2-3 frases — o que foi pedido e por que está sendo avaliado agora.

**Números que Importam:** só incluir esta seção se houver `feature-investment`. Caso
contrário, remover a seção inteira — não inventar números financeiros quando a análise
parou no problem-framing.

**Causa Raiz:** versão mais concisa possível — 2-3 linhas, sem o detalhamento de hipóteses
concorrentes que existe no dossiê completo.

**Recomendação:** a recomendação final identificada no Passo 1, com a cor correspondente.
Se a recomendação for NÃO SEGUIR/NÃO INVESTIR, o resumo executivo deve comunicar isso com
a mesma clareza — não suavizar a mensagem.

**Próximos Passos:** 2-4 ações concretas com responsável e prazo. Se a recomendação foi
negativa, os próximos passos são as ações necessárias para revisitar a demanda, não passos
de execução de um projeto que não foi aprovado.

### 3.4 Salvar

`/mnt/user-data/outputs/resumo-executivo-[slug-da-demanda].html`

---

## Passo 4 — Entregar

Usar `present_files` para entregar os dois arquivos (ou só o dossiê, se o executivo não foi
gerado). Instruir o usuário a abrir no Chrome e usar Ctrl+P → "Salvar como PDF" com background
graphics ativado para preservar logo e cores.

---

## Tratamento de demandas com múltiplas camadas

Quando a demanda original (como identificado pelo business-analyst ou problem-framing) tem
mais de uma camada com recomendações diferentes:

- O dossiê completo mostra cada camada com seu próprio bloco de causa raiz e recomendação
- O TL;DR menciona explicitamente que há múltiplas camadas e resume a recomendação de cada
- O resumo executivo, se as camadas tiverem recomendações muito diferentes (ex: uma SEGUIR
  e outra NÃO SEGUIR), deve deixar isso claro logo na capa — usar o status da camada mais
  avançada ou crítica, mas explicitar no Contexto que há divergência entre as camadas

**Nunca forçar uma recomendação única quando as camadas legitimamente divergem** — isso
mascararia exatamente o tipo de nuance que o problem-framing trabalhou para identificar.

---

## Checklist de qualidade

**Geral**
- [ ] Etapas disponíveis identificadas corretamente — nenhuma etapa ausente foi inventada
- [ ] Recomendação final corresponde à etapa mais avançada disponível
- [ ] Se há múltiplas camadas com recomendações diferentes, isso está explícito em ambos os documentos

**Dossiê completo**
- [ ] TL;DR com as 4 frases obrigatórias
- [ ] Nav de etapas reflete corretamente o que está disponível (ativa/inativa)
- [ ] Seções de etapas ausentes foram removidas do HTML, não deixadas vazias
- [ ] Dúvidas pendentes consolidadas, máximo 6, sem duplicar listas completas
- [ ] Gerado a partir do template `references/demand-summary-full-template.html` sem alterar CSS

**Resumo executivo**
- [ ] Só gerado se há recomendação (problem-framing ou feature-investment)
- [ ] Seção de Números que Importam presente apenas se houver feature-investment
- [ ] Recomendação negativa comunicada com a mesma clareza que uma positiva — sem suavizar
- [ ] Próximos passos com responsável e prazo
- [ ] Gerado a partir do template `references/demand-summary-exec-template.html` sem alterar CSS