import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lumen/common_widgets/maintenance.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/services/database.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';
import 'atendimento_form/atendimento.dart';
import 'sideMenu/sideMenu.dart';

class homeProfessional extends StatefulWidget {
  @override
  _homeProfessionalState createState() => _homeProfessionalState();
}

class _homeProfessionalState extends State<homeProfessional> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userDataProfessional,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          if (snapshot.hasData) {
            return Scaffold(
              drawer: NavDrawer(typeUser: 'Professional',),
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
                      vertical: 0.0,
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
                        'ATENDIMENTO',
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
                          MaterialPageRoute(builder: (context) => Atendimento()),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Container(
                    //button
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 0.0,
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
                        'PRESCRIÇÃO',
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
                            MaterialPageRoute(builder: (context) => Maintanance())//Prescricao(typeUser: 'Company',)),
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
