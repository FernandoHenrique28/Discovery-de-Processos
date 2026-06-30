# Skills — Discovery e Mapeamento de Processo
**Raízen · Time de Dados e Produto**

Pipeline de skills para mapear processos internos, validar com o negócio e apresentar para liderança.

---

## Pipeline Completo

```
00  meeting-extractor          ← transcrição bruta da reunião
        ↓
00.5 discovery-questions       ← perguntas precisas por lacuna real
        ↓
01  ddvp-negocio               ← documento de validação com o negócio
        ↓
    language-editor            ← revisão antes de enviar ao negócio
        ↓
02  presentation-deck          ← versão executiva para o chefe / liderança
        ↓
03  discovery-process-interno  ← diagnóstico crítico antes de automatizar
        ↓
    [especificação técnica]    ← próxima etapa (skill a criar)
```

---

## Quando usar cada skill

| Skill | Quando acionar |
|---|---|
| `meeting-extractor` | Sempre — é a primeira skill. Qualquer transcrição de reunião entra aqui antes de qualquer outra coisa |
| `discovery-questions` | Após o meeting-extractor, para gerar as perguntas que vão para a seção 06 do DDVP |
| `ddvp-negocio` | Quando você tem o output do meeting-extractor + as perguntas da discovery-questions e precisa enviar um documento para o time de negócio validar |
| `language-editor` | Antes de enviar qualquer documento para fora do seu time (DDVP, versão executiva). Não usar em documentos internos |
| `presentation-deck` | Após o DDVP validado, quando precisa apresentar os achados para o chefe ou liderança que não participou do processo |
| `discovery-process-interno` | Após a liderança aprovar avançar. Antes de qualquer especificação técnica ou automação |

---

## Quando NÃO passar pelo language-editor

O `language-editor` é para documentos que saem do seu time. Não usar em:

- Output do `meeting-extractor` — é rascunho interno, só você lê
- Output do `discovery-process-interno` — é diagnóstico interno
- Suas anotações e markdowns de trabalho

Usar obrigatoriamente em:
- DDVP antes de enviar ao negócio
- Versão executiva antes de enviar à liderança

---

## Skills do conjunto

### 00 — meeting-extractor
**O que faz:** Transforma transcrição bruta (Teams ou WhatsApp/TurboScribe) em insumo estruturado.

**Input:** Transcrição bruta colada no chat.

**Output:** Markdown com contexto, participantes, problema relatado (fatos vs suposições), evidências, urgência, custo do erro, lacunas, próximos passos e dinâmica da reunião.

**Detalhe importante:** Separa explicitamente fato de suposição. Suposições sem evidência são marcadas como `[requer validação]`. Se o custo financeiro do erro não foi mencionado na reunião, registra como lacuna.

---

### 00.5 — discovery-questions
**O que faz:** Gera perguntas precisas por categoria a partir das lacunas reais identificadas no meeting-extractor.

**Input:** Output do meeting-extractor ou descrição do processo.

**Output:** Lista de perguntas organizadas por categoria (volume, tempo, responsabilidade, erros, dados, dependências, suposições), com indicação de quem responde cada uma.

**Regra importante:** Só lacunas reais viram perguntas — sem perguntas genéricas. Se o processo for imaturo ou caótico, as perguntas são priorizadas por impacto (Categorias 1, 4 e 7 primeiro) mas a lista completa é entregue.

**Alimenta:** Seção 06 do DDVP (Dúvidas em Aberto) e Seção 08 (Premissas).

---

### 01 — ddvp-negocio
**O que faz:** Gera o Documento de Descoberta e Validação de Processo para o time de negócio.

**Input:** Output do meeting-extractor + perguntas da discovery-questions + nome do analista + nome do contato de negócio.

**Output:** HTML gerado a partir do template `references/ddvp-template-raizen.html`.

**Template:** `references/ddvp-template-raizen.html` — nunca recriar o CSS, apenas preencher os slots.

**Seções do documento:**
- 00 Resumo Executivo (Entendemos que / Precisamos validar / Por que estamos olhando para isso)
- 01 Objetivo
- 02 Escopo
- 03 Fluxo Atual
- 04 Principais Gargalos
- 05 Dados Conhecidos
- 06 Dúvidas em Aberto
- 08 Premissas

**Passa pelo language-editor antes de enviar.**

---

### language-editor
**O que faz:** Revisa artefatos em português brasileiro para clareza, consistência e tom executivo.

**Quando usar:** Antes de enviar qualquer documento para fora do time (DDVP, versão executiva).

**O que não altera:** Números, conclusões, nomes, datas, grau de confiança.

**O que revisa:** Jargão técnico, frases longas, voz passiva, nominalizações, conclusão enterrada no fim da seção.

**Jargões proibidos:** discovery, assessment, stakeholder, dor, deliverable, sprint, roadmap, owner, quick win, backlog, North Star, pivotar, trade-off, pipeline (quando usado como jargão de produto).

---

### 02 — presentation-deck
**O que faz:** Transforma o conteúdo do DDVP em uma versão executiva em HTML para enviar ao chefe ou liderança.

**Diferença do DDVP:** Remove fluxo detalhado, dúvidas operacionais e premissas. Adiciona recomendação explícita e próximos passos com prazo.

**Input:** DDVP gerado + recomendação de próximo passo (vem do analista, não do DDVP) + prazo.

**Output:** HTML gerado a partir do template `references/executive-template-raizen.html`.

**Template:** `references/executive-template-raizen.html` — nunca recriar o CSS, apenas preencher os slots.

**Seções do documento:**
- Capa (status: visão executiva)
- Contexto (por que este documento)
- 01 Números que Importam
- 02 O que Encontramos
- 03 Recomendação
- 04 Próximos Passos

**Passa pelo language-editor antes de enviar.**

---

### 03 — discovery-process-interno
**O que faz:** Conduz um diagnóstico crítico do processo antes de qualquer automação ou especificação técnica.

**Quando usar:** Após a liderança aprovar avançar. Responde: *"estamos prestes a automatizar um processo bom — ou apenas acelerar um processo ruim?"*

**Input:** DDVP validado + respostas do negócio às dúvidas em aberto.

**Output:** Documento de Discovery de Processo publicado no Confluence.

**Não usar:** Logo após a primeira reunião (cedo demais), quando o processo já é maduro e bem documentado, ou quando a liderança ainda não aprovou avançar.

**Fases:**
1. Enquadramento do problema (Dia 1–2)
2. Mapeamento do processo atual — As-Is (Dia 2–4)
3. Análise crítica — falhas, gargalos, automação prematura (Dia 4–6)
4. Síntese e priorização (Dia 6–8)
5. Documento de Discovery no Confluence (Dia 8–10)

---

## Templates visuais

| Arquivo | Usado por | Descrição |
|---|---|---|
| `references/ddvp-template-raizen.html` | ddvp-negocio | Template do DDVP com identidade visual Raízen |
| `references/executive-template-raizen.html` | presentation-deck | Template da versão executiva — mais direto e impactante |

**Regra:** Nunca recriar o CSS dos templates. A skill lê o template, preenche os slots `[entre colchetes]`, e salva o arquivo. O design não muda entre gerações.

---

## Cores Raízen (referência)

| Token | Hex | Uso |
|---|---|---|
| Verde principal | `#005859` | Capa e elementos dominantes (50–70%) |
| Verde-claro | `#76B83E` | Acentos e destaques (até 20%) |
| Verde-escuro | `#023C36` | Títulos e destaques fortes (até 10%) |
| Azul | `#2F6EB8` | Informativo — dúvidas, tags "a confirmar" |
| Cinza | `#6E6E6E` | Metadados e labels |
| Laranja `#F47920` e Vermelho `#DA291C` | — | Exclusivo para temas de segurança — não usar |

---

## FAQ

**Posso usar todas as skills em um prompt só?**
Não recomendado. Cada skill precisa de validação humana antes de avançar. O DDVP depende de respostas do negócio que não existem ainda quando você está no meeting-extractor.

**O discovery-questions tem limite de perguntas?**
Não. O número de perguntas é determinado pelo número de lacunas reais — nem mais, nem menos. Se o processo for caótico, as perguntas são priorizadas mas não cortadas.

**Quando o custo do erro não aparece na transcrição?**
O meeting-extractor registra como `[lacuna: custo do erro não capturado]`. Essa lacuna deve virar uma pergunta na discovery-questions (Categoria 2 — Tempo e SLA) antes de chegar ao DDVP.

**A skill de discovery-process-interno é obrigatória?**
Não. Use quando há risco real de automatizar um processo ruim. Para processos simples e bem estruturados, pode ir direto para a especificação técnica após o DDVP validado.