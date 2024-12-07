-------------------------------------------------------------------------
--  MULTIPLICAÇÃO POR SOMAS SUCESSIVAS E DIVISÃO POR SUBTRAÇÕES SUCESSIVAS
--
--	Multiplicador:
--  	Mcando, Mcador		- Multiplicando e Multiplicador, de N bits
--  	start, endop 		- Início e fim da operação de multiplicação
--  	produto      		- Resultado, com 2N bits
--
--	Divisor:
--  	dividendo,divisor	- Dividendo e Divisor, de N bits
--  	start, endop 		- Início e fim de operação de divisão
--  	quociente,resto		- Resultados, cada um com N bits
--
--  05/07/2018 (Ney) - Inicialização de sinais
--			externos, para evitar que fiquem indefinidos
--  16/06/2020 (Ney) - Bugs corrigidos
--			Mudada a lógica interna do multiplicador e do divisor para 
--			viabilizar resetá-los junto com o reset de processador externo.
--			Isto exigiu inicializar os registradores RegP e RegB em ambos
--			módulos apenas ao sair do estado inicializa e não ao entrar 
--			neste.  			
-------------------------------------------------------------------------

-----------------------------------------------------------------------
--  MÓDULO DE MULTIPLICAÇÃO
-----------------------------------------------------------------------
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;

entity multiplica is                  
      generic(N: integer := 32);
      port( Mcando:			in  std_logic_vector((N-1) downto 0);
			Mcador:			in  std_logic_vector((N-1) downto 0);
            clock,start:	in  std_logic; 
            endop:			out std_logic;
            produto:		out std_logic_vector(2*N-1 downto 0));
end;

architecture multiplica of multiplica is   

   type State_type is (inicializa, desloca, calc, termina, fim);
   signal EA: State_type;
   
   signal regP :      std_logic_vector( N*2 downto 0); 
   signal regB :      std_logic_vector( N   downto 0);
   signal cont:       integer;
     
begin      
   
   --
   -- registradores regP, regB, produto, endop e contador de execução
   --
   process(start, clock)
   begin    
     if (start='0' and EA=inicializa) then 
			-- Inicializa-se os registradores na saída do estado
			-- e não na entrada
         regP( N*2 downto N) <= (others=>'0');
         regP( N-1 downto 0) <= Mcador;         
         regB	<= '0' & Mcando;
         cont	<= 1;
         endop	<= '0';
         produto <= (others=>'0');
    
     elsif clock'event and clock='1' then     
          
          if EA=calc and regP(0)='1' then
                regP(N*2 downto N) <= regP(N*2 downto N) + regB; 
                
           elsif EA=desloca then
                regP <= '0' & regP(N*2 downto 1);
                cont <= cont + 1;
                
           elsif EA=termina then
                produto	<= regP( N*2-1 downto 0);
                endop	<= '1';
                   
           elsif EA=fim then
                endop <= '0';
         end if;
     end if;       
   end process;

   -- Máquina de Estados para controlar a multiplicação
   process (start, clock)
   begin
     if start='1' then
             EA <= inicializa;
     elsif clock'event and clock='1' then  
           case EA is
              when inicializa =>   EA <= calc;   
                        
               when calc       =>  EA <= desloca;                
           
               when desloca    =>  if cont=N then 
                                         EA <= termina; 
                                    else 
                                         EA <= calc;  
                                    end if;             
				-- estado termina só serve para gerar o pulso em endop  
                when termina   =>   EA <= fim;      
                
                when fim       =>   EA <= fim;    

           end case; 
     end if;
   end process;
   
end multiplica;   

-----------------------------------------------------------------------
--  MÓDULO DE DIVISÃO
-----------------------------------------------------------------------
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;

entity divide is                  
      generic(N: integer := 16);
      port( dividendo:		in  std_logic_vector( (N-1) downto 0);
			divisor:		in  std_logic_vector( (N-1) downto 0);
            clock,start :	in  std_logic; 
            endop :			out std_logic;
            quociente :		out std_logic_vector( N-1 downto 0);
            resto :			out std_logic_vector( N-1 downto 0));
end;

architecture divide of divide is   
   type State_type is (inicializa, desloca, calc, termina, fim);
   signal EA: State_type;
    
   signal regP :      std_logic_vector( N*2 downto 0); 
   signal regB :      std_logic_vector( N   downto 0);
   signal diferenca : std_logic_vector( N   downto 0);
   signal cont:       integer;
  
begin      
   
   diferenca <=  regP( N*2 downto N) -  regB( N downto 0);   

   process(start, clock)
   begin    
     if (start='0' and EA=inicializa) then
			-- Inicializa-se os registradores na saída do estado
			-- e não na entrada
		regP(N*2 downto N) <= (others=>'0');
		regP(N-1 downto 0) <= dividendo;
		regB  <= '0' & divisor;
		cont  <= 1;
		endop <= '0';
		resto <= (others=>'0');
		quociente <= (others=>'0');
      
     elsif clock'event and clock='1' then 
     
            if EA=desloca then
                regP  <= regP( N*2-1 downto 0) & regP(N*2);
                
            elsif EA=calc then  
            
                if diferenca(N)='1' then  
                      regP(0)<='0';
                else
                      regP(0)<='1';
                      regP(N*2 downto N) <= diferenca;
                end if;
                
                cont <= cont + 1;
                
            elsif EA=termina then
                      resto   <= regP( N*2-1 downto N);
                      quociente <= regP( N-1   downto 0);
                      endop <= '1';
                   
            elsif EA=fim then
                     endop <= '0';
                      
            end if;
         
        end if;       
    end process;
 
   -- Máquina de Estados para controlar a divisão
   process (start, clock)
      begin
       if start='1'then
                EA <= inicializa;
       elsif clock'event and clock='1' then  
           case EA is
                when inicializa =>  EA <= desloca; 
                
                when desloca    =>  EA <= calc;
                
                when calc       =>  if cont=N then 
                                       EA <= termina; 
                                    else 
                                       EA <= desloca;  
                                    end if;
                                    
				-- estado termina só serve para gerar o pulso em endop  
                when termina   =>   EA <= fim;  
                
                when fim       =>   EA <= fim;    

         end case; 
       end if;
   end process; 
   
end divide;
