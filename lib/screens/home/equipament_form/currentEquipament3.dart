import 'package:flutter/material.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:lumen/services/database.dart';

import 'currentEquipament4.dart';

class CurrentEquipament3 extends StatefulWidget {
  final String typeUser;
  const CurrentEquipament3({Key key, @required this.typeUser}) : super(key: key);
  @override
  _CurrentEquipament3State createState() => _CurrentEquipament3State();
}

class _CurrentEquipament3State extends State<CurrentEquipament3> {
  String error;
  List<String> simNao = ['Sim', 'Não'];
  int impulsoMao, impulsoPe, assento, cambagem, suspensao, centroGravidade, freio, freioValue;
  String impulsoMaoDesc, impulsoPeDesc, assentoDesc, cambagemDesc, suspensaoDesc, centroGravidadeDesc, freioDesc;
  bool tilt = false, recEncosto = false, recChassi = false;
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
                    Text('Posição das rodas traseiras – para impulso com as mãos', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                    SizedBox(height: 25),

                    TextForm(text: 'Correta posição das rodas traseiras para impulso com as mãos?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {impulsoMao = value;});},),
                    if (impulsoMao == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => impulsoMaoDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    Text('Altura do assento – para impulso com os pés', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                    SizedBox(height: 25),

                    TextForm(text: 'Correta altura do assento para impulso com os pés?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {impulsoPe = value;});},),
                    if (impulsoPe == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => impulsoPeDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    Text('Opcionais do Chassi', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                    SizedBox(height: 25),

                    TextForm(text: 'Inclinação assento e encosto'),
                    SizedBox(height: 10),
                    CustomCheckbox(
                      textBox: 'Tilt',
                      onAnswer: (value) {
                        setState(() {
                          tilt = value;
                        });
                      },
                    ),
                    CustomCheckbox(
                      textBox: 'Reclinagem do encosto',
                      onAnswer: (value) {
                        setState(() {
                          recEncosto = value;
                        });
                      },
                    ),
                    CustomCheckbox(
                      textBox: 'Regulagens no chassi',
                      onAnswer: (value) {
                        setState(() {
                          recChassi = value;
                        });
                      },
                    ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correto ajuste?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {assento = value;});},),
                    if (assento == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => assentoDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correto ajuste da suspensão?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {suspensao = value;});},),
                    if (suspensao == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => suspensaoDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correto ajuste da cambagem?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {cambagem = value;});},),
                    if (cambagem == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => cambagemDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correto ajuste do ajuste de centro de gravidade?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {centroGravidade = value;});},),
                    if (centroGravidade == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => centroGravidadeDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Freios'),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: ['Acionamento para frente', 'Freio do condutor', 'Freio nas rodas traseiras'],
                      onAnswer: (value){ setState(() {freioValue = value;});},),
                    SizedBox(height: 25),

                    TextForm(text: 'Correto ajuste?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {freio = value;});},),
                    if (freio == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => freioDesc = val);},),
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
                                      widget: CurrentEquipament4(
                                        typeUser: widget.typeUser
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
