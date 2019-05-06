#!/bin/bash
mkdir -p build
echo "installing stuff"
npm install
echo "Building diagrams..."
node_modules/.bin/diagrams sequence diagrams/mgnt-gui-boot.sequence build/mgnt-gui-boot.png
dot -Tpng -obuild/flow-onboard-validator.png diagrams/flow-onboard-validator.dot
dot -Tpng -obuild/flow-update-validator.png diagrams/flow-update-validator.dot
dot -Tpng -obuild/sys-diagram.png diagrams/sys-diagram.dot
dot -Tpng -obuild/genesis-network.png diagrams/genesis-network.dot
dot -Tpng -obuild/nodecontrol.png diagrams/nodecontrol.dot

cp build/*.png src/images

CURDIR=`pwd`
shopt -s extglob
sudo docker run -it --rm --mount src=$CURDIR/src,target=/usr/src/tex,type=bind dxjoke/tectonic-docker /usr/bin/tectonic -p main.tex

echo "doc in src/main.pdf"

#xdg-open src/main.pdf
