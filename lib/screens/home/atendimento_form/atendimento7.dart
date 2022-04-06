import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/shared/loading.dart';

import 'atendimento5.dart';
import 'atendimento8.dart';

class Atendimento7 extends StatefulWidget {
  final String estadoMatrimonial, grauEscolaridade, ocupacao, diagAttendance, queixaPrincipal, historicoAtual, qualCirurgia, medicacao, descAmput, processoDoenca,
      descAssento, descLocal, distanciaPercorrida, horaUtilizada,  comoSenta, descBanheiro, descSenta, usaTransporte, descReside, tipoResidencia, tipoEntrada, acessibilidadeBanheiro,
      acessibilidadeArea, acessibilidadePorta, atendeNecessidadeStr, atendeCondicoesStr, seguraStr, ofereceAlivioStr, adequadaStr, lateralidadeManual, condicaoVisual, condicaoAuditiva, condicaoCognitiva, expressao, recepcao;
  final Map<String, bool>  qualBanheiro, motivoAvaliacao, usoCadeira, qualAssento, quaisTransporte;
  final Function toggleView;
  Atendimento7({this.toggleView, this.estadoMatrimonial, this.grauEscolaridade, this.ocupacao, this.diagAttendance, this.queixaPrincipal, this.historicoAtual, this.qualCirurgia, this.medicacao, this.descAmput, this.processoDoenca, this.motivoAvaliacao,
    this.usoCadeira, this.descLocal, this.descAssento, this.distanciaPercorrida, this.horaUtilizada, this.qualAssento, this.qualBanheiro, this.comoSenta, this.descBanheiro, this.acessibilidadePorta, this.acessibilidadeArea, this.acessibilidadeBanheiro, this.tipoEntrada, this.tipoResidencia, this.descReside,
    this.quaisTransporte, this.descSenta, this.usaTransporte, this.atendeNecessidadeStr, this.atendeCondicoesStr, this.seguraStr, this.adequadaStr, this.ofereceAlivioStr, this.condicaoAuditiva, this.condicaoCognitiva, this.condicaoVisual, this.expressao,
  this.lateralidadeManual, this.recepcao});

  @override
  _Atendimento7State createState() => _Atendimento7State();

}

class _Atendimento7State extends State<Atendimento7> {

  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  List<String> sistemaSuplementar = <String>[], modelo = <String>[''], condicaoPsico = <String>[''], feridaDuracao= <String>[''];
  List<Map<String, String>> eqpRespiratorio = <Map<String, String>>[], ulcera = <Map<String, String>>[];
  Map<String, String> ventilador = {}, aspirador = {}, umidificador = {}, concentrador = {}, bala = {}, nobreak = {}, outro = {}, possuiUlcera = {};
  Map<String, bool> condicaoResp = <String, bool>{};
  int sistValue, modeloValue = 0, condPsicoValue, condRespValue, feridaPreviaValue, feridaAtualValue, sensibilidadeValue, feridaInstaladaValue = 0, feridaDuracaoValue = 0, correRiscoValue;

  // A ser revisado (temporário)
  String pVentilador = '', xVentilador = '', yVentilador = '', zVentilador = '';
  String pAspirador = '', xAspirador = '', yAspirador = '', zAspirador = '';
  String pUmidificador = '', xUmidificador = '', yUmidificador = '', zUmidificador = '';
  String pConcentrador = '', xConcentrador = '', yConcentrador = '', zConcentrador = '';
  String pBala = '', xBala = '', yBala = '', zBala = '';
  String pNoBreak = '', xNoBreak = '', yNoBreak = '', zNoBreak = '';
  String pOutro = '', xOutro = '', yOutro = '', zOutro = '';
  List<bool> eqpResp = [false,false,false,false,false,false,false];
  // A ser revisado (temporário)

  String pqCorreRiscoStr, modeloStr = '', tipoStr = ' ', fabricanteStr = ' ', condPsicoStr, condRespStr, condSeveraStr, outrosEqpStr, causaFeridaStr, localFeridaStr;
  bool condNormal = false, condLeve = false, condMod = false, condSevera = false, o2 = false, ventilacaoMec = false, ventilacaoInvasiva = false;
  double _currentSliderValue = 20;
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
                //Sistema de Comunicação Suplmentar ou Alterantiva
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
                      TextForm(text: 'Possui Sistema de Comunicação Suplementar ou Alternativa? *'),
                      SingleCustomRadio(
                        namedButton: ['Sim','Não'],
                        onAnswer: (value) {
                          setState(() {
                            sistValue = value;
                            errorBox[0] = false;
                          });
                        },
                      ),
                      if(sistValue == 0)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 20.0),
                            TextForm(text: 'Tipo:'),
                            CustomForm(
                              obscureText: false,
                              hintText: 'Tipo',
                              onChanged: (val) {
                                setState(() => tipoStr = val);
                                errorBox[0] = false;
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextForm(text: 'Fabricante:'),
                            CustomForm(
                              obscureText: false,
                              hintText: 'Fabricante',
                              onChanged: (val) {
                                setState(() => fabricanteStr = val);
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextForm(text: 'Modelo:'),
                            SingleCustomRadio(namedButton: modelo = ['Funcional', 'Alterado'],
                              onAnswer:(value) { setState(() {modeloValue = value;});},),
                            if(modeloValue == 1)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5.0),
                                  TextForm(text: 'Descreva:'),
                                  CustomForm(
                                    obscureText: false,
                                    hintText: 'Descreva o modelo',
                                    onChanged: (val) {
                                      setState(() => modeloStr = val);
                                    },
                                  )
                                ],
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Condição psicossocial e comportamental:
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
                      TextForm(text: 'Condição psicossocial e comportamental *'),
                      SingleCustomRadio(
                        namedButton: condicaoPsico = ['Normal','Alteração leve','Alteração moderada','Alteração severa'],
                        onAnswer: (value) {
                          setState(() {
                            condPsicoValue = value;
                            errorBox[1] = false;
                          });
                        },
                      ),
                      if(condPsicoValue != 0 && condPsicoValue != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            TextForm(text: 'Descreva:'),
                            CustomForm(
                              obscureText: false,
                              hintText: 'Descreva a condição',
                              onChanged: (val) {
                                setState(() => condPsicoStr = val);
                              },
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Condição respiratória
                TextForm(text: 'Condição respiratória'),
                CustomCheckbox(textBox:  'Normal ', onAnswer: (val){setState(() { condNormal = val;});},),
                CustomCheckbox(textBox: 'Alteração leve', onAnswer: (val){setState(() { condLeve = val;}); },),
                CustomCheckbox(textBox: 'Alteração moderada', onAnswer: (val){setState(() { condMod = val;});  },),
                CustomCheckbox(textBox: 'Alteração severa', onAnswer: (val){setState(() { condSevera = val;}); },),
                if(condSevera)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5.0),
                      TextForm(text: 'Descreva:'),
                      CustomForm(
                        obscureText: false,
                        hintText: 'Descreva a condição',
                        onChanged: (val) {
                          setState(() => condSeveraStr = val);
                        },
                      )
                    ],
                  ),
                CustomCheckbox(textBox: 'O2', onAnswer: (val){setState(() { o2 = val;});  },),
                CustomCheckbox(textBox: 'Ventilação mecânica não invasiva', onAnswer: (val){setState(() { ventilacaoMec = val;}); },),
                CustomCheckbox(textBox: 'Ventilação mecânica invasiva', onAnswer: (val){setState(() { ventilacaoInvasiva = val;}); },),
                SizedBox(height: 30.0),

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

                //Presença de dor
                TextForm(text: 'Presença de dor'),
                SizedBox(height: 15.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoSlider(
                        value: _currentSliderValue,
                        activeColor: changeColor(),
                        thumbColor: changeColor(),
                        min: 0.0,
                        max: 100.0,
                        divisions: 5,
                        onChanged: (value) {
                          setState(() {
                            _currentSliderValue = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Nível de dor: ' + _currentSliderValue.toString(), style: TextStyle(color: Colors.black54),)
                  ],
                ),
                SizedBox(height: 30.0),

                //Presença úlceras/feridas
                Text('Presença, risco ou histórico de úlceras/feridas', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 25.0),

                //sensibilidade
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
                      TextForm(text: 'Tem sensibilidade normal? *'),
                      SingleCustomRadio(
                        namedButton: ['Sim','Não',],
                        onAnswer: (value) {
                          setState(() {
                            sensibilidadeValue = value;
                            errorBox[2] = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //ferida atual
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
                      TextForm(text: 'Úlcera/ferida prévia? *'),
                      SingleCustomRadio(
                        namedButton: ['Sim','Não',],
                        onAnswer: (value) {
                          setState(() {
                            feridaPreviaValue = value;
                            errorBox[3] = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //ferida previa
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
                      TextForm(text: 'Úlcera/ferida atual? *'),
                      SingleCustomRadio(
                        namedButton: ['Sim','Não',],
                        onAnswer: (value) {
                          setState(() {
                            feridaAtualValue = value;
                            errorBox[4] = false;
                          });
                        },
                      ),
                      if (feridaAtualValue == 0)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextForm(text: 'É uma ferida instalada?'),
                            Container(
                              padding: EdgeInsets.only(left: 23, right: 5),
                              child: SingleCustomRadio(namedButton: ['Sim','Não',],
                                onAnswer:(value) { setState(() {feridaInstaladaValue = value;});},),
                            ),
                            SizedBox(height: 30.0),
                            TextForm(text: 'Duração?'),
                            Container(
                              padding: EdgeInsets.only(left: 23, right: 5),
                              child: SingleCustomRadio(namedButton: feridaDuracao = ['Menos de 1 mês','1 mês a 6 meses','Mais de 6 meses'],
                                onAnswer:(value) { setState(() {feridaDuracaoValue = value;});},),
                            ),
                            SizedBox(height: 30.0),
                            TextForm(text: 'Causa'),
                            CustomForm(
                              obscureText: false,
                              hintText: 'Descreva a causa',
                              onChanged: (val) {
                                setState(() => causaFeridaStr = val);
                              },
                            ),
                            SizedBox(height: 30.0),
                            TextForm(text: 'Local da úlcera/ferida'),
                            CustomForm(
                              obscureText: false,
                              hintText: 'Descreva a causa',
                              onChanged: (val) {
                                setState(() => localFeridaStr = val);
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Essa pessoa corre risco* de desenvolver uma úlceras/feridas?
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
                      TextForm(text: 'Essa pessoa corre risco de desenvolver uma úlceras/feridas? *'),
                      SingleCustomRadio(
                        namedButton: ['Sim','Não',],
                        onAnswer: (value) {
                          setState(() {
                            correRiscoValue = value;
                            errorBox[5] = false;
                          });
                        },
                      ),
                      if(correRiscoValue == 0)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            TextForm(text: 'Por quê?'),
                            CustomForm(
                              obscureText: false,
                              hintText: 'Descreva neste campo',
                              onChanged: (val) {
                                setState(() => pqCorreRiscoStr = val);
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
                          sistemaSuplementar.add(tipoStr); sistemaSuplementar.add(fabricanteStr);
                          sistemaSuplementar.add(modeloValue == 1 ? modeloStr : modelo[modeloValue]);
                          condicaoResp = {
                            'Normal' : condNormal,
                            'Alteração leve': condLeve,
                            'Alteração moderada': condMod,
                            'Alteração severa': condSevera,
                            'O2': o2,
                            'Ventilação mecância não invasiva': ventilacaoMec,
                            'Ventilação mecância invasiva': ventilacaoInvasiva,
                          };
                          possuiUlcera = {
                            'É uma ferida instalada?': feridaInstaladaValue == 0 ? 'Sim': 'Não',
                            'Duração': feridaDuracao[feridaDuracaoValue],
                            'Causa': causaFeridaStr,
                            'Local da úlcera/ferida': localFeridaStr,
                          };
                          equipamentoRespiratorio();
                          presencaUlcera();

                            Navigator.push(
                                context,
                                SlideRightRoute(widget: Atendimento8(
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
                                  lateralidadeManual: widget.lateralidadeManual,
                                  condicaoVisual: widget.condicaoVisual,
                                  condicaoAuditiva: widget.condicaoAuditiva,
                                  condicaoCognitiva:  widget.condicaoCognitiva,
                                  expressao:  widget.expressao,
                                  recepcao:  widget.recepcao,
                                  sistemaSuplementar: sistemaSuplementar,
                                  condicaoPsico: condPsicoValue == 3 ? condPsicoStr: condicaoPsico[condPsicoValue],
                                  condicaoResp: condicaoResp,
                                  condSeveraStr: condSeveraStr,
                                  eqpRespiratorio: eqpRespiratorio,
                                  presencaDor: _currentSliderValue.toString(),
                                  ulcera: ulcera,
                                  possuiUlcera: possuiUlcera,
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
      if (sistValue == null)
        errorBox[0] = true;
      if (condPsicoValue == null)
        errorBox[1] = true;
      if (sensibilidadeValue == null)
        errorBox[2] = true;
      if (feridaPreviaValue == null)
        errorBox[3] = true;
      if (feridaAtualValue == null)
        errorBox[4] = true;
      if (correRiscoValue == null)
        errorBox[5] = true;
    });
  }
  changeColor(){
    if(_currentSliderValue > 80) {
      return Colors.red;
    } else if(_currentSliderValue > 60) {
      return Colors.red[300];
    } else if(_currentSliderValue > 40) {
      return Colors.orange;
    } else if(_currentSliderValue > 20) {
      return Colors.green;
    } else if(_currentSliderValue >= 0) {
      return Colors.green[300];
    }
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
  presencaUlcera(){
    ulcera.add(
        {
          'Tem sensibilidade normal?': sensibilidadeValue == 0 ? 'Sim':'Não'
        }
    );
    ulcera.add(
        {
          'Úlcera/ferida prévia?': feridaPreviaValue == 0 ? 'Sim':'Não'
        }
    );
    ulcera.add(
        {
          'Úlcera/ferida atual?': feridaAtualValue == 0 ? 'Sim':'Não'
        }
    );
    ulcera.add(
        {
          'Corre risco de desenvolver úlcera?': correRiscoValue == 0 ? 'Sim':'Não'
        }
    );
  }
}
