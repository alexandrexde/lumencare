import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lumen/common_widgets/maintenance.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/screens/home/pre_atendimento_form/pre_atendimento.dart';
import 'package:lumen/screens/home/prescricao_form/prescricao.dart';
import 'package:lumen/services/auth.dart';
import 'package:lumen/services/database.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';
import 'atendimento_form/atendimento.dart';
import 'sideMenu/sideMenu.dart';

class homeCompany extends StatefulWidget {
  @override
  _homeCompanyState createState() => _homeCompanyState();
}

class _homeCompanyState extends State<homeCompany> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    final AuthService _auth = AuthService();



    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userDataCompany,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          if (snapshot.hasData) {
            return Scaffold(
              drawer: NavDrawer(typeUser: 'Company',),
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
                  Column(
                    children: [
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
                              MaterialPageRoute(builder: (context) => PreAtendimento(typeUser: 'Company',)),
                            );
                          },
                        ),
                      ),
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
                              MaterialPageRoute(builder: (context) => Prescricao(typeUser: 'Company',))
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
                            'VERIFICAR EQUIPAMENTO',
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
                                MaterialPageRoute(builder: (context) => Maintanance())//CurrentEquipament(typeUser: 'Company',))
                            );
                          },
                        ),
                      ),
                    ],
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
