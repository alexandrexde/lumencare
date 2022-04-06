import 'package:flutter/material.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:lumen/services/database.dart';

import '../home.dart';
import 'currentEquipament1.dart';

class CurrentEquipament extends StatefulWidget {
  final String typeUser;
  const CurrentEquipament({Key key, @required this.typeUser}) : super(key: key);
  @override
  _CurrentEquipamentState createState() => _CurrentEquipamentState();
}

class _CurrentEquipamentState extends State<CurrentEquipament> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Equipamento',
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 50.0,
          ),
          child: StreamBuilder<UserData>(
            stream: widget.typeUser == 'Client'
                ? DatabaseService(uid: user.uid).userData
                : widget.typeUser == 'Company'
                    ? DatabaseService(uid: user.uid).userDataCompany
                    : DatabaseService(uid: user.uid).userDataProfessional,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserData userData = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Verificação do equipamento', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                    SizedBox(height: 25),

                    TextForm(text: 'Equipamento',),
                    CustomForm(initialValue: 'ABCKD6523', hintText: 'Modelo', obscureText: false,),
                    SizedBox(height: 25,),

                    TextForm(text: 'Fabricante',),
                    CustomForm(initialValue: 'Ortobras Ltda.', hintText: 'Modelo', obscureText: false,),
                    SizedBox(height: 25,),

                    TextForm(text: 'Opcionais',),
                    CustomForm(initialValue: 'xxxxxxx', hintText: 'Modelo', obscureText: false,),
                    SizedBox(height: 25,),

                    Text('Medidas da cadeira de rodas', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                    SizedBox(height: 25,),

                    TextForm(text: 'Comprimento',),
                    CustomForm(initialValue: '150', hintText: 'Modelo', obscureText: false,),
                    SizedBox(height: 25,),

                    TextForm(text: 'Largura',),
                    CustomForm(initialValue: '80', hintText: 'Modelo', obscureText: false,),
                    SizedBox(height: 25,),

                    TextForm(text: 'Altura',),
                    CustomForm(initialValue: '50', hintText: 'Modelo', obscureText: false,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return CurrentEquipament1(typeUser: 'Company');
                              }),
                            );
                          },
                          child: Text(
                            'Revisar detalhes da cadeira',
                            style: TextStyle(
                              color: Color(0xFF6848AE),
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),

                    Container(
                      //button
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
                          'OK',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Home();
                            }),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Loading();
              }
            },
          ),
        ),
      ),
    );
  }
}
