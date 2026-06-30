---
name: problem-framing
description: >
  Use esta skill para descobrir se a demanda estruturada pelo business-analyst é o problema real
  ou sintoma de outra coisa, e recomendar formalmente se vale a pena seguir adiante ou não.
  Gatilhos: "qual é o problema real", "isso é sintoma de quê", "vale a pena seguir com essa
  demanda", "causa raiz", "essa demanda deveria virar projeto", "framing do problema",
  "devo investigar isso ou não", "recomendação de seguir ou não seguir".
  INPUT: documento estruturado do business-analyst (requisitos, regras, premissas, dúvidas).
  OUTPUT: documento de framing do problema com causa raiz e recomendação explícita de
  SEGUIR ou NÃO SEGUIR — com justificativa.
---

# Problem Framing — Causa Raiz e Recomendação de Seguir

Segunda skill do pipeline de Análise de Demanda. Entra depois do business-analyst.

**Objetivo:** descobrir se a demanda é o problema real ou sintoma de outra coisa,
e recomendar explicitamente se vale a pena seguir adiante.

Pipeline:
business-analyst → **problem-framing** → feature-investment → [discovery de processo, se aprovado]

---

## Propósito

A demanda como foi pedida quase nunca é o problema real.

"Preciso de um dashboard" pode ser sintoma de "ninguém confia nos dados que já existem."
"Preciso automatizar X" pode ser sintoma de "X não deveria nem existir do jeito que existe hoje."

Esta skill existe para fazer a pergunta que ninguém faz quando está animado com uma solução:
**o que realmente está causando essa dor, e essa demanda ataca a causa ou só o sintoma?**

Ao final, a skill toma posição — recomenda seguir ou não seguir, com justificativa.
Isso é diferente de só apresentar análise neutra: aqui há uma decisão.

---

## Inputs necessários

| Input | Obrigatório | Origem |
|---|---|---|
| Documento estruturado da demanda | ✅ | business-analyst |
| Requisitos funcionais e não funcionais | ✅ | business-analyst |
| Regras de negócio e exceções | ✅ | business-analyst |
| Premissas e dúvidas pendentes | ✅ | business-analyst |
| Contexto adicional do usuário, se houver | ⬜ | Usuário |

Se o documento do business-analyst não foi fornecido, avisar antes de prosseguir:

> "Para um framing preciso, preciso do documento estruturado do business-analyst primeiro.
> Quer rodar essa skill agora, ou prefiro trabalhar direto com o que você descreveu?"

---

## Como operar

### Passo 1 — Separar sintoma de causa

Ler os requisitos funcionais e o resumo da demanda. Para cada item, perguntar:

**"Se eu resolver exatamente isso que foi pedido, o problema desaparece — ou só fica menos visível?"**

Se a resposta for "fica menos visível", há uma causa mais profunda não capturada na demanda original.

**Técnica dos 5 Porquês adaptada:**
Aplicar de forma direta, sem forçar exatamente 5 iterações — parar quando a resposta deixar
de ser algo que a organização controla.

Exemplo:
> Demanda: "Preciso de um sistema para validar documentos automaticamente."
> Por quê? → Porque a conferência manual tem muitos erros.
> Por quê? → Porque as instruções chegam em formatos diferentes.
> Por quê? → Porque não existe um padrão definido com o cliente.
> Por quê? → Porque ninguém formalizou esse padrão até hoje.
>
> Causa raiz candidata: ausência de padronização na entrada do processo — não a falta de
> validação automática. Automatizar a validação sem padronizar a entrada ataca o sintoma.

### Passo 2 — Classificar o tipo de problema

Classificar a demanda em uma das categorias abaixo. A categoria muda a recomendação.

| Tipo | Característica | Implicação |
|---|---|---|
| **Problema estrutural** | Causa raiz está em como o processo é desenhado | Precisa de discovery de processo antes de qualquer solução |
| **Problema de dado** | Causa raiz é falta de dado confiável ou rastreável | Pode precisar de tratamento de dado antes de automação |
| **Problema de governança** | Causa raiz é ausência de dono, regra ou padrão definido | Precisa de decisão organizacional antes de ferramenta |
| **Sintoma isolado** | A demanda já é a causa raiz — não há nada mais profundo | Pode seguir direto para avaliação de investimento |
| **Demanda política** | Motivada por pressão ou urgência sem problema operacional claro | Avaliar com cautela — risco de investir em algo sem causa real |

### Passo 3 — Avaliar se a demanda ataca a causa ou o sintoma

Comparar o que foi pedido (requisitos funcionais do business-analyst) com a causa raiz identificada.

Três cenários possíveis:

**Ataca a causa diretamente**
A solução pedida, se implementada, resolve a causa raiz. Pode seguir.

**Ataca o sintoma, mas é um passo válido**
A solução não resolve a causa, mas reduz a dor enquanto a causa não é tratada.
Pode seguir, mas com recomendação explícita de tratar a causa em paralelo ou depois.

**Ataca só o sintoma e mascara a causa**
A solução faz o problema parecer resolvido, mas a causa segue intacta e vai se manifestar
de outra forma. Recomendação de não seguir como está — reformular a demanda primeiro.

### Passo 4 — Verificar critérios de prontidão

Antes de recomendar seguir, checar se a demanda está pronta para avançar:

- [ ] A causa raiz foi identificada com razoável confiança (não é só suposição)
- [ ] Existe um dono claro do problema do lado do negócio
- [ ] O problema afeta algo mensurável (tempo, custo, risco, qualidade)
- [ ] Não depende de uma decisão organizacional maior ainda não tomada
- [ ] Não é resultado de uma demanda política sem operação real por trás

Se 2 ou mais critérios falharem, a recomendação tende para NÃO SEGUIR ainda — não significa
descartar a demanda, significa que falta resolver algo antes de investir tempo de discovery.

### Passo 5 — Formular a recomendação

A recomendação é sempre uma das três:

**SEGUIR**
A causa raiz foi identificada, a demanda ataca a causa (ou um passo válido em direção a ela),
e os critérios de prontidão foram atendidos.

**SEGUIR COM RESSALVA**
Vale avançar, mas algo precisa ser resolvido em paralelo — geralmente uma causa estrutural
mais profunda que a solução pedida não resolve sozinha.

**NÃO SEGUIR AGORA**
Falta causa raiz clara, falta dono, ou a demanda mascara um problema maior. Recomendação de
voltar ao business-analyst com perguntas mais específicas, ou esperar uma decisão organizacional
anterior ser tomada.

---

## Estrutura do documento de saída

```markdown
# Problem Framing — [Nome da Demanda]

## Demanda Original
[Como foi pedida, em uma frase]

## Causa Raiz Identificada
[Resultado da análise dos 5 porquês — 2-4 linhas]

## Tipo de Problema
[Estrutural / Dado / Governança / Sintoma isolado / Demanda política]

## A Demanda Ataca a Causa?
[Ataca diretamente / Ataca o sintoma como passo válido / Ataca só o sintoma]

## Critérios de Prontidão
- [x] ou [ ] Causa raiz identificada com confiança
- [x] ou [ ] Dono claro do problema
- [x] ou [ ] Problema afeta algo mensurável
- [x] ou [ ] Não depende de decisão organizacional pendente
- [x] ou [ ] Não é demanda política sem operação real

## Recomendação

**[SEGUIR / SEGUIR COM RESSALVA / NÃO SEGUIR AGORA]**

[Justificativa em 3-5 linhas — por que essa é a recomendação, o que foi decisivo]

## Se SEGUIR COM RESSALVA ou NÃO SEGUIR — o que precisa acontecer antes
- [Ação específica]
- [Quem deveria resolver]
```

---

## Anti-padrões a evitar

**Não confundir urgência com causa raiz.**
"O chefe quer isso rápido" não é causa raiz — é contexto de prazo. A causa raiz está no
problema operacional, não na pressão para resolver.

**Não aceitar a primeira explicação como causa raiz.**
Se a primeira resposta ao "por quê" ainda é algo que a pessoa entrevistada não controla
totalmente, continuar perguntando.

**Não recomendar SEGUIR só porque o documento do business-analyst está bem feito.**
Documento bem estruturado não significa causa raiz clara. São coisas diferentes.

**Não usar jargão para parecer mais analítico.**
"Causa raiz sistêmica de segunda ordem" é jargão. "O processo não tem dono" é causa raiz.

---

## Checklist de qualidade

- [ ] Causa raiz identificada com técnica explícita (5 porquês ou equivalente), não suposição
- [ ] Tipo de problema classificado entre as 5 categorias
- [ ] Comparação clara entre o que foi pedido e o que resolveria a causa
- [ ] Todos os 5 critérios de prontidão avaliados
- [ ] Recomendação é uma das três opções formais — nunca ambígua
- [ ] Se SEGUIR COM RESSALVA ou NÃO SEGUIR, ações concretas estão listadas
- [ ] Nenhum cálculo de ROI ou custo incluído — isso pertence ao feature-investment
