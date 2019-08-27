import 'package:flutter/material.dart';
import 'package:flutter_jwt_login/state.dart';
import 'package:flutter_jwt_login/views/layout.dart';

void main(List<String> args) {
  final Store store = Store<AppState>(
    initialState: AppState.initialState(),
    blocs: [
      AuthBloc(),
      TodoBloc()
    ]
  );

  runApp(StoreProvider<AppState>(
    store: store,
    child: App()
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JWT Auth',
      theme: ThemeData(
        brightness: Brightness.light
      ),
      home: LayoutApp()
    );
  }
}
