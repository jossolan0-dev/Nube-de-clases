"""
Módulo de Juegos — Tragaperras (A.3.1 / B.1.1).
Implementa RF-05 (Jugar Tragaperras).
"""

import random

from almacenamiento import obtener_configuracion
from usuario import obtener_usuario_por_id, actualizar_saldo, actualizar_estadisticas
from transacciones import registrar_transaccion

SIMBOLOS = ["🍒", "🍋", "🔔", "⭐", "💎"]

# Multiplicador aplicado a la apuesta cuando los 3 símbolos coinciden
TABLA_PAGOS = {
    "💎💎💎": 20,
    "⭐⭐⭐": 10,
    "🔔🔔🔔": 7,
    "🍋🍋🍋": 5,
    "🍒🍒🍒": 3,
}


def _calcular_premio(simbolos, apuesta):
    """3 símbolos iguales pagan según TABLA_PAGOS; 2 iguales devuelven la apuesta."""
    if len(set(simbolos)) == 1:
        combinacion = "".join(simbolos)
        return apuesta * TABLA_PAGOS.get(combinacion, 0)
    if len(set(simbolos)) == 2:
        return apuesta  # empate: se recupera la apuesta
    return 0.0


# ---------------------------------------------------------------------
# A.3.1 / B.1.1  jugar_tragaperras()
# ---------------------------------------------------------------------
#
# PSEUDOCÓDIGO
# INICIO jugar_tragaperras(id_usuario, apuesta)
#   config <- obtener_configuracion()
#   usuario <- obtener_usuario_por_id(id_usuario)
#
#   SI usuario es NULO ENTONCES
#       RETORNAR (False, "Usuario no encontrado")
#   FIN SI
#
#   SI apuesta < config.apuesta_minima O apuesta > config.apuesta_maxima ENTONCES
#       RETORNAR (False, "La apuesta está fuera de los límites permitidos")
#   FIN SI
#
#   SI apuesta > usuario.saldo ENTONCES
#       RETORNAR (False, "Saldo insuficiente")
#   FIN SI
#
#   saldo <- actualizar_saldo(id_usuario, -apuesta)
#   registrar_transaccion(id_usuario, "apuesta", -apuesta, saldo, "tragaperras")
#
#   simbolos <- [elegir_al_azar(SIMBOLOS) PARA i EN 1..3]
#   premio <- calcular_premio(simbolos, apuesta)
#
#   SI premio > 0 ENTONCES
#       saldo <- actualizar_saldo(id_usuario, premio)
#       registrar_transaccion(id_usuario, "premio", premio, saldo, "tragaperras")
#   FIN SI
#
#   actualizar_estadisticas(id_usuario, "tragaperras", apuesta, premio)
#
#   RETORNAR (True, {simbolos, apuesta, premio, saldo})
# FIN
# ---------------------------------------------------------------------

def jugar_tragaperras(id_usuario, apuesta):
    """
    RF-05: Procesa una ronda de tragaperras.
    Devuelve (exito: bool, resultado_o_mensaje).
    """
    try:
        apuesta = float(apuesta)
        config = obtener_configuracion()
        usuario = obtener_usuario_por_id(id_usuario)

        if usuario is None:
            return False, "Usuario no encontrado"

        if not (config["apuesta_minima"] <= apuesta <= config["apuesta_maxima"]):
            return False, (
                f"La apuesta debe estar entre {config['apuesta_minima']:.2f} "
                f"y {config['apuesta_maxima']:.2f}"
            )

        if apuesta > usuario["saldo"]:
            return False, "Saldo insuficiente para esta apuesta"

        # 1. Descontar la apuesta y registrar la transacción
        saldo = actualizar_saldo(id_usuario, -apuesta)
        registrar_transaccion(id_usuario, "apuesta", -apuesta, saldo, juego="tragaperras")

        # 2. Generar el resultado y calcular el premio
        simbolos = [random.choice(SIMBOLOS) for _ in range(3)]
        premio = _calcular_premio(simbolos, apuesta)

        # 3. Acreditar el premio (si aplica) y registrar la transacción
        if premio > 0:
            saldo = actualizar_saldo(id_usuario, premio)
            registrar_transaccion(id_usuario, "premio", premio, saldo, juego="tragaperras")

        # 4. Actualizar racha, mayor ganancia y partidas jugadas
        actualizar_estadisticas(id_usuario, "tragaperras", apuesta, premio)

        return True, {
            "simbolos": simbolos,
            "apuesta": apuesta,
            "premio": premio,
            "saldo": saldo,
        }

    except ValueError as error:
        return False, str(error)
