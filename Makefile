principal: encabezado 4_bit_adder 8_bit_adder 32_bit_adder mostrar_resultados
	@echo "Hola"

4_bit_adder:
	@# Esta función crea el directorio del sumador de 4 bits y edita
	@# los archivos según se requiera, finalmente corre la simulación
	@echo "A. Sumador de 4 bits"
	@# Crea directorio
	mkdir '4_bit_adder'

	@echo "A-[0/2]	Copiando y editanto archivos de sumador de 4 bits"

	@# Copia módulo adder
	@cp ./adder.v ./4_bit_adder

	@echo "A-[0.1/2]		Módulo adder listo"

	@# Recrea el testbench
	@cat testbench.v | grep "" -m 7 > ./4_bit_adder/testbench.v
	@# Se cambia el parámetro a 1 contadores de 4 bits, 4 bits
	@echo "parameter N = 1;" >> ./4_bit_adder/testbench.v
	@cat testbench.v | tail -45 >> ./4_bit_adder/testbench.v

	@echo "A-[0.2/2]		Módulo testbench listo"

	@# Recrea el tester
	@cat tester.v | grep "" -m 47 > ./4_bit_adder/tester.v
	cat ./PruebaCompleta4b.txt >> ./4_bit_adder/tester.v
	@cat tester.v | tail -4 >> ./4_bit_adder/tester.v

	@echo "A-[0.3/2]		Módulo tester listo"

	cd '4_bit_adder' && iverilog -o 4_bit_adder.out testbench.v
	
	@echo "A-[1/2]	Circuito y simulación compilados"

	cd '4_bit_adder' && vvp 4_bit_adder.out >> 4_bit_adder_Resultados_simulación.txt
	cd '4_bit_adder' && mv adder_output.vcd 4_bit_adder_wave_output.vcd
	
	@echo "A-[2/2]	Resultados de la simulación exportados para el sumador de 4 bits"

	@echo "";

8_bit_adder:
	@# Esta función crea el directorio del sumador de 8 bits y edita
	@# los archivos según se requiera, finalmente corre la simulación
	@echo "B. Sumador de 8 bits"
	@# Crea directorio
	mkdir '8_bit_adder'

	@echo "B-[0/2]	Copiando y editanto archivos de sumador de 8 bits"

	@# Copia módulo adder
	@cp ./adder.v ./8_bit_adder

	@echo "B-[0.1/2]		Módulo adder listo"

	@# Recrea el testbench
	@cat testbench.v | grep "" -m 7 > ./8_bit_adder/testbench.v
	@# Se cambia el parámetro a 2 contadores de 4 bits, 8 bits
	@echo "parameter N = 2;" >> ./8_bit_adder/testbench.v
	@cat testbench.v | tail -45 >> ./8_bit_adder/testbench.v

	@echo "B-[0.2/2]		Módulo testbench listo"

	@# Recrea el tester
	@cat tester.v | grep "" -m 47 > ./8_bit_adder/tester.v
	cat ./Prueba8b.txt >> ./8_bit_adder/tester.v
	@cat tester.v | tail -4 >> ./8_bit_adder/tester.v

	@echo "B-[0.3/2]		Módulo tester listo"

	cd '8_bit_adder' && iverilog -o 8_bit_adder.out testbench.v
	
	@echo "B-[1/2]	Circuito y simulación compilados"

	cd '8_bit_adder' && vvp 8_bit_adder.out >> 8_bit_adder_Resultados_simulación.txt
	cd '8_bit_adder' && mv adder_output.vcd 8_bit_adder_wave_output.vcd
	
	@echo "B-[2/2]	Resultados de la simulación exportados para el sumador de 8 bits"

	@echo "";

32_bit_adder:
	@# Esta función crea el directorio del sumador de 32 bits y edita
	@# los archivos según se requiera, finalmente corre la simulación
	@echo "C. Sumador de 32 bits"
	@# Crea directorio
	mkdir '32_bit_adder'

	@echo "C-[0/2]	Copiando y editanto archivos de sumador de 32 bits"

	@# Copia módulo adder
	@cp ./adder.v ./32_bit_adder

	@echo "C-[0.1/2]		Módulo adder listo"

	@# Recrea el testbench
	@cat testbench.v | grep "" -m 7 > ./32_bit_adder/testbench.v
	@# Se cambia el parámetro a 8 contadores de 4 bits, 32 bits
	@echo "parameter N = 8;" >> ./32_bit_adder/testbench.v
	@cat testbench.v | tail -45 >> ./32_bit_adder/testbench.v

	@echo "C-[0.2/2]		Módulo testbench listo"

	@# Recrea el tester
	@cat tester.v | grep "" -m 47 > ./32_bit_adder/tester.v
	cat ./Prueba32b.txt >> ./32_bit_adder/tester.v
	@cat tester.v | tail -4 >> ./32_bit_adder/tester.v

	@echo "C-[0.3/2]		Módulo tester listo"

	cd '32_bit_adder' && iverilog -o 32_bit_adder.out testbench.v
	
	@echo "C-[1/2]	Circuito y simulación compilados"

	cd '32_bit_adder' && vvp 32_bit_adder.out >> 32_bit_adder_Resultados_simulación.txt
	cd '32_bit_adder' && mv adder_output.vcd 32_bit_adder_wave_output.vcd
	
	@echo "C-[2/2]	Resultados de la simulación exportados para el sumador de 8 bits"

	@echo "";

encabezado:
	@echo "Hola,";
	@echo "	Este makefile se encarga de crear directorios, editar los archivos y"
	@echo "	correr las simuaciones para todos los casos en estudio."
	@echo "	Finalmente, muestra los archivos en gtkwave."
	@echo ""

mostrar_resultados:
	
	cd '4_bit_adder' && gtkwave 4_bit_adder_wave_output.vcd
	cd '8_bit_adder' && gtkwave 8_bit_adder_wave_output.vcd
	cd '32_bit_adder' && gtkwave 32_bit_adder_wave_output.vcd

clean:
	@echo "Se borrarán todo lo creado para limpiar el directorio."
	rm -rdf 4_bit_adder
	rm -rdf 8_bit_adder
	rm -rdf 32_bit_adder
