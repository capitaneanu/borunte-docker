###########################
# Tools
###########################
set -e
CLEANUP=${CLEANUP:-true}

${SUDO} apt-get update && ${SUDO} apt-get install -y \
                                  zlib1g-dev \
                                  libssl-dev

# install black
if ! type "python3.6" > /dev/null; then
    PY_VERSION=3.6.7
    wget https://www.python.org/ftp/python/${PY_VERSION}/Python-${PY_VERSION}.tgz
    tar xvf Python-${PY_VERSION}.tgz
    cd Python-${PY_VERSION}
    ./configure --without-tests --disable-tests --enable-unicode
    make -j`nproc`
    sudo make altinstall
fi

${SUDO} python3.6 -m pip install black pipenv

# install QModBus dependency
${SUDO} apt-get install -y \
        libmodbus-dev \
        qt5-default \
        qtbase5-dev

# install QModBus
git clone https://github.com/ed-chemnitz/qmodbus.git --depth=1
cd qmodbus
qmake
make -j`nproc`
${SUDO} install qmodbus /usr/local/bin/
#${SUDO} make install

# install CLion dependency
${SUDO} apt-get install -y \
        libxslt1.1 \
        openjdk-8-jdk

# Install network tools
${SUDO} apt-get install -y \
        arping \
        net-tools

###########################
# Clean up
###########################
if $CLEANUP; then
    ${SUDO} apt-get clean
fi
