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
	signal c1, c2, c3, c4, c5: std_logic_vector(3 downto 0);
begin
	test1: main port map(test(3 downto 0), test(7 downto 4), test(9 downto 8), c1);
	test2: main port map(test(3 downto 0), test(7 downto 4), test(9 downto 8), c2);
	test3: main port map(test(3 downto 0), test(7 downto 4), test(9 downto 8), c3);
	test4: main port map(test(3 downto 0), test(7 downto 4), test(9 downto 8), c4);
	test5: main port map(test(3 downto 0), test(7 downto 4), test(9 downto 8), c5);
	
	test <= test + 1 after 10 ps;
end main_testbench_arch;
