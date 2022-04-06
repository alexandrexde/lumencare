import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/screens/home/prescricao_form/prescricao5.dart';
import 'package:lumen/services/database.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';


class Prescricao4 extends StatefulWidget {

  final typeUser;
  final Map<String, dynamic> pageData, pageData1, pageData2;
  final String uid;
  Prescricao4({this.typeUser, this.uid, this.pageData1, this.pageData, this.pageData2});

  @override
  _Prescricao4State createState() => _Prescricao4State();
}

class _Prescricao4State extends State<Prescricao4> {
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  String error = '', descMesa = '', descJoy = '', descModelo = '', outrosEqpStr = '';
  List<Map<String, String>> eqpRespiratorio = <Map<String, String>>[];
  Map<String, String> ventilador = {}, aspirador = {}, umidificador = {}, concentrador = {}, bala = {}, nobreak = {}, outro = {}, possuiUlcera = {};
  int mesaValue, tipoPersoMesaValue, acolchoadaValue, emborrachadaValue, bordaValue, encaixaValue, formatoValue,
  protetorRaioValue, protetorQuadroValue, barraValue, joyValue, suporteValue,suporteEqpValue, barraAjustavelValue;
  List<String> tipoPersoMesa = [], simNao = ['Sim','Não'], formato, joy = ['Joystick mão direita', 'Joystick mão esquerda', 'Joystick alternativo'];
  String pVentilador = '', xVentilador = '', yVentilador = '', zVentilador = '';
  String pAspirador = '', xAspirador = '', yAspirador = '', zAspirador = '';
  String pUmidificador = '', xUmidificador = '', yUmidificador = '', zUmidificador = '';
  String pConcentrador = '', xConcentrador = '', yConcentrador = '', zConcentrador = '';
  String pBala = '', xBala = '', yBala = '', zBala = '';
  String pNoBreak = '', xNoBreak = '', yNoBreak = '', zNoBreak = '';
  String pOutro = '', xOutro = '', yOutro = '', zOutro = '';
  List<bool> eqpResp = [false,false,false,false,false,false,false];
  List<bool> errorBox = [false, false, false, false, false, false, false, false, false, false, false, false];
  bool outraMesa = false, right = false, left = false;
  Map<String, dynamic> pageData3 = new Map<String, dynamic>();

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

    return
    Scaffold(
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
                  User userr = _auth.currentUser;
                  return Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                              TextForm(text: 'Mesa *'),
                              Column(
                                children: [
                                  ACustomRadio(
                                    namedButton: 'Original',
                                    onAnswer: (value) {
                                      setState(() {
                                        mesaValue = value;
                                        errorBox[0] = false;
                                      });
                                    },
                                    groupValue: mesaValue,
                                    index: 0,
                                  ),
                                  if (mesaValue == 0)
                                    Container(
                                      padding: EdgeInsets.only(left: 23, right: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomCheckbox(
                                            textBox: 'Outras mesas',
                                            onAnswer: (value) {
                                              setState(() {
                                                outraMesa = value;
                                              });
                                            },
                                          ),
                                          if (outraMesa)
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(height: 5.0),
                                                TextForm(text: 'Descreva'),
                                                CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => descMesa = val);},),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  if (userr.uid == widget.uid)
                                    Column(
                                      children: [
                                        ACustomRadio(
                                          namedButton: 'Personalizado',
                                          onAnswer: (value) {
                                            setState(() {
                                              mesaValue = value;
                                              errorBox[0] = false;
                                            });},
                                          groupValue: mesaValue,
                                          index: 1,
                                        ),
                                        if (mesaValue == 1)
                                          Container(
                                            padding: EdgeInsets.only(left: 23, right: 5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SingleCustomRadio(namedButton: tipoPersoMesa = ['Fórmica', 'Acrílico', 'Outra'],
                                                  onAnswer: (value){ setState(() {tipoPersoMesaValue = value;});},),
                                                SizedBox(height: 5),
                                                if (tipoPersoMesaValue == 2)
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      SizedBox(height: 5.0),
                                                      TextForm(text: 'Descreva'),
                                                      CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => descMesa = val);},),
                                                      SizedBox(height: 25),
                                                    ],
                                                  ),

                                                TextForm(text: 'Acolchoada'),
                                                SizedBox(height: 10),
                                                SingleCustomRadio(namedButton: simNao,
                                                  onAnswer: (value){ setState(() {acolchoadaValue = value;});},),
                                                SizedBox(height: 25),

                                                TextForm(text: 'Emborrachada'),
                                                SizedBox(height: 10),
                                                SingleCustomRadio(namedButton: simNao,
                                                  onAnswer: (value){ setState(() {emborrachadaValue = value;});},),
                                                SizedBox(height: 25),

                                                TextForm(text: 'Borda'),
                                                SizedBox(height: 10),
                                                SingleCustomRadio(namedButton: simNao,
                                                  onAnswer: (value){ setState(() {bordaValue = value;});},),
                                                SizedBox(height: 25),

                                                TextForm(text: 'Encaixe para Joystick'),
                                                SizedBox(height: 10),
                                                SingleCustomRadio(namedButton: simNao,
                                                  onAnswer: (value){ setState(() {encaixaValue = value;});},),
                                                SizedBox(height: 25),

                                                TextForm(text: 'Formato'),
                                                SizedBox(height: 10),
                                                SingleCustomRadio(namedButton: formato = ['Quadrada', 'Redonda'],
                                                  onAnswer: (value){ setState(() {formatoValue = value;});},),
                                                SizedBox(height: 25),
                                              ],
                                            ),
                                          ),
                                      ],
                                    )
                                  else
                                    Tooltip(
                                      message: "Essa opção não está disponível no momento",
                                      // ignore: missing_required_param
                                      child: RadioListTile<int>(
                                        title: new Text(
                                          'Personalizado',
                                          style: TextStyle(color: Colors.black54, fontSize: 16),
                                        ),
                                        value: 1,
                                        toggleable: false,
                                        activeColor: Color(0xFF6848AE),
                                      ),
                                    ),
                                  SizedBox(height: 25),
                                ],
                              ),
                            ],
                          ),
                        ),

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
                              TextForm(text: 'Roda anti-tombo *'),
                              CustomCheckbox(
                                textBox: 'Direita',
                                onAnswer: (value) {
                                  setState(() {
                                    right = value;
                                    errorBox[1] = false;
                                  });
                                },
                              ),
                              CustomCheckbox(
                                textBox: 'Esquerda',
                                onAnswer: (value) {
                                  setState(() {
                                    left = value;
                                    errorBox[1] = false;
                                  });
                                },
                              ),
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
                              TextForm(text: 'Protetor de raios *'),
                              SingleCustomRadio(namedButton: simNao,
                                onAnswer: (value){ setState(() {protetorRaioValue = value;errorBox[2] = false;});},),
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
                              TextForm(text: 'Protetor de quadro *'),
                              SingleCustomRadio(namedButton: simNao,
                                onAnswer: (value){ setState(() {protetorQuadroValue = value;errorBox[3] = false;});},),
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
                              TextForm(text: 'Barra para condutor *'),
                              SingleCustomRadio(namedButton: ['Original'],
                                onAnswer: (value){ setState(() {barraValue = value;errorBox[4] = false;});},),
                              if (barraValue == 0)
                                Container(
                                  padding: EdgeInsets.only(left: 23, right: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5.0),
                                      TextForm(text: 'Ajustável em altura'),
                                      SingleCustomRadio(namedButton: simNao,
                                        onAnswer: (value){ setState(() {barraAjustavelValue = value;});},),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),

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
                              TextForm(text: 'Suporte de soro *'),
                              SingleCustomRadio(namedButton: simNao,
                                onAnswer: (value){ setState(() {suporteValue = value;errorBox[5] = false;});},),
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
                              TextForm(text: 'Joystick *'),
                              SingleCustomRadio(namedButton: joy ,
                                onAnswer: (value){ setState(() {joyValue = value;errorBox[6] = false;});},),
                              if(joyValue == 2)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 5.0),
                                    TextForm(text: 'Descreva'),
                                    CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => descJoy = val);},),
                                  ],
                                ),
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
                              TextForm(text: 'Suporte para equipamentos respiratórios *'),
                              Column(
                                children: [
                                  ACustomRadio(
                                    namedButton: 'Original',
                                    onAnswer: (value) {
                                      setState(() {
                                        suporteEqpValue = value;
                                        errorBox[7] = false;
                                      });
                                    },
                                    groupValue: suporteEqpValue,
                                    index: 0,
                                  ),
                                  if (suporteEqpValue == 0)
                                    Container(
                                      padding: EdgeInsets.only(left: 23, right: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5.0),
                                          TextForm(text: 'Modelo/marca'),
                                          CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => descModelo = val);},),
                                        ],
                                      ),
                                    ),
                                  if (userr.uid == widget.uid)
                                    Column(
                                      children: [
                                        ACustomRadio(
                                          namedButton: 'Personalizado',
                                          onAnswer: (value) {
                                            setState(() {
                                              suporteEqpValue = value;
                                              errorBox[7] = false;
                                            });},
                                          groupValue: suporteEqpValue,
                                          index: 1,
                                        ),
                                        if (suporteEqpValue == 1)
                                          Container(
                                            padding: EdgeInsets.only(left: 23, right: 5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                //Equipamentos respiratórios
                                                TextForm(text: 'Equipamentos respiratórios'),
                                                CustomCheckbox(textBox: 'Ventilador', onAnswer: (val){setState(() {eqpResp[0] = val;}); },),
                                                if(eqpResp[0])
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      SizedBox(height: 10.0),
                                                      TextForm(text: 'Dimensões do equipamento'),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Largura:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a largura',
                                                        onChanged: (val) {
                                                          setState(() => xVentilador = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Altura:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a altura',
                                                        onChanged: (val) {
                                                          setState(() => yVentilador = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Comprimento:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a comprimento',
                                                        onChanged: (val) {
                                                          setState(() => zVentilador = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Peso:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva o peso',
                                                        onChanged: (val) {
                                                          setState(() => pVentilador = val);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                CustomCheckbox(textBox: 'Aspirador ', onAnswer: (val){setState(() {eqpResp[1] = val;}); },),
                                                if(eqpResp[1] )
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      SizedBox(height: 10.0),
                                                      TextForm(text: 'Dimensões do equipamento'),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Largura:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a largura',
                                                        onChanged: (val) {
                                                          setState(() => xAspirador = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Altura:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a altura',
                                                        onChanged: (val) {
                                                          setState(() => yAspirador = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Comprimento:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a comprimento',
                                                        onChanged: (val) {
                                                          setState(() => zAspirador = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Peso:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva o peso',
                                                        onChanged: (val) {
                                                          setState(() => pAspirador = val);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                CustomCheckbox(textBox: 'Umidificador', onAnswer: (val){setState(() { eqpResp[2] = val;}); },),
                                                if(eqpResp[2] )
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      SizedBox(height: 10.0),
                                                      TextForm(text: 'Dimensões do equipamento'),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Largura:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a largura',
                                                        onChanged: (val) {
                                                          setState(() => xUmidificador = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Altura:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a altura',
                                                        onChanged: (val) {
                                                          setState(() => yUmidificador = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Comprimento:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a comprimento',
                                                        onChanged: (val) {
                                                          setState(() => zUmidificador = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Peso:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva o peso',
                                                        onChanged: (val) {
                                                          setState(() => pUmidificador = val);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                CustomCheckbox(textBox: 'Concentrador de O2', onAnswer: (val){setState(() { eqpResp[3]= val;}); },),
                                                if(eqpResp[3] )
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      SizedBox(height: 10.0),
                                                      TextForm(text: 'Dimensões do equipamento'),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Largura:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a largura',
                                                        onChanged: (val) {
                                                          setState(() => xConcentrador = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Altura:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a altura',
                                                        onChanged: (val) {
                                                          setState(() => yConcentrador = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Comprimento:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a comprimento',
                                                        onChanged: (val) {
                                                          setState(() => zConcentrador = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Peso:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva o peso',
                                                        onChanged: (val) {
                                                          setState(() => pConcentrador = val);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                CustomCheckbox(textBox: 'Bala de O2', onAnswer: (val){setState(() { eqpResp[4] = val;}); },),
                                                if(eqpResp[4] )
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      SizedBox(height: 10.0),
                                                      TextForm(text: 'Dimensões do equipamento'),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Largura:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a largura',
                                                        onChanged: (val) {
                                                          setState(() => xBala = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Altura:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a altura',
                                                        onChanged: (val) {
                                                          setState(() => yBala = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Comprimento:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a comprimento',
                                                        onChanged: (val) {
                                                          setState(() => zBala = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Peso:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva o peso',
                                                        onChanged: (val) {
                                                          setState(() => pBala = val);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                CustomCheckbox(textBox: 'No-break', onAnswer: (val){setState(() { eqpResp[5] = val;}); },),
                                                if(eqpResp[5] )
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      SizedBox(height: 10.0),
                                                      TextForm(text: 'Dimensões do equipamento'),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Largura:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a largura',
                                                        onChanged: (val) {
                                                          setState(() => xNoBreak = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Altura:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a altura',
                                                        onChanged: (val) {
                                                          setState(() => yNoBreak = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Comprimento:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a comprimento',
                                                        onChanged: (val) {
                                                          setState(() => zNoBreak = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Peso:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva o peso',
                                                        onChanged: (val) {
                                                          setState(() => pNoBreak = val);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                CustomCheckbox(textBox: 'Outros', onAnswer: (val){setState(() { eqpResp[6] = val;}); },),
                                                if(eqpResp[6])
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      SizedBox(height: 5.0),
                                                      TextForm(text: 'Descreva:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a condição',
                                                        onChanged: (val) {
                                                          setState(() => outrosEqpStr = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 10.0),
                                                      TextForm(text: 'Dimensões do equipamento'),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Largura:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a largura',
                                                        onChanged: (val) {
                                                          setState(() => xOutro = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Altura:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a altura',
                                                        onChanged: (val) {
                                                          setState(() => yOutro = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Comprimento:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva a comprimento',
                                                        onChanged: (val) {
                                                          setState(() => zOutro = val);
                                                        },
                                                      ),
                                                      SizedBox(height: 20.0),
                                                      TextForm(text: 'Peso:'),
                                                      CustomForm(
                                                        obscureText: false,
                                                        hintText: 'Descreva o peso',
                                                        onChanged: (val) {
                                                          setState(() => pOutro = val);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                SizedBox(height: 30.0),
                                              ],
                                            ),
                                          ),
                                      ],
                                    )
                                  else
                                    Tooltip(
                                      message: "Essa opção não está disponível no momento",
                                      // ignore: missing_required_param
                                      child: RadioListTile<int>(
                                        title: new Text(
                                          'Personalizado',
                                          style: TextStyle(color: Colors.black54, fontSize: 16),
                                        ),
                                        value: 1,
                                        toggleable: false,
                                        activeColor: Color(0xFF6848AE),
                                      ),
                                    ),
                                  SizedBox(height: 25),
                                ],
                              ),
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
                                onPressed: () {
                                  pageData3 = {
                                    'Mesa': mesaValue == 0 ? outraMesa ? descMesa : 'Outra Mesa' : 'Personalizado (Manutenção "TODO")',
                                    'Roda anti-tombo': left ? left && right ? 'Direita e Esquerda': 'Esquerda' : 'Direita',
                                    'Protetor de raios':simNao[protetorRaioValue],
                                    'Protetor de quadro': simNao[protetorQuadroValue],
                                    'Barra para condutor': {
                                      'Ajustável em altura': simNao[barraAjustavelValue]
                                    },
                                    'Suporte de soro':simNao[suporteValue],
                                    'Joystick': joyValue == 2 ? descJoy : joy[joyValue],
                                    'Suporte para equipamentos respiratórios': equipamentoRespiratorio(),
                                  };
                                  try {
                                    Navigator.push(
                                      context,
                                      SlideRightRoute4(widget: Prescricao5(
                                          typeUser: widget.typeUser,
                                          uid: widget.uid,
                                        pageData2: widget.pageData2,
                                        pageData1: widget.pageData1,
                                        pageData: widget.pageData,
                                        pageData3: pageData3,
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
      if (outraMesa == false)
        errorBox[0] = true;
      if (right == false && left == false)
        errorBox[1] = true;
      if (protetorRaioValue == null)
        errorBox[2] = true;
      if (protetorQuadroValue == null)
        errorBox[3] = true;
      if (barraValue == null)
        errorBox[4] = true;
      if (suporteValue == null)
        errorBox[5] = true;
      if (joyValue == null)
        errorBox[6] = true;
      if (suporteEqpValue == null)
        errorBox[7] = true;
    });
  }
  equipamentoRespiratorio(){
    if(eqpResp[0]) {
      ventilador =
      {
        'Ventilador': 'Ventilador',
        'Largura' : xVentilador,
        'Altura' : yVentilador,
        'Comprimento': zVentilador,
        'Peso': pVentilador
      };
      eqpRespiratorio.add(ventilador);
    }
    if(eqpResp[1]) {
      aspirador =
      {
        'Aspirador': 'Aspirador',
        'Largura' : xAspirador,
        'Altura' : yAspirador,
        'Comprimento': zAspirador,
        'Peso': pAspirador
      };
      eqpRespiratorio.add(aspirador);
    }
    if(eqpResp[2]) {
      umidificador =
      {
        'Umidificador': 'Umidificador',
        'Largura' : xUmidificador,
        'Altura' : yUmidificador,
        'Comprimento': zUmidificador,
        'Peso': pUmidificador
      };
      eqpRespiratorio.add(umidificador);
    }
    if(eqpResp[3]) {
      concentrador =
      {
        'Concentrador de O2': 'Concentrador de O2',
        'Largura' : xConcentrador,
        'Altura' : yConcentrador,
        'Comprimento': zConcentrador,
        'Peso': pConcentrador
      };
      eqpRespiratorio.add(concentrador);
    }
    if(eqpResp[4]) {
      bala =
      {
        'Bala de O2': 'Bala de O2',
        'Largura' : xBala,
        'Altura' : yBala,
        'Comprimento': zBala,
        'Peso': pBala
      };
      eqpRespiratorio.add(bala);
    }
    if(eqpResp[5]) {
      nobreak =
      {
        'No-Break': 'No-Break',
        'Largura' : xNoBreak,
        'Altura' : yNoBreak,
        'Comprimento': zNoBreak,
        'Peso': pNoBreak
      };
      eqpRespiratorio.add(nobreak);
    }
    if(eqpResp[6]) {
      outro =
      {
        'Outros': 'Outros',
        'Largura' : xOutro,
        'Altura' : yOutro,
        'Comprimento': zOutro,
        'Peso': pOutro
      };
      eqpRespiratorio.add(outro);
    }
  }
}


