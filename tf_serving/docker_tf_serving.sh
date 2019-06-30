wget https://download.docker.com/linux/static/stable/x86_64/docker-17.03.0-ce.tgz
tar zxvf docker-17.03.0-ce.tgz
cp docker/docker* /usr/local/bin/
dockerd &
docker pull tensorflow/serving
TESTDATA="$(pwd)/serving/tensorflow_serving/servables/tensorflow/testdata"
docker run -t --rm -p 8501:8501     -v "$TESTDATA/saved_model_half_plus_two_cpu:/models/half_plus_two"     -e MODEL_NAME=half_plus_two     tensorflow/serving &
curl -d '{"instances": [1.0, 2.0, 5.0]}'     -X POST http://localhost:8501/v1/models/half_plus_two:predict
