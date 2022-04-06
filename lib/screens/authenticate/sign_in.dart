import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/screens/authenticate/choose_user.dart';
import 'package:lumen/screens/authenticate/forgot_password.dart';
import 'package:lumen/services/auth.dart';
import 'package:lumen/shared/loading.dart';



class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //bool _rememberMe = false;
  final AuthService _auth = AuthService();
  final auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  _signInWithGoogle() async {
    try {
      await _auth.signInWithGoogle();

    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future _signInWithFacebook() async {
    try {
      await _auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //text fild state
  String email = '', password = '', error = '';
  bool _showPassword = false;

  Widget _buildForm() {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            //user tag
            'Usuário',
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
              validator: (val) => val.isEmpty ? '' : null,
              onChanged: (val) {
                setState(() => email = val);
              },
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  hintText: 'Digite seu usuário',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 12.0,
                  ),
                  fillColor: Color(0xFF8E48AE),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF8E48AE),
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF8E48AE),
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  errorStyle: TextStyle(
                    height: 0.0,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          //password text
          Text(
            'Senha',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          //password form
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
              obscureText: !_showPassword,
              validator: (val) => val.isEmpty ? '' : null,
              onChanged: (val) {
                setState(() => password = val);
              },
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: (){
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    child: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(8.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  hintText: 'Digite sua senha',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 12.0,
                  ),
                  fillColor: Color(0xFF8E48AE),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF8E48AE),
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF8E48AE),
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  errorStyle: TextStyle(
                    height: 0.0,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  )),
            ),
          ),
          //forgot password
          Container(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPassword()),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.only(right: 0.0)
              ),
              child: Text(
                'Esqueceu a senha?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          //erro de senha
          Container(
            alignment: Alignment.center,
            child: Text(
              error,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          //button
          Container(
            //padding: EdgeInsets.symmetric(vertical: 25.0),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                if (_formkey.currentState.validate()) {
                  dynamic result =
                      await _auth.signInWithEmailAndPassword(email, password);
                  switch (result) {
                    case 1:
                      loading = false;
                      setState(() => error = 'Email ou senha incorretos');
                      break;
                    case 2:
                      loading = false;
                      _auth.signOut();
                      _showDialog();
                      break;
                    default:
                      loading = true;
                      break;
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 5,
                primary: Colors.white,
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'ENTRAR',
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
          SizedBox(
            height: 25.0,
          ),
          //acess with
          Center(
            child: Column(
              children: <Widget>[
                Text(
                  '- OU -',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Acesse com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          //social buttons
          Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                _buildSocialBtn(
                  () {
                    _signInWithFacebook();
                  },
                  AssetImage('images/logoFacebook.png'),
                ),
                _buildSocialBtn(
                  () {
                    // setState(() {
                    //   loading = true;
                    // });
                    _signInWithGoogle();
                  },
                  AssetImage('images/logoGoogle.png'),
                ),
              ],
            ),
          ),
          //create acount
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseUser()),
                );
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Não possui conta? ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    TextSpan(
                      text: 'Criar conta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialBtn(
    Function onTap,
    AssetImage logo,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        //systemNavigationBarColor: Color(0xFF6848AE),
        //systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return loading
        ? Loading()
        : Scaffold(
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: <Widget>[
                  Container(
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
                  ),
                  Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 50.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('images/logoLumenBranco.png'),
                          SizedBox(
                            height: 20.0,
                          ),
                          _buildForm(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
  void _showDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Verifique seu email'),
          content: Text(
              'Por favor, verifique o seu email para continuar.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  SlideRightRoute5(widget: SignIn()),
                );
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
      },
    );
  }
}

//remember me
/* Container(
            child: Row(
              children: <Widget>[
                  SizedBox(
                    height: 30.0,
                    width: 50.0,
                    child: Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.white,
                      ),
                      child: Checkbox(
                        value: _rememberMe,
                        checkColor: Colors.green,
                        activeColor: Colors.white,
                        onChanged: (value) {
                          setState(
                            () {
                              _rememberMe = value;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Text(
                    'Lembre de mim',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ],
            ),
          ), */
