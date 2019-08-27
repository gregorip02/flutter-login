import 'package:flutter/material.dart';
import 'package:flutter_jwt_login/utils.dart';
import 'package:flutter/cupertino.dart' show
  CupertinoButton,
  CupertinoSegmentedControl;

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.asset('images/jwt.png',
                alignment: Alignment.center, width: 190.0, height: 190.0),
              AuthWidget()
            ]
          )
        )
      )
    );
  }
}

class AuthWidget extends StatefulWidget {
  final Function onSubmit;
  final Function onValueChange;

  AuthWidget({this.onValueChange, this.onSubmit});

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  String _cupertinoSegmentedControlValue;
  double _formErrorsCunt;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cupertinoSegmentedControlValue = 'login';
    _formErrorsCunt = 0;
  }

  void changeCupertinoSegmentedControlValue(String val) {
    setState(() => _cupertinoSegmentedControlValue = val );
  }

  void incrementFormErrorsCount() {
    setState(() {
      if (_formErrorsCunt != 3) {
        _formErrorsCunt++;
      }
    });
  }

  void decrementFormErrorsCount() {
    setState(() {
      if (_formErrorsCunt != 0) {
        _formErrorsCunt--;
      }
    });
  }

  List<Widget> _loginForm({List<Widget> aditionalInputs = const []}) {
    return <Widget>[
      Column(
        children: <Widget>[
          ...aditionalInputs,
          TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.emailAddress,
            validator: (val) {
              final String validation = validateEmail(val); // See utils.dart
              validation != null ?
                incrementFormErrorsCount() : decrementFormErrorsCount();
              return validation;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
              labelText: 'Correo electrónico',
              labelStyle: TextStyle(color: Colors.blueGrey),
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            maxLines: 1,
            obscureText: true,
            validator: (val) {
              final String validation = moreThan(6, val.length); // See utils.dart
              validation != null ?
                incrementFormErrorsCount() : decrementFormErrorsCount();
              return validation;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
              labelText: 'Contraseña',
              labelStyle: TextStyle(color: Colors.blueGrey),
            )
          ),
          SizedBox(height: 10.0),
          CupertinoButton(
            color: Colors.blue,
            child: Row(
              children: <Expanded>[
                Expanded(
                  child: Text('Continuar', textAlign: TextAlign.center)
                )
              ]
            ),
            onPressed: () {
              // Validate returns true if the form is valid, or false
              // otherwise.
              if (_formKey.currentState.validate()) {
                // If the form is valid, display a Snackbar.
                _formKey.currentState.save();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Enviando información...')
                  )
                );
              }
            },
          )
        ]
      )
    ];
  }

  List<Widget> _registerForm() {
    return _loginForm(
      aditionalInputs: <Widget>[
        TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.text,
          validator: (val) {
            final String validation = moreThan(6, val.length); // See utils.dart
            validation != null ?
              incrementFormErrorsCount() : decrementFormErrorsCount();
            return validation;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
            labelText: 'Tu nombre',
            labelStyle: TextStyle(color: Colors.blueGrey),
          ),
        ),
        SizedBox(height: 10.0),
      ]
    );
  }

  List<Widget> _showLoginOrRegisterForm() {
    if (_cupertinoSegmentedControlValue == 'login') {
      return _loginForm();
    }

    return _registerForm();
  }

  CupertinoSegmentedControl _segmentedControl() {
    return CupertinoSegmentedControl(
      borderColor: Colors.grey,
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
      onValueChanged: (val) => changeCupertinoSegmentedControlValue(val),
    );
  }

  Form _formLayout() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _segmentedControl(),
              if (_cupertinoSegmentedControlValue == 'login') Padding(
                padding: EdgeInsets.all(20),
                child: Text('Json web token', style: TextStyle(
                  fontFamily: 'Lobster',
                  fontSize: 32.0,
                  color: Colors.blueGrey
                ))
              )
            ]
          ),
          ..._showLoginOrRegisterForm()
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height =  MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        height: height - (190 - (11 * (_formErrorsCunt + 1))),
        width: MediaQuery.of(context).size.width * 0.95,
        padding: EdgeInsets.all(10),
        color: Colors.white.withOpacity(0.9),
        child: _formLayout()
      )
    );
  }
}
