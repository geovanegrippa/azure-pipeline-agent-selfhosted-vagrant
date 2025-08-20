#!/bin/bash
set -e

# -----------------------------
# Script para instalar Agente Azure DevOps Self-Hosted
# Uso: ./install-azdo-agent.sh <ORG_URL> <PAT_TOKEN> <POOL> [AGENT_NAME]
# Exemplo: 
# chmod +x install-azdo-agent.sh
# ./install-azdo-agent.sh "https://dev.azure.com/minhaorg" "meuPAT" "Default" "agent-linux-01"

# -----------------------------

ORG_URL=$1
PAT_TOKEN=$2
POOL=$3
AGENT_NAME=${4:-$(hostname)}   # Se não passar, usa o hostname

# Variáveis
AGENT_DIR=/opt/agent

# Criar diretório
sudo mkdir -p $AGENT_DIR
sudo chown $(whoami) $AGENT_DIR
cd $AGENT_DIR

# Descobrir versão mais recente do agente
AGENT_VERSION=$(curl -s https://api.github.com/repos/microsoft/azure-pipelines-agent/releases/latest \
    | grep tag_name | cut -d '"' -f 4 | sed 's/v//')

echo ">>> Baixando agente versão $AGENT_VERSION"

# Baixar e extrair
curl -LsS https://download.agent.dev.azure.com/agent/$AGENT_VERSION/vsts-agent-linux-x64-$AGENT_VERSION.tar.gz -o agent.tar.gz
tar zxvf agent.tar.gz
rm agent.tar.gz

# Configurar agente
./config.sh --unattended \
    --url $ORG_URL \
    --auth pat \
    --token $PAT_TOKEN \
    --pool $POOL \
    --agent $AGENT_NAME \
    --replace \
    --acceptTeeEula

# Instalar como serviço
sudo ./svc.sh install
sudo ./svc.sh start



echo ">>> Agente instalado e rodando!"
