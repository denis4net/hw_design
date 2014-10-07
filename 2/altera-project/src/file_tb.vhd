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
		NRCO: out std_logic;
		QDATA: out std_logic_vector(7 downto 0)
		);
	end component;

	signal TEST_DATA: 	std_logic_vector(7 downto 0) := b"00000000";
	signal NRCO: 		std_logic;

	signal NCCLR: 	std_logic := '0';
	signal RCK: 	std_logic := '0';
	signal NCLOAD: 	std_logic := '1';
	signal NCCKEN: 	std_Logic := '0';
	signal CCK: 	std_logic := '0';

	signal NRCO_FILE: std_logic := '0';
	signal QDATA: 	std_logic_vector(7 downto 0) := b"00000000";
begin
	COUNTER80: COUNTER8 port map(DATA=>TEST_DATA, NRCO=>NRCO, NCCKEN=>NCCKEN, CCK=>CCK, NCLOAD=>NCLOAD, RCK=>RCK, NCCLR=>NCCLR, QDATA=>QDATA);

	CCK <= not CCK after period / 2;

	--genereate data test file
	create_data_file : process
		file 	 file_pointer : text; 
		variable file_status 	: file_open_status;	
		variable current_line 	: line;
		-- prefix 'f' mean data readed from file
		variable fDATA: std_logic_vector(7 downto 0);
		variable fNCCLR, fNCCKEN,  fCCK, fNCLOAD, fRCK: std_logic;
		variable fNRCO: std_logic;
		variable timestamp: time;
		variable fQDATA: std_logic_vector(7 downto 0);
	begin
		-- create file
		file_open(file_status, file_pointer, "test.data", READ_MODE);
		-- check file open ok
		assert(file_status = OPEN_OK)
			report "ERROR: open file WRITE_MODE "
			severity failure;

		wait for period;

		readloop:
		while not endfile(file_pointer)
		loop			
			-- DATA: in std_logic_vector(7 downto 0);
			-- NCCLR, NCCKEN,  CCK, NCLOAD, RCK: in std_logic;
			-- NRCO: out std_logic
			readline(file_pointer, current_line);
			read(current_line, timestamp);

			readline(file_pointer, current_line);
			read(current_line, fDATA);
			
			readline(file_pointer, current_line);
			read(current_line, fNCCLR);
			
			readline(file_pointer, current_line);
			read(current_line, fNCCKEN);

			readline(file_pointer, current_line);
			read(current_line, fNCLOAD);
			
			readline(file_pointer, current_line);
			read(current_line, fRCK);

			readline(file_pointer, current_line);
			read(current_line, fNRCO);

			readline(file_pointer, current_line);
			read(current_line, fQDATA);

			TEST_DATA <= fDATA;
			NCCLR <= fNCCLR;
			NCCKEN <= fNCCKEN;
			NCLOAD <= fNCLOAD;
			NRCO_FILE <= fNRCO;
			RCK <= fRCK;


			wait for period / 2;

			assert(NRCO = NRCO_FILE) report ("Test failed on test.data");
			assert(QDATA = fQDATA) report ("Test (2) failed");
		end loop;
		file_close(file_pointer);
		stop(2);
	end process;

end architecture;
