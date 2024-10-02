
run assignment problem:
  spim -file src/{{assignment}}/{{problem}}.asm

zip assignment:
  zip --junk-paths PatrickMiller_{{assignment}} src/{{assignment}}/*.asm

dup +filenames:
  tee {{filenames}} < src/template.asm > /dev/null