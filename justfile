
run assignment problem:
  spim -file src/{{assignment}}/{{problem}}.asm

zip assignment:
  zip --junk-paths PatrickMiller_{{assignment}} *.asm