# Install mesaflash dependencies
set -e
CLEANUP=${CLEANUP:-true}

${SUDO} apt-get install -y \
        git \
        build-essential \
        libpci-dev

git clone https://github.com/micges/mesaflash.git
cd mesaflash
make
${SUDO} make install

###########################
# Clean up
###########################
if $CLEANUP; then
    ${SUDO} apt-get clean
fi
