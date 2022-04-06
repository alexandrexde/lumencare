import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/screens/home/prescricao_form/prescricao4.dart';
import 'package:lumen/services/database.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';
import '../home.dart';


class Prescricao3 extends StatefulWidget {

  final typeUser;
  final Map<String, dynamic> pageData, pageData1;
  final String  uid;
  Prescricao3({this.typeUser, this.uid, this.pageData, this.pageData1});

  @override
  _Prescricao3State createState() => _Prescricao3State();
}

class _Prescricao3State extends State<Prescricao3>{
  final _formkey = GlobalKey<FormState>();
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  String error = '';
  Map<String, dynamic> pageData2 = Map<String, dynamic>();
  List<String> simNao = ['Sim','Não'];
  int inclinacaoValue, suspensaoValue, cambagemValue, ajusteValue, freioValue, tipoPneuDianValue, tipoPneuTrasValue, tamPneuDianValue, tamPneuTrasValue, quickDianValue, quickTrasValue, arosValue;
  List<bool> errorBox = [false, false, false, false, false, false, false, false, false, false, false, false];
  List<String> inclinacao = ['Tilt', 'Reclinagem do encosto', 'Tilt + Reclinagem do encosto', 'Regulagens no chassi'];
  List<String> freios = ['Acionamento para frente', 'Freio do condutor', 'Freio nas rodas traseiras'];
  List<String> tipoPneu = ['Maciço','Inflável'];
  List<String> tamanhoPneuDian = ["6'","7'","8'"];
  List<String> tamanhoPneuTras = ["16'","20'","24'"];
  List<String> aros = ["Aros lisos","Aros com pinos","Protetor de raios",'Aros de impulso com pinos','Aro hemiplégico direito', 'Aro hemiplégico esquerdo'];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        //systemNavigationBarColor: Color(0xFF6848AE),
        //systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    final user = Provider.of<Users>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(title: 'Prescrição'),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 50.0,
          ),
          child: Container(
            child:  StreamBuilder<UserData>(
              stream: widget.typeUser == 'Client' ? DatabaseService(uid: user.uid).userData : widget.typeUser == 'Company' ? DatabaseService(uid: user.uid).userDataCompany : DatabaseService(uid: user.uid).userDataProfessional,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //User userr = _auth.currentUser;
                  return Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Opcionais do Chassi', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                        SizedBox(height: 25),

                        Container(
                          padding: errorBox[0] ? EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10
                          ): EdgeInsets.all(0),
                          decoration: errorBox[0] ? BoxDecoration(
                              border: Border.all(color: Colors.red)
                          ) : BoxDecoration(
                              border: Border.all(color: Colors.transparent)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextForm(text: 'Inclinação assento e encosto *'),
                              SizedBox(height: 10),
                              SingleCustomRadio(namedButton: inclinacao,
                                onAnswer: (value){ setState(() {inclinacaoValue = value;errorBox[0] = false;});},),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),

                        Container(
                          padding: errorBox[1] ? EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10
                          ): EdgeInsets.all(0),
                          decoration: errorBox[1] ? BoxDecoration(
                              border: Border.all(color: Colors.red)
                          ) : BoxDecoration(
                              border: Border.all(color: Colors.transparent)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextForm(text: 'Suspensão *'),
                              SizedBox(height: 10),
                              SingleCustomRadio(namedButton: simNao,
                                onAnswer: (value){ setState(() {suspensaoValue = value; errorBox[1] = false;});},),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),

                        Container(
                          padding: errorBox[2] ? EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10
                          ): EdgeInsets.all(0),
                          decoration: errorBox[2] ? BoxDecoration(
                              border: Border.all(color: Colors.red)
                          ) : BoxDecoration(
                              border: Border.all(color: Colors.transparent)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextForm(text: 'Cambagem *'),
                              SizedBox(height: 10),
                              SingleCustomRadio(namedButton: simNao,
                                onAnswer: (value){ setState(() {cambagemValue = value;errorBox[2] = false;});},),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),

                        Container(
                          padding: errorBox[3] ? EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10
                          ): EdgeInsets.all(0),
                          decoration: errorBox[3] ? BoxDecoration(
                              border: Border.all(color: Colors.red)
                          ) : BoxDecoration(
                              border: Border.all(color: Colors.transparent)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextForm(text: 'Ajuste de centro de gravidade *'),
                              SizedBox(height: 10),
                              SingleCustomRadio(namedButton: simNao,
                                onAnswer: (value){ setState(() {ajusteValue = value;errorBox[3] = false;});},),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),

                        Container(
                          padding: errorBox[4] ? EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10
                          ): EdgeInsets.all(0),
                          decoration: errorBox[4] ? BoxDecoration(
                              border: Border.all(color: Colors.red)
                          ) : BoxDecoration(
                              border: Border.all(color: Colors.transparent)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextForm(text: 'Freios *'),
                              SizedBox(height: 10),
                              SingleCustomRadio(namedButton: freios,
                                onAnswer: (value){ setState(() {freioValue = value;errorBox[4] = false;});},),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),

                        Text('Rodas dianteiras', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                        SizedBox(height: 25),
                        Container(
                          padding: EdgeInsets.only(left: 23, right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: errorBox[5] ? EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 10
                                ): EdgeInsets.all(0),
                                decoration: errorBox[5] ? BoxDecoration(
                                    border: Border.all(color: Colors.red)
                                ) : BoxDecoration(
                                    border: Border.all(color: Colors.transparent)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextForm(text: 'Tipo de pneu *'),
                                    SizedBox(height: 10),
                                    SingleCustomRadio(namedButton: tipoPneu,
                                      onAnswer: (value){ setState(() {tipoPneuDianValue = value; errorBox[5] = false;});},),
                                  ],
                                ),
                              ),
                              SizedBox(height: 25),

                              Container(
                                padding: errorBox[6] ? EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 10
                                ): EdgeInsets.all(0),
                                decoration: errorBox[6] ? BoxDecoration(
                                    border: Border.all(color: Colors.red)
                                ) : BoxDecoration(
                                    border: Border.all(color: Colors.transparent)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextForm(text: 'Tamanho *'),
                                    SizedBox(height: 10),
                                    SingleCustomRadio(namedButton: tamanhoPneuDian,
                                      onAnswer: (value){ setState(() {tamPneuDianValue = value;errorBox[6] = false;});},),
                                  ],
                                ),
                              ),
                              SizedBox(height: 25),

                              Container(
                                padding: errorBox[7] ? EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 10
                                ): EdgeInsets.all(0),
                                decoration: errorBox[7] ? BoxDecoration(
                                    border: Border.all(color: Colors.red)
                                ) : BoxDecoration(
                                    border: Border.all(color: Colors.transparent)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextForm(text: 'Quick Release *'),
                                    SizedBox(height: 10),
                                    SingleCustomRadio(namedButton: simNao,
                                      onAnswer: (value){ setState(() {quickDianValue = value;errorBox[7] = false;});},),
                                  ],
                                ),
                              ),
                              SizedBox(height: 25),
                            ],
                          ),
                        ),


                        Text('Rodas traseiras', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                        SizedBox(height: 25),
                        Container(
                          padding: EdgeInsets.only(left: 23, right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: errorBox[8] ? EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 10
                                ): EdgeInsets.all(0),
                                decoration: errorBox[8] ? BoxDecoration(
                                    border: Border.all(color: Colors.red)
                                ) : BoxDecoration(
                                    border: Border.all(color: Colors.transparent)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextForm(text: 'Tipo de pneu *'),
                                    SizedBox(height: 10),
                                    SingleCustomRadio(namedButton: ['Maciço','Inflável','Anti furo'],
                                      onAnswer: (value){ setState(() {tipoPneuTrasValue = value;errorBox[8] = false;});},),
                                  ],
                                ),
                              ),
                              SizedBox(height: 25),

                              Container(
                                padding: errorBox[9] ? EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 10
                                ): EdgeInsets.all(0),
                                decoration: errorBox[9] ? BoxDecoration(
                                    border: Border.all(color: Colors.red)
                                ) : BoxDecoration(
                                    border: Border.all(color: Colors.transparent)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextForm(text: 'Tamanho *'),
                                    SizedBox(height: 10),
                                    SingleCustomRadio(namedButton:tamanhoPneuTras ,
                                      onAnswer: (value){ setState(() {tamPneuTrasValue = value;errorBox[9] = false;});},),
                                  ],
                                ),
                              ),
                              SizedBox(height: 25),

                              Container(
                                padding: errorBox[10] ? EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 10
                                ): EdgeInsets.all(0),
                                decoration: errorBox[10] ? BoxDecoration(
                                    border: Border.all(color: Colors.red)
                                ) : BoxDecoration(
                                    border: Border.all(color: Colors.transparent)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextForm(text: 'Quick Release *'),
                                    SizedBox(height: 10),
                                    SingleCustomRadio(namedButton: simNao,
                                      onAnswer: (value){ setState(() {quickTrasValue = value;errorBox[10] = false;});},),
                                  ],
                                ),
                              ),
                              SizedBox(height: 25),

                              Container(
                                padding: errorBox[11] ? EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 10
                                ): EdgeInsets.all(0),
                                decoration: errorBox[11] ? BoxDecoration(
                                    border: Border.all(color: Colors.red)
                                ) : BoxDecoration(
                                    border: Border.all(color: Colors.transparent)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextForm(text: 'Aros de impulso *'),
                                    SizedBox(height: 10),
                                    SingleCustomRadio(namedButton: aros,
                                      onAnswer: (value){ setState(() {arosValue = value;errorBox[11] = false;});},),
                                  ],
                                ),
                              ),
                              SizedBox(height: 25),
                            ],
                          ),
                        ),



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
                                onPressed: ()  {
                                  try {
                                    pageData2 = {
                                      'Inclinação assento e encosto': inclinacao[inclinacaoValue],
                                      'Suspensão' : simNao[suspensaoValue],
                                      'Cambagem': simNao[cambagemValue],
                                      'Ajuste de centro de gravidade': simNao[ajusteValue],
                                      'Freios': freios[freioValue],
                                      'Rodas Dianteiras': {
                                        'Tipo de pneu': tipoPneu[tipoPneuDianValue],
                                        'Tamanho': tamanhoPneuDian[tamPneuDianValue],
                                        'Quick release': simNao[quickDianValue]
                                      },
                                      'Rodas Traseiras': {
                                        'Tipo de pneu': tipoPneuTrasValue == 2 ? 'Anti furo': tipoPneu[tipoPneuTrasValue],
                                        'Tamanho': tamanhoPneuTras[tamPneuTrasValue],
                                        'Quick release': simNao[quickTrasValue],
                                        'Aros de Impulso': aros[arosValue],
                                      },
                                    };
                                    Navigator.push(
                                      context,
                                      SlideRightRoute4(widget: Prescricao4(
                                          typeUser: widget.typeUser,
                                          uid: widget.uid,
                                        pageData: widget.pageData,
                                        pageData1: widget.pageData1,
                                        pageData2: pageData2,
                                      )),
                                    );
                                  } catch (e){
                                    if (e.toString() == 'Invalid argument(s)')
                                      errorTest();
                                  }
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
              },
            ),
          ),
        ),
      ),
    );
  }
  void errorTest(){
    setState(() {
      if (inclinacaoValue == null)
        errorBox[0] = true;
      if (suspensaoValue == null)
        errorBox[1] = true;
      if (cambagemValue == null)
        errorBox[2] = true;
      if (ajusteValue == null)
        errorBox[3] = true;
      if (freioValue == null)
        errorBox[4] = true;
      if (tipoPneuDianValue == null)
        errorBox[5] = true;
      if (tamPneuDianValue == null)
        errorBox[6] = true;
      if (quickDianValue == null)
        errorBox[7] = true;
      if (tipoPneuTrasValue == null)
        errorBox[8] = true;
      if (tamPneuTrasValue == null)
        errorBox[9] = true;
      if (quickTrasValue == null)
        errorBox[10] = true;
      if (arosValue == null)
        errorBox[11] = true;
    });
  }
}


