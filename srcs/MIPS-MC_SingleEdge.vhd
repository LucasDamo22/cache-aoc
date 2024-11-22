-------------------------------------------------------------------------
--
-- I M P L E M E N T A Ç Ã O   P A R C I A L  D O  M I P S (junho/2020)
-- MIPS_S
--  Professores     Fernando Moraes / Ney Calazans
--
--  ==> A entidade de nível mais alto denomina-se MIPS_S
--  21/06/2010 (Ney) - Bug corrigido no mux que gera op1 - agora recebe
--		NPC e não mais o pc.
--  17/11/2010 (Ney) - Bugs corrigidos:
--		1 - Decodificação das instruções BGEZ e BLEZ estava 
--		incompleta
--		2 - Definição de que linhas escolhem o registrador a
--		ser escrito nas instruções de deslocamento 
--		(SSLL, SLLV, SSRA, SRAV, SSRL e SRLV)
--  05/06/2012 (Ney) - Mudanças menores em nomenclatura
--  19/11/2015 (Ney) - Mudança para MIPS-MC Single Clock Edge
--			Além das mudanças óbvias de sensibilidade de elementos de 
--			memória para somente borda de subida, tambem mudou-se o
--			ponto de onde as entradas de dados do multiplicador e do
--			divisor provém, agora direto da saída do banco de 
--			registradores e não mais de R1 e R2. Ainda, mudou-se a
--			estrutura dos blocos de dados e controle. O Bloco
--			de Controle agora contém o PC, o NPC e o IR e,
--			naturalmente a interface com a memória de instruções.
--			Foi também eliminado o estado Sidle, por desnecessário.
--  04/07/2016 (Ney) - Diversas revisões em nomes de sinais para 
--			aumentar a intuitividade da descrição, mudança do
--			nome do processador para MIPS_S (ver documentação, versão 2.0
--			ou superior).
--  05/08/2016 (Ney) - Correção e adaptação dos nomes de sinais e
--			blocos para facilitar aprendizado. Processador agora se chama
--			MIPS_MCS (MIPS Multi-Ciclo Single Edge)
--  05/07/2018 (Ney) - Correção e adaptação dos nomes de sinais para 
--			facilitar o aprendizado.
--  13/12/2018 (Ney) - Eliminada qualquer menção a um registrador
--			temporário IMED (para deixar a descrição coerente)
--  11/12/2019 (Ney) - Bugs corrigidos:
--			Corrigido um erro no MUX M6 que não se manifestou jamais antes,
--			pois usamos somente enderecos de salto onde os bits 
--			25-21=00000. O erro era deixar passar R1 para a entrada op1
--			da ALU quando se está calculando o endereço de salto para 
--			J e JAL, e não o NPC, que é o certo.
--  16/06/2020 (Ney) - Bugs corrigidos:
--			Devido a falhas no multiplicador/divisor. Por algum motivo, 
--			entre a versão anterior	e a de 19/11/2015, as entradas do 
--			multiplicador/divisor voltaram a estar conectadas as saídas de
--			R1 e R2. Agora isto foi desfeito. Outra alteração foi mudar a
--			lógica interna do multiplicador e do divisor para viabilizar 
--			resetá-los junto com o processador. Isto exigiu inicializar os
--			registradores RegP e RegB em ambos os módulos apenas ao sair do
--			estado inicializa e não ao entrar neste. Depois desta 
--			modificação ficou simples tornar o sinal rst dos módulos um
--			OR do sinal rst do processador e de uins.rst_md. O novo sinal
--			criado se chama rst_muldiv.
--	29/09/2021 (Ney) - Comentários revisados, resolvendo questões de 
--			grafia e acentuação possíveis de serem considerados em Sw tal 
--			como o Vivado.
--	20/10/2021 (Ney) - Comentários revisados, rótulos acrescentados e nome
--			regnbits trocado para reg32bit. Por coerência o processador
--          é agora denominado MIPS_S em todos os lugares, mudando-se 
--          até mesmo o nome do package para p_MIPS_S.
-------------------------------------------------------------------------

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- package com os tipos básicos auxiliares para descrever o processador
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.Std_Logic_1164.all;

package p_MIPS_S is  
    
    -- inst_type define as instruções decodificáveis pelo bloco de controle
    type inst_type is  
            ( ADDU, SUBU, AAND, OOR, XXOR, NNOR, SSLL, SLLV, SSRA, SRAV,
				SSRL, SRLV,ADDIU, ANDI, ORI, XORI, LUI, LBU, LW, SB, SW, SLT,
				SLTU, SLTI,	SLTIU, BEQ, BGEZ, BLEZ, BNE, J, JAL, JALR, JR, 
				MULTU, DIVU, MFHI, MFLO, invalid_instruction);
 
    type microinstruction is record
            CY1:   std_logic;       -- identificador de primeiro ciclo da instrução
            CY2:   std_logic;       -- identificador de segundo ciclo da instrução
            walu:  std_logic;       -- identificador de terceiro ciclo da instrução
            wmdr:  std_logic;       -- identificador de quarto ciclo da instrução
            wpc:   std_logic;       -- habilitação de escrita no PC
            wreg:  std_logic;       -- habilitação de escrita no Banco de Registradores
            whilo: std_logic;       -- habilitação de escrita nos registradores HI e LO
            ce:    std_logic;       -- chip enable e controle de escrita/leitura
            rw:    std_logic;
            bw:    std_logic;       -- controle de escrita a byte
            i:     inst_type;       -- código que especifica a instrução sob execução
            rst_md:std_logic;       -- inicialização do multiplicador e do divisor
    end record;
         
end p_MIPS_S;


--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Registrador de uso geral de 32 bits - sensível à  borda de subida do
-- relógio (ck), com reset assíncrono (rst) e habilitação de escrita (ce)
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;

entity reg32bit is
           generic( INIT_VALUE : STD_LOGIC_VECTOR(31 downto 0) := (others=>'0')
					);
           port(  ck, rst, ce : in std_logic;
                  D : in  STD_LOGIC_VECTOR (31 downto 0);
                  Q : out STD_LOGIC_VECTOR (31 downto 0)
               );
end reg32bit;

architecture reg32bit of reg32bit is 
begin
  process(ck, rst)
  begin
       if rst = '1' then
              Q <= INIT_VALUE;
       elsif ck'event and ck = '1' then
           if ce = '1' then
              Q <= D; 
           end if;
       end if;
  end process;
        
end reg32bit;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Banco de Registradores  (R0..R31) - 31 registradores de 32 bits
-- 	Trata-se de uma memória com trás portas de acesso, não confundir
--		com a memória principal do processador. 
--		São duas portas de leitura (sinais AdRP1+DataRP1 e AdRP2+DataRP2) e
--		uma porta de escrita (controlada pelo conjunto de sinais ck, rst,
--		ce, AdWP e DataWP).
--		Os endereços de cada porta (AdRP1, AdRP2 e AdWP) são obviamente de
--		5 bits (pois 2^5=32 e precisamos de um endereço distinto para
--		cada um dos 32 registradores), enquanto que os barramentos de dados de 
--		saída (DataRP1, DataRP2) e de entrada (DataWP) são de 32 bits.
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.Std_Logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;   
use work.p_MIPS_S.all;

entity reg_bank is
       port( ck, rst, ce :    in std_logic;
             AdRP1, AdRP2, AdWP : in std_logic_vector( 4 downto 0);
             DataWP : in std_logic_vector(31 downto 0);
             DataRP1, DataRP2: out std_logic_vector(31 downto 0) 
           );
end reg_bank;

architecture reg_bank of reg_bank is
   type wirebank is array(0 to 31) of std_logic_vector(31 downto 0);
   signal reg : wirebank ;                            
   signal wen : std_logic_vector(31 downto 0) ;
begin            
    g1: for i in 0 to 31 generate        

        -- Lembrar que o registrador $0 ($zero) é a constante 0, não um registrador.
        -- Ele é descrito como um registrador cujo ce nunca é ativado
		-- O sinal wen é o vetor sinais de controle de habilitação de escrita em cada
		-- um dos 32 registradores: wen(0) é a habilitação de escrita no registrador 0
		-- (como dito acima, wen(0)='0', sempre. Os demais dependem do valor de AdWP
		-- o do ce global.
        wen(i) <= '1' when i/=0 and AdWP=i and ce='1' else '0';
         
        -- Lembrar que o registrador $29, por convenção de software é o apontador de
		-- pilha. Ele aponta inicialmente para um lugar diferente do valor usado no MARS.
		-- A pilha aqui é pensada como usando a parte final da memória de dados
        g2: if i=29 generate -- SP ---  x10010000 + x800 -- local do topo da pilha
           r29: entity work.reg32bit generic map(INIT_VALUE=>x"10010800")    
                port map(ck=>ck, rst=>rst, ce=>wen(i), D=>DataWP, Q=>reg(i));
        end generate;  
                
        g3: if i/=29 generate 
           rx: entity work.reg32bit 
					port map(ck=>ck, rst=>rst, ce=>wen(i), D=>DataWP, Q=>reg(i));                    
        end generate;
                   
   end generate g1;   
    

    DataRP1 <= reg(CONV_INTEGER(AdRP1));    -- seleção do fonte 1 

    DataRP2 <= reg(CONV_INTEGER(AdRP2));    -- seleção do fonte 2 
   
end reg_bank;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- ALU - Uma unidade lógico-aritmética puramente combinacional, cuja 
--		saída depende dos valores nas suas entradas de dados op1 e op2, cada
--		uma de 32 bits e da instrução sendo executada pelo processador,
--		que é informada via o sinal de controle op_alu.
--
-- 22/11/2004 (Ney Calazans) - correção de um erro sutil para a instrução J
-- Lembrar que parte do trabalho para a J (cálculo de endereço) já foi
-- iniciado antes, deslocando IR(25 downto 0) para a esquerda em 2 bits
-- antes de escrever dados no registrador R3.
--
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use work.p_MIPS_S.all;

entity alu is
       port( op1, op2 : in std_logic_vector(31 downto 0);
             outalu :   out std_logic_vector(31 downto 0);   
             op_alu : in inst_type   
           );
end alu;

architecture alu of alu is 
   signal menorU, menorS : std_logic ;
begin
  
    menorU <=  '1' when op1 < op2 else '0'; -- comparação de naturais
    menorS <=  '1' when ieee.Std_Logic_signed."<"(op1,  op2) else '0' ; -- comparação de inteiros
    
    outalu <=  
		op1 - op2                            when  op_alu=SUBU                     else
        op1 and op2                          when  op_alu=AAND  or op_alu=ANDI     else 
        op1 or  op2                          when  op_alu=OOR   or op_alu=ORI      else 
        op1 xor op2                          when  op_alu=XXOR  or op_alu=XORI     else 
        op1 nor op2                          when  op_alu=NNOR                     else 
        op2(15 downto 0) & x"0000"           when  op_alu=LUI                      else
        (0=>menorU, others=>'0')             when  op_alu=SLTU  or op_alu=SLTIU    else
        (0=>menorS, others=>'0')             when  op_alu=SLT   or op_alu=SLTI     else
        op1(31 downto 28) & op2(27 downto 0) when  op_alu=J     or op_alu=JAL      else 
        op1                                  when  op_alu=JR    or op_alu=JALR     else 
        to_StdLogicVector(to_bitvector(op1) sll  CONV_INTEGER(op2(10 downto 6)))   when
													op_alu=SSLL   else 
        to_StdLogicVector(to_bitvector(op2) sll  CONV_INTEGER(op1(5 downto 0)))    when
													op_alu=SLLV   else 
        to_StdLogicVector(to_bitvector(op1) sra  CONV_INTEGER(op2(10 downto 6)))   when  
													op_alu=SSRA   else 
        to_StdLogicVector(to_bitvector(op2) sra  CONV_INTEGER(op1(5 downto 0)))    when  
													op_alu=SRAV   else 
        to_StdLogicVector(to_bitvector(op1) srl  CONV_INTEGER(op2(10 downto 6)))   when  
													op_alu=SSRL   else 
        to_StdLogicVector(to_bitvector(op2) srl  CONV_INTEGER(op1(5 downto 0)))    when
													op_alu=SRLV   else 
        op1 + op2;    -- default para ADDU,ADDIU,LBU,LW,SW,SB,BEQ,BGEZ,BLEZ,BNE    

end alu;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Descrição Estrutural do Bloco de Dados 
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_signed.all; -- necessário para as instruções SLTx
use IEEE.Std_Logic_arith.all;  -- necessário para as instruções SLTxU
use work.p_MIPS_S.all;
   
entity datapath is
      port( ck, rst :     in std_logic;
			d_address :   out std_logic_vector(31 downto 0);
			data :        inout std_logic_vector(31 downto 0); 
			inst_branch_out, salta_out : out std_logic;
			end_mul :	   out std_logic;
			end_div :	   out std_logic;
			RESULT_OUT :  out std_logic_vector(31 downto 0);
			uins :        in microinstruction;
			IR_IN :  		in std_logic_vector(31 downto 0);
			NPC_IN : 		in std_logic_vector(31 downto 0)
          );
end datapath;

architecture datapath of  datapath is
    signal result, R1, R2, R3, R1_in, R2_in, R3_in, RIN, sign_extend, op1, op2, 
           outalu, RALU, MDR, mdr_int, HI, LO,
		   quociente, resto, D_Hi, D_Lo : std_logic_vector(31 downto 0) := (others=> '0');
    signal adD, adS : std_logic_vector(4 downto 0) := (others=> '0');    
    signal inst_branch, inst_R_sub, inst_I_sub, rst_muldiv: std_logic;   
    signal salta : std_logic := '0';
    signal produto : std_logic_vector(63 downto 0);
begin

	-- sinais auxiliares 
	inst_branch  <= '1' when uins.i=BEQ or uins.i=BGEZ or uins.i=BLEZ or uins.i=BNE else 
					'0';
	inst_branch_out <= inst_branch;
   
	-- inst_R_sub é um subconjunto das instruções tipo R 
	inst_R_sub  <= 	'1' when uins.i=ADDU or uins.i=SUBU or uins.i=AAND
							or uins.i=OOR or uins.i=XXOR or uins.i=NNOR else
					'0';

	-- inst_I_sub é um subconjunto das instruções tipo I
	inst_I_sub  <= '1' when uins.i=ADDIU or uins.i=ANDI or uins.i=ORI or uins.i=XORI else
                   '0';

	--==============================================================================
	-- segundo estágio
	--==============================================================================
                
	-- A cláusula "then" aqui só é usada para deslocamentos com um campo "shamt"       
	M3: adS <=	IR_IN(20 downto 16) when uins.i=SSLL or uins.i=SSRA or uins.i=SSRL else 
				IR_IN(25 downto 21);
          
	REGS: entity work.reg_bank(reg_bank) port map
					(AdRP1=>adS, DataRP1=>R1_in, AdRP2=>IR_IN(20 downto 16), 
					DataRP2=>R2_in, ck=>ck, rst=>rst, ce=>uins.wreg, AdWP=>adD, DataWP=>RIN);
    
	-- extensão de sinal  
	sign_extend <=  x"FFFF" & IR_IN(15 downto 0) when IR_IN(15)='1' else
					x"0000" & IR_IN(15 downto 0);
    
	-- Cálculo da constante imediata - extensões e mux M5
	M5: R3_in <= 	sign_extend(29 downto 0)  & "00"     when inst_branch='1' else
					-- ajusta o endereço de salto para uma fronteira múltiplo de palavra
					"0000" & IR_IN(25 downto 0) & "00" when uins.i=J or uins.i=JAL else
					-- J/JAL são endereçadas a palavra. Os 4 bits menos significativos são definidos
					-- na ALU, não aqui!!
					x"0000" & IR_IN(15 downto 0) when uins.i=ANDI or uins.i=ORI  or uins.i=XORI else					-- instruções lógicas com operando imediatao usam extensão de 0 para calcular este
					sign_extend;
					-- O caso "default" (extensão de sinal) é usado por addiu, lbu, lw, sbu e sw
             
	-- registradores do segundo estágio 
	R1reg:  entity work.reg32bit port map(ck=>ck, rst=>rst, ce=>uins.CY2, D=>R1_in, Q=>R1);

	R2reg:  entity work.reg32bit port map(ck=>ck, rst=>rst, ce=>uins.CY2, D=>R2_in, Q=>R2);
  
	R3reg: entity work.reg32bit port map(ck=>ck, rst=>rst, ce=>uins.CY2, D=>R3_in, Q=>R3);
 
 
	--==============================================================================
	-- terceiro estágio
	--==============================================================================
                      
	-- seleciona o primeiro operando da ALU
	M6: op1 <= 	NPC_IN  when (inst_branch='1' or uins.i=J or uins.i=JAL) else R1; 
     
	-- seleciona o segundo operando da ALU
	M7: op2 <= 	R2 when inst_R_sub='1' or uins.i=SLTU or uins.i=SLT or uins.i=JR 
                  or uins.i=SLLV or uins.i=SRAV or uins.i=SRLV else 
		R3; 
                 
	-- instanciação da ALU
	DALU: entity work.alu port map (op1=>op1, op2=>op2, outalu=>outalu, op_alu=>uins.i);
   
	-- registrador na saída da ALU
	ALUreg: entity work.reg32bit  port map(ck=>ck, rst=>rst, ce=>uins.walu, 
				D=>outalu, Q=>RALU);               
 
	-- Avliação das condições para executar saltos em "branchs"
	salta <=	'1' when ( (R1=R2  and uins.i=BEQ)  or (R1>=0  and uins.i=BGEZ) or
                        (R1<=0  and uins.i=BLEZ) or (R1/=R2 and uins.i=BNE) )  else
				'0';
	salta_out <= salta;
	
	-- reset do multiplicador e do divisor; pode ser via reset global (rst) ou antes do início da
	-- instrução multu/divu
	rst_muldiv <= rst or uins.rst_md; 
	
	-- instanciação do multiplicador e do divisor
	inst_mult: entity work.multiplica port map (Mcando=>R1_in, Mcador=>R2_in, clock=>ck,
	  start=>rst_muldiv, endop=>end_mul, produto=>produto);
	  
	inst_div: entity work.divide generic map (32) port map (dividendo=>R1_in, divisor=>R2_in, clock=>ck,
	  start=>rst_muldiv, endop=>end_div, quociente=>quociente, resto=>resto);

	M10: D_Hi <= produto(63 downto 32) when uins.i=MULTU else resto; 
	
	M11: D_Lo <= produto(31 downto 0) when uins.i=MULTU else quociente; 

	-- registradores HI e LO
	HIreg: entity work.reg32bit  port map(ck=>ck, rst=>rst, ce=>uins.whilo, 
			D=>D_Hi, Q=>HI);               
	LOreg: entity work.reg32bit  port map(ck=>ck, rst=>rst, ce=>uins.whilo, 
			D=>D_Lo, Q=>LO);               

   --==============================================================================
   -- quarto estágio
   --==============================================================================
     
   d_address <= RALU;
    
   -- tristate para controlar a escrita na memória    
   data <= R2 when (uins.ce='1' and uins.rw='0') else (others=>'Z');  

   -- mux M8 escolhe entre passar 32 bits da memória para dentro do processador
   -- ou passar apenas o byte menos significativo com 24 bits de extensão de 0. 
   -- assume-se aqui como em todos os lugares, que o processador é "little endian"
   M8: mdr_int <= data when uins.i=LW  else
              x"000000" & data(7 downto 0);
       
   RMDR: entity work.reg32bit  port map(ck=>ck, rst=>rst, ce=>uins.wmdr,
			D=>mdr_int, Q=>MDR);                 
  
   M9: result <=	MDR when uins.i=LW  or uins.i=LBU else
                    HI when uins.i=MFHI else
                    LO when uins.i=MFLO else
                    RALU;

   --==============================================================================
   -- quinto estágio
   --==============================================================================

   -- M2 escolhe o sinal com o dado a ser escrito no banco de registradores
   M2: RIN <= NPC_IN when (uins.i=JALR or uins.i=JAL) else result;
   
   -- M4 seleciona o endereço de escrita no banco de registradores 
   M4: adD <= "11111" when uins.i=JAL else -- JAL escreve sempre no registrador $31
         IR_IN(15 downto 11) when (inst_R_sub='1' 
					or uins.i=SLTU or uins.i=SLT
					or uins.i=JALR
					or uins.i=MFHI or uins.i=MFLO
					or uins.i=SSLL or uins.i=SLLV
					or uins.i=SSRA or uins.i=SRAV
					or uins.i=SSRL or uins.i=SRLV) else
         IR_IN(20 downto 16) 	-- inst_I_sub='1' ou uins.i=SLTIU ou uins.i=SLTI 
        ;                 		-- ou uins.i=LW ou uins.i=LBU ou uins.i=LUI, ou "default"
    
  RESULT_OUT <= result;
	 
end datapath;

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--  Descrição do Bloco de Controle (mista, estrutural-comportamental)
--------------------------------------------------------------------------
--------------------------------------------------------------------------
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;
use work.p_MIPS_S.all;

entity control_unit is
        port(	ck, rst : in std_logic;
				hold: in std_logic;
				inst_branch_in, salta_in : in std_logic;
				end_mul, end_div : in std_logic;
				i_address : out std_logic_vector(31 downto 0);
				instruction : in std_logic_vector(31 downto 0);
				RESULT_IN : in std_logic_vector(31 downto 0);
				uins : out microinstruction;
				IR_OUT : out std_logic_vector(31 downto 0);
				NPC_OUT : out std_logic_vector(31 downto 0)
             );
end control_unit;
                   
architecture control_unit of control_unit is
	type type_state is (Sfetch, Sreg, Salu, Swbk, Sld, Sst, Ssalta); -- 7 estados 
	signal PS, NS : type_state; -- PS = estado atual; NS = próximo estado
	signal i : inst_type;
	signal uins_int : microinstruction;
	signal dtpc, NPC, pc, incpc, IR  : std_logic_vector(31 downto 0);
begin
    ----------------------------------------------------------------------------------------
    -- BLOCO (1 de 4) - Os registradores de controle da MIPS_S.
	-- Busca de instrução e incremento do PC
    ----------------------------------------------------------------------------------------
	-- M1 seleciona a entrada do registrador PC 
	M1: dtpc <=	RESULT_IN when (inst_branch_in='1' and salta_in='1') or uins_int.i=J
   			or uins_int.i=JAL or uins_int.i=JALR or uins_int.i=JR	else
   		NPC;
   
	NPC_OUT <= NPC;
	
	-- Endereço de partida onde está armazenado o programa: cuidado com este valor!
	-- O valor abaixo (x"00400000") serve para código gerado pelo simulador MARS
	PC_reg: entity work.reg32bit generic map(INIT_VALUE=>x"00400000")   
		port map(ck=>ck, rst=>rst, ce=>uins_int.wpc, D=>dtpc, Q=>pc);

	incpc <= pc + 4;
  
	NPCreg: entity work.reg32bit 
		 port map(ck=>ck, rst=>rst, ce=>uins_int.CY1, D=>incpc, Q=>NPC);     
           
	IR_reg:	entity work.reg32bit  
		port map(ck=>ck, rst=>rst, ce=>uins_int.CY1, D=>instruction, Q=>IR);

	IR_OUT <= IR ;    	-- IR é o registrador de instruções 
             
	i_address <= pc;	-- conecta a saída do PC ao barramento de endereços da memória de
						-- instruções

    ----------------------------------------------------------------------------------------
    -- BLOCO (2 de 4) - A Decodifiação de Instruções
    -- Este bloco gera um sinal, i, um dos sinais da
	-- 	função de saída da máquina de estados de controle do MIPS_S
    ----------------------------------------------------------------------------------------
    i <=   ADDU   when IR(31 downto 26)="000000" and IR(10 downto 0)="00000100001" else
           SUBU   when IR(31 downto 26)="000000" and IR(10 downto 0)="00000100011" else
           AAND   when IR(31 downto 26)="000000" and IR(10 downto 0)="00000100100" else
           OOR    when IR(31 downto 26)="000000" and IR(10 downto 0)="00000100101" else
           XXOR   when IR(31 downto 26)="000000" and IR(10 downto 0)="00000100110" else
           NNOR   when IR(31 downto 26)="000000" and IR(10 downto 0)="00000100111" else
           SSLL   when IR(31 downto 21)="00000000000" and IR(5 downto 0)="000000" else
           SLLV   when IR(31 downto 26)="000000" and IR(10 downto 0)="00000000100" else
           SSRA   when IR(31 downto 21)="00000000000" and IR(5 downto 0)="000011" else
           SRAV   when IR(31 downto 26)="000000" and IR(10 downto 0)="00000000111" else
           SSRL   when IR(31 downto 21)="00000000000" and IR(5 downto 0)="000010" else
           SRLV   when IR(31 downto 26)="000000" and IR(10 downto 0)="00000000110" else
           ADDIU  when IR(31 downto 26)="001001" else
           ANDI   when IR(31 downto 26)="001100" else
           ORI    when IR(31 downto 26)="001101" else
           XORI   when IR(31 downto 26)="001110" else
           LUI    when IR(31 downto 26)="001111" else
           LW     when IR(31 downto 26)="100011" else
           LBU    when IR(31 downto 26)="100100" else
           SW     when IR(31 downto 26)="101011" else
           SB     when IR(31 downto 26)="101000" else
           SLTU   when IR(31 downto 26)="000000" and IR(5 downto 0)="101011" else
           SLT    when IR(31 downto 26)="000000" and IR(5 downto 0)="101010" else
           SLTIU  when IR(31 downto 26)="001011"                             else
           SLTI   when IR(31 downto 26)="001010"                             else
           BEQ    when IR(31 downto 26)="000100" else
           BGEZ   when IR(31 downto 26)="000001" and IR(20 downto 16)="00001" else
           BLEZ   when IR(31 downto 26)="000110" and IR(20 downto 16)="00000" else
           BNE    when IR(31 downto 26)="000101" else
           J      when IR(31 downto 26)="000010" else
           JAL    when IR(31 downto 26)="000011" else
           JALR   when IR(31 downto 26)="000000"  and IR(20 downto 16)="00000"
                                           and IR(10 downto 0) = "00000001001" else
           JR     when IR(31 downto 26)="000000" and IR(20 downto 0)="000000000000000001000" else
           MULTU  when IR(31 downto 26)="000000" and IR(15 downto 0)="0000000000011001" else
           DIVU   when IR(31 downto 26)="000000" and IR(15 downto 0)="0000000000011011" else
           MFHI   when IR(31 downto 16)=x"0000" and IR(10 downto 0)="00000010000" else
           MFLO   when IR(31 downto 16)=x"0000" and IR(10 downto 0)="00000010010" else
           invalid_instruction ; -- IMPORTANTE: a condição else de tudo é invalid instruction
        
    assert i /= invalid_instruction
          report "******************* INVALID INSTRUCTION *************"
          severity error;
                   
    uins_int.i <= i;    -- isto instrui a ALU a executar a operação dela esperada, se houver alguma
						-- também controla a operação de praticamente todos os multiplexadores
						--		que definem os caminhos a usar no bloco de dados e no bloco de controle

    ---------------------------------------------------------------------------------------------
    -- BLOCO (3 de 4) - Dois Comandos process VHDL que respectivamente geram:
	--					1) O Registrador de Estados da Máquina de Estados de Controle do MIPS_S
	--					2) A Função de Transição da Máquina de Estados de Controle do MIPS_S
	--	O Registrador de Estados é o único  hardware sequencial da Máquina de Estados
	--	A Função de Transição e uma única função Booleana combinacional que gera o próximo estado
	--		da Máquina de Estados
    --------------------------------------------------------------------------------------------- 
    process(rst, ck)
    begin
        if rst='1' then
            PS <= Sfetch; -- Sfetch é o estado em que a máquina fica enquanto o processador está sendo ressetado
        elsif ck'event and ck='1' then
            if hold = '1' then -- Quando estiver em hold, a máquina não anda
                if PS /= Sfetch then -- Em hold, espera até o próximo Sfetch para trancar a máquina
                    PS <= NS;
                end if;
			else
                PS <= NS;
            end if;
        end if;
    end process;
     
     
    process(PS, i, end_mul, end_div)
    begin
       case PS is         
            -- Sfetch ativa o primeiro estágio: busca-se a instrução apontada pelo PC e incrementa-se ele
            when Sfetch=>NS <= Sreg;  
     
            -- SReg ativa o segundo estágio: busca-se os operandos fonte da maioria das instruções
			--		registradores, dados imediatos e valores para computar endereços de salto
            when Sreg=>NS <= Salu;  
             
            -- Salu ativa o terceiro estágio: operação na ALU, no comparador ou no multiplicador ou no divisor
            when Salu =>if (i=LBU or i=LW) then 
										NS <= Sld;  
								elsif (i=SB or i=SW) then 
										NS <= Sst;
								elsif (i=J or i=JAL or i=JALR or i=JR or i=BEQ
                               or i=BGEZ or i=BLEZ  or i=BNE) then 
										NS <= Ssalta;
								elsif ((i=MULTU and end_mul='0') or (i=DIVU and end_div='0')) then
										NS <= Salu;
								elsif ((i=MULTU and end_mul='1') or (i=DIVU and end_div='1')) then
										NS <= Sfetch;
								else 
										NS <= Swbk; 
								end if;
                         
            -- Sld ativa o quarto estágio: operação na memória de dados, apenas quando a instrução sendo
			--		requer tal tipo de ação
            when Sld=>  NS <= Swbk; 
            
            -- Sst/Ssalta/ Swbk ativam o quarto ou quinto estágio: 
			--		último estágio para a maioria das instruções
            when Sst | Ssalta | Swbk=> 
								NS <= Sfetch;
  
       end case;

    end process;
	
	----------------------------------------------------------------------------------------
    -- BLOCO (4 de 4) - Função de Saída da Máquina de Estados de Controle do MIPS_S
	--	Gera 11 sinais  de controle - a maioria destes são sinais de habilitação 
	--	de escrita em registradores dos blocos de dados e de controle
    -- 	Também gera os sinais de controle de acesso a memória de dados e o sinal de
	--	inicialização dos blocos de multiplicação e divisão
	--		Ao todo, são 11 funções Booleanas, uma para cada sinal de controle
    ----------------------------------------------------------------------------------------
    uins_int.CY1   <= '1' when PS=Sfetch         else '0';
            
    uins_int.CY2   <= '1' when PS=Sreg           else '0';
  
    uins_int.walu  <= '1' when PS=Salu           else '0';
                
    uins_int.wmdr  <= '1' when PS=Sld            else '0';
  
    uins_int.wreg   <= '1' when PS=Swbk or (PS=Ssalta and (i=JAL or i=JALR)) else   '0';
   
    uins_int.rw    <= '0' when PS=Sst            else  '1';
                  
    uins_int.ce    <= '1' when PS=Sld or PS=Sst  else '0';
    
    uins_int.bw    <= '0' when PS=Sst and i=SB   else '1';
      
    uins_int.wpc   <= '1' when PS=Swbk or PS=Sst or PS=Ssalta 
	 		or (PS=Salu and ((i=MULTU and end_mul='1')
			or (i=DIVU and end_div='1'))) else  '0';

    uins_int.whilo   <= '1' when (PS=Salu and end_mul='1' and i=MULTU)
			  or (PS=Salu and end_div='1' and i=DIVU) 
			else  '0';

    uins_int.rst_md   <= '1' when PS=Sreg and (i=MULTU or i=DIVU) else  '0';

	uins <= uins_int;
    
end control_unit;

--------------------------------------------------------------------------
-- Processador MIPS_S completo
-- Aqui se instanciam o Bloco de Dados (datapath) e
-- o Bloco de Controle (control_unit) e conectam estes blocos entre si
-- e com os pinos externos do processador
--------------------------------------------------------------------------
library IEEE;
use IEEE.Std_Logic_1164.all;
use work.p_MIPS_S.all;

entity MIPS_S is
    port( clock, reset: in std_logic;
    	  hold: in std_logic;
          ce, rw, bw: out std_logic;
          i_address, d_address: out std_logic_vector(31 downto 0);
          instruction: in std_logic_vector(31 downto 0);
          data: inout std_logic_vector(31 downto 0));
end MIPS_S;

architecture MIPS_S of MIPS_S is
		signal IR, NPC, RESULT: std_logic_vector(31 downto 0);
		signal uins: microinstruction;  
		signal inst_branch, salta, end_mul, end_div: std_logic;
 begin

     dp: entity work.datapath   
         port map(ck=>clock, rst=>reset, d_address=>d_address, data=>data,
		  inst_branch_out=>inst_branch, salta_out=>salta,
		  end_mul=>end_mul, end_div=>end_div, RESULT_OUT=>RESULT,
		  uins=>uins, IR_IN=>IR, NPC_IN=>NPC);

     ct: entity work.control_unit port map( ck=>clock, rst=>reset, hold=>hold, 
		i_address=>i_address, instruction=>instruction,
		inst_branch_in=>inst_branch, salta_in=>salta, 
		end_mul=>end_mul, end_div=>end_div, RESULT_IN=>RESULT,
		uins=>uins, IR_OUT=>IR, NPC_OUT=>NPC);
         
     ce <= uins.ce;
     rw <= uins.rw; 
     bw <= uins.bw;
     
end MIPS_S;