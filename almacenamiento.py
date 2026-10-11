"""
Módulo de persistencia (Capa de Persistencia).
Contiene las funciones genéricas de lectura/escritura en JSON y las
utilidades de seguridad (hash de contraseñas) usadas por el resto
de los módulos del Casino Virtual.
"""

import json
import os
import hashlib
import secrets

RUTA_USUARIOS = "usuarios.json"
RUTA_CONFIGURACION = "configuracion.json"

CONFIGURACION_POR_DEFECTO = {
    "configuracion": {
        "nombre_sistema": "Casino Virtual",
        "saldo_bienvenida": 1000.00,
        "apuesta_minima": 10.00,
        "apuesta_maxima": 5000.00,
        "max_intentos_login": 3,
        "tiempo_bloqueo_minutos": 15
    }
}


def leer_json(ruta, valor_por_defecto=None):
    """Lee un archivo JSON. Si no existe, lo crea con un valor por defecto."""
    if not os.path.exists(ruta):
        datos_iniciales = valor_por_defecto if valor_por_defecto is not None else {}
        guardar_json(ruta, datos_iniciales)
        return datos_iniciales
    with open(ruta, "r", encoding="utf-8") as archivo:
        return json.load(archivo)


def guardar_json(ruta, datos):
    """Escribe datos en un archivo JSON de forma legible (indentado)."""
    with open(ruta, "w", encoding="utf-8") as archivo:
        json.dump(datos, archivo, indent=2, ensure_ascii=False)


def obtener_configuracion():
    return leer_json(RUTA_CONFIGURACION, CONFIGURACION_POR_DEFECTO)["configuracion"]


def generar_id(lista_registros):
    """Genera el siguiente ID autoincremental de una lista de diccionarios con clave 'id'."""
    if not lista_registros:
        return 1
    return max(registro["id"] for registro in lista_registros) + 1


def generar_hash(password, salt=None):
    """
    Genera un hash seguro (SHA-256 + salt) para una contraseña.
    Devuelve una tupla (password_hash, password_salt).
    """
    if salt is None:
        salt = secrets.token_hex(16)
    hash_resultante = hashlib.sha256((salt + password).encode("utf-8")).hexdigest()
    return hash_resultante, salt


def verificar_password(password, password_hash, password_salt):
    """Compara una contraseña en texto plano contra el hash almacenado."""
    hash_calculado, _ = generar_hash(password, password_salt)
    return hash_calculado == password_hash
