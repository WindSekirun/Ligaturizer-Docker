mkdir /input
mkdir /output

docker run --rm -v $(pwd)/input:/input -v $(pwd)/output:/output --user $(id -u) windsekirun/ligaturizer-docker