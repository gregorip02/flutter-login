import 'package:rebloc/rebloc.dart';

import 'package:flutter_jwt_login/models/todo.dart';
import 'package:flutter_jwt_login/models/user.dart';

// Actions
//
// Las acciones son cargas de información que envían datos desde su aplicación a
// su Store. Son la única fuente de información para el Store.
//
// See https://redux.js.org/basics/actions#actions

// Login actions
class LoginAction extends Action {}
class LoginFailedAction extends Action {}
class LoginSuccessAction extends Action {
  final User user;
  LoginSuccessAction(this.user);
}

// Register actions
class RegisterAction extends Action {}
class RegisterFailedAction extends Action {}
class RegisterSuccessAction extends Action {
  final User user;
  RegisterSuccessAction(this.user);
}


// Todos Action
class ObtainingTodosAction extends Action {}
class FailObtainingTodosAction extends Action {}
class ObtainedTodosAction extends Action {
  final List<Todo> todos;
  ObtainedTodosAction(this.todos);
}

