
# Projeto Vagrant - Agente Azure DevOps Self-Hosted

Este projeto configura uma VM Windows e Ubuntu usando Vagrant, instala dependências e registra automaticamente um agente Self-Hosted do Azure DevOps como serviço.

---

## 🔹 Pré-requisitos

Antes de rodar o projeto, certifique-se de ter instalado em sua máquina host:

- [VirtualBox](https://www.virtualbox.org/)  
- [Vagrant](https://www.vagrantup.com/)  
- Plugin dotenv do Vagrant:  
  ```bash
  vagrant plugin install vagrant-env


## 🔹 Estrutura de diretórios

AZURE-PIPELINE-AGENT-SELFHOSTED-VAGRANT
├── Linux
│ ├── .vagrant/
│ ├── .env
│ ├── install-azdo-agent.sh
│ ├── provision.sh
│ └── Vagrantfile
│
├── Windows
│ ├── .vagrant/
│ ├── .env
│ ├── install-azdo-agent.ps1
│ └── Vagrantfile
│
├── .gitignore
└── Readme.md

## 🔹 Descrição das Pastas

- **Linux/**  
  Contém os arquivos necessários para provisionar e instalar o agente self-hosted do Azure DevOps em uma VM Linux:  
  - `.vagrant/` → diretório interno do Vagrant.  
  - `.env` → variáveis de ambiente (ex: URL da organização, token PAT, pool do agente).  
  - `install-azdo-agent.sh` → script de instalação do agente no Linux.  
  - `provision.sh` → script de provisionamento inicial da VM.  
  - `Vagrantfile` → define a máquina virtual Linux no VirtualBox.  

- **Windows/**  
  Contém os arquivos necessários para provisionar e instalar o agente self-hosted em uma VM Windows:  
  - `.vagrant/` → diretório interno do Vagrant.  
  - `.env` → variáveis de ambiente para configuração do agente.  
  - `install-azdo-agent.ps1` → script de instalação do agente no Windows.  
  - `Vagrantfile` → define a máquina virtual Windows no VirtualBox.  

- **.gitignore**  
  Lista arquivos e diretórios que não devem ser versionados.  

- **Readme.md**  
  Documentação do projeto.


## 🔹 Configuração do .env

Crie o .env com seu PAT secreto e outras variáveis:

AZDO_URL=https://dev.azure.com/minhaorg
AZDO_PAT=meuPATsuperSecreto
AZDO_POOL=Default
AZDO_AGENT_NAME=agent-linux-001


## 🔹 Como rodar o projeto

Inicialize o Vagrant (se ainda não tiver feito):

vagrant init


Suba a VM com provisionamento:

vagrant up
