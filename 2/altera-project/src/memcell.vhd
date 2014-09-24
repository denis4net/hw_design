library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity MEMCELL is
	port (
		A, B, NRCK, CLOAD, CCLR: in std_logic;
		O: out std_logic
	);
end MEMCELL;

architecture MEMCELL0 of MEMCELL is
	component D_TRIGER
	port
	(
		D, CLK, NRST, NST: in std_logic;
		Q, NQ: out std_logic
	);
	end component;

	component T_TRIGER
	port 
	(
		T, NRST, NST: in std_logic;
		Q: out std_logic
	);
	end component;

	signal d_q, d_nq: std_logic;
	signal t_s, t_r: std_logic;
	signal const_0: std_logic := '0';
	signal const_1: std_logic := '1';
begin
	D: D_TRIGER port map(D=>A, CLK=>NRCK, Q=>d_q, NQ=>d_nq, NRST=>const_1, NST=>const_1);
	t_s <= not (d_q and CLOAD);
	t_r <= not ((d_nq and CLOAD) or not CCLR);
	T: T_TRIGER port map(T=>B, NST=>t_s, NRST=>t_r, Q=>O);

end;