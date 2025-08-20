param(
    [string]$OrgUrl,
    [string]$PatToken,
    [string]$Pool = "Default",
    [string]$AgentName = $env:COMPUTERNAME
)

# Pasta do agente
$AgentDir = "C:\agent"

Write-Host ">>> Instalando agente do Azure DevOps"
Write-Host ">>> URL: $OrgUrl"
Write-Host ">>> Pool: $Pool"
Write-Host ">>> Nome do agente: $AgentName"

# Criar pasta do agente
if (-not (Test-Path $AgentDir)) {
    New-Item -ItemType Directory -Path $AgentDir | Out-Null
}

# Baixar agente
$AgentVersionInfo = Invoke-RestMethod -Uri "https://api.github.com/repos/microsoft/azure-pipelines-agent/releases/latest"
$AgentVersion = $AgentVersionInfo.tag_name.TrimStart("v")
$AgentZip = "vsts-agent-win-x64-$AgentVersion.zip"
$DownloadUrl = "https://download.agent.dev.azure.com/agent/$AgentVersion/$AgentZip"

Write-Host ">>> Baixando agente versão $AgentVersion"
#Invoke-WebRequest -Uri $DownloadUrl -OutFile "$AgentDir\$AgentZip" -UseBasicParsing

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($DownloadUrl, "$AgentDir\$AgentZip")

# Extrair zip
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory("$AgentDir\$AgentZip", $AgentDir)

# Configurar agente (unattended)
cd $AgentDir
.\config.cmd --unattended `
    --url $OrgUrl `
    --auth pat `
    --token $PatToken `
    --pool $Pool `
    --agent $AgentName `
    --replace `
    --acceptteeeula `
    --runAsService


Write-Host ">>> ✅ Agente registrado e rodando como serviço do Windows!"
