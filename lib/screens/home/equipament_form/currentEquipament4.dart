import 'package:flutter/material.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:lumen/services/database.dart';

import 'currentEquipament5.dart';

class CurrentEquipament4 extends StatefulWidget {
  final String typeUser;
  const CurrentEquipament4({Key key, @required this.typeUser}) : super(key: key);
  @override
  _CurrentEquipament4State createState() => _CurrentEquipament4State();
}

class _CurrentEquipament4State extends State<CurrentEquipament4> {
  String error;
  List<String> simNao = ['Sim', 'Não'];
  int mesa, barra, joystick, eqpResp, soro, lado, frente, pressao;
  String mesaDesc, barraDesc, joystickDesc, eqpRespDesc, soroDesc, ladoDesc, frenteDesc, pressaoDesc;

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


                    TextForm(text: 'Correto ajuste de mesa?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {mesa = value;});},),
                    if (mesa == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => mesaDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correto ajuste de barra para condutor?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {barra = value;});},),
                    if (barra == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => barraDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correto ajuste de joystick?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {joystick = value;});},),
                    if (joystick == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => joystickDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correto ajuste de suporte para equipamentos respiratórios?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {eqpResp = value;});},),
                    if (eqpResp == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => eqpRespDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correto ajuste de suporte de soro?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {soro = value;});},),
                    if (soro == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => soroDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    Text('Verificação da postura com o usuário sentado no equipamento', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                    SizedBox(height: 25),

                    TextForm(text: 'Observe de lado e de frente como o usuário está sentado na cadeira. Ele está sentado em postura ereta?',),
                    SizedBox(height: 10),
                    TextForm(text: 'De lado',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {lado = value;});},),
                    if (lado == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => ladoDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'De frente',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {frente = value;});},),
                    if (frente == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => frenteDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    Text('Verificação da pressão com o usuário sentado no equipamento', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                    SizedBox(height: 15),
                    Text('Para todos os usuários em risco de desenvolver úlceras/feridas, verifique se a pressão sob o osso do ísquio é segura.', style: TextStyle(color: Colors.black54,fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(height: 25),

                    TextForm(text: 'Pressão segura sobre o osso isquio?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {pressao = value;});},),
                    if (pressao == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => pressaoDesc = val);},),
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
                                      widget: CurrentEquipament5(
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
