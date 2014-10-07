library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE ieee.std_logic_textio.ALL;
USE std.textio.ALL;
library std;
use std.env.all;

entity testbench is
generic(
		constant period: time:= 20 ps;
		constant infinity: boolean := true
	);	
end entity;

architecture arch of testbench is
	component COUNTER8
	port (
		DATA: in std_logic_vector(7 downto 0);
		NCCLR, NCCKEN,  CCK, NCLOAD, RCK: in std_logic;
		NRCO: out std_logic;
		QDATA: out std_logic_vector(7 downto 0)
		);
	end component;

	signal TEST_DATA: std_logic_vector(7 downto 0) := b"00000000";
	signal NRCO: 	std_logic;
	
	signal NCCLR: 	std_logic := '0';
	signal RCK: 	std_logic := '0';
	signal NCLOAD: 	std_logic := '1';
	signal NCCKEN: 	std_Logic := '0';
	signal CCK: 	std_logic := '0';
	signal QDATA: 	std_logic_vector(7 downto 0) := b"00000000";
begin
	TEST_DATA <= TEST_DATA + 1 after period;
	COUNTER80: COUNTER8 port map(DATA=>TEST_DATA, NRCO=>NRCO, NCCKEN=>NCCKEN, CCK=>CCK, NCLOAD=>NCLOAD, RCK=>RCK, NCCLR=>NCCLR, QDATA=>QDATA);

	process
	begin
		wait for 2*period;
		NCCLR <= '1';	
		wait for period * 257;
		wait for 4 * period; 
		NCCLR <= '0';
		wait for period;
		NCCLR <= '1';
		wait for 2 * period;
		NCCKEN <= '1';
		wait;
	end process;

	CCK <= not CCK after period / 2;

	process 
	begin
		wait for period * 2;
		RCK <= '1';
		wait for period * 1;
		RCK <= '0';
		wait for period * 2;
		NCLOAD <= '0';
		wait for period * 1;
		NCLOAD <= '1';
		wait for 20 * period;
		NCCLR <= '0';
		wait for period;
		NCCLR <= '1';
		wait for period * 3;
		NCCKEN <= '1'
		wait for period * 3;
		
	end process;
	--genereate data test file
	create_data_file : 
	process
		file 	 file_pointer 	: text; 
		variable file_status 	: file_open_status;	
		variable current_line 	: line;
	begin
		-- create file
		file_open(file_status, file_pointer, "test.data", WRITE_MODE);
		-- check file open ok
		assert(file_status = OPEN_OK)
			report "ERROR: open file WRITE_MODE "
			severity failure;
			
			wait for period;
			wait for 1 ps;

			while true loop
				-- DATA: in std_logic_vector(7 downto 0);
				-- NCCLR, NCCKEN,  CCK, NCLOAD, RCK: in std_logic;
				-- NRCO: out std_logic
				write(current_line, time'IMAGE(now));
				writeline(file_pointer, current_line);

				write(current_line, TEST_DATA);
				writeline(file_pointer, current_line);
				
				write(current_line, NCCLR);
				writeline(file_pointer, current_line);
				
				write(current_line, NCCKEN);
				writeline(file_pointer, current_line);
				
				write(current_line, NCLOAD);
				writeline(file_pointer, current_line);
				
				write(current_line, RCK);
				writeline(file_pointer, current_line);
			
				write(current_line, NRCO);
				writeline(file_pointer, current_line);

				write(current_line, QDATA);
				writeline(file_pointer, current_line);

				
				wait for period / 2;
			end loop;
		end process;
end architecture;
