import 'package:flutter/material.dart';
import 'package:flutter_jwt_login/state.dart';

// Para usuarios no autenticados.
import 'package:flutter_jwt_login/views/auth.dart';

// Para usuarios autenticados
import 'package:flutter_jwt_login/views/home.dart';

class LayoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelSubscriber<AppState, bool>(
      converter: (AppState state) => state.hasUser(),
      builder: (BuildContext context, DispatchFunction dispatch, bool hasUser)
        => hasUser ? HomePage() : AuthScreen()
    );
  }
}
