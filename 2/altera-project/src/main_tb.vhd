library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity testbench is
begin
end testbench;

architecture arch of testbench is
	component COUNTER8
	port (
		DATA: in std_logic_vector(7 downto 0);
		NCCLR, NCCKEN,  CCK, NCLOAD, RCK: in std_logic;
		NRCO: out std_logic
		);
	end component;

	signal TEST_DATA: std_logic_vector(7 downto 0) := b"00000000";
	signal NRCO: std_logic;
	signal NCCKEN, CCK, NCLOAD, RCK, NCCLR: std_logic := '0';
begin
	TEST_DATA <= TEST_DATA + 1 after 10 ps;
	COUNTER80: COUNTER8 port map(DATA=>TEST_DATA, NRCO=>NRCO, NCCKEN=>NCCKEN, CCK=>CCK, NCLOAD=>NCLOAD, RCK=>RCK, NCCLR=>NCCLR);
	
	CCK <= not CCK after 10 ps;
	
	process
	begin
		RCK <= '1';
		wait for 10 ps;
		NCCLR <= '1';
		wait for 10 ps;	
		NCCKEN <= '0';
		wait for 10 ps;
		NCLOAD <= '1' ;
		
		wait for 5200 ps; -- 10ps * 2 * 255 + 100ps
		RCK <= '0';
		wait for 20 ps;
		RCK <= '1';
		NCLOAD <= '0';
		wait for 20 ps;
		NCLOAD <= '1';
		wait;
	end process;

end architecture;
