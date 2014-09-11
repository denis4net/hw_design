library verilog;
use verilog.vl_types.all;
entity busmux4x4 is
    port(
        in_bus          : in     vl_logic_vector(15 downto 0);
        sel             : in     vl_logic_vector(3 downto 0);
        out_bus         : out    vl_logic_vector(3 downto 0)
    );
end busmux4x4;
