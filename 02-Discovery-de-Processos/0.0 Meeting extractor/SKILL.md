---
name: meeting-extractor
description: >
  Use esta skill para transformar uma transcrição bruta de reunião (Teams, WhatsApp/TurboScribe
  ou texto corrido) em um insumo estruturado de descoberta de processo. É a primeira skill do fluxo.
  Ela não analisa a demanda — apenas organiza o ruído da transcrição em contexto, participantes,
  falas-chave, processo descrito, dores e dúvidas.
  Gatilhos: "extrair reunião", "processar transcrição", "transcrição da reunião", "resumir a call",
  "extrair o processo da reunião", "meeting extractor", "transformar a transcrição", "ata estruturada",
  "o que saiu da reunião".
  INPUT: transcrição bruta (Teams, WhatsApp/TurboScribe ou texto corrido).
  OUTPUT: arquivo Markdown estruturado que alimenta a discovery-questions e o ddvp-negocio.
---

# 00 — Meeting Extractor

Primeira skill do fluxo. Executada antes da discovery-questions.

Pipeline:
**Meeting Extractor** → discovery-questions → ddvp-negocio → language-editor → presentation-deck

## Propósito

Transcrições brutas de reunião são ruído.

Esta skill recebe uma transcrição bruta — de qualquer formato — e entrega o insumo estruturado que a discovery-questions precisa para funcionar. Ela não analisa a demanda. Ela prepara o terreno para que a análise seja possível.

---

## Formatos de Entrada Suportados

### Formato Teams

Gerado automaticamente pelo Microsoft Teams. Cada fala tem nome completo, timestamp e texto.

```
**[Gestor de TI]   **0:04
vou apresentar rapidinho porque o tempo aqui é curto...

**[Dono da Demanda]   **0:57
Então eu vou me apresentar em 10 segundos...
```

Identificadores do formato Teams:
- Nomes em negrito seguidos de timestamp no formato `M:SS` ou `MM:SS`
- Múltiplos participantes claramente identificados
- Pode conter artefatos de transcrição automática (palavras cortadas, frases incompletas)
- Reuniões longas podem vir com transcrição cortada ou incompleta — registrar explicitamente quando isso ocorrer e marcar os blocos afetados como `[transcrição incompleta]`
- Falas em inglês no meio de reunião em português devem ser mantidas no idioma original — não traduzir terminologia técnica

### Formato WhatsApp / TurboScribe

Gerado por ferramentas de transcrição de áudio como TurboScribe. Texto corrido, sem identificação de falante.

```
(Transcrito por TurboScribe. Atualize para Ilimitado para remover esta mensagem.)

É que nem aquela parte que a gente perguntou de como era a especificação...
```

Identificadores do formato WhatsApp/TurboScribe:
- Texto contínuo sem quebras por falante
- Pode conter marca d'água da ferramenta no início e no fim
- Sem timestamps por fala
- Mudanças de falante inferidas pelo contexto ("eu falei", "ele disse", mudança de assunto)

---

## Fase 0 — Contexto Pré-Reunião

Antes de ler a transcrição, registrar o que se sabe sobre o contexto da reunião.

Essas informações mudam completamente a leitura do que foi dito. Uma reunião convocada pelo dono da demanda com material preparado é diferente de uma conversa informal que virou reunião.

**Qual foi o título e o objetivo declarado da reunião?**
Registrar exatamente como apareceu no convite ou na abertura.

**Quem convocou?**
Nome, área e papel de quem organizou.

**Quem foi convidado e não apareceu?**
Ausências relevantes são dados — registrar quem faltou e, se conhecido, por quê.

**Havia material enviado antes?**
Apresentação, documento, e-mail preparatório. Se sim, registrar o que continha.

**Esta é a primeira conversa sobre o tema ou continuação de algo anterior?**
- Primeira conversa
- Continuação — o que foi discutido antes e qual foi o resultado?

---

## Fase 1 — Detecção e Limpeza

### 1.1 Identificar o formato

Verificar se o texto contém o padrão `**Nome   **M:SS`. Se sim, é Teams. Se não, é WhatsApp/TurboScribe.

### 1.2 Remover ruído

**Teams:**
- Falas de uma palavra ou som isolado (`"Certo."`, `"Mm-hmm."`, `"Yeah."`) — remover ou agregar à fala anterior se forem do mesmo falante
- Artefatos de transcrição automática (frases sem sentido, palavras cortadas) — marcar como `[ininteligível]` ou remover
- Trechos de apresentação social e problemas técnicos de áudio — registrar como contexto, não como conteúdo

**WhatsApp/TurboScribe:**
- Remover marca d'água da ferramenta
- Remover expressões de preenchimento excessivas quando prejudicam a leitura — manter quando fazem parte do raciocínio
- Separar falas por contexto quando possível

**O que nunca remover mesmo parecendo ruído:**

Estes elementos parecem dispensáveis mas carregam informação relevante sobre dinâmica e prioridade:

- Hesitações longas antes de resposta direta — podem indicar incerteza, desconforto ou resposta preparada
- Interrupções — registrar quem interrompeu quem; revela hierarquia e urgência real
- Repetição do mesmo tema por participantes diferentes — indica prioridade real, não declarada
- Mudanças de assunto abruptas sem conclusão — podem indicar tema sensível sendo evitado
- Concordância imediata sem questionamento — pode indicar pressão hierárquica, não convicção real

### 1.3 Normalizar participantes

**Teams:** Extrair nome completo do padrão em negrito. Criar um mapa de participantes com nome real e papel identificado na reunião.

**WhatsApp/TurboScribe:** Identificar participantes por contexto. Se a reunião é 1:1, registrar como `[Falante A]` e `[Falante B]`. Se houver mais de dois, registrar como `[desconhecido]` até que o contexto permita identificar.

**Exemplo de mapa de participantes:**
```
[Gestor de TI]           → Líder técnico / conduz a reunião
[Dono da Demanda]        → Negócio / responsável pelo processo
[Operador do Processo]   → Quem executa no dia a dia
[Especialista Externo]   → Parceiro técnico / consultor
[Analista]               → Membro do time de TI
```

---

## Fase 2 — Extração de Conteúdo

Com a transcrição limpa e normalizada, extrair os seguintes blocos. Cada bloco deve citar o timestamp (Teams) ou o trecho exato (WhatsApp) que gerou a extração.

### 2.1 Demanda Identificada

O que foi pedido, em uma frase sem jargão.

**Exemplo:**
> Automatizar a leitura de instruções documentárias de clientes e a verificação de conformidade dos documentos gerados por terceiros.

### 2.2 Quem Pediu

Nome, área e papel de quem originou a demanda. Distinguir de quem apresentou a reunião.

**Exemplo:**
> [Dono da Demanda] — Área comercial / operações de exportação. Responsável pelo processo e quem apresentou a demanda. [Operador do Processo] é quem executa no dia a dia.

### 2.3 Canal de Entrada

Como a demanda chegou até este ponto.

**Exemplo:**
> Reunião formal no Teams, com participantes de negócio, operações e parceiro técnico externo. Reunião convocada pelo dono da demanda.

### 2.4 Problema Relatado

O que foi descrito como dor. Separar obrigatoriamente fatos de opiniões.

**Fatos observados** — afirmações com evidência concreta e dado mensurável:
> - 578 BLs gerando aproximadamente 5.060 documentos para conferência manual (18:32)
> - Cada instrução documentária chega em formato diferente — corpo de e-mail, PDF ou Word — sem template padrão (2:55)
> - Os documentos são verificados por um terceiro e voltam para revisão gerando múltiplas idas e vindas (5:48)
> - O time opera no fuso horário das Américas enquanto clientes asiáticos operam no fuso oposto (7:08)

**Opiniões e suposições** — afirmações sem evidência concreta:
> - "Os melhores vão lá muito pouco, os piores vão lá direto" — percepção sem dado (18:51)
> - "Os japoneses pegam, não passa nada" — percepção sem dado formal (7:08)

### 2.5 Evidências Mencionadas

Dados concretos citados na reunião com fonte e timestamp.

**Exemplo:**
> - 578 BLs ativos (18:32)
> - Documento de reclamação formal foi mencionado e compartilhado na tela (11:00) — solicitar o documento
> - Cada navio pode ter múltiplos BLs, cada BL gera um jogo de documentos diferente (8:23)

### 2.6 Urgência e Custo do Erro

O que foi dito sobre prazo, consequência de não resolver, e impacto financeiro de cada erro ou atraso.

**Capturar separadamente:**

**Urgência declarada** — prazos e consequências mencionados:
- Existe uma data limite? O que acontece se não for resolvido até lá?
- Existe um KPI ou meta do ano que depende disso?

**Custo do erro** — impacto financeiro mencionado:
- Foi citado algum valor financeiro associado a erro ou atraso? (ex: "1 dia de atraso custa R$ X em demurrage")
- Foi mencionado perda de receita, multa contratual, custo de retrabalho ou pagamento postergado?
- Se o custo financeiro NÃO foi mencionado, registrar explicitamente como lacuna — isso bloqueia qualquer cálculo de ROI futuro

**Exemplo:**
> - Cada erro atrasa o recebimento do pagamento — emissão correta é condição para receber (7:08)
> - O KPI principal do ano é reduzir o tempo de emissão de documentos (25:51)
> - Custo financeiro por erro: não mencionado → **[lacuna: custo do erro não capturado]**
> - Sem urgência de prazo imediato declarada

### 2.7 Alternativas Discutidas

Soluções mencionadas na reunião além da proposta principal.

**Exemplo:**
> - Templates manuais com regras fixas — descartado por [Especialista Externo] com base em experiência anterior (20:10)
> - Abordagem híbrida com LLM — proposta como mais viável (14:19)
> - Pedido de clarificação automático ao cliente quando instrução for ambígua (21:28)

### 2.8 Lacunas — Perguntas Sem Resposta

O que ficou em aberto na reunião por falta de informação.
Estas lacunas alimentam diretamente a skill `discovery-questions` — registrar com precisão.

**Exemplo:**
> - Taxa de erro atual por ciclo de revisão — não há dado
> - Tempo médio de cada ciclo de ida e volta — não mencionado
> - Perspectiva do operador direto — citado mas não participou da reunião
> - Documento de reclamação formal mencionado mas não analisado
> - Se o cliente aceitaria receber pedidos de clarificação — apenas suposição

### 2.9 Próximos Passos Mencionados

O que os participantes definiram como ação.

**Exemplo:**
> - [Especialista Externo] vai propor arquitetura de agentes para avaliação (24:33)
> - [Dono da Demanda] quer decisão antes da semana que vem (25:09)
> - [Operador do Processo] vai definir ponto focal para operações (25:29)
> - Primeiro teste proposto com um cliente apenas — piloto antes de escalar (21:44)

### 2.10 Dinâmica da Reunião

O que não foi dito diretamente mas é relevante para entender o contexto da demanda.

**Quem dominou a conversa?**
Registrar quem falou mais, quem conduziu os temas, quem definiu o ritmo.

**Houve resistência não declarada?**
Concordância verbal sem comprometimento real. Alguém disse "sim" mas sinalizou dúvida pelo tom, pela hesitação ou pelo desvio de assunto logo depois.

**Alguém relevante estava ausente?**
Se sim, registrar quem e o impacto da ausência na completude da análise.

**Algum tópico foi evitado ou desviado?**
Mudanças de assunto abruptas, perguntas que não foram respondidas diretamente, temas que surgiram e foram encerrados antes da conclusão.

**Houve pressão hierárquica visível?**
Alguém mudou de posição depois que uma pessoa de nível superior falou? Concordância imediata sem questionamento após fala de gestor.

**O dono da demanda estava vendendo ou descrevendo?**
Há diferença entre quem descreve um problema com neutralidade e quem está ativamente convencendo a sala. Energia alta de patrocínio é boa para execução — mas contamina dados. Se o dono da demanda estava claramente vendendo a ideia, os números e estimativas que vieram dele têm viés de confirmação e devem ser tratados com grau de confiança menor nos artefatos seguintes.

Registrar: quais dados ou estimativas vieram predominantemente do dono da demanda, e se havia alguém na sala com incentivo para questionar — ou se todos estavam alinhados antes de entrar.

**Alguma suposição crítica veio de uma fala casual, de uma pessoa, em um momento?**
Suposições ditas de passagem em reunião frequentemente viram premissas em documentos sem que ninguém perceba a transição. Identificar falas do tipo "acho que dá", "provavelmente funciona", "deve ser possível" que tocaram em pontos que se tornarão premissas nos artefatos seguintes.

Para cada uma encontrada, registrar:
- O que foi dito, por quem e em que momento
- Qual premissa essa fala vai gerar nos artefatos seguintes
- Se há alguma evidência além da fala que sustente essa premissa — ou se ela está sozinha

Suposições sem evidência de suporte marcadas aqui devem ser explicitamente marcadas como `[requer validação]` no artefato em que aparecerem.

**O que não foi perguntado que deveria ter sido?**
As perguntas que ninguém fez na reunião são tão reveladoras quanto as que foram feitas. Temas que o grupo não questionou podem indicar pontos cegos coletivos.

Registrar as perguntas ausentes mais relevantes. Categorias típicas:
- Custo e orçamento da solução — quanto vai custar e quem paga
- Impacto em sistemas ou processos de terceiros
- Dados sensíveis e compliance — como os dados serão tratados, quem tem acesso
- Critério de fracasso — o que faria o projeto ser cancelado
- Quem vai manter depois de entregue

**Impacto da dinâmica no grau de confiança**

Com base em tudo observado nesta seção, avaliar:
- Os dados fornecidos na reunião têm viés de confirmação? Se sim, de quem e em quais estimativas.
- Alguma premissa crítica está sustentada apenas por fala casual sem evidência? Listar.
- As perguntas ausentes revelam pontos cegos que podem invalidar a análise? Listar os mais relevantes.

Registrar o impacto no grau de confiança geral da extração. Se a dinâmica indica viés alto ou premissas frágeis, o grau de confiança do artefato deve ser rebaixado — e isso deve ser explícito para a discovery-questions que virá depois.

**Exemplo:**
> - [Dono da Demanda] conduziu e vendeu ativamente a ideia — estimativas de volume e tempo vieram predominantemente dele, sem questionamento da sala. Grau de confiança dessas estimativas: Baixo.
> - Fala casual de [Especialista Externo] — "daria para aproveitar a estrutura que já temos" — vai virar premissa de custo. Não há evidência além dessa fala. Marcar como [requer validação].
> - Ninguém perguntou quanto o piloto vai custar, quem vai manter a solução depois de entregue, nem como os dados dos clientes serão tratados. Três pontos cegos relevantes.

---

## Saída

A extração é entregue em um documento Markdown único com todos os blocos acima preenchidos.

O documento deve conter ao final uma seção obrigatória:

### Grau de Completude da Extração

Avaliar o quanto a transcrição permitiu preencher cada bloco:

| Bloco | Completude | Observação |
|---|---|---|
| Contexto pré-reunião | Alta / Média / Baixa | |
| Demanda identificada | Alta / Média / Baixa | |
| Quem pediu | Alta / Média / Baixa | |
| Canal de entrada | Alta / Média / Baixa | |
| Problema relatado — fatos | Alta / Média / Baixa | |
| Problema relatado — opiniões | Alta / Média / Baixa | |
| Evidências | Alta / Média / Baixa | |
| Urgência | Alta / Média / Baixa | |
| Alternativas discutidas | Alta / Média / Baixa | |
| Lacunas identificadas | Alta / Média / Baixa | |
| Próximos passos | Alta / Média / Baixa | |
| Dinâmica — estrutura geral | Alta / Média / Baixa | |
| Dinâmica — vendendo ou descrevendo | Alta / Média / Baixa | |
| Dinâmica — suposições casuais críticas | Alta / Média / Baixa | |
| Dinâmica — perguntas ausentes | Alta / Média / Baixa | |
| Dinâmica — impacto no grau de confiança | Alta / Média / Baixa | |

Blocos com completude baixa devem ser explicitamente marcados como `[requer validação]` antes de alimentar a discovery-questions.

---

## Padrão de Escrita

Este artefato será revisado pelo language-editor antes da publicação.

---

## Regra de Ouro

> Esta skill não interpreta se a demanda é boa ou ruim.
> Ela garante que o que foi dito seja separado do que foi suposto,
> e que o que ficou em aberto seja registrado antes de ser esquecido.
>
> Uma extração que mistura fato com suposição contamina tudo que vem depois.
> A discovery-questions vai gerar as perguntas erradas.
> O DDVP vai validar o processo errado.
> O erro não aparece na análise — aparece no projeto,
> quando já custa caro corrigir.