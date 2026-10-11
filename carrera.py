import time
import numpy as np
import os

def limpiar_pantalla():
    os.system("cls" if os.name == "nt" else "clear")
    



caballos = [
    "\033[31m█ 🐴 \033[0m", 
    "\033[32m█ 🐴 \033[0m", 
    "\033[33m█ 🐴 \033[0m", 
    "\033[34m█ 🐴 \033[0m"
]

posiciones = np.zeros(4, dtype=int)
meta = 50

print("¡COMIENZA LA CARRERA DE CABALLOS!")
time.sleep(3)

while True:
    avances = np.random.randint(1, 4, size=4)
    posiciones += avances
    
    limpiar_pantalla()
    for i in range(4):
        pista = "-" * posiciones[i] + caballos[i] + "-" * max(0, (meta - posiciones[i]))
        print(f"Pista {i+1}: |{pista}| Yrd: {posiciones[i]}")
    
    if np.any(posiciones >= meta):
        ganador = np.argmax(posiciones)
        print(f"\n ¡El caballo de la pista {ganador + 1} ha ganado la carrera!")
        break
        
    time.sleep(1.2) 