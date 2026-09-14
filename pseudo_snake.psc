Algoritmo CasinoVirtual
    Definir usuarios, claves, juego_favorito Como Caracter;
    Definir historial_tipo Como Caracter;
    Definir saldos, victorias, derrotas, rachas, mejor_racha, mayor_ganancia, total_apostado Como Real;
    Definir historial_monto Como Real;
    Definir partidas, cont_historial, veces_juego Como Entero;
    Definir num_usuarios, usuario_actual, opcion, juego, opcion_apuesta Como Entero;
    Definir i, j, k, existe, salir, monto, apuesta, premio, resultado Como Entero;
    Definir usuario_ingresado, clave_ingresada Como Caracter;
    Definir dado1, dado2, suma, numero_elegido, numero_sorteado, diferencia Como Entero;
    Definir caballo_elegido, ganador, simbolo1, simbolo2, simbolo3 Como Entero;
    Definir puntaje_jugador, puntaje_casa, decision, mejor, mejor_juego Como Entero;
    Definir indices_lideres Como Entero;
    Dimension usuarios[50], claves[50], juego_favorito[50];
    Dimension historial_tipo[50,100];
    Dimension saldos[50], victorias[50], derrotas[50], rachas[50], mejor_racha[50], mayor_ganancia[50], total_apostado[50];
    Dimension historial_monto[50,100];
    Dimension partidas[50], cont_historial[50], veces_juego[50,5], indices_lideres[3];
	
    num_usuarios <- 0;
    usuario_actual <- 0;
    salir <- 0;
	
    Mientras salir = 0 Hacer
        Limpiar Pantalla;
        Escribir '========== CASINO VIRTUAL ==========';
        Escribir '1. Registrar usuario';
        Escribir '2. Iniciar sesion';
        Escribir '3. Depositar';
        Escribir '4. Retirar';
        Escribir '5. Jugar';
        Escribir '6. Ver perfil y records';
        Escribir '7. Ver historial';
        Escribir '8. Tabla de lideres';
        Escribir '9. Cerrar sesion';
        Escribir '0. Salir';
        Leer opcion;
		
        Segun opcion Hacer
            1:
                Si num_usuarios < 50 Entonces
                    Escribir 'Nuevo nombre de usuario:';
                    Leer usuarios[num_usuarios + 1];
                    existe <- 0;
                    Para i <- 1 Hasta num_usuarios Hacer
                        Si usuarios[i] = usuarios[num_usuarios + 1] Entonces
                            existe <- 1;
                        FinSi
                    FinPara
                    Si existe = 1 Entonces
                        Escribir 'El usuario ya existe.';
                    SiNo
                        Escribir 'Nueva contrasena:';
                        Leer claves[num_usuarios + 1];
                        num_usuarios <- num_usuarios + 1;
                        saldos[num_usuarios] <- 0;
                        victorias[num_usuarios] <- 0;
                        derrotas[num_usuarios] <- 0;
                        rachas[num_usuarios] <- 0;
                        mejor_racha[num_usuarios] <- 0;
                        mayor_ganancia[num_usuarios] <- 0;
                        total_apostado[num_usuarios] <- 0;
                        partidas[num_usuarios] <- 0;
                        cont_historial[num_usuarios] <- 0;
                        juego_favorito[num_usuarios] <- 'Ninguno';
                        Escribir 'Registro exitoso. Saldo inicial: 0';
                    FinSi
                SiNo
                    Escribir 'Se alcanzo el limite de usuarios.';
                FinSi
                Esperar Tecla;
				
            2:
                usuario_actual <- 0;
                Escribir 'Usuario:';
                Leer usuario_ingresado;
                Escribir 'Contrasena:';
                Leer clave_ingresada;
                Para i <- 1 Hasta num_usuarios Hacer
                    Si usuarios[i] = usuario_ingresado Y claves[i] = clave_ingresada Entonces
                        usuario_actual <- i;
                    FinSi
                FinPara
                Si usuario_actual = 0 Entonces
                    Escribir 'Credenciales incorrectas.';
                SiNo
                    Escribir 'Inicio de sesion correcto. Bienvenido ', usuarios[usuario_actual];
                FinSi
                Esperar Tecla;
				
            3:
                Si usuario_actual = 0 Entonces
                    Escribir 'Debe iniciar sesion primero.';
                SiNo
                    Escribir 'Monto del deposito:';
                    Leer monto;
                    Si monto <= 0 Entonces
                        Escribir 'El monto debe ser mayor que cero.';
                    SiNo
                        saldos[usuario_actual] <- saldos[usuario_actual] + monto;
                        Si cont_historial[usuario_actual] < 100 Entonces
                            cont_historial[usuario_actual] <- cont_historial[usuario_actual] + 1;
                            historial_tipo[usuario_actual,cont_historial[usuario_actual]] <- 'Deposito';
                            historial_monto[usuario_actual,cont_historial[usuario_actual]] <- monto;
                        FinSi
                        Escribir 'Deposito realizado. Saldo actual: ', saldos[usuario_actual];
                    FinSi
                FinSi
                Esperar Tecla;
				
            4:
                Si usuario_actual = 0 Entonces
                    Escribir 'Debe iniciar sesion primero.';
                SiNo
                    Escribir 'Monto del retiro:';
                    Leer monto;
                    Si monto <= 0 Entonces
                        Escribir 'El monto debe ser mayor que cero.';
                    SiNo
                        Si monto > saldos[usuario_actual] Entonces
                            Escribir 'Saldo insuficiente.';
                        SiNo
                            saldos[usuario_actual] <- saldos[usuario_actual] - monto;
                            Si cont_historial[usuario_actual] < 100 Entonces
                                cont_historial[usuario_actual] <- cont_historial[usuario_actual] + 1;
                                historial_tipo[usuario_actual,cont_historial[usuario_actual]] <- 'Retiro';
                                historial_monto[usuario_actual,cont_historial[usuario_actual]] <- -monto;
                            FinSi
                            Escribir 'Retiro realizado. Saldo actual: ', saldos[usuario_actual];
                        FinSi
                    FinSi
                FinSi
                Esperar Tecla;
				
            5:
                Si usuario_actual = 0 Entonces
                    Escribir 'Debe iniciar sesion primero.';
                SiNo
                    Escribir '1. Tragaperras';
                    Escribir '2. Blackjack';
                    Escribir '3. Dados';
                    Escribir '4. Carrera de caballos';
                    Escribir '5. Loteria';
                    Leer juego;
                    Si juego < 1 O juego > 5 Entonces
                        Escribir 'Juego no valido.';
                    SiNo
                        Escribir 'Monto de la apuesta:';
                        Leer apuesta;
                        Si apuesta <= 0 O apuesta > saldos[usuario_actual] Entonces
                            Escribir 'Apuesta no valida o saldo insuficiente.';
                        SiNo
                            saldos[usuario_actual] <- saldos[usuario_actual] - apuesta;
                            total_apostado[usuario_actual] <- total_apostado[usuario_actual] + apuesta;
                            partidas[usuario_actual] <- partidas[usuario_actual] + 1;
                            veces_juego[usuario_actual,juego] <- veces_juego[usuario_actual,juego] + 1;
                            premio <- 0;
                            resultado <- 0;
							
                            Segun juego Hacer
                                1:
                                    simbolo1 <- Azar(3) + 1;
                                    simbolo2 <- Azar(3) + 1;
                                    simbolo3 <- Azar(3) + 1;
                                    Escribir 'Resultado: ', simbolo1, ' - ', simbolo2, ' - ', simbolo3;
                                    Si simbolo1 = simbolo2 Y simbolo2 = simbolo3 Entonces
                                        premio <- apuesta * 5;
                                        resultado <- 1;
                                    SiNo
                                        Si simbolo1 = simbolo2 O simbolo1 = simbolo3 O simbolo2 = simbolo3 Entonces
                                            premio <- apuesta * 2;
                                            resultado <- 1;
                                        FinSi
                                    FinSi
                                2:
                                    puntaje_jugador <- Azar(11) + 11;
                                    puntaje_casa <- Azar(6) + 16;
                                    decision <- 0;
                                    Mientras decision <> 2 Y puntaje_jugador < 21 Hacer
                                        Escribir 'Tu puntaje es ', puntaje_jugador;
                                        Escribir '1. Pedir carta';
                                        Escribir '2. Plantarse';
                                        Leer decision;
                                        Si decision = 1 Entonces
                                            puntaje_jugador <- puntaje_jugador + Azar(10) + 1;
                                        FinSi
                                    FinMientras
                                    Mientras puntaje_casa < 17 Hacer
                                        puntaje_casa <- puntaje_casa + Azar(10) + 1;
                                    FinMientras
                                    Escribir 'Tu puntaje: ', puntaje_jugador, ' | Casa: ', puntaje_casa;
                                    Si puntaje_jugador <= 21 Y (puntaje_casa > 21 O puntaje_jugador > puntaje_casa) Entonces
                                        premio <- apuesta * 2;
                                        resultado <- 1;
                                    SiNo
                                        Si puntaje_jugador = puntaje_casa Entonces
                                            premio <- apuesta;
                                            resultado <- 2;
                                        FinSi
                                    FinSi
                                3:
                                    dado1 <- Azar(6) + 1;
                                    dado2 <- Azar(6) + 1;
                                    suma <- dado1 + dado2;
                                    Escribir 'Dados: ', dado1, ' y ', dado2, ' | Suma: ', suma;
                                    Escribir '1. Par  2. Impar  3. Numero exacto  4. Mayor que 7  5. Menor que 7';
                                    Leer opcion_apuesta;
                                    Si opcion_apuesta = 3 Entonces
                                        Escribir 'Elija un numero entre 2 y 12:';
                                        Leer numero_elegido;
                                        Si suma = numero_elegido Entonces
                                            premio <- apuesta * 5;
                                            resultado <- 1;
                                        FinSi
                                    SiNo
                                        Si opcion_apuesta = 1 Y suma MOD 2 = 0 Entonces
                                            premio <- apuesta * 2;
                                            resultado <- 1;
                                        SiNo
                                            Si opcion_apuesta = 2 Y suma MOD 2 <> 0 Entonces
                                                premio <- apuesta * 2;
                                                resultado <- 1;
                                            SiNo
                                                Si opcion_apuesta = 4 Y suma > 7 Entonces
                                                    premio <- apuesta * 2;
                                                    resultado <- 1;
                                                SiNo
                                                    Si opcion_apuesta = 5 Y suma < 7 Entonces
                                                        premio <- apuesta * 2;
                                                        resultado <- 1;
                                                    FinSi
                                                FinSi
                                            FinSi
                                        FinSi
                                    FinSi
                                4:
                                    Escribir 'Elija un caballo del 1 al 4:';
                                    Leer caballo_elegido;
                                    ganador <- Azar(4) + 1;
                                    Escribir 'El caballo ganador fue el ', ganador;
                                    Si caballo_elegido = ganador Entonces
                                        premio <- apuesta * 4;
                                        resultado <- 1;
                                    FinSi
                                5:
                                    Escribir 'Elija un numero del 0 al 9:';
                                    Leer numero_elegido;
                                    numero_sorteado <- Azar(10);
                                    diferencia <- numero_elegido - numero_sorteado;
                                    Si diferencia < 0 Entonces
                                        diferencia <- diferencia *(-1);
                                    FinSi
                                    Escribir 'Numero sorteado: ', numero_sorteado;
                                    Si diferencia = 0 Entonces
                                        premio <- apuesta * 10;
                                        resultado <- 1;
                                    SiNo
                                        Si diferencia = 1 Entonces
                                            premio <- apuesta * 3;
                                            resultado <- 1;
                                        FinSi
                                    FinSi
                            FinSegun
							
                            Si resultado = 1 Entonces
                                saldos[usuario_actual] <- saldos[usuario_actual] + premio;
                                victorias[usuario_actual] <- victorias[usuario_actual] + 1;
                                rachas[usuario_actual] <- rachas[usuario_actual] + 1;
                                Si rachas[usuario_actual] > mejor_racha[usuario_actual] Entonces
                                    mejor_racha[usuario_actual] <- rachas[usuario_actual];
                                FinSi
                                Si premio > mayor_ganancia[usuario_actual] Entonces
                                    mayor_ganancia[usuario_actual] <- premio;
                                FinSi
                                Escribir 'Gano. Premio: ', premio;
                                Si cont_historial[usuario_actual] < 99 Entonces
                                    cont_historial[usuario_actual] <- cont_historial[usuario_actual] + 1;
                                    historial_tipo[usuario_actual,cont_historial[usuario_actual]] <- 'Apuesta ganada';
                                    historial_monto[usuario_actual,cont_historial[usuario_actual]] <- premio - apuesta;
                                FinSi
                            SiNo
                                Si resultado = 2 Entonces
                                    saldos[usuario_actual] <- saldos[usuario_actual] + premio;
                                    Escribir 'Empate. Se devuelve la apuesta.';
                                    Si cont_historial[usuario_actual] < 100 Entonces
                                        cont_historial[usuario_actual] <- cont_historial[usuario_actual] + 1;
                                        historial_tipo[usuario_actual,cont_historial[usuario_actual]] <- 'Apuesta empatada';
                                        historial_monto[usuario_actual,cont_historial[usuario_actual]] <- 0;
                                    FinSi
                                SiNo
                                    derrotas[usuario_actual] <- derrotas[usuario_actual] + 1;
                                    rachas[usuario_actual] <- 0;
                                    Escribir 'Perdio la apuesta.';
                                    Si cont_historial[usuario_actual] < 100 Entonces
                                        cont_historial[usuario_actual] <- cont_historial[usuario_actual] + 1;
                                        historial_tipo[usuario_actual,cont_historial[usuario_actual]] <- 'Apuesta perdida';
                                        historial_monto[usuario_actual,cont_historial[usuario_actual]] <- -apuesta;
                                    FinSi
                                FinSi
                            FinSi
							
                            mejor <- 0;
                            mejor_juego <- 1;
                            Para j <- 1 Hasta 5 Hacer
                                Si veces_juego[usuario_actual,j] > mejor Entonces
                                    mejor <- veces_juego[usuario_actual,j];
                                    mejor_juego <- j;
                                FinSi
                            FinPara
                            Segun mejor_juego Hacer
                                1: juego_favorito[usuario_actual] <- 'Tragaperras';
                                2: juego_favorito[usuario_actual] <- 'Blackjack';
                                3: juego_favorito[usuario_actual] <- 'Dados';
                                4: juego_favorito[usuario_actual] <- 'Carrera';
                                5: juego_favorito[usuario_actual] <- 'Loteria';
                            FinSegun
                            Escribir 'Saldo actual: ', saldos[usuario_actual];
                        FinSi
                    FinSi
                FinSi
                Esperar Tecla;
				
            6:
                Si usuario_actual = 0 Entonces
                    Escribir 'Debe iniciar sesion primero.';
                SiNo
                    Escribir 'Usuario: ', usuarios[usuario_actual];
                    Escribir 'Saldo: ', saldos[usuario_actual];
                    Escribir 'Partidas: ', partidas[usuario_actual];
                    Escribir 'Victorias: ', victorias[usuario_actual];
                    Escribir 'Derrotas: ', derrotas[usuario_actual];
                    Escribir 'Mejor racha: ', mejor_racha[usuario_actual];
                    Escribir 'Mayor ganancia: ', mayor_ganancia[usuario_actual];
                    Escribir 'Total apostado: ', total_apostado[usuario_actual];
                    Escribir 'Juego favorito: ', juego_favorito[usuario_actual];
                FinSi
                Esperar Tecla;
				
            7:
                Si usuario_actual = 0 Entonces
                    Escribir 'Debe iniciar sesion primero.';
                SiNo
                    Escribir '===== HISTORIAL =====';
                    Si cont_historial[usuario_actual] = 0 Entonces
                        Escribir 'No hay transacciones registradas.';
                    SiNo
                        Para i <- 1 Hasta cont_historial[usuario_actual] Hacer
                            Escribir i, '. ', historial_tipo[usuario_actual,i], ' : ', historial_monto[usuario_actual,i];
                        FinPara
                    FinSi
                FinSi
                Esperar Tecla;
				
            8:
                Escribir '===== TABLA DE LIDERES POR SALDO =====';
                Para k <- 1 Hasta 3 Hacer
                    indices_lideres[k] <- 0;
                FinPara
                Para k <- 1 Hasta 3 Hacer
                    mejor <- -1;
                    Para i <- 1 Hasta num_usuarios Hacer
                        existe <- 0;
                        Para j <- 1 Hasta 3 Hacer
                            Si indices_lideres[j] = i Entonces
                                existe <- 1;
                            FinSi
                        FinPara
                        Si existe = 0 Y saldos[i] > mejor Entonces
                            mejor <- saldos[i];
                            indices_lideres[k] <- i;
                        FinSi
                    FinPara
                    Si indices_lideres[k] <> 0 Entonces
                        Escribir k, '. ', usuarios[indices_lideres[k]], ' - Saldo: ', saldos[indices_lideres[k]];
                    FinSi
                FinPara
                Esperar Tecla;
				
            9:
                usuario_actual <- 0;
                Escribir 'Sesion cerrada.';
                Esperar Tecla;
				
            0:
                salir <- 1;
				
            De Otro Modo:
                Escribir 'Opcion no valida.';
                Esperar Tecla;
        FinSegun
    FinMientras
    Escribir 'Gracias por utilizar el Casino Virtual.';
FinAlgoritmo
