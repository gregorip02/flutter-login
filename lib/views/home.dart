// Esta pantalla asume que hay un usuario autenticado
import 'package:flutter/material.dart';
import 'package:flutter_jwt_login/state.dart';
import 'package:flutter_jwt_login/models/user.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelSubscriber<AppState, User>(
      converter: (state) => state.user,
      builder: (context, dispatch, user) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hola \n${user.name}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.display1
                ),
                RaisedButton(
                  child: Text('Salir'),
                  onPressed: () => dispatch(LogoutAction()),
                  color: Colors.blue
                )
              ]
            )
          )
        );
      }
    );
  }
}
