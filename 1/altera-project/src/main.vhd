-- Varian number is 4
-- Issue: 4-bit simple ALU ("+", "-", "+1")
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity main is
	generic (
		bus_width: integer := 4;
		op_width: integer := 2
	);
	
	port (
		a: in std_logic_vector(bus_width-1 downto 0);
		b: in std_logic_vector(bus_width-1 downto 0);
		op: in std_logic_vector(op_width-1 downto 0);
		c: out std_logic_vector(bus_width-1 downto 0)
	);
begin
end main;


architecture ALU1 of main is	
	component add_4_bits
		 port (
			 x: in std_logic_vector(3 downto 0);
			 y: in std_logic_vector(3 downto 0);
			 cin: in std_logic;
			 sum: out std_logic_vector(3 downto 0)
		 );
	end component; 
	
	component busmux4x4
		port (
			in_bus: in std_logic_vector(15 downto 0);
			sel: in std_logic_vector(3 downto 0);
			out_bus: out std_logic_vector(3 downto 0)
			);
	end component;
	
	signal results: std_logic_vector(15 downto 0);
	signal sel: std_logic_vector(3 downto 0);
begin
		sel(1) <= not op(0) and op(1);
		sel(2) <= op(0) and not op(1);
		sel(3) <= op(0) and op(1);
	
		adder_4: add_4_bits port map(a, b, '0', results(7 downto 4));
		inc_4: 	add_4_bits port map(a, b"0001", '0', results(11 downto 8));
		subber_4: add_4_bits port map(a, b, '0', results(15 downto 12));
		result_busmux: busmux4x4 port map (results, sel, c);
end ALU1;

-- A signal assignment statement represents a process that assigns values to signals. It has three basic formats.
-- A <= B when condition1 elseC when condition2 else D when condition3 else E;
architecture ALU2 of main is
begin
		c <= 		a + b when conv_integer(op) = 1
				else 
					a - b when conv_integer(op) = 2 
				else 
					a + 1 when conv_integer(op) = 3 
				else 
					b"0000";
end ALU2;


-- with expression select A <= B when choice1, C when choice2, D when choice3, E when others;
architecture ALU3 of main is
begin
	with conv_integer(op) select 
			c <= a + b when 1,
			a -b when 2,
			a + 1 when 3,
			b"0000" when others;
end ALU3;



-- Using parallel assignment and if condition statement 
architecture ALU4 of main is
begin
	process (a, b, op) begin
		if conv_integer(op) = 1 then
			c <= a + b;
		elsif conv_integer(op) = 2 then
			c <= a - b;
		elsif conv_integer(op) = 3 then
			c <= a + 1;
		else 
			c <= b"0000";
		end if;
	end process;
end ALU4;


-- Using case condition statement
architecture ALU5 of main is
begin
	process (a, b, op) begin
		case  conv_integer(op) is
			when 1 =>
				c <= a + b;
			when 2 => 
				c <= a - b;
			when 3 =>
				c <= a + 1;
			when others =>
				c <= b"0000";
		end case;
	end process;
end ALU5;