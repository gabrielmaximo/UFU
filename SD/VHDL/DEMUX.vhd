library ieee;
use ieee.std_logic_1164.all;

entity Demux is
    port(
        I:                      in std_logic;
        S:                      in std_logic_vector(1 downto 0);
        out0,out1,out2,out3:    out std_logic;
        );
    end Demux;

    architecture behv of Demux is
        begin
            process(I,S)
            begin
                -- use case statement
                case S is
                when "00" =>	out0 <= I;
                when "01" =>	out1 <= I;
                when "10" =>	out2 <= I;
                when "11" =>	out3 <= I;
            end case;
        
            end process;
        end behv;
