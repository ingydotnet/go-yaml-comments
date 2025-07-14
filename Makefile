# Using the "Makes" Makefile framework - https://github.com/makeplus/makes
M := $(or $(MAKES_REPO_DIR),.cache/makes)
$(shell [ -d $M ] || git clone -q https://github.com/makeplus/makes $M)
include $M/init.mk
include $M/clean.mk
include $M/yq.mk
include $M/ys.mk

MAKES-CLEAN := *.events.yaml *.nodes.yaml *.yq.yaml
MAKES-REALCLEAN := go-yaml-event go-yaml-node
MAKES-DISTCLEAN := .cache

override PATH := $(ROOT)/bin:go-yaml-event:go-yaml-node:$(PATH)

.PRECIOUS: %.events.yaml %.nodes.yaml %.yq.yaml

%: %.events.yaml %.nodes.yaml %.yq.yaml
	@echo
	ls -l $^
	@echo

%-gist: %.events.yaml %.nodes.yaml %.yq.yaml $(YS)
	@echo
	gist $(@:%-gist=%)
	@echo

%.events.yaml: %.yaml go-yaml-event/go-yaml-event
	go-yaml-event < $< | \
	  grep -Ev '^  (Start|End|Style|Implicit):' | \
	  grep -Ev '^$$' \
	  > $@

%.nodes.yaml: %.yaml go-yaml-node/go-yaml-node
	go-yaml-node < $< > $@

%.yq.yaml: %.yaml $(YQ)
	yq $< > $@

go-yaml-event/go-yaml-event: go-yaml-event
	$(MAKE) -C $< build

go-yaml-node/go-yaml-node: go-yaml-node
	$(MAKE) -C $< build

go-yaml-event go-yaml-node:
	git clone https://github.com/ingydotnet/$@ $@
