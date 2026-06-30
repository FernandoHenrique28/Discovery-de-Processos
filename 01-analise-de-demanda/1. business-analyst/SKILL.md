---
name: business-analyst
description: >
  Use esta skill para estruturar uma demanda de negócio antes de qualquer análise de processo —
  gera perguntas para entrevista com o stakeholder e, depois, organiza o que foi dito em
  requisitos, regras de negócio, exceções, premissas e dúvidas pendentes.
  Gatilhos: "estruturar a demanda", "preparar entrevista com o stakeholder", "que perguntas eu
  faço pra entender essa demanda", "organizar os requisitos", "extrair requisitos da reunião",
  "documento de levantamento de requisitos", "business analyst", "entender a necessidade de negócio".
  INPUT: mensagem solta, transcrição de reunião do Teams, ou descrição informal da demanda.
  OUTPUT: (1) perguntas de entrevista, se a demanda ainda não foi explorada; (2) documento
  estruturado de requisitos, se a entrevista já aconteceu.
  NÃO faz: análise crítica do processo, causa raiz, recomendação de solução, cálculo de ROI,
  priorização. Essas etapas pertencem às skills seguintes do pipeline.
---

# Business Analyst — Estruturação da Demanda

Primeira skill do pipeline de Análise de Demanda. Entra antes de qualquer mapeamento de processo.

**Objetivo:** entender e estruturar a necessidade de negócio — nada além disso.

Pipeline:
**business-analyst** → problem-framing → feature-investment → [discovery de processo, se aprovado]

---

## Propósito

Toda demanda chega crua — uma mensagem no Teams, uma reunião informal, um pedido de corredor.
Antes de decidir se vale a pena seguir (problem-framing) ou mapear o processo (discovery de processo),
alguém precisa fazer a pergunta mais básica: **o que exatamente está sendo pedido, e o que falta saber?**

Esta skill não julga a demanda. Não diz se é boa ideia. Não calcula custo.
Ela organiza — e prepara o terreno para que as próximas skills possam julgar com informação completa.

---

## Os dois modos de operação

A skill identifica automaticamente em qual modo operar, com base no input recebido.

### Modo 1 — Antes da entrevista (demanda ainda não explorada)

**Quando ativa:** o usuário descreve a demanda de forma resumida, sem transcrição de conversa
aprofundada. Ex: "meu chefe pediu pra eu ver um jeito de agilizar o fechamento mensal."

**O que a skill faz:**
1. Identificar o que já se sabe e o que está faltando
2. Gerar perguntas específicas para a entrevista com o stakeholder
3. Adaptar as perguntas ao domínio da demanda (financeiro, RH, logística, dados, comercial etc.)

### Modo 2 — Depois da entrevista (conversa já aconteceu)

**Quando ativa:** o usuário fornece transcrição do Teams, anotações de reunião, ou relato
detalhado de uma conversa que já ocorreu.

**O que a skill faz:**
1. Organizar o que foi dito
2. Extrair requisitos funcionais e não funcionais
3. Identificar regras de negócio, exceções, premissas, dependências
4. Registrar dúvidas que ainda ficaram pendentes
5. Produzir o documento estruturado final

**Se o usuário fornecer os dois** (perguntas já geradas + transcrição da entrevista que respondeu
essas perguntas), a skill pula direto para o Modo 2, mas verifica se todas as perguntas originais
foram respondidas — perguntas sem resposta viram dúvidas pendentes no documento final.

---

## Modo 1 — Gerar Perguntas de Entrevista

### Passo 1 — Mapear o que já se sabe

Ler a descrição da demanda e identificar:
- Quem pediu (nome, área, papel)
- O que foi pedido, em linguagem direta
- Qualquer contexto adicional já mencionado (urgência, motivo, tentativas anteriores)

### Passo 2 — Identificar o domínio da demanda

O domínio muda quais perguntas fazem sentido. Identificar entre:

| Domínio | Sinal de identificação |
|---|---|
| Financeiro | Menção a fechamento, custos, orçamento, faturamento, contas a pagar/receber |
| Logística / Operações | Menção a estoque, transporte, armazém, fornecedor, entrega |
| Comercial / Trade | Menção a cliente, contrato, pedido, exportação, vendas |
| Dados / TI | Menção a sistema, relatório, dashboard, integração, automação |
| RH / Pessoas | Menção a colaborador, contratação, folha, benefícios |
| Indefinido | Não há sinal claro — perguntar ao usuário antes de gerar perguntas |

Se o domínio for indefinido, perguntar ao usuário antes de prosseguir — perguntas genéricas
demais não ajudam a entrevista.

### Passo 3 — Gerar perguntas por categoria

Sempre cobrir estas 8 categorias. Adaptar o conteúdo de cada uma ao domínio identificado.

**1. Origem e motivação**
- Por que essa demanda surgiu agora? Algo mudou recentemente?
- Quem mais sente esse problema, além de quem pediu?

**2. Mapa de Stakeholders**
Não confundir com "quem pediu" — o solicitante é só um dos papéis. Sempre perguntar pelos
outros explicitamente, mesmo que pareça óbvio:
- Quem é o patrocinador? (quem aprova orçamento ou prioridade, se for diferente de quem pediu)
- Quem precisa aprovar antes de avançar? (pode ser mais de uma pessoa ou área)
- Quem vai usar a solução no dia a dia, além de quem pediu?
- Quem é impactado mesmo sem usar diretamente? (áreas que recebem o output, terceiros, clientes)

**3. Estado atual**
- Como isso é feito hoje, sem a mudança pedida?
- Quem executa isso atualmente?

**4. Critérios de Sucesso**
Esta categoria é obrigatória e não pode ser respondida de forma vaga. Insistir até obter algo
específico — não aceitar "vai ficar melhor" ou "vai ficar mais rápido" sem um número ou
estado concreto associado.
- Como você vai saber que essa demanda foi resolvida? O que precisa ser verdade?
- Existe um número, prazo ou estado específico que define sucesso? (ex: "ciclo cair de 7 para 2 dias")
- Quem mais precisa concordar que isso foi resolvido, além de você?

**5. Escopo e limites**
- Isso afeta só essa área, ou outras áreas também são impactadas?
- Existe algo que definitivamente não deve mudar?

**6. Tentativas anteriores**
- Já tentaram resolver isso antes? O que aconteceu?
- Existe alguma solução parcial em uso hoje?

**7. Restrições conhecidas**
- Existe orçamento, prazo ou recurso já definido para isso?
- Algum sistema, contrato ou processo externo limita o que pode ser feito?

**8. Urgência e prazo**
- Existe um prazo ou marco que torna isso urgente?
- O que acontece se isso não for resolvido nos próximos meses?

**Exemplo adaptado — domínio Financeiro:**
> "Você mencionou o fechamento mensal. Hoje, quantos dias leva do fim do mês até o fechamento
> estar pronto? E quais áreas precisam entregar informação antes desse fechamento começar?"

**Exemplo adaptado — domínio Logística:**
> "Você mencionou atraso na separação de pedidos. Isso acontece em todos os centros de
> distribuição ou só em algum específico? Existe sazonalidade nesse atraso?"

**Exemplo — Critérios de Sucesso mal respondido vs bem respondido:**
> Mal respondido: "Vai ficar mais ágil." → Insistir.
> Bem respondido: "Vou saber que resolveu quando o ciclo de revisão cair de 7 para 2 dias,
> e o Thiago confirmar que não precisa mais aprovar manualmente cada exceção."

### Saída do Modo 1

Lista de perguntas organizadas pelas 8 categorias, prontas para guiar a entrevista com o stakeholder.
Formato:

```
Categoria: Origem e Motivação

1. [Pergunta adaptada ao domínio]
2. [Pergunta adaptada ao domínio]

Categoria: Estado Atual

3. [Pergunta adaptada ao domínio]
...
```

---

## Modo 2 — Estruturar a Demanda Pós-Entrevista

### Passo 1 — Ler o conteúdo disponível

Transcrição do Teams, anotações ou relato da conversa.
Se as perguntas do Modo 1 foram geradas antes, conferir quais foram respondidas e quais não.

### Passo 2 — Extrair os blocos estruturados

**Mapa de Stakeholders**
Registrar todos os papéis identificados — não confundir solicitante com os demais.
Se um papel não foi mencionado na conversa, marcar como `[não identificado — perguntar]`
em vez de deixar em branco ou supor.

| Papel | Nome | Observação |
|---|---|---|
| Solicitante | [Nome] | Quem fez o pedido |
| Patrocinador | [Nome ou "mesmo que solicitante"] | Quem aprova orçamento/prioridade |
| Aprovador(es) | [Nome(s)] | Quem precisa validar antes de avançar |
| Usuários | [Nome(s) / Área] | Quem vai usar a solução no dia a dia |
| Impactados | [Nome(s) / Área] | Quem recebe o efeito sem usar diretamente |

Exemplo:
> - Solicitante: Thiago (Operações de Trade)
> - Patrocinador: mesmo que solicitante
> - Aprovador: Leandro (Liderança) — precisa validar antes de qualquer investimento
> - Usuários: Time operacional de conferência (Leonardo e equipe)
> - Impactados: Financeiro (recebe o documento para liberar pagamento), Cliente (recebe pedidos de clarificação, se a solução incluir isso)

**Critérios de Sucesso**
Resposta à pergunta "como saberemos que isso foi resolvido". Nunca aceitar resposta vaga
sem tentar uma segunda pergunta de aprofundamento durante a extração. Se a transcrição não
tiver uma resposta específica, registrar como dúvida pendente — não inventar um critério.

Formato: estado ou número específico + quem precisa confirmar que foi atingido.

Exemplo:
> - O ciclo de revisão cai de 7 dias para até 2 dias, em média
> - O Thiago não precisa mais aprovar manualmente cada exceção de instrução
> - Critério não foi claramente respondido na entrevista `[requer aprofundamento]`

**Requisitos Funcionais**
O que o resultado precisa fazer — comportamento esperado, em linguagem de negócio.
Formato: "O sistema/processo deve [ação] quando [condição]."

Exemplo:
> - O fechamento mensal deve consolidar os dados das 4 áreas antes do dia 5 útil
> - O relatório deve permitir filtro por centro de custo

**Requisitos Não Funcionais**
Características de qualidade — não é o que faz, é como deve ser.
Categorias comuns: desempenho, segurança, disponibilidade, usabilidade, conformidade.

Exemplo:
> - Os dados financeiros não podem ser editados após o fechamento ser confirmado
> - O processo precisa estar disponível mesmo em períodos de pico (último dia útil)

**Regras de Negócio**
Lógicas que o negócio já segue hoje e que precisam ser respeitadas em qualquer solução.

Exemplo:
> - Despesas acima de R$ 50 mil exigem aprovação de diretoria antes do lançamento
> - Centro de custo sem responsável definido não pode ser fechado

**Exceções**
Casos que fogem da regra geral e que o stakeholder mencionou.

Exemplo:
> - Em mês de fechamento de trimestre, o prazo de consolidação é 2 dias mais curto
> - Filiais internacionais seguem calendário fiscal diferente

**Premissas**
O que está sendo assumido como verdade, mas não foi formalmente confirmado.
Marcar como `[requer validação]` quando a fonte for só uma fala isolada sem evidência.

Exemplo:
> - Assume-se que todas as áreas usam o mesmo sistema de lançamento `[requer validação]`
> - Assume-se que o calendário de fechamento não muda nos próximos 2 anos

**Dependências**
O que esse processo ou demanda depende para funcionar — sistemas, áreas, aprovações externas.

Exemplo:
> - Depende da consolidação prévia feita pela área de Controladoria
> - Depende de aprovação do sistema ERP corporativo, fora do escopo desta área

**Dúvidas Pendentes**
Perguntas que ficaram sem resposta — incluindo as do Modo 1 que não foram respondidas na entrevista.

Exemplo:
> - Não foi possível confirmar se todas as 4 áreas usam o mesmo formato de planilha
> - Pergunta original "existe sazonalidade no atraso?" não foi respondida na conversa

### Passo 3 — Montar o documento estruturado

**Regra de tamanho — resumo executivo obrigatório acima de 200 linhas:**

Se o documento final ultrapassar 200 linhas (comum em demandas com múltiplas camadas, muitos
stakeholders ou muitas dúvidas pendentes), incluir um bloco de **TL;DR** logo após o cabeçalho,
antes do Resumo da Demanda completo.

O TL;DR deve caber em 5 linhas e responder, nessa ordem:
1. O que foi pedido, em uma frase
2. Quantas camadas ou frentes distintas a demanda tem, se houver mais de uma
3. O maior risco ou lacuna identificada (ex: bus factor, ausência de dono, premissa não validada)
4. Quantas dúvidas pendentes ficaram, em número
5. Para onde isso vai a seguir no pipeline (problem-framing)

Formato:
```markdown
> **TL;DR:** [Demanda em uma frase]. A demanda tem [N] camadas distintas: [nomes das camadas].
> Maior risco identificado: [risco]. [N] dúvidas pendentes registradas. Próximo passo: problem-framing.
```

Isso não substitui o Resumo da Demanda completo — é um adicional para quem só vai bater o olho
antes de decidir se lê o documento inteiro.

```markdown
# Levantamento de Requisitos — [Nome da Demanda]

**Solicitante:** [Nome / Área]
**Data da entrevista:** [Data]
**Analista:** [Nome]

[Se o documento ultrapassar 200 linhas, incluir o bloco de TL;DR aqui]

## Resumo da Demanda
[2-3 frases descrevendo o que foi pedido, em linguagem direta]

## Mapa de Stakeholders

| Papel | Nome | Observação |
|---|---|---|
| Solicitante | [Nome] | |
| Patrocinador | [Nome] | |
| Aprovador(es) | [Nome(s)] | |
| Usuários | [Nome(s) / Área] | |
| Impactados | [Nome(s) / Área] | |

## Critérios de Sucesso
- [Estado ou número específico] — confirmado por: [quem]
- [Item 2, se houver]

## Requisitos Funcionais
- [Item 1]
- [Item 2]

## Requisitos Não Funcionais
- [Item 1]
- [Item 2]

## Regras de Negócio
- [Item 1]
- [Item 2]

## Exceções
- [Item 1]

## Premissas
- [Item 1] `[requer validação]` se aplicável

## Dependências
- [Item 1]

## Dúvidas Pendentes
- [Item 1]
```

---

## O que esta skill NÃO faz

Importante deixar explícito — essas etapas pertencem às próximas skills do pipeline:

| Não faz | Pertence a |
|---|---|
| Análise crítica do processo atual | discovery-process-interno |
| Causa raiz profunda do problema | problem-framing |
| Recomendar uma solução | problem-framing / feature-investment |
| Calcular ROI ou custo-benefício | feature-investment |
| Decidir prioridade frente a outras demandas | feature-investment |

Se o usuário pedir qualquer uma dessas coisas durante o uso desta skill, registrar a informação
relevante no documento (ela pode ser útil depois), mas não fazer a análise — apontar que isso
é trabalho da skill seguinte no pipeline.

---

## Checklist de qualidade

**Modo 1 — Perguntas**
- [ ] Domínio da demanda identificado antes de gerar perguntas
- [ ] Todas as 8 categorias cobertas, incluindo Stakeholders e Critérios de Sucesso
- [ ] Perguntas adaptadas ao domínio — não genéricas
- [ ] Nenhuma pergunta sobre solução ou implementação

**Modo 2 — Documento estruturado**
- [ ] Se documento > 200 linhas, bloco de TL;DR incluído no topo com as 5 informações obrigatórias
- [ ] Resumo da demanda em linguagem direta, sem jargão
- [ ] Mapa de Stakeholders preenchido — papéis não identificados marcados como `[não identificado — perguntar]`, nunca deixados em branco ou supostos
- [ ] Critérios de Sucesso são específicos (número ou estado concreto) — resposta vaga marcada como `[requer aprofundamento]`, nunca inventada
- [ ] Requisitos funcionais e não funcionais separados corretamente
- [ ] Regras de negócio distintas de premissas — regra é confirmada, premissa é assumida
- [ ] Premissas sem evidência marcadas como `[requer validação]`
- [ ] Dúvidas pendentes incluem perguntas do Modo 1 que ficaram sem resposta
- [ ] Nenhuma análise de causa raiz, ROI ou recomendação de solução incluída