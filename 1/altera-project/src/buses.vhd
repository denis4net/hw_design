library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity busgate4 is
	port( 
		in_bus: in std_logic_vector(3 downto 0);
		is_enabled: in std_logic;
		out_bus: out std_logic_vector(3 downto 0)
	);
end;

architecture logic of busgate4 is
	signal tmp_enabled: std_logic_vector(3 downto 0);
begin
		tmp_enabled <= (others => is_enabled);
		out_bus <= in_bus and tmp_enabled;
	
end;

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
end;
architecture logic of busmux4x4 is
	component busmux
		port( 
		in_bus: in std_logic_vector(3 downto 0);
		is_enabled: in std_logic;
		out_bus: out std_logic_vector(3 downto 0)
	);
	end component;
	
	signal internal_bus: std_logic_vector(15 downto 0);
begin
	cell1: busmux port map (in_bus=>in_bus(3 downto 0), is_enabled=>sel(0), out_bus=>internal_bus(3 downto 0));
	cell2: busmux port map (in_bus=>in_bus(7 downto 4), is_enabled=>sel(1), out_bus=>internal_bus(7 downto 4));
	cell3: busmux port map (in_bus=>in_bus(11 downto 8), is_enabled=>sel(2), out_bus=>internal_bus(11 downto 8));
	cell4: busmux port map (in_bus=>in_bus(15 downto 12), is_enabled=>sel(3), out_bus=>internal_bus(15 downto 12));
	out_bus <= internal_bus(3 downto 0) or internal_bus(7 downto 4) or internal_bus(11 downto 8) or internal_bus(15 downto 12);
end logic;