
docker run --rm -v $(pwd)/input:/usr/local/src/input-fonts -v $(pwd)/output:/usr/local/src/output-fonts --user $(id -u) windsekirun/ligaturizer-docker