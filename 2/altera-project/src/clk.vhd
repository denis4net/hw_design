
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity CLKBLK is
	port (
		NCLKEN, NCCLR: in std_logic;
		CCK: in std_logic;
		IN_CCK: out std_logic
	);
end entity;

architecture arch of CLKBLK is
	component D_TRIGER
	port
	(
		D, CLK, NRST, NST: in std_logic;
		Q, NQ: out std_logic
	);
	end component;

	signal wire0, wire1: std_logic;
	signal const_1: std_logic:= '1';
	signal const_0: std_logic:= '0';
begin
	D0: D_TRIGER port map(D=>wire0, Q=>wire1, NQ=>wire0, CLK=>CCK, NRST=>NCCLR, NST=>const_1);

	IN_CCK <= not NCLKEN and CCK;
end;