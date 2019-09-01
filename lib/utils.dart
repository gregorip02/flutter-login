String buildMode() {
  // Si el valor de entorno 'dart.vm.product' es true
  // el valor de construcción es 'release'
  if (const bool.fromEnvironment('dart.vm.product')) {
    return 'release';
  }

  // Por defecto esta funcion retorna un valor
  // de construcción a 'profile'
  var result = 'profile';

  // Si el codigo de assercion es ejecutado
  // el modo de construcción esta en 'debug'
  assert(() {
    result = 'debug';
    return true;
  }());

  return result;
}

bool inReleaseMode() => buildMode() == 'release';

// La uri de la api para obtener los datos
// no incluya el slash final (/)
String getBaseUri() =>
  inReleaseMode() ?
    'https://backend-jwt.herokuapp.com' : 'http://10.42.0.1:3000';

// Una simple validación de emails
// Fuente: https://medium.com/@nitishk72/form-validation-in-flutter-d762fbc9212c
String validateEmail(String value) {
  final Pattern pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  final RegExp regex = new RegExp(pattern);

  return regex.hasMatch(value) ?
    null : 'Introduce un email valido';
}

String moreThan(num expectedLength, num valueLength) {
  return valueLength < expectedLength ?
    'Debe tener al menos $expectedLength caracteres' : null;
}