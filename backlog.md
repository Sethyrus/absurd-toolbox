# TODO
- [ ] Investigar sobre el patrón BLoC
- [ ] Buscar cómo pasar el estado de la red a los demás providers (incluso a los que ya reciben uno)
- [ ] Mover claves de API a un archivo .env, fuera de git
- [ ] Documentar/Añadir comentarios al código
- [ ] Funcionalidad para todos los campos de las notas (pinned, archived y demás)
- - [ ] Poder modificar color de las notas
- [ ] Revisar en qué casos tiene más sentido usar transacciones (Firestore) e implementar
- [x] Añadir una colección "users" a firebase donde almacenar los detalles del perfil de los usuarios
- - [x] Este dato debe cargarse y mantenerse actualizado dentro de la app
- - [x] Se mostrarán en la página de perfil
- - [ ] Se podrá editar en la página de editar perfil
- [x] Poder ordenar notas
- - [x] Añadir un campo "order" a las notas para usarse como sistema de ordenado
- [x] El toast usado debe cambiarse por un mensaje flotante
- [x] La recarga de notas debe funcionar como un listener y no ser llamado más que en el arranque
- [x] Bloquear la rotación, solo debe funcionar en vertical

# Bugs
- [ ] Al iniciar la app (con sesión previa) aparece un error de Notes y UserProfile en la consola de depuración (used after being disposed)
- [x] El alert al eliminar varias notas retrocede a home en lugar de cerrarse

# Useful resources:
- https://docs.flutter.dev/cookbook/effects/nested-nav
- BLoC
  - https://medium.com/codechai/architecting-your-flutter-project-bd04e144a8f1
  - https://www.didierboelens.com/2018/12/reactive-programming-streams-bloc-practical-use-cases/
  - https://www.mobindustry.net/blog/how-to-implement-the-bloc-architecture-in-flutter-benefits-and-best-practices/
  - https://medium.com/codechai/effective-bloc-pattern-45c36d76d5fe
  - https://medium.com/codechai/when-firebase-meets-bloc-pattern-fb5c405597e0