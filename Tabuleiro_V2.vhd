LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY TABULEIRO IS 
	PORT (
		Player_1 	: IN std_logic_vector(41 DOWNTO 0); -- entrada das jogadas do Player 1
		Player_2 	: IN std_logic_vector(41 DOWNTO 0); -- entrada das jogadas do Player 2
		Tabuleiro_OUT 	: OUT std_logic_vector(41 DOWNTO 0);
		Empate_OUT		: OUT std_logic
        );
END TABULEIRO;

ARCHITECTURE rtl OF TABULEIRO IS
	BEGIN
		Tabuleiro_OUT(0) <= Player_1(0) OR Player_2(0);
		Tabuleiro_OUT(1) <= Player_1(1) OR Player_2(1);
		Tabuleiro_OUT(2) <= Player_1(2) OR Player_2(2);
		Tabuleiro_OUT(3) <= Player_1(3) OR Player_2(3);
		Tabuleiro_OUT(4) <= Player_1(4) OR Player_2(4);
		Tabuleiro_OUT(5) <= Player_1(5) OR Player_2(5);
		Tabuleiro_OUT(6) <= Player_1(6) OR Player_2(6);
		Tabuleiro_OUT(7) <= Player_1(7) OR Player_2(7);
		Tabuleiro_OUT(8) <= Player_1(8) OR Player_2(8);
		Tabuleiro_OUT(9) <= Player_1(9) OR Player_2(9);
		Tabuleiro_OUT(10) <= Player_1(10) OR Player_2(10);
		Tabuleiro_OUT(11) <= Player_1(11) OR Player_2(11);
		Tabuleiro_OUT(12) <= Player_1(12) OR Player_2(12);
		Tabuleiro_OUT(13) <= Player_1(13) OR Player_2(13);
		Tabuleiro_OUT(14) <= Player_1(14) OR Player_2(14);
		Tabuleiro_OUT(15) <= Player_1(15) OR Player_2(15);
		Tabuleiro_OUT(16) <= Player_1(16) OR Player_2(16);
		Tabuleiro_OUT(17) <= Player_1(17) OR Player_2(17);
		Tabuleiro_OUT(18) <= Player_1(18) OR Player_2(18);
		Tabuleiro_OUT(19) <= Player_1(19) OR Player_2(19);
		Tabuleiro_OUT(20) <= Player_1(20) OR Player_2(20);
		Tabuleiro_OUT(21) <= Player_1(21) OR Player_2(21);
		Tabuleiro_OUT(22) <= Player_1(22) OR Player_2(22);
		Tabuleiro_OUT(23) <= Player_1(23) OR Player_2(23);
		Tabuleiro_OUT(24) <= Player_1(24) OR Player_2(24);
		Tabuleiro_OUT(25) <= Player_1(25) OR Player_2(25);
		Tabuleiro_OUT(26) <= Player_1(26) OR Player_2(26);
		Tabuleiro_OUT(27) <= Player_1(27) OR Player_2(27);
		Tabuleiro_OUT(28) <= Player_1(28) OR Player_2(28);
		Tabuleiro_OUT(29) <= Player_1(29) OR Player_2(29);
		Tabuleiro_OUT(30) <= Player_1(30) OR Player_2(30);
		Tabuleiro_OUT(31) <= Player_1(31) OR Player_2(31);
		Tabuleiro_OUT(32) <= Player_1(32) OR Player_2(32);
		Tabuleiro_OUT(33) <= Player_1(33) OR Player_2(33);
		Tabuleiro_OUT(34) <= Player_1(34) OR Player_2(34);
		Tabuleiro_OUT(35) <= Player_1(35) OR Player_2(35);
		Tabuleiro_OUT(36) <= Player_1(36) OR Player_2(36);
		Tabuleiro_OUT(37) <= Player_1(37) OR Player_2(37);
		Tabuleiro_OUT(38) <= Player_1(38) OR Player_2(38);
		Tabuleiro_OUT(39) <= Player_1(39) OR Player_2(39);
		Tabuleiro_OUT(40) <= Player_1(40) OR Player_2(40);
		Tabuleiro_OUT(41) <= Player_1(41) OR Player_2(41);
		
		Empate_OUT <= (Player_1(5) OR Player_2(5)) and (Player_1(11) OR Player_2(11)) and (Player_1(17) OR Player_2(17)) and (Player_1(23) OR Player_2(23)) and (Player_1(29) OR Player_2(29)) and (Player_1(35) OR Player_2(35)) and (Player_1(41) OR Player_2(41));
		--WITH Player_1 OR Player_2 SELECT
    		--Empate_OUT <= '1' WHEN "111111111111111111111111111111111111111111",
							  --'0' WHEN "000000000000000000000000000000000000000000",
								--null WHEN OTHERS;
END ARCHITECTURE;
