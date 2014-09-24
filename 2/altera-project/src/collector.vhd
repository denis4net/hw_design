library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


entity COLLECTOR is
	port(
		A: in std_logic_vector(7 downto 0);
		B: out std_logic_vector(6 downto 0);
		CLK: in std_logic;
	  	NRCO: out std_logic
	);
end entity;

architecture COLLECTOR0 of COLLECTOR is
	signal collector_bus: std_logic_vector(7 downto 0);
begin
	collector_bus <= A;

	process (CLK)
	begin
		if CLK = '1' then
			B(0) <= collector_bus(0) and CLK;
			B(1) <= collector_bus(0) and collector_bus(1) and CLK;
			B(2) <= collector_bus(0) and collector_bus(1) and collector_bus(2) and CLK;
			B(3) <= collector_bus(0) and collector_bus(1) and collector_bus(2) and collector_bus(3) and CLK;
			B(4) <= collector_bus(0) and collector_bus(1) and collector_bus(2) and collector_bus(3) and collector_bus(4) and CLK;
			B(5) <= collector_bus(0) and collector_bus(1) and collector_bus(2) and collector_bus(3) and collector_bus(4) and collector_bus(5) and CLK;
			B(6) <= collector_bus(0) and collector_bus(1) and collector_bus(2) and collector_bus(3) and collector_bus(4) and collector_bus(5) and collector_bus(6) and CLK;
		end if;


		NRCO <= not (
				 collector_bus(0) and collector_bus(1) and collector_bus(2) and 
				 collector_bus(3) and collector_bus(4) and collector_bus(5) and
				 collector_bus(6) and collector_bus(7)
				);
	end process;
end architecture;
	
