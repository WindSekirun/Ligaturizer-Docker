wget -O hack.zip https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
unzip -j hack.zip -d $(pwd)/input

mkdir /output

docker run --rm -v $(pwd)/input:/input -v $(pwd)/output:/output --user $(id -u) windsekirun/ligaturizer-docker