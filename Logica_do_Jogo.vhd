LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Logica_do_Jogo IS 
	PORT (
		CLK_IN 				: IN std_logic; -- Clock de entrada (Reduzido)
		RESET					: IN std_logic; -- Reset de todas as posições
		Coluna_confirmada : IN std_logic_vector(2 DOWNTO 0);
		Jogada_confirmada	: IN std_logic;		 -- jogada confirmada
		Player_1_IN			: IN std_logic_vector(41 DOWNTO 0); -- Entrada da posição das jogadas do Player 1
		Player_2_IN			: IN std_logic_vector(41 DOWNTO 0); -- Entrada da posição das jogadas do Player 2
		Player_1_OUT		: OUT std_logic_vector(41 DOWNTO 0); -- Entrada da posição das jogadas do Player 1
		Player_2_OUT		: OUT std_logic_vector(41 DOWNTO 0) -- Entrada da posição das jogadas do Player 2
        );
END Logica_do_jogo;

ARCHITECTURE Logica_do_Jogo_arch OF Logica_do_Jogo IS
	
	SIGNAL	Tabuleiro_aux 												: std_logic_vector(41 DOWNTO 0):= (OTHERS => '0'); -- saida da posição das jogadas do Player 2
	--SIGNAL	Jogador_aux													: std_logic := '1';
	SIGNAL	Botao_Jogada_aux, Botao_Direita_aux, RESET_aux	: std_logic;
	--SIGNAL 	Contador		 												: INTEGER RANGE 0 TO 7 := 0;		
	SIGNAL   Coluna_confirmada_aux            					: std_logic_vector(2 DOWNTO 0):= (OTHERS => '0');
	SIGNAL 	Jogada_confirmada_aux 									: std_logic := '1';
	SIGNAL	Player_1_OUT_aux											: std_logic_vector(41 DOWNTO 0);
	SIGNAL	Player_2_OUT_aux											: std_logic_vector(41 DOWNTO 0);
	SIGNAL 	EN																: std_logic;
	SIGNAL	EMPATE														: std_logic;
	
	
	COMPONENT TABULEIRO IS 
	PORT (
		Player_1 		: IN std_logic_vector(41 DOWNTO 0); -- entrada da posição das jogadas do Player 1
		Player_2 		: IN std_logic_vector(41 DOWNTO 0); -- entrada da posição das jogadas do Player 2
		Tabuleiro_OUT 	: OUT std_logic_vector(41 DOWNTO 0);
		Empate_OUT		: OUT std_logic
			 );
	END COMPONENT;
	
	BEGIN
	EN <= '1';
	--Botao_Jogada_aux <= Botao_Jogada;
	--Botao_Direita_aux <= Botao_Direita OR RESET;
	RESET_aux <= RESET OR CLK_IN;
	Coluna_confirmada_aux <= Coluna_confirmada;
	Jogada_confirmada_aux <= Jogada_confirmada;
	
	
	TABULEIRO1 : TABULEIRO
	PORT MAP(Player_1_IN, Player_2_IN, Tabuleiro_aux, EMPATE);
	
	JOGADA: PROCESS (Coluna_confirmada_aux, EN, Player_1_OUT_aux, Player_2_OUT_aux, RESET)
	BEGIN
		IF (rising_edge(Jogada_confirmada_aux) AND EN = '1') THEN
			IF Coluna_confirmada_aux = "001" THEN
				IF Tabuleiro_aux(0) = '0' THEN
					Player_1_OUT_aux(0) <= '1';
				ELSIF Tabuleiro_aux(1) = '0' THEN
					Player_1_OUT_aux(1) <= '1';
				ELSIF Tabuleiro_aux(2) = '0' THEN
					Player_1_OUT_aux(2) <= '1';
				ELSIF Tabuleiro_aux(3) = '0' THEN
					Player_1_OUT_aux(3) <= '1';
				ELSIF Tabuleiro_aux(4) = '0' THEN
					Player_1_OUT_aux(4) <= '1';
				ELSIF Tabuleiro_aux(5) = '0' THEN
					Player_1_OUT_aux(5) <= '1';
				END IF;
			ELSIF Coluna_confirmada_aux = "010" THEN
				IF Tabuleiro_aux(6) = '0' THEN
					Player_1_OUT_aux(6) <= '1';
				ELSIF Tabuleiro_aux(7) = '0' THEN
					Player_1_OUT_aux(7) <= '1';
				ELSIF Tabuleiro_aux(8) = '0' THEN
					Player_1_OUT_aux(8) <= '1';
				ELSIF Tabuleiro_aux(9) = '0' THEN
					Player_1_OUT_aux(9) <= '1';
				ELSIF Tabuleiro_aux(10) = '0' THEN
					Player_1_OUT_aux(10) <= '1';
				ELSIF Tabuleiro_aux(11) = '0' THEN
					Player_1_OUT_aux(11) <= '1';
				END IF;
			ELSIF Coluna_confirmada_aux = "011" THEN
				IF Tabuleiro_aux(12) = '0' THEN
					Player_1_OUT_aux(12) <= '1';
				ELSIF Tabuleiro_aux(13) = '0' THEN
					Player_1_OUT_aux(13) <= '1';
				ELSIF Tabuleiro_aux(14) = '0' THEN
					Player_1_OUT_aux(14) <= '1';
				ELSIF Tabuleiro_aux(15) = '0' THEN
					Player_1_OUT_aux(15) <= '1';
				ELSIF Tabuleiro_aux(16) = '0' THEN
					Player_1_OUT_aux(16) <= '1';
				ELSIF Tabuleiro_aux(17) = '0' THEN
					Player_1_OUT_aux(17) <= '1';
				END IF;
			ELSIF Coluna_confirmada_aux = "100" THEN
				IF Tabuleiro_aux(18) = '0' THEN
					Player_1_OUT_aux(18) <= '1';
				ELSIF Tabuleiro_aux(19) = '0' THEN
					Player_1_OUT_aux(19) <= '1';
				ELSIF Tabuleiro_aux(20) = '0' THEN
					Player_1_OUT_aux(20) <= '1';
				ELSIF Tabuleiro_aux(21) = '0' THEN
					Player_1_OUT_aux(21) <= '1';
				ELSIF Tabuleiro_aux(22) = '0' THEN
					Player_1_OUT_aux(22) <= '1';
				ELSIF Tabuleiro_aux(23) = '0' THEN
					Player_1_OUT_aux(23) <= '1';
				END IF;
			ELSIF Coluna_confirmada_aux = "101" THEN
				IF Tabuleiro_aux(24) = '0' THEN
					Player_1_OUT_aux(24) <= '1';
				ELSIF Tabuleiro_aux(25) = '0' THEN
					Player_1_OUT_aux(25) <= '1';
				ELSIF Tabuleiro_aux(26) = '0' THEN
					Player_1_OUT_aux(26) <= '1';
				ELSIF Tabuleiro_aux(27) = '0' THEN
					Player_1_OUT_aux(27) <= '1';
				ELSIF Tabuleiro_aux(28) = '0' THEN
					Player_1_OUT_aux(28) <= '1';
				ELSIF Tabuleiro_aux(29) = '0' THEN
					Player_1_OUT_aux(29) <= '1';
				END IF;
			ELSIF Coluna_confirmada_aux = "110" THEN
				IF Tabuleiro_aux(30) = '0' THEN
					Player_1_OUT_aux(30) <= '1';
				ELSIF Tabuleiro_aux(31) = '0' THEN
					Player_1_OUT_aux(31) <= '1';
				ELSIF Tabuleiro_aux(32) = '0' THEN
					Player_1_OUT_aux(32) <= '1';
				ELSIF Tabuleiro_aux(33) = '0' THEN
					Player_1_OUT_aux(33) <= '1';
				ELSIF Tabuleiro_aux(34) = '0' THEN
					Player_1_OUT_aux(34) <= '1';
				ELSIF Tabuleiro_aux(35) = '0' THEN
					Player_1_OUT_aux(35) <= '1';
				END IF;
			ELSIF Coluna_confirmada_aux = "111" THEN
				IF Tabuleiro_aux(36) = '0' THEN
					Player_1_OUT_aux(36) <= '1';
				ELSIF Tabuleiro_aux(37) = '0' THEN
					Player_1_OUT_aux(37) <= '1';
				ELSIF Tabuleiro_aux(38) = '0' THEN
					Player_1_OUT_aux(38) <= '1';
				ELSIF Tabuleiro_aux(39) = '0' THEN
					Player_1_OUT_aux(39) <= '1';
				ELSIF Tabuleiro_aux(40) = '0' THEN
					Player_1_OUT_aux(40) <= '1';
				ELSIF Tabuleiro_aux(41) = '0' THEN
					Player_1_OUT_aux(41) <= '1';
				END IF;
			Player_1_OUT <= Player_1_OUT_aux;
			Player_2_OUT <= Player_2_OUT_aux;
			END IF;
	END IF;
	END PROCESS;
		
END ARCHITECTURE;
