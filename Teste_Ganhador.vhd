LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Teste_Ganhador IS 
	PORT (
		Jogada 	: IN std_logic_vector(41 DOWNTO 0); -- entrada da posição das jogadas do Player
		GANHADOR_OUT 	: OUT std_logic
        );
END Teste_Ganhador;

ARCHITECTURE Teste_ganhador_arch OF Teste_ganhador IS
	BEGIN
          GANHADOR_OUT <= 
	 -- Coluna1 de 0 a 5
			(Jogada(0) AND Jogada(1) AND Jogada(2) AND Jogada(3)) OR 
			(Jogada(1) AND Jogada(2) AND Jogada(3) AND Jogada(4)) OR
			(Jogada(2) AND Jogada(3) AND Jogada(4) AND Jogada(5)) OR 
          -- Coluna2 de 6 a 11
			(Jogada(6) AND Jogada(7) AND Jogada(8) AND Jogada(9)) OR
			(Jogada(7) AND Jogada(8) AND Jogada(9) AND Jogada(10)) OR
          		(Jogada(8) AND Jogada(9) AND Jogada(10) AND Jogada(11)) OR
          -- Coluna3 de 12 a 17
			(Jogada(12) AND Jogada(13) AND Jogada(14) AND Jogada(15)) OR
			(Jogada(13) AND Jogada(14) AND Jogada(15) AND Jogada(16)) OR
          		(Jogada(14) AND Jogada(15) AND Jogada(16) AND Jogada(17)) OR
          -- Coluna4 de 18 a 23
			(Jogada(18) AND Jogada(19) AND Jogada(20) AND Jogada(21)) OR
			(Jogada(19) AND Jogada(20) AND Jogada(21) AND Jogada(22)) OR
          		(Jogada(20) AND Jogada(21) AND Jogada(22) AND Jogada(23)) OR
          -- Coluna5 de 24 a 29
			(Jogada(24) AND Jogada(25) AND Jogada(26) AND Jogada(27)) OR
			(Jogada(25) AND Jogada(26) AND Jogada(27) AND Jogada(28)) OR
          		(Jogada(26) AND Jogada(27) AND Jogada(28) AND Jogada(29)) OR
          -- Coluna6 de 30 a 35
			(Jogada(30) AND Jogada(31) AND Jogada(32) AND Jogada(33)) OR
			(Jogada(31) AND Jogada(32) AND Jogada(33) AND Jogada(34)) OR
          		(Jogada(32) AND Jogada(33) AND Jogada(34) AND Jogada(35)) OR
          -- Coluna7 de 36 a 41
			(Jogada(36) AND Jogada(37) AND Jogada(38) AND Jogada(39)) OR
			(Jogada(37) AND Jogada(38) AND Jogada(39) AND Jogada(40)) OR
        		(Jogada(38) AND Jogada(39) AND Jogada(40) AND Jogada(41)) OR
          -- Linha 1 (de cima pra baixo)
			(Jogada(0) AND Jogada(6) AND Jogada(12) AND Jogada(18)) OR
			(Jogada(6) AND Jogada(12) AND Jogada(18) AND Jogada(24)) OR
        		(Jogada(12) AND Jogada(18) AND Jogada(24) AND Jogada(30)) OR
			(Jogada(18) AND Jogada(24) AND Jogada(30) AND Jogada(36)) OR
	  -- Linha 2
			(Jogada(1) AND Jogada(7) AND Jogada(13) AND Jogada(19)) OR
			(Jogada(7) AND Jogada(13) AND Jogada(19) AND Jogada(25)) OR
        		(Jogada(13) AND Jogada(19) AND Jogada(25) AND Jogada(31)) OR
			(Jogada(19) AND Jogada(25) AND Jogada(31) AND Jogada(37)) OR
	  -- Linha 3
			(Jogada(2) AND Jogada(8) AND Jogada(14) AND Jogada(20)) OR
			(Jogada(8) AND Jogada(14) AND Jogada(20) AND Jogada(26)) OR
        		(Jogada(14) AND Jogada(20) AND Jogada(26) AND Jogada(32)) OR
			(Jogada(20) AND Jogada(26) AND Jogada(32) AND Jogada(38)) OR
	  -- Linha 4	
			(Jogada(3) AND Jogada(9) AND Jogada(15) AND Jogada(21)) OR
			(Jogada(9) AND Jogada(15) AND Jogada(21) AND Jogada(27)) OR
        		(Jogada(15) AND Jogada(21) AND Jogada(27) AND Jogada(33)) OR
			(Jogada(21) AND Jogada(27) AND Jogada(33) AND Jogada(39)) OR
	  -- Linha 5
			(Jogada(4) AND Jogada(10) AND Jogada(16) AND Jogada(22)) OR
			(Jogada(10) AND Jogada(16) AND Jogada(22) AND Jogada(28)) OR
        		(Jogada(16) AND Jogada(22) AND Jogada(28) AND Jogada(34)) OR
			(Jogada(22) AND Jogada(28) AND Jogada(34) AND Jogada(40)) OR
	  -- Linha 6
			(Jogada(5) AND Jogada(11) AND Jogada(17) AND Jogada(23)) OR
			(Jogada(11) AND Jogada(17) AND Jogada(23) AND Jogada(29)) OR
        		(Jogada(17) AND Jogada(23) AND Jogada(29) AND Jogada(35)) OR
			(Jogada(23) AND Jogada(29) AND Jogada(35) AND Jogada(41)) OR
	  -- Diagonais
			(Jogada(0) AND Jogada(7) AND Jogada(14) AND Jogada(21)) OR
			(Jogada(1) AND Jogada(8) AND Jogada(15) AND Jogada(22)) OR
			(Jogada(2) AND Jogada(9) AND Jogada(16) AND Jogada(23)) OR
	
			(Jogada(6) AND Jogada(13) AND Jogada(20) AND Jogada(27)) OR
			(Jogada(7) AND Jogada(14) AND Jogada(21) AND Jogada(28)) OR
			(Jogada(8) AND Jogada(15) AND Jogada(22) AND Jogada(29)) OR
		
			(Jogada(12) AND Jogada(19) AND Jogada(26) AND Jogada(33)) OR
			(Jogada(13) AND Jogada(20) AND Jogada(27) AND Jogada(34)) OR
			(Jogada(14) AND Jogada(21) AND Jogada(28) AND Jogada(35)) OR
			
			(Jogada(18) AND Jogada(25) AND Jogada(32) AND Jogada(39)) OR
			(Jogada(19) AND Jogada(26) AND Jogada(33) AND Jogada(40)) OR
			(Jogada(20) AND Jogada(27) AND Jogada(34) AND Jogada(41)) OR
		
			(Jogada(18) AND Jogada(13) AND Jogada(8) AND Jogada(3)) OR 
			(Jogada(19) AND Jogada(14) AND Jogada(9) AND Jogada(4)) OR 
			(Jogada(20) AND Jogada(15) AND Jogada(10) AND Jogada(5)) OR 
			
			(Jogada(24) AND Jogada(19) AND Jogada(14) AND Jogada(9)) OR 
			(Jogada(30) AND Jogada(25) AND Jogada(20) AND Jogada(15)) OR 
			(Jogada(25) AND Jogada(20) AND Jogada(15) AND Jogada(10)) OR 
			(Jogada(20) AND Jogada(15) AND Jogada(10) AND Jogada(5)) OR 

			(Jogada(36) AND Jogada(31) AND Jogada(26) AND Jogada(21)) OR 
			(Jogada(31) AND Jogada(26) AND Jogada(21) AND Jogada(16)) OR 
			(Jogada(26) AND Jogada(21) AND Jogada(16) AND Jogada(11)) OR


			(Jogada(37) AND Jogada(32) AND Jogada(27) AND Jogada(22)) OR 
			(Jogada(32) AND Jogada(27) AND Jogada(22) AND Jogada(17)) OR 

			(Jogada(38) AND Jogada(33) AND Jogada(28) AND Jogada(23)); 
			
END ARCHITECTURE;
