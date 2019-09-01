import 'package:flutter/material.dart';
import 'package:flutter_jwt_login/state.dart';
import 'package:flutter_jwt_login/views/layout.dart';

void main(List<String> args) async {
  final AppState state = await AppState.initState();
  runApp(
    App(state)
  );
}

class App extends StatelessWidget {
  final AppState state;
  App(this.state);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => AppStore(state),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'JWT Auth',
        theme: ThemeData(
          brightness: Brightness.light
        ),
        home: AppLayout()
      )
    );
  }
}
