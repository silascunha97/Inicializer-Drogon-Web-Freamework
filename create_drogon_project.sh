#!/bin/bash

# Verifica se o usuário forneceu um nome para o projeto
if [ $# -eq 0 ]; then
  echo "Por favor, forneça um nome para o seu projeto Drogon."
  exit 1
fi

project_name="$1"

# Cria o diretório do projeto
mkdir -p $project_name

# Navega para o diretório do projeto
cd $project_name

# Clona o repositório do Drogon
git clone https://github.com/drogonframework/drogon.git

# Cria o diretório de build e configura
mkdir build
cd build
cmake ..

# Instala as dependências (ajuste conforme necessário)
sudo apt-get install build-essential cmake libssl-dev libgtest-dev libboost-all-dev

# Cria o arquivo main.cpp (exemplo básico)
cat > main.cpp << EOF
#include <drogon/drogon.h>

using namespace drogon;

int main() {
    app().loadConfigFile("config.json");
    app().run();
    return 0;
}
EOF

# Cria o arquivo config.json (exemplo básico)
cat > config.json << EOF
{
  "port": 8080,
  "thread_num": 4
}
EOF

# Compila e instala o projeto
make
sudo make install

# Volta para o diretório raiz do projeto
cd ..

echo "Projeto Drogon criado com sucesso: $project_name"