import 'package:flutter/material.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:lumen/services/database.dart';
import 'currentEquipament1.dart';
import 'currentEquipament3.dart';

class CurrentEquipament2 extends StatefulWidget {
  final String typeUser;
  const CurrentEquipament2({Key key, @required this.typeUser}) : super(key: key);
  @override
  _CurrentEquipament2State createState() => _CurrentEquipament2State();
}

class _CurrentEquipament2State extends State<CurrentEquipament2> {
  String error;
  List<String> simNao = ['Sim', 'Não'];
  int peiteira, abdutor, pelvico, toracico, toracicoQuatro, diagonal;
  String peiteiraDesc, abdutorDesc, pelvicoDesc, toracicoDesc, toracicoQuatroDesc, diagonalDesc;
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
                    Text('Cintos (sistemas de segurança)', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                    SizedBox(height: 25),

                    TextForm(text: 'Correto ajuste do cinto pélvico?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {pelvico = value;});},),
                    if (pelvico == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => pelvicoDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correto ajuste do cinto torácico?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {toracico = value;});},),
                    if (toracico == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => toracicoDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correto ajuste do cinto torácico de quatro pontos?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {toracicoQuatro = value;});},),
                    if (toracicoQuatro == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => toracicoQuatroDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correto ajuste do cinto diagonal?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {diagonal = value;});},),
                    if (diagonal == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => diagonalDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correto ajuste do cinto abdutor em Y?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {abdutor = value;});},),
                    if (abdutor == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => abdutorDesc = val);},),
                        ],
                      ),
                    SizedBox(height: 25),

                    TextForm(text: 'Correto ajuste do cinto peiteira?',),
                    SizedBox(height: 10),
                    SingleCustomRadio(namedButton: simNao,
                      onAnswer: (value){ setState(() {peiteira = value;});},),
                    if (peiteira == 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          TextForm(text: 'Descreva'),
                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => peiteiraDesc = val);},),
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
                              Navigator.pop(
                                  context,
                                  SlideRightRoute(widget: CurrentEquipament1())
                              );
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
                                      widget: CurrentEquipament3(
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
