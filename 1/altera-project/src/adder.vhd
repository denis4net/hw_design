library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- 1 bit adder
entity add_1_bit is
	 port (
		 x: in std_logic;
		 y: in std_logic;
		 cin: in std_logic;
		 sum: out std_logic;
		cout: out std_logic
	 );
 end add_1_bit;

 architecture main of add_1_bit is
 begin
	 sum <= x xor y xor cin;
	 cout <= (x and y) or (x and cin) or (y and cin);
 end main;

 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

 -- 4 bit adder
entity add_4_bits is
	 port (
		 x: in std_logic_vector(3 downto 0);
		 y: in std_logic_vector(3 downto 0);
		 cin: in std_logic;
		 sum: out std_logic_vector(3 downto 0);
		 cout: out std_logic
	 );
end add_4_bits;

architecture main of add_4_bits is
	component add_1_bit
		port (
			x: in std_logic;
			y: in std_logic;
			cin: in std_logic;
			sum: out std_logic;
			cout: out std_logic
		);
	end component; 
	signal i_carry: std_logic_vector(2 downto 0);
begin
	cell_1: add_1_bit
		port map (x(0), y(0), cin, sum(0), i_carry(0));
	cell_2: add_1_bit
		port map (x(1), y(1), i_carry(0), sum(1), i_carry(1));
	cell_3: add_1_bit
		port map (x(2), y(2), i_carry(1), sum(2), i_carry(2));
	cell_4: add_1_bit
		port map (x(3), y(3), i_carry(2), sum(3), cout);
end main;

