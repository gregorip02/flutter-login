import 'package:flutter/material.dart';
import 'package:flutter_jwt_login/utils.dart';
import 'package:flutter_jwt_login/state.dart';
import 'package:flutter/cupertino.dart'
  show CupertinoButton, CupertinoSegmentedControl;

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Una llave global para asignarla al estado de
  // nuestro widget Form
  // @var GlobalKey
  final _formKey = GlobalKey<FormState>();

  // El valor por defecto de la barra segmentada.
  // @var String
  String _cupertinoSegmentedControlValue = 'login';

  // Las credenciales por defecto enviadas
  // al servidor backend.
  // @var Map
  Map _formValues = { 'name': '', 'email': '', 'password': '' };

  @override
  initState() {
    super.initState();
    if (buildMode() != 'release') {
      // En ambientes de desarrollo es conveniente tener
      // algunos datos pre-definidos para no escribirlos
      // cada vez que hacemos un hot-relead ;)
      _formValues = {
        'name': 'Jhon Anderson',
        'email': 'jhona@email.com',
        'password': 'secret'
      };
    }
  }

  // Agrega un nuevo valor a nuestro Map _formValues
  // @param Object key
  // @param dynamic val
  // @return void
  void _setFormValue(Object key, dynamic val) {
    if (_formValues.containsKey(key)) {
      setState(() => _formValues[key] = val );
    }
  }

  // Cambia el valor del segmentedControl
  // @param String val
  void _changeCupertinoSegmentedControlValue(String val) {
    _formKey.currentState.reset();
    setState(() => _cupertinoSegmentedControlValue = val );
  }

  // Un simple operador ternario para determinar que tipo
  // de formulario mostrar basado en el valor de
  // _cupertinoSegmentedControlValue.
  //
  // @return List<Widget>
  List<Widget> _showLoginOrRegisterInputs() =>
    _cupertinoSegmentedControlValue == 'login' ?
      _loginForm() : _registerForm();

  // El formulario de login, esta lista de widgets acepta una
  // lista de widgets (opcional) para añadirlos después.
  // @param List<Widget> aditionalInputs
  // @return List<Widget>
  List<Widget> _loginForm({List<Widget> aditionalInputs = const []}) {
    return <Widget>[
      TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        initialValue: _formValues['email'],
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
        initialValue: _formValues['password'],
        validator: (val) => moreThan(6, val.length),
        onSaved: (val) => _setFormValue('password', val),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock),
          labelText: 'Contraseña',
          //labelStyle: TextStyle(color: Colors.blueGrey),
        )
      ),
      ...aditionalInputs
    ];
  }

  // El formulario de registro extiende la logica del widget _loginForm
  // y envía un TextFormField adicional para que el usuario ingrese su
  // nombre.
  // @return List<Widget>
  List<Widget> _registerForm() {
    return _loginForm(
      aditionalInputs: <TextFormField>[
        TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.text,
          initialValue: _formValues['name'],
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

  // La barra segmentada estilo IOS. Permite cambiar entre formularios
  // @return Widget
  Widget _cupertinoSegmentedControl() {
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

  // Header del _loginContainer, incorpora _cupertinoSegmentedControl
  // añada un 'fancy string' basado en el valor de
  // _cupertinoSegmentedControlValue
  // @return Widget
  Widget _headerLoginContainer() {
    return Column(
      children: <Widget>[
        _cupertinoSegmentedControl(),
        // The json web token fancy header
        if (_cupertinoSegmentedControlValue == 'login') Padding(
          padding: EdgeInsets.all(18),
          child: Text('Json web token', style: TextStyle(
            fontSize: 40.0,
            fontFamily: 'Lobster',
            color: Colors.blueGrey
          ))
        )
      ]
    );
  }

  // El boton de submit.
  // @return Widget
  Widget _submitButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: ViewModelSubscriber<AppState, bool>(
        converter: (state) => state.hasLoading(),
        builder: (context, dispatch, loading) {
          return CupertinoButton(
            color: loading ? Colors.grey : Colors.blue,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text('Continuar', textAlign: TextAlign.center)
                )
              ]
            ),
            onPressed: ()
              => loading ? null : _onSubmitPressed(context, dispatch),
          );
        }
      )
    );
  }

  void _onSubmitPressed(BuildContext context, DispatchFunction dispatch) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      dispatch(AuthAction(
        // El endpoint del backend ejm: http://example.com/(login|register)
        _cupertinoSegmentedControlValue,
        // Las credenciales: email, password and name.
        _formValues
      ));
    }
  }

  // El contenedor de todo el esqueleto de login.
  // @return Widget
  Widget _loginContainer(double screenHeight, double screenWidth) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Container(
        width: screenWidth * 0.95,
        height: (screenHeight * 0.75)-5,
        padding: const EdgeInsets.all(10),
        color: Colors.white.withOpacity(0.9),
        constraints: BoxConstraints(
          maxHeight: 400,
          maxWidth: 350
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _headerLoginContainer(),
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _showLoginOrRegisterInputs()
                )
              )
            ),
            _submitButton(context)
          ]
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // TODO: Handle the auth failed dialog!
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SafeArea(
                child: Image.asset('images/jwt.png',
                  height: screenHeight * 0.20)
              ),
              _loginContainer(screenHeight, screenWidth)
            ]
          )
        )
      )
    );
  }
}
