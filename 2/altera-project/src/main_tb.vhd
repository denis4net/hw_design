library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity main_testbench is
end main_testbench;

architecture main_testbench_arch of main_testbench is
	component main
		port (
			a: in std_logic_vector(3 downto 0);
			b: in std_logic_vector(3 downto 0);
			op: in std_logic_vector(1 downto 0);
			c: out std_logic_vector(3 downto 0)
		);
	end component;

	for test1: main use entity work.main(ALU1);
	for test2: main use entity work.main(ALU2);
	for test3: main use entity work.main(ALU3);
	for test4: main use entity work.main(ALU4);
	for test5: main use entity work.main(ALU5);
	
	signal test: std_logic_vector(9 downto 0) := b"0000000000";
	signal c: std_logic_vector(19 downto 0);
begin
	test1: main port map(test(3 downto 0), test(7 downto 4), test(9 downto 8), c(3 downto 0));
	test2: main port map(test(3 downto 0), test(7 downto 4), test(9 downto 8), c(7 downto 4));
	test3: main port map(test(3 downto 0), test(7 downto 4), test(9 downto 8), c(11 downto 8));
	test4: main port map(test(3 downto 0), test(7 downto 4), test(9 downto 8), c(15 downto 12));
	test5: main port map(test(3 downto 0), test(7 downto 4), test(9 downto 8), c(19 downto 16));
	
	test <= test + 1 after 10 ps;
end main_testbench_arch;
