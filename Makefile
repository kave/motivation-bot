SHA1 ?= $(shell git rev-parse HEAD)
image_name := motivation-bot

define build_image
docker build --tag $(image_name):latest .
endef

image-latest:
	$(call build_image)

image: image-latest

define docker_run
docker run -it --log-driver fluentd --log-opt fluentd-address=docker.for.mac.localhost:24224 \
	--log-opt tag=docker.motivation_bot $(image_name):latest
endef

run-docker:
	$(call docker_run)

run: run-docker