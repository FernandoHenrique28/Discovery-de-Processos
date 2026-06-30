# gerar_pdf.ps1 — Documentation Publisher (motor Windows / Chromium)
# Converte um HTML (que usa brand.css) em PDF com identidade Raízen.
# Uso:
#   .\gerar_pdf.ps1 -Html "caminho\documento.html" -Pdf "caminho\saida.pdf"
#
# Observações:
# - WeasyPrint depende de GTK/Pango e normalmente falha no Windows; por isso
#   o motor padrão aqui é o Chromium (Edge ou Chrome), que já vem instalado.
# - printBackground é preservado pelo CSS (print-color-adjust: exact em brand.css).
# - --generate-pdf-document-outline cria os marcadores (bookmarks) a partir dos headings.
# - Use caminhos sem acentos para a pasta de build, ou embuta o logo em base64,
#   para evitar problemas do Chromium ao carregar arquivos locais.

param(
    [Parameter(Mandatory=$true)][string]$Html,
    [Parameter(Mandatory=$true)][string]$Pdf
)

$ErrorActionPreference = 'Stop'

$candidatos = @(
    "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
    "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
    "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe"
)
$navegador = $candidatos | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $navegador) { throw "Chrome/Edge não encontrado. Instale um Chromium para gerar o PDF." }

$htmlFull = (Resolve-Path $Html).Path
$url = 'file:///' + ($htmlFull -replace '\\','/')
if (Test-Path $Pdf) { Remove-Item $Pdf -Force }

& $navegador --headless=new --disable-gpu --no-sandbox `
    --generate-pdf-document-outline `
    "--print-to-pdf=$Pdf" $url 2>&1 | Out-Null

Start-Sleep -Seconds 2
if (Test-Path $Pdf) {
    Write-Host "PDF gerado: $Pdf ($((Get-Item $Pdf).Length) bytes) via $([System.IO.Path]::GetFileName($navegador))"
} else {
    throw "Falha ao gerar o PDF."
}
