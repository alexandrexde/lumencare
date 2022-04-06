import 'package:flutter/material.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:lumen/services/database.dart';

import 'currentEquipament7.dart';

class CurrentEquipament6 extends StatefulWidget {
  final String typeUser;
  const CurrentEquipament6({Key key, @required this.typeUser}) : super(key: key);
  @override
  _CurrentEquipament6State createState() => _CurrentEquipament6State();
}

class _CurrentEquipament6State extends State<CurrentEquipament6> {
  String error;
  List<String> simNao = ['Sim', 'Não'];
  int adaptacao, progressivo, dobrar, erguer, freios, quick, almofada, independente, dependente, equipamento, assistida;

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
                    Text('Orientações para o uso do equipamento', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                    SizedBox(height: 25),

                    Text('Tempo de uso do equipamento', style: TextStyle(color: Color(0xFF6935AE),fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 15),

                    TextForm(text: 'Fase de adaptação com curtos períodos de tempo concluída?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {adaptacao = value;});},),
                    SizedBox(height: 25),

                    TextForm(text: 'Aumento progressivo do tempo concluído?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {progressivo = value;});},),
                    SizedBox(height: 25),

                    Text('Manuseio da cadeira de rodas', style: TextStyle(color: Color(0xFF6935AE),fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 15),

                    TextForm(text: 'Dobrar a cadeira de rodas?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {dobrar = value;});},),
                    SizedBox(height: 25),

                    TextForm(text: 'Erguer a cadeira de rodas?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {erguer = value;});},),
                    SizedBox(height: 25),

                    TextForm(text: 'Usar quick release?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {quick = value;});},),
                    SizedBox(height: 25),

                    TextForm(text: 'Usar os freios?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {freios = value;});},),
                    SizedBox(height: 25),

                    TextForm(text: 'Usar a almofada de alívio de pressão, incluindo posicioná-la corretamente?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {almofada = value;});},),
                    SizedBox(height: 25),

                    Text('Transferências', style: TextStyle(color: Color(0xFF6935AE),fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(height: 15),

                    TextForm(text: 'Transferência independente?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {independente = value;});},),
                    SizedBox(height: 25),

                    TextForm(text: 'Transferência assistida?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {assistida = value;});},),
                    SizedBox(height: 25),

                    TextForm(text: 'Transferência dependente?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {dependente = value;});},),
                    SizedBox(height: 25),

                    TextForm(text: 'Transferência equipamento?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {equipamento = value;});},),
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
                                      widget: CurrentEquipament7(
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
