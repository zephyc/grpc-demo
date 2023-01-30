
.PHONY: build clean help

PROTOC_REQUIRED_VERSION := 3.21.8
PROTOC_GEN_GO_REQUIRED_VERSION := v1.28.1
PROTOC_GEN_GO_GRPC_REQUIRED_VERSION := 1.2.0
PROTOC_VERSION := $(shell protoc --version | awk '{print $$2}')
PROTOC_GEN_GO_VERSION := $(shell protoc-gen-go --version | awk '{print $$2}')
PROTOC_GEN_GO_GRPC_VERSION := $(shell protoc-gen-go-grpc --version | awk '{print $$2}')

build:
ifneq ($(PROTOC_VERSION),$(PROTOC_REQUIRED_VERSION))
	@echo "protoc version $(PROTOC_VERSION) is incorrect, required version $(PROTOC_REQUIRED_VERSION)"
	@echo "protoc installation: https://grpc.io/docs/protoc-installation"
	@exit 1
endif

ifneq ($(PROTOC_GEN_GO_VERSION),$(PROTOC_GEN_GO_REQUIRED_VERSION))
	@echo "protoc-gen-go version $(PROTOC_GEN_GO_VERSION) is incorrect, required version $(PROTOC_GEN_GO_REQUIRED_VERSION)"
	@echo "protoc-gen-go installation: https://grpc.io/docs/languages/go/quickstart"
	@exit 1
endif

ifneq ($(PROTOC_GEN_GO_GRPC_VERSION),$(PROTOC_GEN_GO_GRPC_REQUIRED_VERSION))
	@echo "protoc-gen-go-grpc version $(PROTOC_GEN_GO_GRPC_VERSION) is incorrect, required version $(PROTOC_GEN_GO_GRPC_REQUIRED_VERSION)"
	@echo "protoc-gen-go-grpc installation: https://grpc.io/docs/languages/go/quickstart"
	@exit 1
endif

	@echo "protoc version: $(PROTOC_REQUIRED_VERSION)"
	@echo "protoc-gen-go version: $(PROTOC_GEN_GO_VERSION)"
	@echo "protoc-gen-go-grpc version: $(PROTOC_GEN_GO_GRPC_VERSION)"
	rm -fr ./gen && mkdir -p gen/demo
	go build -o ${GOPATH}/bin/protoc-gen-client-pool
	protoc --proto_path=./proto --go_out=./gen/demo --go-grpc_out=./gen/demo --client-pool_out=./gen/demo ./proto/*.proto

clean:
	rm -fr ./gen

help:
	@echo "protoc installation: https://grpc.io/docs/protoc-installation"
	@echo "protoc-gen-go installation: https://grpc.io/docs/languages/go/quickstart/"
	@echo "protoc-gen-go-grpc installation: https://grpc.io/docs/languages/go/quickstart/"
