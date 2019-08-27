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
    'https://example.com' : 'http://192.168.2.101:3000';
