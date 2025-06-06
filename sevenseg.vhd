library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- required libraries

entity SevSegmentDisplayModule is
    Port ( digit : in STD_LOGIC_VECTOR (3 downto 0); -- binary number input
           Segs : out STD_LOGIC_VECTOR (6 downto 0)); -- encoded result
end SevSegmentDisplayModule;

architecture Behavioral of SevSegmentDisplayModule is

begin

    process ( digit ) -- encoder
    
    begin
    
        case ( digit ) is 
            when "0000" => Segs <= "0000001"; -- 0
            when "0001" => Segs <= "1001111"; -- 1
            when "0010" => Segs <= "0010010"; -- 2
            when "0011" => Segs <= "0000110"; -- 3
            when "0100" => Segs <= "1001100"; -- 4
            when "0101" => Segs <= "0100100"; -- 5
            when "0110" => Segs <= "0100000"; -- 6
            when "0111" => Segs <= "0001111"; -- 7
            when "1000" => Segs <= "0000000"; -- 8
            when others => Segs <= "0000100"; -- 9
            
        end case;
        
    end process;

end Behavioral;