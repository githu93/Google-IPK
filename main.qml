name: Build IPK Paulo

on:
  push:
    branches: [ main ]
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-22.04

    steps:
      - name: Baixando o Codigo
        uses: actions/checkout@v4

      - name: Instalar Motores do Google
        run: |
          sudo apt-get update
          sudo apt-get install -y qtbase5-dev qt5-qmake build-essential

      - name: Instalar Ferramentas LG
        run: |
          sudo npm install -g @webos-tools/cli --unsafe-perm

      - name: Compilar Navegador Nativo
        run: |
          qmake -qt=qt5
          make

      - name: Gerar Pacote IPK
        run: |
          mkdir -p build
          ares-package . --out ./build

      - name: Download do Arquivo Final
        uses: actions/upload-artifact@v4
        with:
          name: App-Paulo-TV
          path: ./build/*.ipk
