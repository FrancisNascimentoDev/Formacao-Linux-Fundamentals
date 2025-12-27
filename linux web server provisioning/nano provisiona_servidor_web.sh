#!/bin/bash
set -e

echo "======================================="
echo " PROVISIONAMENTO DE SERVIDOR WEB APACHE "
echo "======================================="

# ===============================
# ATUALIZAR O SERVIDOR
# ===============================
echo "🔄 Atualizando o servidor..."
apt update -y && apt upgrade -y

# ===============================
# INSTALAR APACHE2
# ===============================
echo "🌐 Instalando Apache2..."
apt install apache2 -y

# ===============================
# INSTALAR UNZIP
# ===============================
echo "📦 Instalando unzip..."
apt install unzip -y

# ===============================
# BAIXAR A APLICAÇÃO
# ===============================
echo "⬇️ Baixando aplicação para /tmp..."
cd /tmp
wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip

# ===============================
# DESCOMPACTAR A APLICAÇÃO
# ===============================
echo "📂 Descompactando arquivos..."
unzip -o main.zip

# ===============================
# COPIAR ARQUIVOS PARA O APACHE
# ===============================
echo "📁 Copiando arquivos para /var/www/html..."
cp -R linux-site-dio-main/* /var/www/html/

# ===============================
# AJUSTAR PERMISSÕES
# ===============================
echo "🔐 Ajustando permissões..."
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# ===============================
# INICIAR E HABILITAR APACHE
# ===============================
echo "▶️ Iniciando Apache..."
systemctl enable apache2
systemctl restart apache2

echo "✅ Provisionamento concluído com sucesso!"
echo "🌍 Acesse o site pelo IP do servidor"
