---------------------------------------------------------------
-- Projeto: Filtro IIR Notch para 3 frequencias de rejeição ---
-- Adelson Duarte dos Santos	RA:190710							---
-- Processamento de sinais em tempo real							---
--																				---
--				--Descrição do Flip Flop tipo D--					---
--																				---
---------------------------------------------------------------

library IEEE;
library ieee_proposed;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.fixed_pkg.all;

entity FFD is 
   port(
      Q : out sfixed(34 downto -32);      --output connected to the adder
      Clk :in std_logic;      -- Clock input
      D :in  sfixed(34 downto -32)      -- Data input from the MCM block.
   );
end FFD;

architecture Behavioral of FFD is 

signal qt : sfixed(34 downto -32) := (others => '0');

begin 

Q <= qt;

process(Clk) 
begin 
  if ( rising_edge(Clk) ) then 
    qt <= D;
  end if;       
end process; 

end Behavioral;


----Versão Final--   
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--
--entity FFD is 
--   port(
--      Q : out real :=000000000.0000000000;       --output connected to the adder
--      Clk :in std_logic;      -- Clock input
--      D :in  real :=000000000.0000000000       -- Data input from the MCM block.
--   );
--end FFD;
--
--architecture Behavioral of FFD is 
--
--signal qt : real :=000000000.0000000000;
--
--begin 
--
--Q <= qt;
--
--process(Clk) 
--begin 
--  if ( rising_edge(Clk) ) then 
--    qt <= D;
--  end if;       
--end process; 
--
--end Behavioral;
