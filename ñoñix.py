import json


usuarios_bd = {}
def registrar_usuario():
    usuario = input("Ingrese nombre de usuario: ")
    if usuario in usuarios_bd:
        print("Error: El usuario ya existe. Intente con otro nombre.")
    else:
        contrasena = input("Ingrese contraseña: ")
        # Se crea la cuenta con un saldo inicial de 0.0
        usuarios_bd[usuario] = {
        "contrasena": contrasena,
        "saldo": 0.0
        }
        print("Cuenta creada exitosamente.")
        
def iniciar_sesion():
    usuario = input("Ingrese nombre de usuario: ")
    contrasena = input("Ingrese contraseña: ")
    # Verificación de credenciales
    if usuario in usuarios_bd and usuarios_bd[usuario]:
        ["contrasena"] == contrasena
        print("Inicio de sesión exitoso.")
        return usuario
    else:
        print("Error: Usuario o contraseña incorrectos.")
        return None
    
def depositar(usuario_actual):
    try:
        monto = float(input("Ingrese el monto a depositar: "))
        if monto > 0:
            usuarios_bd[usuario_actual]["saldo"] += monto
            nuevo_saldo = usuarios_bd[usuario_actual]["saldo"]
            print(f"Depósito exitoso. Su nuevo saldo es: ${nuevo_saldo:.2f}")
        else:
            print("Error: El monto a depositar debe ser mayor a 0.")
    except ValueError:
        print("Error: Por favor ingrese un valor numérico válido.")
        
def jugar_tragaperras(usuario_actual):
    try:
        apuesta = float(input("Ingrese el monto de su apuesta: "))
        saldo_actual = usuarios_bd[usuario_actual]["saldo"]
        if apuesta <= 0:
            print("Error: La apuesta debe ser mayor a 0.")
        elif apuesta > saldo_actual:
            print(f"Error: Saldo insuficiente. Su saldo actual es: ${saldo_actual:.2f}")
        else:
            print(f"Apuesta de ${apuesta:.2f} registrada. ¡Listos para jugar!")
    # Aquí se integrará posteriormente la mecánica de los rodillos
    except ValueError:
        print("Error: Por favor ingrese un valor numérico válido para la apuesta.")
        
def snakebet_logo():
    a = '''
    *****************************************************************************
    *  ######  ##    ##    ###    ##    ## ######## ########  ######## ######## *
    * ##    ## ###   ##   ## ##   ##   ##  ##       ##     ## ##          ##    *
    * ##       ####  ##  ##   ##  ##  ##   ##       ##     ## ##          ##    *
    *  ######  ## ## ## ##     ## #####    ######   ########  ######      ##    *
    *       ## ##  #### ######### ##  ##   ##       ##     ## ##          ##    *
    * ##    ## ##   ### ##     ## ##   ##  ##       ##     ## ##          ##    *
    *  ######  ##    ## ##     ## ##    ## ######## ########  ########    ##    *
    *****************************************************************************
    '''
    return a


