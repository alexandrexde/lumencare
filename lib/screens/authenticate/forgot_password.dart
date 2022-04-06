import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/services/auth.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String error = '', email = '';

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Verifique seu email'),
            content: Text(
                'Um email para redefinir sua senha foi enviado para $email'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Text(
                  'Voltar',
                  style: TextStyle(
                    color: Color(0xFF6848AE),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _buildForm() {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            //user tag
            'Email',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          //email form
          Container(
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 4),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: TextFormField(
              cursorColor: Color(0xFF6848AE),
              validator: (val) => val.isEmpty ? '' : null,
              onChanged: (val) {
                setState(() => email = val);
              },
              style: TextStyle(
                color: Color(0xFF6848AE),
                fontSize: 12.0,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xFF6848AE),
                ),
                hintText: 'Digite seu email',
                hintStyle: TextStyle(
                  color: Color(0xFF6848AE).withOpacity(0.7),
                  fontSize: 12.0,
                ),
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                errorStyle: TextStyle(
                  height: 0.0,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF8E48AE),
                Color(0xFF6848AE),
              ],
              stops: [0.1, 0.5],
            ),
          ),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 50.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // back btn
                Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 60.0,
                ),
                //icone locker
                Icon(
                  Icons.lock_open,
                  color: Colors.white,
                  size: 100.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                // forgot password text
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Esqueceu sua senha?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // instruction text
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Preencha o campo abaixo e receba um email para redefinir sua senha.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 90.0,
                ),
                // email form
                _buildForm(),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  //error text
                  error,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // button
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5.0,
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      primary: Colors.white,
                    ),
                    onPressed: () async {
                      await _auth.sendPasswordResetEmail(email);
                      if (_formkey.currentState.validate()) {
                        _showDialog();
                      }
                      else {
                        setState(() => error = 'Digite um email válido');
                      }
                    },
                    child: Text(
                      'ENVIAR',
                      style: TextStyle(
                        color: Color(0xFF6848AE),
                        letterSpacing: 1.5,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
