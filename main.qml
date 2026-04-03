name: Gerar Instalador IPK para TV

on:
  push:
    branches: [ main ]
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Baixando o Código do Paulo
        uses: actions/checkout@v4

      - name: Preparando o Computador do GitHub (Qt + Motores)
        run: |
          sudo apt-get update
          # Instalando as ferramentas do Qt5 individualmente
          sudo apt-get install -y qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools qtdeclarative5-dev qtwebengine5-dev build-essential

      - name: Instalando Ferramentas da LG (WebOS CLI)
        run: |
          sudo npm install -g @webos-tools/cli

      - name: Compilando o Motor C++ (Nativo)
        run: |
          # Usamos o qmake do Qt5 explicitamente
          qmake -qt=qt5
          make

      - name: Criando o Pacote .IPK Final
        run: |
          mkdir -p build
          ares-package . --out ./build

      - name: Salvar o Arquivo para o Paulo Baixar
        uses: actions/upload-artifact@v4
        with:
          name: Instalador-Google-TV
          path: ./build/*.ipk
