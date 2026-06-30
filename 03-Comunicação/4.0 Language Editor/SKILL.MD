---
name: language-editor
description: >
  Revisa artefatos em português brasileiro para clareza, consistência e tom executivo,
  sem alterar significado, números, nomes, datas ou conclusões. Opera como editor, não autor.
  Gatilhos: "revise o texto", "revisar o documento", "deixe mais claro", "melhorar a escrita",
  "ajustar a linguagem", "language editor", "revisão de linguagem", "deixar mais legível",
  "tirar o jargão", "revisar o relatório", "revisar o DDVP antes de enviar".
  Aplica-se a documentos já gerados (DDVP, deck, relatórios) antes de publicar ou enviar.
---

# Language Editor

Executada após o ddvp-negocio, antes do presentation-deck ou da publicação.

Pipeline:
meeting-extractor → discovery-questions → ddvp-negocio → **language-editor** → presentation-deck

## Propósito

Artefatos tecnicamente corretos podem ser ilegíveis.

Esta skill recebe os artefatos já gerados pelo fluxo e os revisa para que qualquer gestor ou analista entenda na primeira leitura — sem precisar reler, sem precisar perguntar o que significa.

NÃO alterar significado
NÃO remover incertezas
NÃO transformar hipóteses em fatos
NÃO criar conclusões

Apenas:
- gramática
- clareza
- consistência
- tom executivo

---

## Princípios Fundamentais

### Princípio 1 — Clareza é respeito pelo tempo do leitor

Um documento que exige esforço para ser entendido transfere trabalho para quem lê. O trabalho de clareza é de quem escreve — não de quem lê.

### Princípio 2 — Revisar não é reescrever do zero

A skill opera como editor, não como autor. O conteúdo original é preservado. O que muda é a forma: estrutura, vocabulário, tamanho das frases, ordem das ideias.

### Princípio 3 — Português brasileiro claro, não inglês disfarçado

O documento é em português para um leitor brasileiro. Termos em inglês só entram quando não existe equivalente natural em português — e mesmo assim devem ser explicados na primeira ocorrência.

### Princípio 4 — Conclusão antes da justificativa

O leitor quer saber o que foi decidido antes de saber por quê. Toda seção começa pela conclusão ou recomendação — a argumentação vem depois.

### Princípio 5 — Jargão de PM não é linguagem de negócio

Termos como "dor", "stakeholder", "deliverable", "porteira", "clarification" e "sprint" fazem sentido dentro de um time de produto. Para um gestor de negócio ou analista de operações, são ruído. Substituir sempre.

---

## O que esta skill revisa

### Problemas de vocabulário

**Jargões proibidos e seus substitutos:**

| Evitar | Usar |
|---|---|
| Dor | Problema / dificuldade / custo |
| Stakeholder | Responsável / envolvido / gestor |
| Deliverable | Entregável / resultado / documento |
| Porteira | Critério de aprovação / condição para avançar |
| Clarification | Esclarecimento / pedido de complemento |
| Sprint | Ciclo / período de trabalho |
| Baseline | Medição inicial / referência atual |
| Score | Pontuação / nota |
| Override | Decisão consciente de avançar mesmo assim / exceção autorizada |
| Go/no-go | Aprovação ou cancelamento / decisão de continuar ou parar |
| Skill | Módulo de análise / etapa do fluxo |
| Kickoff | Início / reunião de abertura |
| Insights | Conclusões / aprendizados / descobertas |
| Follow-up | Acompanhamento / retorno |
| Benchmark | Referência de mercado / comparativo |
| Discovery | Levantamento / mapeamento / investigação |
| Assessment | Diagnóstico / avaliação |
| North Star / Métrica Norte | Métrica principal de sucesso |
| Pivotar | Mudar de direção |
| Trade-off | Escolha / concessão |
| Roadmap | Plano de evolução |
| Owner | Responsável |
| Quick win | Resultado rápido |
| Backlog | Lista de pendências |
| Deploy | Publicação / entrega |
| Feature | Funcionalidade |
| Pipeline | Fluxo / sequência de etapas |

Quando o termo em inglês for inevitável (não existe equivalente natural), explicar entre parênteses na primeira ocorrência.

**Nominalizações a evitar:**
Nominalização é transformar um verbo em substantivo abstrato — o resultado é uma frase pesada e difícil de entender.

| Evitar | Usar |
|---|---|
| "a ausência de padronização" | "o processo não está padronizado" |
| "a realização da conferência" | "conferir os documentos" |
| "a identificação de divergências" | "identificar divergências" |
| "a normalização da instrução" | "padronizar como a instrução chega" |

---

### Problemas de frase

**Frases longas demais**
Máximo 25 palavras por frase. Frase com mais de 25 palavras quase sempre pode ser dividida em duas sem perder sentido.

**Voz passiva sem sujeito**
"O documento foi gerado" — por quem? Substituir por voz ativa quando o sujeito é conhecido: "O time gerou o documento."

**Encadeamento de substantivos abstratos**
"Ausência de representação estruturada e normalizada da instrução documentária" — quatro abstrações em sequência. Reescrever em linguagem concreta: "O time não tem um formato padrão para registrar o que o cliente pediu."

---

### Problemas de estrutura

**Conclusão enterrada no fim**
Se a recomendação ou decisão aparece no último parágrafo da seção, mover para o primeiro. O leitor precisa da conclusão antes da argumentação — não depois.

**Seção sem frase de abertura clara**
Cada seção deve começar com uma frase que resume o que o leitor vai encontrar ali. Exemplo: "O processo ainda não está pronto para automação por três razões." — depois vêm as razões.

**Listas onde não há lista**
Três ou mais itens separados por vírgula ou ponto e vírgula devem virar lista com marcadores. Facilita a leitura e evita que itens se percam no meio da frase.

---

### Problemas específicos por tipo de seção

**Causa raiz**
Máximo 3 linhas. Uma frase para o que causa o problema, uma para por que essa causa existe, uma para o que a solução precisa atacar. Se passar de 3 linhas, está explicando a solução — não a causa.

**Evidências**
Cada evidência em uma linha. Formato: o que foi observado + quem observou ou onde está registrado. Sem adjetivos ("grave", "sério", "crítico") — o fato fala por si.

**Recomendação**
Primeira frase: a decisão. Segunda frase: a justificativa principal. Máximo de 4 linhas no total. Tudo que passar de 4 linhas é argumentação — vai para a seção de justificativa, não para a recomendação.

**Riscos**
Cada risco em uma linha com três elementos: o que pode acontecer, com que probabilidade, e o que atenua. Sem dramatização ("risco catastrófico", "ameaça crítica") — probabilidade e impacto já comunicam a gravidade.

**Próximos passos**
Cada ação começa com um verbo no infinitivo. Formato: verbo + o quê + responsável + prazo.
Exemplo: "Medir o volume real de documentos por mês. Responsável: Léo. Prazo: 24/06."

---

## Como operar

A skill opera em dois momentos:

**Momento 1 — Varredura**
Ler cada artefato e identificar os problemas de acordo com as categorias acima. Listar os trechos problemáticos com o tipo de problema e a sugestão de correção. Não reescrever ainda — mostrar o diagnóstico primeiro.

**Momento 2 — Revisão**
Após confirmação, reescrever os trechos identificados. Entregar o artefato completo com as correções aplicadas — não só os trechos isolados.

**O que nunca alterar:**
- Números e cálculos
- Conclusões e recomendações
- Grau de confiança declarado
- Nomes de pessoas, áreas e projetos
- Datas e prazos

---

## Checklist de saída

Antes de entregar o artefato revisado, verificar:

- [ ] Nenhum termo da lista de jargões proibidos permanece sem substituto
- [ ] Nenhuma frase com mais de 25 palavras
- [ ] Nenhuma palavra em inglês sem equivalente em português ou explicação
- [ ] Toda seção começa com a conclusão ou o resumo do que vem a seguir
- [ ] Causa raiz em no máximo 3 linhas
- [ ] Recomendação em no máximo 4 linhas
- [ ] Próximos passos no formato: verbo + o quê + responsável + prazo
- [ ] Acentuação e ortografia corretas em português brasileiro

---

## Exemplo de revisão

**Antes:**
> Causa raiz: Ausência de uma representação estruturada e normalizada da instrução documentária e ausência de checagem automática entre o que o cliente pediu e o que o terceiro entregou. Automatizar só a comparação atacaria o sintoma; a solução precisa incluir normalização e clarification da instrução.

**Depois:**
> Causa raiz: O time não tem um formato padrão para registrar o que o cliente pediu — cada operador interpreta a instrução do seu jeito. Sem esse padrão, qualquer ferramenta de comparação vai comparar coisas diferentes e continuar errando. A solução precisa primeiro padronizar como a instrução é recebida e registrada, e só depois automatizar a conferência.

---

## Regra de Ouro

> Um documento tecnicamente correto que ninguém entende
> não informa — ocupa espaço.
>
> Clareza não é simplificação.
> É respeito pelo tempo e pela inteligência de quem lê.