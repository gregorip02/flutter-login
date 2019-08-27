import 'package:flutter/material.dart';
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
                alignment: Alignment.center, width: 200.0, height: 200.0),
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                child: Container(
                  height: MediaQuery.of(context).size.height - 200,
                  width: MediaQuery.of(context).size.width * 0.95,
                  padding: EdgeInsets.all(10),
                  color: Colors.white.withOpacity(0.9),
                  child: AuthWidget()
                ),
              )
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

  @override
  void initState() {
    super.initState();
    _cupertinoSegmentedControlValue = 'login';
  }

  void changeCupertinoSegmentedControlValue(String val) {
    setState(() => _cupertinoSegmentedControlValue = val );
  }

  List<Widget> loginForm({List<Widget> aditionalInputs = const []}) {
    return <Widget>[
      Column(
        children: <Widget>[
          ...aditionalInputs,
          TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.emailAddress,
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
            onPressed: () => null,
          )
        ]
      )
    ];
  }

  List<Widget> registerForm() {
    return loginForm(
      aditionalInputs: <Widget>[
        TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.text,
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

  List<Widget> showForm() {
    if (_cupertinoSegmentedControlValue == 'login') {
      return loginForm();
    }

    return registerForm();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoSegmentedControl(
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
              ),
              if (_cupertinoSegmentedControlValue == 'login')
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Json web token', style: TextStyle(
                    fontFamily: 'Lobster',
                    fontSize: 32.0,
                    color: Colors.blueGrey
                  ))
                )
            ]
          ),
          ...showForm()
        ]
      )
    );
  }
}
