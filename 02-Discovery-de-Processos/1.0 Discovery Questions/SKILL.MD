---
name: discovery-questions
description: >
  Use esta skill para gerar perguntas precisas e estruturadas sobre um processo de negócio.
  Acionar sempre que o usuário quiser: gerar perguntas para uma sessão de mapeamento de processo,
  preparar uma entrevista com o time de negócio, preencher a seção "Dúvidas em Aberto" do DDVP,
  ou identificar o que ainda não se sabe sobre um processo antes de mapeá-lo ou automatizá-lo.
  Gatilhos: "que perguntas eu faço", "perguntas pra reunião", "o que perguntar pro negócio",
  "dúvidas sobre o processo", "o que ainda não sei sobre o processo", "perguntas de mapeamento",
  "quero entender melhor o processo", "preencher dúvidas em aberto", "gerar as perguntas do DDVP".
  INPUT: output do meeting-extractor ou descrição do processo pelo usuário.
  OUTPUT: lista de perguntas por categoria, sem limite artificial — tantas quanto as lacunas reais.
  Alimenta diretamente a seção 06 do ddvp-negocio.
---

# Discovery Questions — Perguntas Precisas de Processo

Gera perguntas de mapeamento organizadas por categoria para o time de negócio.
Não gera perguntas genéricas. Cada pergunta nasce de uma lacuna real no entendimento do processo.

Pipeline:
meeting-extractor → **discovery-questions** → ddvp-negocio → language-editor → presentation-deck

---

## Princípio fundamental

**Inspirado no meeting-extractor:**
Uma extração que mistura fato com suposição contamina tudo que vem depois.
Uma pergunta genérica que não nasce de uma lacuna real desperdiça o tempo do negócio.

Antes de gerar qualquer pergunta, a skill separa:
- O que já se sabe (fatos confirmados)
- O que se assume (suposições não verificadas)
- O que está em aberto (lacunas reais)

**Só lacunas reais viram perguntas.**

---

## Inputs necessários

Coletar antes de gerar as perguntas. Extrair do contexto se já fornecido.

| Input | Obrigatório | Exemplo |
|---|---|---|
| Nome do processo | ✅ | "Conferência de documentos de exportação" |
| Etapas conhecidas | ✅ | Lista bruta das etapas |
| Responsáveis identificados | ✅ | Quem faz o quê (mesmo que parcial) |
| Ferramentas usadas | ⬜ | E-mail, planilha, ERP |
| Dores mencionadas | ⬜ | O que o time reclama |
| Dados já coletados | ⬜ | Volumes, tempos, taxas |
| Exceções conhecidas | ⬜ | O que quebra, casos especiais |

Se o usuário já tem um output do meeting-extractor ou descrição do processo, extrair tudo dali antes de perguntar.

---

## O que NÃO gerar

Perguntas de implementação ou solução não pertencem ao mapeamento de processo.

❌ Não gerar:
- "Qual ferramenta de automação vocês preferem?"
- "Com qual cliente faz sentido começar o piloto?"
- "Vocês teriam orçamento para uma solução?"
- "Há interesse em expandir para outros mercados?"

✅ Gerar apenas:
- Perguntas sobre como o processo funciona HOJE
- Perguntas sobre quem faz o quê e quando
- Perguntas sobre volume, tempo, erro e exceção
- Perguntas sobre o que não está registrado ou não tem dono

---

## As 7 categorias

Cada categoria deve ser verificada. Se não houver lacuna real em uma categoria, ela fica em branco — não forçar perguntas onde não existem lacunas.

**Sem limite de perguntas por categoria e sem total mínimo ou máximo.**
O número de perguntas é determinado pelo número de lacunas reais identificadas no processo — nem mais, nem menos.

### Categoria 1 — Volume e Frequência
**O que queremos saber:** Quanto acontece? Com que regularidade? Tem pico?

Lacunas típicas:
- Volume mencionado sem fonte confirmada
- Sazonalidade desconhecida
- Crescimento esperado não mapeado

Exemplo de pergunta precisa:
> "Você mencionou ~578 BLs. Esse número vem de qual fonte — sistema, planilha, estimativa? E é por mês ou por trimestre?"

Exemplo de pergunta genérica (evitar):
> "Qual é o volume do processo?"

### Categoria 2 — Tempo e SLA
**O que queremos saber:** Quanto tempo cada etapa leva? Existe prazo definido? O que acontece quando não cumpre?

Lacunas típicas:
- Etapas sem tempo estimado
- SLA informal ou inexistente
- Consequência do atraso não mapeada

Exemplo de pergunta precisa:
> "Desde que a instrução chega até o documento ser emitido, qual é o tempo esperado? E qual é o tempo real na maioria dos casos?"

### Categoria 3 — Responsabilidade e Backup
**O que queremos saber:** Quem decide? Quem executa? O que acontece quando o responsável falta?

Lacunas típicas:
- Responsável identificado mas sem substituto
- Decisão centralizada em uma pessoa
- Responsabilidade compartilhada sem critério claro

Exemplo de pergunta precisa:
> "Quando o Leonardo está de férias ou ausente, quem assume a conferência dos documentos? Existe um substituto formal ou acontece de forma improvisada?"

**Ponto de concentração de conhecimento é risco operacional — sempre verificar se existe substituto.**

### Categoria 4 — Exceções e Erros
**O que queremos saber:** O que quebra? Com que frequência? Quem resolve? Como é tratado hoje?

Lacunas típicas:
- Exceções mencionadas sem frequência ou tratamento definido
- Taxa de erro desconhecida
- Tratamento de exceção improvisado sem registro

Exemplo de pergunta precisa:
> "Quando um documento volta com divergência, qual é o passo a passo do time hoje? Existe um critério para decidir quando pedir reenvio versus corrigir internamente?"

### Categoria 5 — Dados e Rastreabilidade
**O que queremos saber:** O que é registrado? Onde? Quem acessa? O que se perde?

Lacunas típicas:
- Processo executado sem registro
- Registro em planilha pessoal, não compartilhada
- Histórico de decisões não documentado

Exemplo de pergunta precisa:
> "Existe algum registro do histórico de revisões de cada BL — quantas idas e vindas teve, quem aprovou, quando foi emitido? Ou isso fica apenas no e-mail?"

**Ausência de rastreabilidade é dado relevante — registrar explicitamente quando não existe.**

### Categoria 6 — Dependências Externas
**O que queremos saber:** O que depende de terceiro, de outro sistema, de outro time? Qual o impacto quando essa dependência falha?

Lacunas típicas:
- Terceiro identificado mas sem acordo de prazo
- Dependência de sistema legado sem alternativa
- Aprovação de outro time sem prazo definido

Exemplo de pergunta precisa:
> "O terceiro que emite o BL — existe um acordo de prazo com ele? Se ele atrasar ou errar, qual é o canal e o prazo para correção?"

### Categoria 7 — Suposições Críticas Não Verificadas
**O que queremos saber:** O que o time assume como verdade mas nunca verificou formalmente?

**Inspirado diretamente no meeting-extractor:**
> "Suposições ditas de passagem em reunião frequentemente viram premissas em documentos sem que ninguém perceba a transição."

Lacunas típicas:
- Dados citados pelo dono da demanda sem fonte
- "Acho que funciona assim" dito por uma pessoa
- Afirmações sobre o cliente ou terceiro sem confirmação direta

Exemplo de pergunta precisa:
> "Na reunião foi mencionado que 'os japoneses não passam nada com erro'. Isso é uma percepção ou existe algum dado que confirme a taxa de erro por cliente?"

---

## Como gerar as perguntas

### Passo 1 — Mapear o que já se sabe

Ler o conteúdo disponível (output do meeting-extractor, descrição do processo, DDVP parcial) e listar:
- Fatos confirmados → não viram perguntas
- Suposições identificadas → candidatas a perguntas da Categoria 7
- Lacunas explícitas → perguntas das Categorias 1 a 6

### Passo 2 — Identificar lacunas por categoria

Para cada uma das 7 categorias, verificar:
- Há alguma informação sobre isso no que já se sabe?
- Se não há, ou se é uma suposição, gerar uma pergunta
- Se a categoria não tem lacuna relevante para este processo, deixar em branco

### Passo 3 — Formular a pergunta com contexto

Cada pergunta deve:
- Referenciar algo específico do processo (não ser genérica)
- Ter uma única lacuna como alvo (não misturar duas perguntas em uma)
- Ser formulada de forma que o time de negócio consiga responder (sem jargão técnico)
- Indicar quem deve responder quando possível

### Passo 4 — Verificar saturação e maturidade do processo

A lista está saturada quando todas as categorias com lacunas reais foram cobertas e não há mais lacunas relevantes identificadas no processo descrito.

Não gerar perguntas além das lacunas reais. Não forçar perguntas em categorias sem lacuna.

**Regra de priorização por maturidade do processo:**

Se o meeting-extractor indicou processo imaturo ou caótico — sem dono claro, sem dados, sem registro, com múltiplas contradições — aplicar a seguinte regra antes de entregar a lista:

1. Ordenar as perguntas por categoria de impacto: Categoria 1 (Volume), Categoria 4 (Erros) e Categoria 7 (Suposições) primeiro
2. Sinalizar ao usuário: "O processo parece ainda pouco estruturado. Sugiro começar pelas 3 perguntas mais críticas abaixo e avançar para as demais após as respostas iniciais."
3. Entregar a lista completa — mas destacar as 3 prioritárias no topo

**O que não fazer:** cortar perguntas legítimas porque o processo é caótico. Processo caótico precisa de mais entendimento, não de menos perguntas — só precisa de sequenciamento melhor.

---

## Integração com o pipeline

Esta skill alimenta diretamente o ddvp-negocio:

- Perguntas desta skill → seção 06 do DDVP (Dúvidas em Aberto)
- Suposições identificadas → seção 08 do DDVP (Premissas)
- Fatos confirmados → seção 05 do DDVP (Dados Conhecidos) ou seção 03 (Fluxo)

**Nunca misturar:** o que é fato não entra como dúvida. O que é dúvida não entra como premissa.

---

## Formato de saída

As perguntas são entregues em duas formas. Perguntar ao usuário qual prefere antes de entregar.

### Forma 1 — Para o DDVP (seção 06)
Perguntas numeradas, organizadas por categoria, com indicação de quem responde.

```
Categoria: Volume e Frequência

1. [Pergunta específica]
   Quem responde: [nome ou papel]

2. [Pergunta específica]
   Quem responde: [nome ou papel]

Categoria: Tempo e SLA

3. [Pergunta específica]
   Quem responde: [nome ou papel]
```

### Forma 2 — Para preparação de reunião
Lista priorizada com contexto de por que cada pergunta importa.

```
Prioridade alta (bloqueia o diagnóstico sem resposta):
1. [Pergunta] — Por quê: [lacuna que resolve]

Prioridade média (enriquece o diagnóstico):
2. [Pergunta] — Por quê: [lacuna que resolve]
```

---

## Checklist de qualidade

- [ ] Cada pergunta nasce de uma lacuna real — nenhuma é genérica
- [ ] Nenhuma pergunta é de implementação ou solução
- [ ] Suposições críticas da reunião estão na Categoria 7
- [ ] Cada pergunta tem indicação de quem deve responder
- [ ] Categorias sem lacuna real foram deixadas em branco — não forçadas
- [ ] Fatos já confirmados não viraram perguntas desnecessárias
- [ ] Perguntas estão em linguagem que o time de negócio entende — sem jargão técnico