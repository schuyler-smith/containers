PORT = 
CONTAINER = $(APP)
DOCKER_NAME = $(if $(CONTAINER),--name $(CONTAINER),)
DOCKER_PORT = $(if $(PORT),-p $(PORT):$(PORT),)
DOCKER_RUN = docker run --rm $(MODE) $(DOCKER_PORT) $(CONTAINER) $(APP)
DOCKER_STOP = -docker stop $(CONTAINER) > /dev/null 2>&1
DOCKER_RM = -docker rm $(CONTAINER) > /dev/null 2>&1
define DOCKER_SECRET_ARGS
	$(strip $(foreach secret,$(SECRETS),--secret id=$(word 1,$(subst :, ,$(secret))),src=$(word 2,$(subst :, ,$(secret))) ))
endef
GITHUB_SECRET = $(if $(GITHUB_SSH),$(shell echo --secret id=ssh_key,src=$(GITHUB_SSH)),)

DOCKER_BUILD = docker build $(GITHUB_SECRET) -f $(DOCKERFILE) -t $(APP) .


.PHONY: all
all: \
	open_refine

.PHONY: docker-run
docker-run:
	$(DOCKER_RUN)

.PHONY: docker-interactive
docker-interactive:
	$(eval MODE = -it --entrypoint /bin/bash)
	$(DOCKER_RUN)

.PHONY: clean
clean:
	$(DOCKER_STOP) || true
	$(DOCKER_RM) || true
	docker image prune -f

.PHONY: open_refine
open_refine:
	$(eval DOCKERFILE = Docker/OpenRefine)
	$(eval APP = $(@))
	$(DOCKER_BUILD)


