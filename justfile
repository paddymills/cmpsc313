[private]
default:
  @just --list

[linux]
devc:
  podman build -t spim .
  podman run --rm -itv ./:/src:z spim

run problem:
  spim -file src/$FOLDER/{{problem}}.asm

init problem:
  cp src/template.asm src/$FOLDER/{{problem}}.asm

zip assignment:
  zip --junk-paths PatrickMiller_{{assignment}} src/{{assignment}}/*.asm

dup +filenames:
  tee {{filenames}} < src/template.asm > /dev/null