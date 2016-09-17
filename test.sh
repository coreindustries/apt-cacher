# docker run -t -i --rm -e http_proxy http://$(ipconfig getifaddr en0):3142/ ubuntu bash
docker run -t -i --rm -e "http_proxy=http://0.0.0.0:3142/" ubuntu bash