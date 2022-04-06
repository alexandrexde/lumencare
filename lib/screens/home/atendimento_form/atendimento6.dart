import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/shared/loading.dart';
import 'atendimento5.dart';
import 'atendimento7.dart';


// ignore: must_be_immutable
class Atendimento6 extends StatefulWidget {
  final String estadoMatrimonial, grauEscolaridade, ocupacao, diagAttendance, queixaPrincipal, historicoAtual, qualCirurgia, medicacao, descAmput, processoDoenca,
      descAssento, descLocal, distanciaPercorrida, horaUtilizada,  comoSenta, descBanheiro, descSenta, usaTransporte, descReside, tipoResidencia, tipoEntrada, acessibilidadeBanheiro,
      acessibilidadeArea, acessibilidadePorta, atendeNecessidadeStr, atendeCondicoesStr, seguraStr, ofereceAlivioStr, adequadaStr;
  final Map<String, bool>  qualBanheiro, motivoAvaliacao, usoCadeira, qualAssento, quaisTransporte;
  final Function toggleView;
  Atendimento6({this.toggleView, this.estadoMatrimonial, this.grauEscolaridade, this.ocupacao, this.diagAttendance, this.queixaPrincipal, this.historicoAtual, this.qualCirurgia, this.medicacao, this.descAmput, this.processoDoenca, this.motivoAvaliacao,
    this.usoCadeira, this.descLocal, this.descAssento, this.distanciaPercorrida, this.horaUtilizada, this.qualAssento, this.qualBanheiro, this.comoSenta, this.descBanheiro, this.acessibilidadePorta, this.acessibilidadeArea, this.acessibilidadeBanheiro, this.tipoEntrada, this.tipoResidencia,
    this.descReside, this.quaisTransporte, this.descSenta, this.usaTransporte, this.atendeNecessidadeStr, this.atendeCondicoesStr, this.seguraStr, this.adequadaStr, this.ofereceAlivioStr});


  @override
  _Atendimento6State createState() => _Atendimento6State();

}

class _Atendimento6State extends State<Atendimento6> {

  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  List<String> lateralidadeManual  = ['Direita','Esquerda','N/A','Outros'],
      condicaoVisual  = <String>['', '', '', '', '', '', ''],
      condicaoVisual2  =  ['Direita', 'Esquerda'],
      condicaoAuditiva = <String>['', '', '', '', '',],
      condicaoAuditiva2  = ['Ouvido direito', 'Ouvido esquerdo', 'Bilateral'],
      alteracao = ['Normal','Alteração leve','Alteração moderada','Alteração severa'];
  String lateralidadeStr, condicaoVisualStr, condicaoAuditivaStr, condicaoCognitivaStr, expressaoStr, recepcaoStr;
  int lateralidadeValue, condicaoVisualValue, condicaoVisualValue2 = 0, condicaoAuditivaValue, condicaoAuditivaValueAlt = 0 , condicaoAuditivaValuePerd = 0,
      condicaoCognitivaValue, expressaoValue, recepcaoValue;
  List<bool> errorBox = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        //systemNavigationBarColor: Color(0xFF6848AE),
        //systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return loading
        ? Loading()
        : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(title: 'Atendimento',),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 50.0,
          ),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Avaliação física (Funcional / Sensorial)', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                SizedBox(height: 30.0),


                //Lateralidade manual
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
                      TextForm(text: 'Lateralidade manual *'),
                      SingleCustomRadio(
                        namedButton: lateralidadeManual ,
                        onAnswer: (value) {
                          setState(() {
                            lateralidadeValue = value;
                            errorBox[0] = false;
                          });
                        },
                      ),
                      if(lateralidadeValue == 3)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            TextForm(text: 'Descreva:'),
                            CustomForm(
                              obscureText: false,
                              hintText: 'Descreva a lateralidade',
                              onChanged: (val) {
                                setState(() => lateralidadeStr = val);
                              },
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                // //Condição visual
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
                      TextForm(text: 'Condição visual *'),
                      RadioListTile<int>(
                        title: new Text(
                          condicaoVisual[0] = 'Normal',
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        value: -1,
                        groupValue: condicaoVisualValue,
                        onChanged: (int value) {setState(() {condicaoVisualValue = value; errorBox[1] = false;});},
                        activeColor: Color(0xFF6848AE),
                      ),
                      RadioListTile<int>(
                        title: new Text(
                          condicaoVisual[1] ='Funcional',
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        value: 1,
                        groupValue: condicaoVisualValue,
                        onChanged: (int value) {setState(() {condicaoVisualValue = value;errorBox[1] = false;});},
                        activeColor: Color(0xFF6848AE),
                      ),
                      RadioListTile<int>(
                        title: new Text(
                          condicaoVisual[2] ='Alterada',
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        value: 2,
                        groupValue: condicaoVisualValue,
                        onChanged: (int value) {setState(() {condicaoVisualValue = value;errorBox[1] = false;});},
                        activeColor: Color(0xFF6848AE),
                      ),
                      RadioListTile<int>(
                        title: new Text(
                          condicaoVisual[3] ='Visão subnormal',
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        value: 3,
                        groupValue: condicaoVisualValue,
                        onChanged: (int value) {setState(() {condicaoVisualValue = value;errorBox[1] = false;});},
                        activeColor: Color(0xFF6848AE),
                      ),
                      RadioListTile<int>(
                        title: new Text(
                          condicaoVisual[4] ='Cegueira',
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        value: 4,
                        groupValue: condicaoVisualValue,
                        onChanged: (int value) {setState(() {condicaoVisualValue = value;errorBox[1] = false;});},
                        activeColor: Color(0xFF6848AE),
                      ),
                      RadioListTile<int>(
                        title: new Text(
                          condicaoVisual[5] ='Heminopsia',
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        value: 5,
                        groupValue: condicaoVisualValue,
                        onChanged: (int value) {setState(() {condicaoVisualValue = value;errorBox[1] = false;});},
                        activeColor: Color(0xFF6848AE),
                      ),
                      if (condicaoVisualValue == 5)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 23, right: 5),
                              child: SingleCustomRadio(namedButton:condicaoVisual2,
                                onAnswer:(value) { setState(() {condicaoVisualValue2 = value;});},),
                            ),
                          ],
                        ),
                      RadioListTile<int>(
                        title: new Text(
                          condicaoVisual[6] ='Outros',
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        value: 6,
                        groupValue: condicaoVisualValue,
                        onChanged: (int value) {setState(() {condicaoVisualValue = value;errorBox[1] = false;});},
                        activeColor: Color(0xFF6848AE),
                      ),
                      if(condicaoVisualValue == 6)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            TextForm(text: 'Descreva:'),
                            CustomForm(
                              obscureText: false,
                              hintText: 'Descreva a codição',
                              onChanged: (val) {
                                setState(() => condicaoVisualStr = val);
                              },
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Condição auditiva
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
                      TextForm(text: 'Condição auditiva *'),
                      RadioListTile<int>(
                        title: new Text(
                          condicaoAuditiva[0] = 'Normal',
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        value: -1,
                        groupValue: condicaoAuditivaValue,
                        onChanged: (int value) {setState(() {condicaoAuditivaValue = value;errorBox[2] = false;});},
                        activeColor: Color(0xFF6848AE),
                      ),
                      RadioListTile<int>(
                        title: new Text(
                          condicaoAuditiva[1] = 'Alterada',
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        value: 1,
                        groupValue: condicaoAuditivaValue,
                        onChanged: (int value) {setState(() {condicaoAuditivaValue = value;errorBox[2] = false;});},
                        activeColor: Color(0xFF6848AE),
                      ),
                      if (condicaoAuditivaValue == 1)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 23, right: 5),
                              child: SingleCustomRadio(namedButton: condicaoAuditiva2,
                                onAnswer:(value) { setState(() {condicaoAuditivaValueAlt = value;});},),
                            ),
                          ],
                        ),
                      RadioListTile<int>(
                        title: new Text(
                          condicaoAuditiva[2] ='Perda severa',
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        value: 2,
                        groupValue: condicaoAuditivaValue,
                        onChanged: (int value) {setState(() {condicaoAuditivaValue = value;errorBox[2] = false;});},
                        activeColor: Color(0xFF6848AE),
                      ),
                      if (condicaoAuditivaValue == 2)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 23, right: 5),
                              child: SingleCustomRadio(namedButton: ['Ouvido direito', 'Ouvido esquerdo', 'Bilateral'],
                                onAnswer:(value) { setState(() {condicaoAuditivaValuePerd = value;});},),
                            ),
                          ],
                        ),
                      RadioListTile<int>(
                        title: new Text(
                          condicaoAuditiva[3] ='Surdez',
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        value: 3,
                        groupValue: condicaoAuditivaValue,
                        onChanged: (int value) {setState(() {condicaoAuditivaValue = value;errorBox[2] = false;});},
                        activeColor: Color(0xFF6848AE),
                      ),
                      RadioListTile<int>(
                        title: new Text(
                          condicaoAuditiva[4] ='Outros',
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        value: 4,
                        groupValue: condicaoAuditivaValue,

                        onChanged: (int value) {setState(() {condicaoAuditivaValue = value;errorBox[2] = false;});},
                        activeColor: Color(0xFF6848AE),
                      ),
                      if(condicaoAuditivaValue == 4)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            TextForm(text: 'Descreva:'),
                            CustomForm(
                              obscureText: false,
                              hintText: 'Descreva a codição',
                              onChanged: (val) {
                                setState(() => condicaoAuditivaStr = val);
                              },
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Condição cognitiva
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
                      TextForm(text: 'Condição cognitiva *'),
                      SingleCustomRadio(
                        namedButton: alteracao ,
                        onAnswer: (value) {
                          setState(() {
                            condicaoCognitivaValue = value;
                            errorBox[3] = false;
                          });
                        },
                      ),
                      if(condicaoCognitivaValue != 0 && condicaoCognitivaValue != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            TextForm(text: 'Descreva:'),
                            CustomForm(
                              obscureText: false,
                              hintText: 'Descreva a codição',
                              onChanged: (val) {
                                setState(() => condicaoCognitivaStr = val);
                              },
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Condição de linguagem
                Text('Condição de linguagem',style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 30.0),

                //Expressão
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
                      TextForm(text: 'Expressão *'),
                      SingleCustomRadio(
                        namedButton: alteracao,
                        onAnswer: (value) {
                          setState(() {
                            expressaoValue = value;
                            errorBox[4] = false;
                          });
                        },
                      ),
                      if(expressaoValue != 0 && expressaoValue != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            TextForm(text: 'Descreva:'),
                            CustomForm(
                              obscureText: false,
                              hintText: 'Descreva a expressão',
                              onChanged: (val) {
                                setState(() => expressaoStr = val);
                              },
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Recepção
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
                      TextForm(text: 'Recepção *'),
                      SingleCustomRadio(
                        namedButton: alteracao,
                        onAnswer: (value) {
                          setState(() {
                            recepcaoValue = value;
                            errorBox[5] = false;
                          });
                        },
                      ),
                      if(recepcaoValue != 0 && recepcaoValue != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            TextForm(text: 'Descreva:'),
                            CustomForm(
                              obscureText: false,
                              hintText: 'Descreva a expressão',
                              onChanged: (val) {
                                setState(() => recepcaoStr = val);
                              },
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

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
                              SlideRightRoute(widget: Atendimento5())
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
                                SlideRightRoute(widget: Atendimento7(
                                  estadoMatrimonial: widget.estadoMatrimonial,
                                  grauEscolaridade: widget.grauEscolaridade,
                                  ocupacao: widget.ocupacao,
                                  diagAttendance: widget.diagAttendance,
                                  queixaPrincipal: widget.queixaPrincipal,
                                  historicoAtual: widget.historicoAtual,
                                  qualCirurgia: widget.qualCirurgia,
                                  medicacao: widget.medicacao,
                                  descAmput: widget.descAmput,
                                  processoDoenca: widget.processoDoenca,
                                  motivoAvaliacao: widget.motivoAvaliacao,
                                  usoCadeira: widget.usoCadeira,
                                  distanciaPercorrida: widget.distanciaPercorrida,
                                  horaUtilizada: widget.horaUtilizada,
                                  qualAssento: widget.qualAssento,
                                  descAssento: widget.descAssento,

                                  comoSenta: widget.comoSenta,
                                  qualBanheiro: widget.qualBanheiro,
                                  descBanheiro: widget.descBanheiro,
                                  descSenta: widget.descSenta,
                                  usaTransporte: widget.usaTransporte,
                                  quaisTransporte: widget.quaisTransporte,
                                  descReside: widget.descReside,
                                  tipoResidencia: widget.tipoResidencia,
                                  tipoEntrada: widget.tipoEntrada,
                                  acessibilidadeBanheiro: widget.acessibilidadeBanheiro,
                                  acessibilidadeArea: widget.acessibilidadeArea,
                                  acessibilidadePorta: widget.acessibilidadePorta,
                                  atendeNecessidadeStr: widget.atendeNecessidadeStr,
                                  atendeCondicoesStr: widget.atendeCondicoesStr,
                                  seguraStr: widget.seguraStr,
                                  adequadaStr: widget.adequadaStr,
                                  ofereceAlivioStr: widget.ofereceAlivioStr,
                                  lateralidadeManual: lateralidadeValue == 3 ? lateralidadeStr : lateralidadeManual[lateralidadeValue],
                                  condicaoVisual: condicaoVisualValue == 5 ? 'Heminopsia ' + condicaoVisual2[condicaoVisualValue2] : condicaoVisualValue == 6 ? condicaoVisualStr : condicaoVisual[condicaoVisualValue],
                                  condicaoAuditiva: condicaoAuditivaValue == 1 ? condicaoAuditiva[condicaoAuditivaValue] + condicaoAuditiva2[condicaoAuditivaValueAlt] : condicaoAuditivaValue == 2 ? condicaoAuditiva[condicaoAuditivaValue] + condicaoAuditiva2[condicaoAuditivaValuePerd] : condicaoAuditivaValue == 4 ?condicaoAuditivaStr : condicaoAuditiva[condicaoAuditivaValue],
                                  condicaoCognitiva: condicaoCognitivaValue != 0 ? condicaoCognitivaStr : alteracao[condicaoCognitivaValue],
                                  expressao: expressaoValue != 0 ? expressaoStr : alteracao[expressaoValue],
                                  recepcao: recepcaoValue != 0 ? recepcaoStr : alteracao[recepcaoValue],
                                ))
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
          ),
        ),
      ),
    );
  }

  void errorTest(){
    setState(() {
      if (lateralidadeValue == null)
        errorBox[0] = true;
      if (condicaoVisualValue == null)
        errorBox[1] = true;
      if (condicaoAuditivaValue == null)
        errorBox[2] = true;
      if (condicaoCognitivaValue == null)
        errorBox[3] = true;
      if (expressaoValue == null)
        errorBox[4] = true;
      if (recepcaoValue == null)
        errorBox[5] = true;
    });
  }
}
