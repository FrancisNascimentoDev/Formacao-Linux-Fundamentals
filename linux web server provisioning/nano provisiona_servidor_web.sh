#!/bin/bash
# ============================================================
# Script: provisiona_servidor_web.sh
# Descrição: Provisionamento automático de servidor web Apache
# Autor: Francis Nascimento
# ============================================================

# Faz o script parar imediatamente caso ocorra qualquer erro
set -e

echo "======================================="
echo " PROVISIONAMENTO DE SERVIDOR WEB APACHE "
echo "======================================="

# ===============================
# ATUALIZAÇÃO DO SISTEMA
# ===============================
# Atualiza a lista de pacotes disponíveis e
# realiza a atualização dos pacotes instalados
echo "🔄 Atualizando o servidor..."
apt update -y && apt upgrade -y

# ===============================
# INSTALAÇÃO DO APACHE2
# ===============================
# Apache é o servidor web responsável por
# disponibilizar o site via HTTP
echo "🌐 Instalando Apache2..."
apt install apache2 -y

# ===============================
# INSTALAÇÃO DO UNZIP
# ===============================
# Utilitário necessário para descompactar
# arquivos .zip baixados do GitHub
echo "📦 Instalando unzip..."
apt install unzip -y

# ===============================
# DOWNLOAD DA APLICAÇÃO WEB
# ===============================
# A aplicação será baixada no diretório /tmp,
# utilizado para arquivos temporários
echo "⬇️ Baixando aplicação para /tmp..."
cd /tmp
wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip

# ===============================
# DESCOMPACTAÇÃO DOS ARQUIVOS
# ===============================
# Extrai o conteúdo do arquivo ZIP
# A opção -o sobrescreve arquivos existentes
echo "📂 Descompactando arquivos..."
unzip -o main.zip

# ===============================
# PUBLICAÇÃO NO APACHE
# ===============================
# Copia os arquivos da aplicação para o
# diretório padrão do Apache
echo "📁 Copiando arquivos para /var/www/html..."
cp -R linux-site-dio-main/* /var/www/html/

# ===============================
# AJUSTE DE PERMISSÕES
# ===============================
# Define o usuário e grupo corretos do Apache
# e ajusta permissões de leitura e execução
echo "🔐 Ajustando permissões..."
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# ===============================
# INICIALIZAÇÃO DO APACHE
# ===============================
# Habilita o Apache para iniciar junto com o sistema
# e reinicia o serviço para aplicar as configurações
echo "▶️ Iniciando Apache..."
systemctl enable apache2
systemctl restart apache2

# ===============================
# FINALIZAÇÃO
# ===============================
echo "✅ Provisionamento concluído com sucesso!"
echo "🌍 Acesse o site pelo IP do servidor"
