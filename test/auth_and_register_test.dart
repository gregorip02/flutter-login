import 'package:flutter_jwt_login/repository.dart';
import 'package:flutter_jwt_login/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final AuthRepository repository = AuthRepository();

  final Map usuarioNoRegistrado = {
    'email': 'fake@gmail.com',
    'password': '094j534iomfdklfmdl'
  };

  final Map usuarioConCredencialesIncorrectas = {
    'email': 'gregori.pineres02@gmail.com',
    'password': '094j534iomfdklfmdl'
  };

  final Map usuarioConCredencialesCorrectas = {
    'email': 'gregori.pineres02@gmail.com',
    'password': 'secret'
  };

  test('Autenticando usuario con credenciales correctas.', () async {
    final user = await repository.login(usuarioConCredencialesCorrectas);
    assert(user.runtimeType == User);
  });

  test('Autenticando usuario con credenciales incorrectas.', () async {
    try {
      final user = await repository.login(usuarioConCredencialesIncorrectas);
      assert(user.runtimeType != User);
    } catch (statusCode) {
      assert(statusCode == 401);
    }
  });

  test('Autenticando usuario no registrado.', () async {
    try {
      final user = await repository.login(usuarioNoRegistrado);
      assert(user.runtimeType != User);
    } catch (statusCode) {
      assert(statusCode == 404);
    }
  });
}