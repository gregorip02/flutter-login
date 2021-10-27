# JWT Login

Una aplicación de flutter que integra un sistema de autenticación basado en JWT.

## Instalación y arranque

Abre un terminal y ejecuta lo siguiente:

```bash
git clone https://github.com/gregorip02/flutter-jwt-login
cd flutter-jwt-login
flutter packages get
flutter run
```

## Empezando

Para este ejemplo desarrollé una app de Express y la desplegué en [heroku](https://backend-jwt.herokuapp.com),
puedes clonar el [repositorio](https://github.com/gregorip02/jwt-backend) y correrlo en tu maquina si así lo prefieres.
Dependiendo de tu elección has algunos cambios en el archivo `lib/utils.dart`:

#### Backend remoto
```dart
String getBaseUri() =>
  inReleaseMode() ?
    'https://backend-jwt.herokuapp.com' : 'https://backend-jwt.herokuapp.com';
```

#### Backend local
```dart
String getBaseUri() =>
  inReleaseMode() ?
    'https://backend-jwt.herokuapp.com' : 'http://<your-ip>:<your-port>';
```

## Screenshots

<img src="./images/screenshots/Screenshot_1567560178.png" width="400px">
<img src="./images/screenshots/Screenshot_1567560181.png" width="400px">
<img src="./images/screenshots/Screenshot_1567560191.png" width="400px">
