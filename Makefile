all: BambuP1Streamer nuke
	docker build -t bambu_p1_streamer .
	docker run \
		-d \
		--name bambu_p1_streamer \
		-p 1984:1984 \
		-e PRINTER_ADDRESS="$$(cat ip)" \
		-e PRINTER_ACCESS_CODE="$$(cat pac)" \
		bambu_p1_streamer

start:
	docker start bambu_p1_streamer

stop:
	docker stop bambu_p1_streamer

restart:
	docker restart bambu_p1_streamer

BambuP1Streamer:
	gcc src/BambuP1Streamer.cpp -o BambuP1Streamer

nuke:
	docker stop bambu_p1_streamer || true
	docker rm bambu_p1_streamer || true
	docker rmi bambu_p1_streamer || true

clean: nuke
	rm BambuP1Streamer

.PHONY: all start stop build restart nuke clean
