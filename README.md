# cache-aoc
- cd srcs
- vsim -do sim.do
tem varios sim's.do, cada um deles com seu proposito, tem o que testa a memoria, tem o que compila o vhdl, e tem um pro system verilog. Quando começarem a fazer a cache, tentem deixar bem parametrizavel e modularizado.
Dentro da ram.sv tem uma função que pega a parte mais baixa do endereço pra usar, pq é assim que é feito nessa bomba
Tem que ajeitar a PRIMEIRA instrução depois do reset, por algum motivo ele nao espera pra trocar o endereço, tenho 95% de certza que é do processador o problema, mas antes de mexerem nisso, vejam de impacta realmente em algo, e se vale a pena quebrar a cabeça com isso.
Quando forem fazer programas novos no mips, fazem o dump de BINARIO, e coloquem o path na instanciação das memorias
