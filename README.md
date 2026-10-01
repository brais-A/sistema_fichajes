# Sistema de fichajes

App de fichajes hecha en Flutter

## Qué hace

- Fichar la entrada y la salida con un solo botón, que cambia entre "Entrar" y "Terminar" según toque.
- Ver los tramos del día con su hora de entrada, de salida y lo que ha durado cada uno.
- Mientras estás trabajando, el tiempo se va actualizando solo cada segundo.
- Arriba sale el total de horas que llevas hoy.
- Una pestaña de historial con los días anteriores y las horas de cada día.
- Los fichajes se guardan en el móvil, así que no se pierden al cerrar la app.

## Cómo está organizado

- `models/` → la clase Fichaje
- `screen/` → la pantalla principal y la del historial
- `services/` → la parte que guarda y carga los fichajes (con shared_preferences)
- `utils/` → funciones para mostrar bien las horas y las fechas

## Lo siguiente

- Pasar el guardado a una base de datos (seguramente Firebase).
- Avisar si se te olvidó fichar la salida el día anterior.