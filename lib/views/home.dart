// Esta pantalla asume que hay un usuario autenticado
import 'package:flutter/material.dart';
import 'package:flutter_jwt_login/state.dart';
import 'package:flutter_jwt_login/models/user.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppStore store = Provider.of<AppStore>(context);
    final AppState state = store.state;

    return Scaffold(
      body: Center(
        child: Text('Hola \n${state.user.name}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.display1),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: () {
          // Drop the user offline credentials
          User.dropOffline();
          store.dispatch((AppState state) {
            return state.copyWith(user: User());
          });
        }
      )
    );
  }
}
