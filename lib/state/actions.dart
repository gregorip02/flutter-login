import 'package:rebloc/rebloc.dart';

import 'package:flutter_jwt_login/models/todo.dart';
import 'package:flutter_jwt_login/models/user.dart';

// Actions
//
// Las acciones son cargas de información que envían datos desde su aplicación a
// su Store. Son la única fuente de información para el Store.
//
// See https://redux.js.org/basics/actions#actions

// Auth actions
class AuthAction extends Action {
  final String endpoint;
  final Map credentials;
  AuthAction(this.endpoint, this.credentials);
}
class AuthFailedAction extends Action {}
class AuthSuccessAction extends Action {
  final User user;
  AuthSuccessAction(this.user);
}

class LogoutAction extends Action {}

// Todos Action
class ObtainingTodosAction extends Action {}
class FailObtainingTodosAction extends Action {}
class ObtainedTodosAction extends Action {
  final List<Todo> todos;
  ObtainedTodosAction(this.todos);
}

