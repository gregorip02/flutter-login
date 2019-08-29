export 'package:rebloc/rebloc.dart';
export 'package:flutter_jwt_login/state/blocs.dart';
export 'package:flutter_jwt_login/state/actions.dart';

import 'package:flutter_jwt_login/models/todo.dart';
import 'package:flutter_jwt_login/models/user.dart';

class AppState {
  final User user;
  final List<Todo> todos;

  // networkStatus almacena el estado de una petición http.
  // Sus valores son variables y representan lo siguiente:
  //
  // null      => Inactivo
  // loading   => Cargando recursos
  // completed => Carga completa
  // failed    => Carga fallida
  // offline   => Funcionando con datos offline
  final String networkStatus;

  factory AppState.initialState() => AppState();

  AppState({ this.user, this.todos = const [], this.networkStatus });

  AppState copyWith({ List<Todo> todos, String networkStatus }) {
    return AppState(
      todos: todos ?? this.todos,
      networkStatus: networkStatus ?? this.networkStatus
    );
  }

  AppState withUser(User user) => AppState(user: user);
  AppState withLoading() => copyWith(networkStatus: 'loading');
  AppState withFailed() => copyWith(networkStatus: 'failed');

  bool hasUser() => user.runtimeType == User;
  bool hasLoading() => networkStatus == 'loading';
  bool hasFailed() => networkStatus == 'failed';
}
