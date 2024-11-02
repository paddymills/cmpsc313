[private]
default:
  @just --list

[linux]
devc:
  podman build -t spim .
  podman run --rm -itv ./:/src:z spim

run assignment problem:
  spim -file src/{{assignment}}/{{problem}}.asm

init assignment problem:
  cp src/template.asm src/{{assignment}}/{{problem}}.asm

zip assignment:
  zip --junk-paths PatrickMiller_{{assignment}} src/{{assignment}}/*.asm

dup +filenames:
  tee {{filenames}} < src/template.asm > /dev/null