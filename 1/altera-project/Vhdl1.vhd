library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


entity busmux4x4 is
	port (
		in_bus: in std_logic_vector(15 downto 0);
		sel: in std_logic_vector(3 downto 0);
		out_bus: out std_logic_vector(3 downto 0)
	);
end busmux4x4;

architecture busmux4x4_arch of busmux4x4
is
begin
end busmux4x4_arch;