import 'package:flutter/material.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:lumen/services/database.dart';

import 'currentEquipament6.dart';

class CurrentEquipament5 extends StatefulWidget {
  final String typeUser;
  const CurrentEquipament5({Key key, @required this.typeUser}) : super(key: key);
  @override
  _CurrentEquipament5State createState() => _CurrentEquipament5State();
}

class _CurrentEquipament5State extends State<CurrentEquipament5> {
  String error;
  List<String> simNao = ['Sim', 'Não'];
  int movimentar, suporte, cabeca, apoio, traseiras, prescrito;
  String movimentarDesc, suporteDesc, cabecaDesc, apoioDesc, traseirasDesc, prescritoDesc;

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
                    Text('Verificação do equipamento em movimento e com o usuário sentado', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                    SizedBox(height: 25),

                    TextForm(text: 'O encosto permite ao usuário movimentar os ombros livremente para impulsionar a cadeira?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {movimentar = value;});},),
                    if (movimentar == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => movimentarDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'O encosto dá suporte suficiente ao usuário?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {suporte = value;});},),
                    if (suporte == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => suporteDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'O apoio de cabeça dá suporte suficiente ao usuário?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {cabeca = value;});},),
                    if (cabeca == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => cabecaDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Os pés do usuário mantêm-se no apoio para os pés?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {apoio = value;});},),
                    if (apoio == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => apoioDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'A rodas traseiras estão na posição correta para o usuário?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {traseiras = value;});},),
                    if (traseiras == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => traseirasDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Algum item prescrito faltou no equipamento?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {prescrito = value;});},),
                    if (prescrito == 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => prescritoDesc = val);},),
                        ],
                      ),
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
                                      widget: CurrentEquipament6(
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
