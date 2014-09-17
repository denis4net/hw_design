-- Variant 13
-- 8 bit counter with input registers

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity COUNTER8 is
	port (
		DATA: in std_logic_vector(7 downto 0);
		NCCLR, NCKEN,  CCK, NCLOAD, RCK: in std_logic;
		NRCO: out std_logic
		);
end COUNTER8;


architecture counter_arch of COUNTER8 is
begin

end counter_arch;