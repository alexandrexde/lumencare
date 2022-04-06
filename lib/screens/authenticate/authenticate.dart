import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:lumen/screens/authenticate/register/client/register.dart';
import 'dart:io';
import 'package:lumen/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }
  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return 0;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
      if (showSignIn) {
        if (_checkInternetConnectivity() == 0) {
          _showDialog();
        } else {
          return SignIn(toggleView: toggleView);
        }
      } else {
        if (_checkInternetConnectivity() == 0) {
          _showDialog();
        } else {
          return Register(toggleView: toggleView);
        }
      }
  }
  _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
          return Padding(
            padding: EdgeInsets.only(top: 235, bottom: 235),
            child:  AlertDialog(
              content:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.wifi_off,
                      color: Colors.black,
                      size: 50.0,
                    ),
                    SizedBox(height: 5),
                    Text('Sem conexão',textAlign: TextAlign.center,style:TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),],
                ),
              actions: <Widget>[
                TextButton(
                    child: Text('Ok'),
                    onPressed: () {exit(0);}
                ),
              ],
            ),
          );
      }
    );
  }
}



