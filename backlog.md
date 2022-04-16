# TODO

- Abstraer ToolScreen
- Contador
- Cronómetro
  - Mejorar diseño, más a lo reloj de Google
  - Botón de pausa
  - Botón de reinicio
  - Botón de "lap" y mostrar "laps"
  - Guardar estado en un stream/servicio propio para preservar el estado si se sale
- Notas
  - Poder guardar notas vacías para que Víctor no llore
  - Funcionalidad para todos los campos de las notas
    - Archiving
      - Mover funcionalidad al notesService
    - Color
    - Pinning
  - Probar Hero en la transición de navegación de las notas
- Investigar sobre el patrón BLoC
- En el sorteo de dados, poder añadir más dados
- Mover claves de API a un archivo .env, fuera de git
- Drag'n'drop de los enlaces de la home
- Añadir función de conversor de unidades
- Hacer la función de los chats
- Documentar/Añadir comentarios al código
- Revisar en qué casos tiene más sentido usar transacciones (Firestore) e implementar
- Definir campos no modificables en Firestore
- OCR
  - Poder recortar la imagen
  - Función de OCR en las notas (ML Kit)
- Establecer colores del tema como los del fondo del logo
- Añadir una colección "users" a firebase donde almacenar los detalles del perfil de los usuarios
  - Este dato debe cargarse y mantenerse actualizado dentro de la app
  - Mostrar datos en la página de perfil
  - Poder editar en la página de editar perfil
- Notas
  - Poder ordenar notas
    - Añadir un campo "order" a las notas para usarse como sistema de ordenado
- El toast usado debe cambiarse por un mensaje flotante
- La recarga de notas debe funcionar como un listener y no ser llamado más que en el arranque
- Bloquear la rotación, solo debe funcionar en vertical
- Probar FittedBoxes en los ToolButtons para mejorar el estilo

# Bugs

- You tell me

# Useful dev resources:

- Misc
  - https://docs.flutter.dev/cookbook/effects/nested-nav
- BLoC
  - https://medium.com/codechai/architecting-your-flutter-project-bd04e144a8f1
  - https://www.didierboelens.com/2018/12/reactive-programming-streams-bloc-practical-use-cases/
  - https://www.mobindustry.net/blog/how-to-implement-the-bloc-architecture-in-flutter-benefits-and-best-practices/
  - https://medium.com/codechai/effective-bloc-pattern-45c36d76d5fe
  - https://medium.com/codechai/when-firebase-meets-bloc-pattern-fb5c405597e0
