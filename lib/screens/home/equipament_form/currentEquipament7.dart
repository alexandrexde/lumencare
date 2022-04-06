import 'package:flutter/material.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:lumen/services/database.dart';

import 'currentEquipament8.dart';

class CurrentEquipament7 extends StatefulWidget {
  final String typeUser;
  const CurrentEquipament7({Key key, @required this.typeUser}) : super(key: key);
  @override
  _CurrentEquipament7State createState() => _CurrentEquipament7State();
}

class _CurrentEquipament7State extends State<CurrentEquipament7> {
  String error;
  List<String> simNao = ['Sim', 'Não'];
  int impulsionar, rampas, escadas, terreno, empinar, pressao, pushUp, comer, fazer;

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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Mobilidade na cadeira de rodas', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                    SizedBox(height: 25),

                    TextForm(text: 'Impulsionar corretamente?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {impulsionar = value;});},),
                    SizedBox(height: 25),

                    TextForm(text: 'Subir e descer rampas?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {rampas = value;});},),
                    SizedBox(height: 25),

                    TextForm(text: 'Subir e descer escadas?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {escadas = value;});},),
                    SizedBox(height: 25),

                    TextForm(text: 'Impulsionar em terreno irregular?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {terreno = value;});},),
                    SizedBox(height: 25),

                    TextForm(text: 'Empinar parcialmente?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {empinar = value;});},),
                    SizedBox(height: 25),

                    Text('Prevenção de úlceras/feridas de pressão', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                    SizedBox(height: 25),

                    TextForm(text: 'Verificar a existência de úlceras/feridas de pressão?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {pressao = value;});},),
                    SizedBox(height: 25),

                    TextForm(text: 'Elevação para alívio de pressão (push up)?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {pushUp = value;});},),
                    SizedBox(height: 25),

                    TextForm(text: 'Comer adequadamente e tomar boa quantidade de água?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {comer = value;});},),
                    SizedBox(height: 25),

                    TextForm(text: 'O que fazer se aparecerem úlceras/feridas de pressão?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {fazer = value;});},),
                    SizedBox(height: 25),

                    //arrows
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //back btn
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Color(0xFF6848AE),
                            ),
                            onPressed: () {
                              // Navigator.pop(
                              //     context,
                              //     SlideRightRoute(widget: Atendimento3())
                              // );
                            },
                          ),
                        ),
                        //foward btn
                        Container(
                          width: 60.0,
                          height: 60.0,
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
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                            onPressed: ()  {
                              try {
                                Navigator.push(
                                  context,
                                  SlideRightRoute4(
                                      widget: CurrentEquipament8(
                                        typeUser: widget.typeUser,
                                      )),
                                );
                              } catch (e){
                                if (e.toString() == 'Invalid argument(s)')
                                  setState(() => error = 'Preencha os campos vazios');
                              }
                            },
                          ),
                        ),
                      ],
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
