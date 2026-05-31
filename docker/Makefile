# Docker build
#
# This file is part of the 'Git Actions' (GA) project.
#
# Copyright © 2026, Giampiero Gabbiani <giampiero@gabbiani.org>
#
# SPDX-License-Identifier: GPL-3.0-or-later

IMAGE		= git-actions
# depending on the installed docker engine (docker vs podman) the image removal command could differ
REMOVE_CMD	= $(shell file $$(which docker) | (grep ELF >&/dev/null && echo 'docker rmi &>/dev/null' || echo 'docker rmi --ignore'))
# DOCKER_RUN gets '-it' options only if the current bash has tty attached to stdin
# UNUSED
RUN_CMD		= docker run -v $(PRJ_ROOT):/import:Z $(if $(patsubst not a tty,,$(shell tty)),-it) --rm
BUILD_CMD	= docker build
BUILDX_CMD	= docker buildx build

RNDR_IMG	:= ggabbiani/renderer
RNDR_VER	:= v1.2.0


.DEFAULT_GOAL := help

.PHONY: renderer

all: fedora	## Build images in all the target platforms

.base:
	$(call target-prologue)
	$(if $(BASE_IMG), , $(error BASE_IMG undefined.))
	cd base && docker build -t base .
	docker tag base $(BASE_IMG)
	docker push $(BASE_IMG)
	$(call target-epilogue-success)

renderer:
	$(call target-prologue)
	cd renderer && ( [ -d app ] || mkdir app ) && cp -a \
		$(BIN)/entry-point.sh \
		$(BIN)/functions.sh \
		$(BIN)/make-picture.py \
		$(BIN)/ofl.py \
		app/ \
	&& docker build -t $(RNDR_IMG):$(RNDR_VER) .
	docker tag $(RNDR_IMG) $(RNDR_IMG):latest
	# push all the local tags for the renderer (version and latest)
	docker push -a $(RNDR_IMG)
	$(call target-epilogue-success)

clean: ## Clean all local Docker images
	$(call aggregate-prologue)
	$(REMOVE_CMD) $(IMAGE):fedora || true
	docker image prune --build-cache -f
	$(call aggregate-epilogue)

.buildx:  ## Cached build through buildx and GHA cache (used by gitops ONLY)
	$(call target-prologue)
	cd $(DISTRO) && ( [ -d app ] || mkdir app ) && cp -a \
		$(BIN)/entry-point.sh \
		$(BIN)/functions.sh \
		$(BIN)/make-picture.py \
		$(BIN)/ofl.py \
		app/ \
	&& $(BUILDX_CMD) \
		--progress=plain \
		--cache-from=type=gha \
		--cache-to=type=gha,mode=max \
		--load \
		-t $(IMAGE):$(DISTRO) .
	$(call target-epilogue-success)

help: ## Shows this help
	@grep -Eh '^[a-zA-Z0-9_/%. -]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
