---
name: ddvp-negocio
description: >
  Use esta skill para gerar um DDVP — Documento de Descoberta e Validação de Processo —
  formatado para o TIME DE NEGÓCIO. O documento pergunta: "Foi isso que entendemos do seu processo?"
  Gatilhos: "documento pro negócio", "validação com o negócio", "DDVP negócio", "enviar pro time de negócio",
  "negócio validar o processo", "documento de validação", "DDVP", "resumo do processo pra negócio",
  "foi isso que entendemos", "gerar o DDVP", "montar o documento de validação".
  INPUT: output do meeting-extractor + perguntas da discovery-questions.
  OUTPUT: arquivo HTML gerado a partir do template fixo em references/ddvp-template-raizen.html.
  Este documento é intencionalmente CURTO e SIMPLES — sem scores de maturidade, sem matrizes de risco,
  sem diagramas de arquitetura. O time de negócio lê em 5 minutos e valida.
  NÃO usar as skills process-discovery-doc ou assessment para isso — são documentos internos/técnicos.
---

# DDVP — Documento de Validação com o Negócio

Documento curto, direto ao ponto, com um único objetivo: confirmar que você entendeu o processo corretamente.

**Tom:** Linguagem simples. Sem jargão. Sem "maturidade", "viabilidade", "complexidade", "stakeholder".
**Tamanho:** Cabe em uma tela. O time de negócio lê em 5 minutos.
**Propósito:** Obter validação. Avançar.

---

## Pipeline

```
00 meeting-extractor → output estruturado
        ↓
00.5 discovery-questions → perguntas precisas por categoria
        ↓
01 ddvp-negocio ← você está aqui
        ↓
02 language-editor → revisão antes de enviar
```

---

## Inputs necessários

| Input | Obrigatório | Origem |
|---|---|---|
| Nome do processo | ✅ | Usuário / meeting-extractor |
| Área responsável | ✅ | Usuário / meeting-extractor |
| Gatilho do processo (início) | ✅ | Usuário / meeting-extractor |
| Fim do processo | ✅ | Usuário / meeting-extractor |
| Etapas (mesmo que brutas) | ✅ | Usuário / meeting-extractor |
| Dores / gargalos principais | ✅ | Usuário / meeting-extractor |
| Perguntas da seção 06 | ✅ | **discovery-questions** (obrigatório) |
| Ferramentas / sistemas usados | ⬜ | Usuário / meeting-extractor |
| Dados e métricas conhecidos | ⬜ | Usuário / meeting-extractor |
| Nome do analista | ⬜ | Usuário (perguntar se não informado) |
| Nome do contato de negócio | ⬜ | Usuário (perguntar se não informado) |

**Se as perguntas da seção 06 não foram geradas pela `discovery-questions`:** avisar o usuário antes de gerar:

> "Para garantir perguntas precisas na seção 06, rode a skill `discovery-questions` primeiro com o output do meeting-extractor. Quer fazer isso agora, ou prefiro gerar as perguntas diretamente aqui com o que temos?"

Se o usuário pedir para gerar diretamente, aplicar as mesmas regras da `discovery-questions` — perguntas nascem de lacunas reais, organizadas por categoria, com indicação de quem responde.

**Se analista ou contato de negócio não foram informados:** perguntar ANTES de gerar. Esses campos não podem ficar vazios no documento enviado ao negócio.

---

## Como gerar o documento

### Passo 1 — Ler o template

Ler o arquivo `references/ddvp-template-raizen.html`.

O template contém toda a estrutura visual, CSS, cores Raízen e logo já configurados.
**Nunca recriar o CSS. Nunca alterar o design. Apenas preencher os slots.**

Os slots estão marcados com colchetes: `[Nome do Processo]`, `[Nome do Analista]`, etc.

### Passo 2 — Preencher os slots

Substituir cada slot pelo conteúdo real extraído dos inputs.

**Regras de preenchimento:**

**Capa**
- `[Nome do Processo]` → nome do processo exatamente como será reconhecido pelo negócio
- `[Nome do Analista]` → nunca deixar em branco; perguntar se não informado
- `[Nome do Contato de Negócio]` → nunca deixar em branco; perguntar se não informado
- `[Área Responsável]` → time ou área dona do processo
- `[DD/MM/AAAA]` → data de geração do documento
- `[Nome] — [Data]` na linha Base → reunião de origem
- O status pill "aguardando validação" nunca muda na geração — é atualizado manualmente depois

**Seção 00 — Resumo Executivo**

Bloco "Entendemos que": 4–6 frases curtas e factuais sobre o processo.
- O que acontece, quem faz, onde dói
- Sem dados não confirmados
- Sem solução ou tecnologia futura

Bloco "Precisamos validar": 3–5 itens que ainda não foram confirmados e bloqueiam o avanço.
- Apenas o que realmente não se sabe
- Sem repetir o que já está nas Dúvidas em Aberto — este bloco é um resumo executivo, não a lista completa

Bloco "Por que estamos olhando para isso": 1 item obrigatório.
- Uma frase que conecta o processo ao impacto financeiro ou operacional que justifica a análise
- Usar dado concreto se disponível na seção 2.6 do meeting-extractor (custo do erro)
- Se o custo financeiro não foi capturado, usar o impacto operacional mais direto
- Exemplo: "A cada erro na conferência, a emissão do BL atrasa e o recebimento do pagamento é postergado"
- Exemplo com dado: "Cada dia de atraso na emissão gera R$ X em demurrage"
- Este bloco existe para que o gestor que assina lembre por que está gastando 5 minutos neste documento

**Seção 01 — Objetivo**

Descreve o propósito do DOCUMENTO, não o resultado esperado do processo.

✅ Correto: "Validar o entendimento do processo atual de [X], seus principais gargalos e dados conhecidos, antes da avaliação de possíveis melhorias."
❌ Errado: "Garantir que os documentos sejam emitidos corretos e no prazo" — isso é meta operacional da área.

2–3 frases. Tom neutro. Sem antecipar solução. Sem viés de automação.

**Seção 02 — Escopo**

- Início: o que dispara o processo (uma frase)
- Fim: o que significa "concluído" (uma frase)
- Chips de participantes: times e papéis que participam do processo HOJE

O que NÃO entra no escopo:
- Tecnologia futura, IA, automação, ou qualquer solução hipotética
- O escopo descreve o AS-IS — como funciona agora, com quem executa agora

**Seção 03 — Fluxo Atual**

Tabela com colunas: Etapa / Responsável / Ferramenta.
- Máximo 10 linhas. Se houver mais etapas, agrupar.
- Responsável desconhecido → marcar com tag "a confirmar" no estilo do template
- Adicionar nota abaixo da tabela se houver contexto relevante (fuso horário, sazonalidade)

**Seção 04 — Principais Gargalos**

3–5 gargalos. Cada um com:
- Título curto (4–5 palavras)
- Impacto: uma frase explicando o que causa para o negócio
- Evidência: origem concreta — "Relato da reunião de [data]" ou dado específico

Sem scores. Sem análise técnica. A evidência não precisa ser longa — só precisa existir.

**Seção 05 — Dados Conhecidos**

Tabela com: O que sabemos / Valor.
- Usar `~` para estimativas
- Tag "a confirmar" para valores incertos — no estilo do template
- Sem limite de linhas — incluir todos os dados mencionados na reunião
- Sem inventar dados: se não foi mencionado, não entra

**Seção 06 — Dúvidas em Aberto**

Preencher com as perguntas geradas pela `discovery-questions`.
- Se o usuário já forneceu as perguntas → usar exatamente essas, sem alterar
- Sem limite de perguntas — incluir todas as lacunas reais identificadas
- Cada pergunta com número e indicação de quem responde
- Apenas perguntas sobre o processo HOJE — nenhuma de implementação ou solução

**Seção 08 — Premissas**

Lista de afirmações que estão sendo assumidas como verdade até a validação.
- Sem limite de itens — incluir todas as premissas identificadas
- Cada premissa: uma frase afirmativa (não uma pergunta)
- O que ainda é pergunta fica na seção 06, não aqui

Exemplo:
- O terceiro é o responsável pela emissão dos documentos
- O pagamento do cliente depende da emissão correta dos documentos
- O volume estimado é de ~578 BLs por mês

### Passo 3 — Gerar o HTML

Copiar o template e substituir os slots com o conteúdo preenchido.
Salvar como `/mnt/user-data/outputs/ddvp-[slug-do-processo].html`.

**O que nunca fazer:**
- Recriar o CSS
- Alterar cores, fontes ou layout
- Adicionar seções que não existem no template
- Remover seções do template sem instrução explícita do usuário

### Passo 4 — Gerar o PDF

Tentar na seguinte ordem:

**Opção 1 — Instrução manual (preferencial):**
Entregar o HTML e instruir o usuário a abrir no Chrome e usar Ctrl+P → "Salvar como PDF" com margens em "Nenhuma" e background graphics ativado. Essa opção preserva o logo e as cores com fidelidade.

**Opção 2 — WeasyPrint (fallback):**
```bash
pip install weasyprint --break-system-packages -q
python3 -c "
from weasyprint import HTML
HTML(filename='/mnt/user-data/outputs/ddvp-[slug].html').write_pdf('/mnt/user-data/outputs/ddvp-[slug].pdf')
print('PDF gerado')
"
```
Atenção: WeasyPrint pode falhar com imagens base64 (como o logo). Se falhar, usar a Opção 1.

### Passo 5 — Entregar

Usar `present_files` para entregar o HTML.
Se o PDF foi gerado com sucesso, entregar ambos.
Se não, instruir o usuário sobre como gerar via Chrome.

---

## O que NÃO é o DDVP

Para não confundir com outros documentos do pipeline:

| Documento | Quando usar |
|---|---|
| **DDVP** (este) | Validar com o negócio o que foi entendido do processo |
| **discovery-process-interno** | Análise crítica interna antes de automatizar |
| **meeting-extractor output** | Insumo estruturado da reunião — não vai para o negócio |
| **presentation-deck** | Apresentação para liderança executiva |

---

## Checklist de qualidade

**Conteúdo**
- [ ] Linguagem simples — sem "maturidade", "viabilidade", "complexidade", "stakeholder"
- [ ] Resumo Executivo com os dois blocos: "Entendemos que" e "Precisamos validar"
- [ ] Seção 01 descreve o propósito do DOCUMENTO, não a meta operacional da área
- [ ] Seção 02 lista apenas quem participa HOJE — sem IA, tecnologia futura ou solução
- [ ] Seção 03 em tabela com colunas Etapa / Responsável / Ferramenta
- [ ] Seção 04 tem título + impacto + evidência em cada gargalo
- [ ] Seção 05 usa `~` para estimativas e tag "a confirmar" para valores incertos
- [ ] Seção 06 contém APENAS perguntas sobre o processo atual — nenhuma de implementação
- [ ] Seção 06 veio da `discovery-questions` ou foi gerada com as mesmas regras
- [ ] Seção 08 lista afirmações, não perguntas
- [ ] Nenhuma métrica inventada — se não foi mencionado, não entra
- [ ] Documento legível em 5 minutos

**Capa — nunca enviar com campos em branco**
- [ ] Nome do analista preenchido
- [ ] Nome do contato de negócio preenchido
- [ ] Área responsável preenchida
- [ ] Data preenchida
- [ ] Reunião de origem referenciada
- [ ] Status pill: "aguardando validação"

**HTML**
- [ ] Gerado a partir do template `references/ddvp-template-raizen.html`
- [ ] Nenhum CSS alterado ou recriado
- [ ] Todos os slots `[entre colchetes]` substituídos
- [ ] Nenhum slot vazio no documento final

**PDF**
- [ ] Gerado via Chrome (preferencial) ou WeasyPrint (fallback)
- [ ] Logo e cores preservados
- [ ] Nenhum conteúdo cortado entre páginas
- [ ] Footer em linha única e legível