import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/screens/home/pre_atendimento_form/pre_atendimento.dart';
import 'package:lumen/services/database.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';
import 'sideMenu/sideMenu.dart';

class homeUser extends StatefulWidget {
  @override
  _homeUserState createState() => _homeUserState();
}

class _homeUserState extends State<homeUser> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          if (snapshot.hasData) {
            return Scaffold(
              drawer: NavDrawer(typeUser: 'Client',),
              backgroundColor: Colors.white,
              appBar: AppBar(
                brightness: Brightness.light,
                title: Text('Lumen Care'),
                backgroundColor: Color(0xFF6848AE),
                elevation: 0.0,
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 50.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Text(
                          'Bem-vindo ',
                          style: TextStyle(
                            color: Color(0xFF6848AE),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userData.name.split(" ")[0],
                          style: TextStyle(
                            color: Color(0xFF6848AE),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    //button
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 50.0,
                    ),
                    width: double.infinity,
                    child: ElevatedButton(
                      //button
                      style: ElevatedButton.styleFrom(
                        elevation: 5.0,
                        primary: Color(0xFF6848AE),
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'PRÉ-ATENDIMENTO',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PreAtendimento(typeUser: 'Client',)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
