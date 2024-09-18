#!/bin/bash

# Por: Mateus Cruz

# Script para deletar arquivos antigos do disco.

# Solicita a confirmação do usuário para iniciar Script
echo "Este Script deleta arquivos. Deseja continuar? [s/n]"
read RESPOSTA

# Verifica se o usuário digitou "s" para continuar
test "$RESPOSTA" != s && exit

# Solicita ao usuário o caminho do $DIRETORIO
echo "Informe o diretório"
read DIRETORIO

# Solicita ao usuário o tempo de criação em $DIAS dos arquivos a ser deletado
echo "Informe o tempo de criação em dias dos arquivos a ser deletado"
read DIAS

# Busca e remove arquivos criados a mais de DIAS dias dentro do diretório indicado
find $DIRETORIO -type f -ctime $DIAS -delete

# Finaliza o Script
echo "Arquivos deletados com sucesso!"