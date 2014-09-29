library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE ieee.std_logic_textio.ALL;
USE std.textio.ALL;
library std;
use std.env.all;

entity testbench_file is
generic(
		constant period: time:= 20 ps
	);	
end entity;

architecture arch of testbench_file is
	component COUNTER8
	port (
		DATA: in std_logic_vector(7 downto 0);
		NCCLR, NCCKEN,  CCK, NCLOAD, RCK: in std_logic;
		NRCO: out std_logic
		);
	end component;

	signal TEST_DATA: std_logic_vector(7 downto 0) := b"00000000";
	signal NRCO, NRCO_FILE: std_logic;
	signal NCCKEN, CCK, NCLOAD, RCK, NCCLR: std_logic := '0';
begin
	COUNTER80: COUNTER8 port map(DATA=>TEST_DATA, NRCO=>NRCO, NCCKEN=>NCCKEN, CCK=>CCK, NCLOAD=>NCLOAD, RCK=>RCK, NCCLR=>NCCLR);
	CCK <= not CCK after period/2;
	RCK <= not RCK after period/2;
	--genereate data test file
	create_data_file : process
		file 	 file_pointer : text; 
		variable file_status 	: file_open_status;	
		variable current_line 	: line;
		-- prefix 'f' mean data readed from file
		variable fDATA: std_logic_vector(7 downto 0);
		variable fNCCLR, fNCCKEN,  fCCK, fNCLOAD, fRCK: std_logic;
		variable fNRCO: std_logic;
	begin
		-- create file
		file_open(file_status, file_pointer, "test.file.data", READ_MODE);
		-- check file open ok
		assert(file_status = OPEN_OK)
			report "ERROR: open file WRITE_MODE "
			severity failure;
		
		readloop:
		while not endfile(file_pointer)
		loop			
			-- DATA: in std_logic_vector(7 downto 0);
			-- NCCLR, NCCKEN,  CCK, NCLOAD, RCK: in std_logic;
			-- NRCO: out std_logic
			readline(file_pointer, current_line);
			read(current_line, fDATA);
			readline(file_pointer, current_line);
			read(current_line, fNCCLR);
			readline(file_pointer, current_line);
			read(current_line, fNCCKEN);
			readline(file_pointer, current_line);
			read(current_line, fNCLOAD);
			readline(file_pointer, current_line);
			read(current_line, fNRCO);
			
			TEST_DATA <= fDATA;
			NCCLR <= fNCCLR;
			NCCKEN <= fNCCKEN;
			NCLOAD <= fNCLOAD;
			NRCO_FILE <= fNRCO;

			wait for 1*period;

			assert(NRCO = NRCO_FILE)
				report ("Test failed on test data");
      	end loop;
		file_close(file_pointer);
		stop(2);
	end process;

end architecture;
