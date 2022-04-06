import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/services/auth.dart';

class ConnectWithClient extends StatefulWidget {
  final String typeUser;

  ConnectWithClient({this.typeUser});

  @override
  _ConnectWithClientState createState() => _ConnectWithClientState();
}

class _ConnectWithClientState extends State<ConnectWithClient> {
  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String error = '', email = '';

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
                  Icons.group_add,
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
                    'Deseja conectar a cliente?',
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
                    'Compartilhe com o cliente o código abaixo para fazer a conexão.',
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
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'XY95T2',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'VOLTAR',
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
