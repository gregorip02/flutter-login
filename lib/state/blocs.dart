import 'dart:async';
import 'package:flutter_jwt_login/state.dart';
import 'package:flutter_jwt_login/repository.dart';
import 'package:flutter_jwt_login/models/user.dart';

class AuthBloc extends SimpleBloc<AppState> {
  final AuthRepository repository = AuthRepository();

  // Los reductores especifican cómo cambia el estado de la aplicación en respuesta
  // a las acciones enviadas al Store. Recuerde que las acciones solo describen
  // lo que sucedió, pero no describen cómo cambia el estado de la aplicación.
  //
  // See https://redux.js.org/basics/reducers#reducers
  @override
  AppState reducer(AppState state, Action action) {
    if (action is LoginAction) {
      return state.isLoading();
    } else if (action is LoginSuccessAction) {
      return state.withUser(action.user);
    }

    return state;
  }

  @override
  FutureOr<Action> afterware(DispatchFunction dispatch, AppState state, Action action) {
    if (action is LoginAction) {
      repository.login(action.credentials).then((User user) {
        dispatch(LoginSuccessAction(user));
      }).catchError((err) {
        print(err);
      });
    }

    return action;
  }
}

class TodoBloc extends SimpleBloc<AppState> {
  // Los reductores especifican cómo cambia el estado de la aplicación en respuesta
  // a las acciones enviadas al Store. Recuerde que las acciones solo describen
  // lo que sucedió, pero no describen cómo cambia el estado de la aplicación.
  //
  // See https://redux.js.org/basics/reducers#reducers
  @override
  AppState reducer(AppState state, Action action) {
    return state;
  }

  @override
  FutureOr<Action> afterware(DispatchFunction dispatch, AppState state, Action action) {
    return action;
  }
}
