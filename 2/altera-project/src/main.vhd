-- Variant 13
-- 8 bit counter with input registers

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity COUNTER8 is
	port (
		DATA: in std_logic_vector(7 downto 0);
		NCCLR, NCCKEN,  CCK, NCLOAD, RCK: in std_logic;
		NRCO: out std_logic;
		QDATA: out std_logic_vector(7 downto 0)
		);
end entity;


architecture counter_arch of COUNTER8 is

	component MEMCELL
	port(
		A, B, NRCK, CLOAD, NCCLR: in std_logic;
		O: out std_logic
	);
	end component;

	component COLLECTOR
	port(
		A: in std_logic_vector(7 downto 0);
		B: out std_logic_vector(6 downto 0);
		NRCO: out std_logic;
		CLK: in std_logic
	);
	end component;

	component CLKBLK is
	port (
		NCLKEN, NCCLR: in std_logic;
		CCK: in std_logic;
		IN_CCK: out std_logic
	);
	end component;

	signal IN_CCK, CLOAD, NRCK: std_logic;
	signal COLLECTOR_IN: std_logic_vector(7 downto 0);
	signal CARRY: std_logic_vector(6 downto 0);

begin
	CLOAD <= not NCLOAD;
	NRCK <= RCK;

	CLKBLK0: CLKBLK port map(CCK=>CCK, NCLKEN=>NCCKEN, IN_CCK=>IN_CCK, NCCLR=>NCCLR);

	COLLECTOR0: COLLECTOR port map(A=>COLLECTOR_IN, B=>CARRY, CLK=>IN_CCK, NRCO=>NRCO); 

	QDATA <= COLLECTOR_IN;

	CELL0: MEMCELL port map(A=>DATA(0), B=>IN_CCK, 		NRCK=>NRCK, CLOAD=>CLOAD, NCCLR=>NCCLR, O=>COLLECTOR_IN(0));
	CELL1: MEMCELL port map(A=>DATA(1), B=>CARRY(0), 	NRCK=>NRCK, CLOAD=>CLOAD, NCCLR=>NCCLR, O=>COLLECTOR_IN(1));
	CELL2: MEMCELL port map(A=>DATA(2), B=>CARRY(1), 	NRCK=>NRCK, CLOAD=>CLOAD, NCCLR=>NCCLR, O=>COLLECTOR_IN(2));
	CELL3: MEMCELL port map(A=>DATA(3), B=>CARRY(2), 	NRCK=>NRCK, CLOAD=>CLOAD, NCCLR=>NCCLR, O=>COLLECTOR_IN(3));
	CELL4: MEMCELL port map(A=>DATA(4), B=>CARRY(3), 	NRCK=>NRCK, CLOAD=>CLOAD, NCCLR=>NCCLR, O=>COLLECTOR_IN(4));
	CELL5: MEMCELL port map(A=>DATA(5), B=>CARRY(4), 	NRCK=>NRCK, CLOAD=>CLOAD, NCCLR=>NCCLR, O=>COLLECTOR_IN(5));
	CELL6: MEMCELL port map(A=>DATA(6), B=>CARRY(5), 	NRCK=>NRCK, CLOAD=>CLOAD, NCCLR=>NCCLR, O=>COLLECTOR_IN(6));
	CELL7: MEMCELL port map(A=>DATA(7), B=>CARRY(6), 	NRCK=>NRCK, CLOAD=>CLOAD, NCCLR=>NCCLR, O=>COLLECTOR_IN(7));

end architecture;