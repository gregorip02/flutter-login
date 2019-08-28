import 'package:flutter/material.dart';
import 'package:flutter_jwt_login/utils.dart';
import 'package:flutter_jwt_login/state.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton, CupertinoSegmentedControl;

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String _cupertinoSegmentedControlValue = 'login';

  Map _formValues = {
    'name': '',
    'email': '',
    'password': '',
  };

  void _setFormValue(String key, dynamic value) {
    if (_formValues[key] != null) {
      _formValues[key] = value;
    }
  }

  // Cambia el valor del segmentedControl
  // @param String val
  void _changeCupertinoSegmentedControlValue(String val) {
    setState(() => _cupertinoSegmentedControlValue = val );
  }

  CupertinoSegmentedControl _cupertinoSegmentedControl() {
    return CupertinoSegmentedControl(
      selectedColor: Colors.blue,
      unselectedColor: Colors.white,
      children: {
        'login': Padding(
          padding: EdgeInsets.all(10),
          child: Text('Iniciar Sesión')
        ),
        'register': Padding(
          padding: EdgeInsets.all(10),
          child: Text('Registrarme')
        )
      },
      groupValue: _cupertinoSegmentedControlValue,
      onValueChanged: (val) => _changeCupertinoSegmentedControlValue(val),
    );
  }

  List<Widget> _showLoginOrRegisterInputs() =>
    _cupertinoSegmentedControlValue == 'login' ?
      _loginForm() : _registerForm();

  List<Widget> _loginForm({List<Widget> aditionalInputs = const []}) {
    return <Widget>[
      TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        validator: (val) => validateEmail(val), // See utils.dart
        onSaved: (val) => _setFormValue('email', val),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.email),
          labelText: 'Correo electrónico',
          labelStyle: TextStyle(color: Colors.blueGrey),
        ),
      ),
      TextFormField(
        maxLines: 1,
        obscureText: true,
        validator: (val) => moreThan(6, val.length),
        onSaved: (val) => _setFormValue('password', val),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock),
          labelText: 'Contraseña',
          labelStyle: TextStyle(color: Colors.blueGrey),
        )
      ),
      ...aditionalInputs
    ];
  }

  List<Widget> _registerForm() {
    return _loginForm(
      aditionalInputs: <TextFormField>[
        TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.text,
          validator: (val) => moreThan(6, val.length),
          onSaved: (val) => _setFormValue('name', val),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
            labelText: 'Tu nombre',
            labelStyle: TextStyle(color: Colors.blueGrey),
          ),
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SafeArea(
                child: Image.asset('images/jwt.png', height: screenHeight * 0.25)
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Container(
                  height: screenHeight * 0.70,
                  width: screenWidth * 0.95,
                  padding: EdgeInsets.all(10),
                  color: Colors.white.withOpacity(0.9),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Header
                      Column(
                        children: <Widget>[
                          _cupertinoSegmentedControl(),
                          if (_cupertinoSegmentedControlValue == 'login') Padding(
                            padding: EdgeInsets.all(18),
                            child: Text('Json web token', style: TextStyle(
                              fontFamily: 'Lobster',
                              fontSize: 36.0,
                              color: Colors.blueGrey
                            ))
                          )
                        ]
                      ),
                      // Body
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: _showLoginOrRegisterInputs()
                          )
                        )
                      ),
                      // Footer
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: ViewModelSubscriber<AppState, String>(
                          converter: (AppState state) => state.networkStatus,
                          builder: (BuildContext context, DispatchFunction dispatch, String ns) {
                            return CupertinoButton(
                              color: Colors.blue,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text('Continuar', textAlign: TextAlign.center)
                                  ),
                                  if (ns == 'loading') CircularProgressIndicator(
                                    backgroundColor: Colors.white
                                  )
                                ]
                              ),
                              onPressed: () {
                                // Validate returns true if the form is valid, or false
                                // otherwise.
                                if (_formKey.currentState.validate()) {
                                  // If the form is valid, display a Snackbar.
                                  _formKey.currentState.save();
                                  // Dispatch login or register action
                                  if (_cupertinoSegmentedControlValue == 'login') {
                                    dispatch(LoginAction(_formValues));
                                  }
                                }
                              },
                            );
                          }
                        )
                      )
                    ]
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}
