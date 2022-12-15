#!/bin/bash
wget "https://dl.walletbuilders.com/download?customer=60c22841b4f0b2e669d0334101b023cc445498f399d4db7175&filename=bitcoinwhite-qt-linux.tar.gz" -O bitcoinwhite-qt-linux.tar.gz

mkdir $HOME/Desktop/BitcoinWhite

tar -xzvf bitcoinwhite-qt-linux.tar.gz --directory $HOME/Desktop/BitcoinWhite

mkdir $HOME/.bitcoinwhite

cat << EOF > $HOME/.bitcoinwhite/bitcoinwhite.conf
rpcuser=rpc_bitcoinwhite
rpcpassword=dR2oBQ3K1zYMZQtJFZeAerhWxaJ5Lqeq9J2
rpcbind=0.0.0.0
rpcallowip=127.0.0.1
listen=1
server=1
addnode=node2.walletbuilders.com
EOF

cat << EOF > $HOME/Desktop/BitcoinWhite/start_wallet.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
./bitcoinwhite-qt
EOF

chmod +x $HOME/Desktop/BitcoinWhite/start_wallet.sh

cat << EOF > $HOME/Desktop/BitcoinWhite/mine.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
echo Press [CTRL+C] to stop mining.
while :
do
./bitcoinwhite-cli generatetoaddress 1 \$(./bitcoinwhite-cli getnewaddress)
done
EOF

chmod +x $HOME/Desktop/BitcoinWhite/mine.sh

exec $HOME/Desktop/BitcoinWhite/bitcoinwhite-qt &

sleep 15

cd $HOME/Desktop/BitcoinWhite/

clear

exec $HOME/Desktop/BitcoinWhite/mine.sh