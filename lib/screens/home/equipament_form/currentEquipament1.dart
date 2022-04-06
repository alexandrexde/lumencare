import 'package:flutter/material.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:lumen/services/database.dart';
import 'currentEquipament2.dart';

class CurrentEquipament1 extends StatefulWidget {
  final String typeUser;
  const CurrentEquipament1({Key key, @required this.typeUser}) : super(key: key);
  @override
  _CurrentEquipament1State createState() => _CurrentEquipament1State();
}

class _CurrentEquipament1State extends State<CurrentEquipament1> {
  List<String> simNao = ['Sim', 'Não'];
  int altura, largura, cabeca, braco, tronco, profundidade, alturaEncosto;
  String alturaDesc, larguraDesc, cabecaDesc, bracoDesc, troncoDesc, profundidadeDesc, alturaEncostoDesc, error;

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

                    TextForm(text: 'Correta largura do assento?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {largura = value;});},),
                    if (largura == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => larguraDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correta profundidade do assento?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {profundidade = value;});},),
                    if (profundidade == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => profundidadeDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correta altura do apoio para os pés?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {altura = value;});},),
                    if (altura == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => alturaDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correta altura do encosto?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {alturaEncosto = value;});},),
                    if (alturaEncosto == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => alturaEncostoDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correto ajuste dos apoios de braços?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {braco = value;});},),
                    if (braco == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => bracoDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correto ajuste do apoio de tronco?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {tronco = value;});},),
                    if (tronco == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => troncoDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correto ajuste do apoio de cabeça?',),
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


                    //arrows
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
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
                            onPressed: () async {
                              try {
                                Navigator.push(
                                  context,
                                  SlideRightRoute4(widget: CurrentEquipament2(
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
