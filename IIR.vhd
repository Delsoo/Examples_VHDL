---------------------------------------------------------------
-- Projeto: Filtro IIR Notch para 3 frequencias de rejeição ---
-- Adelson Duarte dos Santos	RA:190710							---
-- Processamento de sinais em tempo real							---
--																				---
--						--Descrição do filtro--							---
--																				---
---------------------------------------------------------------
   
library IEEE;
library ieee_proposed;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.fixed_pkg.all;
--
--
entity IIR is
port(   Clk : in std_logic; 
        Xin : in sfixed(1 downto -14); 
        Yout : out sfixed(1 downto -14)  
        );
end IIR;
--
architecture Behavioral of IIR is

component FFD is 
   port(
      Q : out sfixed(34 downto -32);     
      Clk :in std_logic;      
      D :in  sfixed(34 downto -32)      
   );
end component;  
 
signal A0,A1,A2,B0,B1,B2 : sfixed(2 downto -14); -- coeficientes
signal add_out11 : sfixed(34 downto -32);
signal add_out12 : sfixed(33 downto -32);
signal add_out21 : sfixed(39 downto -46);
signal add_out22 : sfixed(38 downto -46);


signal mult21, mult22,mult23    :   sfixed(37 downto -46);
SIGNAL mult11,mult12,mult13 : sfixed(37 downto -46);

signal Q1,Q2 : sfixed(34 downto -32);
signal mult11todff : sfixed(34 downto -32);
signal aux : sfixed(1 downto -14);

begin

A0 <= to_sfixed(1,2,-14);
A1 <= to_sfixed(1.828,2,-14);
A2 <= to_sfixed(-0.9691,2,-14);

B0 <= to_sfixed(0.9845,2,-14);
B1 <= to_sfixed(-1.828,2,-14);
B2 <= to_sfixed(0.9845,2,-14);


mult11 <= add_out11*A0;
mult12 <= Q1*A1;
mult13 <= Q2*A2;

Mult21 <= resize(mult11,34,-32)*B0;
mult22 <= Q1*B1;
mult23 <= Q2*B2;


add_out11<= add_out12  + aux;
add_out12 <= resize(mult13,32,-32)  + resize(mult22,32,-32);


add_out21 <= add_out22 + mult21;
add_out22 <= mult23  + mult22;


mult11todff <= resize(mult11,34,-32);

dff1 : FFD port map(Q1,Clk,mult11todff);
dff2 : FFD port map(Q2,Clk,Q1);


process(Clk)
begin
    if(rising_edge(Clk)) then
    --mult11 <= Xin*A0;
    aux <=Xin;
    Yout <= resize(add_out21,1,-14);
    end if;
    end process;

--process
--      file file_pointer : text;
--      variable line_num : line;
--   begin.
--      file_open(file_pointer,"C:\Users\Adelson\Documents\Matlab\saida.txt",WRITE_MODE);
--        write(line_num,(add_out21)); 
--      writeline (file_pointer,line_num); 
--        wait for 10 ns;  
--    end process;
--
--
end Behavioral;
