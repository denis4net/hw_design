library verilog;
use verilog.vl_types.all;
entity busgate4 is
    port(
        \in\            : in     vl_logic_vector(3 downto 0);
        enabled         : in     vl_logic;
        \out\           : out    vl_logic_vector(3 downto 0)
    );
end busgate4;
