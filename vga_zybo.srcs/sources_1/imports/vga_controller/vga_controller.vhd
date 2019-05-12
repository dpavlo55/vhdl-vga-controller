
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity vga_controller is
			
	port(
		pclk : in std_logic;
		locked : in std_logic;
		rst : in std_logic;
		h_sync : out std_logic;
		v_sync : out std_logic;
		display_enable : out std_logic
		);
		
end entity;

architecture behav of vga_controller is

	signal h_counter : std_logic_vector(9 downto 0);
	signal v_counter : std_logic_vector(9 downto 0);
	signal h_end : std_logic;
	signal v_end : std_logic;
	signal h_active : std_logic;
	signal v_active : std_logic;

begin

	hor_counter:
	process(pclk) is
	begin
		if rising_edge(pclk) then
			if rst = '1' or locked = '0' then
				h_counter <= "11" & x"FF";
			elsif h_end = '1' then
				h_counter <= (others => '0');
			else
				h_counter <= h_counter + 1;
			end if;
		end if;
	end process hor_counter;
	
	hor_logic:
	process(h_counter) is
	begin
		h_sync <= '0';
		h_active <= '0';
		h_end <= '0';
		if (h_counter >= "00" & x"00") and (h_counter < "00" & x"60") then
			h_sync <= '1';
		elsif (h_counter >= "00" & x"90") and (h_counter < "0" & x"310") then
			h_active <= '1';
		elsif h_counter = "0" & x"31F" then
			h_end <= '1';
		end if;
	end process hor_logic;
	
	ver_counter:
	process(pclk) is
	begin
		if rising_edge(pclk) then
			if rst = '1' or locked = '0' then
				v_counter <= "00" & x"00";
			elsif v_end = '1' then
				v_counter <= (others => '0');
			elsif h_end = '1' then
				v_counter <= v_counter + 1;
			else
				null;
			end if;
		end if;
	end process ver_counter;
	
	ver_logic:
	process(v_counter,h_counter) is
	begin
		v_sync <= '0';
		v_active <= '0';
		v_end <= '0';
		if (v_counter >= "00" & x"00") and (v_counter < "00" & x"02") then
			v_sync <= '1';
		elsif (v_counter >= "00" & x"23") and (v_counter < "0" & x"203") then
			v_active <= '1';
		elsif (v_counter = "0" & x"20C") and (h_counter = "0" & x"31F") then
			v_end <= '1';
		end if;
	end process ver_logic;
	
	disp_en:
	process(h_active,v_active) is
	begin
		if (h_active = '1') and (v_active = '1') then
			display_enable <= '1';
		else
			display_enable <= '0';
		end if;
	end process disp_en;

end behav;
