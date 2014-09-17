library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DTrigger is
port
(
	D, CLK, NRST, NST: in std_logic;
	Q, NQ: out std_logic
);
end DTrigger;

architecture ADT of DTrigger is
begin
	process(CLK, NRST, NST)
	begin
	if NRST = '0' then 
		Q <= '0';
		NQ <= '1';
	elsif NST = '0' then 
		Q <= '1';
		NQ <= '0';
	elsif(CLK'event and CLK = '1') then
		Q <= D;
		NQ <= not D;
	end if;
	end process;

end ADT;

