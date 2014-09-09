-- Varian number is 4
-- Issue: 4-bit simple ALU ("+", "-", "+1")

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity main is
	generic (
		bus_width: integer := 8;
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



-- A signal assignment statement represents a process that assigns values to signals. It has three basic formats.
-- A <= B when condition1 elseC when condition2 else D when condition3 else E;
architecture ALU2 of main is
	variable opcode: integer;
	variable result: std_logic_vector(bus_width-1 downto 0)
begin
	process (a, b, op) begin
		c <= a + b when conv_integer(op) = 1 else a -b when conv_integer(op) = 2 else a + 1 when conv_integer(op) = 3 else b"00000000";
	end process;
end ALU2;

-- with expression select A <= B when choice1, C when choice2, D when choice3, E when others;
architecture ALU3 of main is
begin
	process (a, b, op) begin
		with conv_integer(op) select 
			c <= a + b when conv_integer(op) = 1,
			a -b when conv_integer(op) = 2,
			a + 1 when conv_integer(op) = 3,
			b"00000000" when others;
	end process;
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
			c <= b"00000000";
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
				c <= b"00000000";
		end case;
	end process;
end ALU5;