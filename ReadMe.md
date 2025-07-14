go-yaml-comments
================

Comment Reporting for go-yaml and yq


## Synopsis

For a file named `example.yaml` in this directory, run `make example` or `make
example-gist`:

```bash
$ make example
go-yaml-event < example.yaml | \
  grep -Ev '^  (Start|End|Style|Implicit):' | \
  grep -Ev '^$' \
  > example.events.yaml
go-yaml-node < example.yaml > example.nodes.yaml
yq example.yaml > example.yq.yaml

ls -l example.events.yaml example.nodes.yaml example.yq.yaml
-rw-r--r-- 1 ingy ingy 296 Jul 14 09:49 example.events.yaml
-rw-r--r-- 1 ingy ingy 173 Jul 14 09:49 example.nodes.yaml
-rw-r--r-- 1 ingy ingy  59 Jul 14 09:49 example.yq.yaml

$ make example-gist
go-yaml-event < example.yaml | \
  grep -Ev '^  (Start|End|Style|Implicit):' | \
  grep -Ev '^$' \
  > example.events.yaml
go-yaml-node < example.yaml > example.nodes.yaml
yq example.yaml > example.yq.yaml

gist example
https://gist.github.com/ingydotnet/ba778f29a88823a7b070cff85fbf339a
```

See: <https://gist.github.com/ingydotnet/ba778f29a88823a7b070cff85fbf339a>


## Posting gists

The `make <name>-gist` command creates the files and posts them as a GitHub
Gist via the GitHub API.

To do this you will need an appropriate GitHub API token.

Put the token in a file called `~/.gist-api-token` or in the `GIST_API_TOKEN`
environment variable (don't forget to export it).


## Make Commands

This Makefile requires no prerequisites.
It will automatically install a local `go`, clone and build both formatter
repos and install `yq` and `ys` locally as needed.

You can run `make example` right away.

* `make <name>` - Generate files for `<name>.yaml`
* `make <name>-gist` - Generate files and post as a Gist
* `make clean` - Remove generated files
* `make realclean` - Remove generated files and build dirs
* `make distclean` - Remove generated files and build dirs and `.cache/`

TIP: Create the `~/.cache/makes` directory to speed up subsequent builds.
