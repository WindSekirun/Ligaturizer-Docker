
docker run --rm -v $(pwd)/input:/input-fonts -v $(pwd)/output:/output-fonts --user $(id -u) windsekirun/ligaturizer-docker