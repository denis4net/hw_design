library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_TRIGER is
port
(
	D, CLK, NRST, NST: in std_logic;
	Q, NQ: out std_logic
);
end D_TRIGER;

architecture arch of D_TRIGER is
	signal r: std_logic := '0';
begin
	Q <= r;
	NQ <= not r;

	process(CLK, NRST, NST)
	begin
		if NRST = '0' then 
			r <= '0';
		elsif NST = '0' then 
			r <= '1';
		elsif(CLK'event and CLK = '1') then
			r <= D;
		end if;
	end process;

end architecture;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T_TRIGER is
	port 
	(
		T, NRST, NST: in std_logic;
		Q: out std_logic
	);
end T_TRIGER;

architecture T_TRIGER0 of T_TRIGER is
	component D_TRIGER
		port
		(
			D, CLK, NRST, NST: in std_logic;
			Q, NQ: out std_logic
		);
	end component;

	signal wire0: std_logic;
begin
	dt: D_TRIGER port map(CLK=>T, NRST=>NRST, NST=>NST, Q=>Q, NQ=>wire0, D=>wire0);
end;