library ieee;
use ieee.std_logic_1164.all;

entity Mux is
port(	
    I3: 	in std_logic_vector(2 downto 0);
	I2: 	in std_logic_vector(2 downto 0);
	I1: 	in std_logic_vector(2 downto 0);
	I0: 	in std_logic_vector(2 downto 0);
	S:	in std_logic_vector(1 downto 0);
	O:	out std_logic_vector(2 downto 0)
);
end Mux;  

architecture behv1 of Mux is
begin
    process(I3,I2,I1,I0,S)
    begin
        -- use case statement
        case S is
	    when "00" =>	O <= I0;
	    when "01" =>	O <= I1;
	    when "10" =>	O <= I2;
	    when "11" =>	O <= I3;
	end case;

    end process;
end behv1;