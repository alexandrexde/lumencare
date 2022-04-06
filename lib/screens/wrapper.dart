
import 'package:flutter/material.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    //RETURN EITHER HOME OR AUTHENTICATE
    if (user == null) {
      return Authenticate();
      //return SignIn();
    } else {
      return Home();
    }
  }

}
