
build_vpn_docker:
	docker build -t vpn-server-base:debian -f Dockerfile.vpn-basic.debian .

build_ca: build_vpn_docker
build_ca:
	./build.local_ca.sh

build_vpn_server: build_ca
build_vpn_server:
	./build.vpn_server.sh 


build_vpn_client:
	./build.vpn_client.sh A