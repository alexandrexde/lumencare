import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/shared/loading.dart';
import 'atendimento10.dart';
import 'atendimento8.dart';


// ignore: must_be_immutable
class Atendimento9 extends StatefulWidget {
  final String estadoMatrimonial, grauEscolaridade, ocupacao, diagAttendance, queixaPrincipal, historicoAtual, qualCirurgia, medicacao, descAmput, processoDoenca,
      descAssento, descLocal, distanciaPercorrida, horaUtilizada,  comoSenta, descBanheiro, descSenta, usaTransporte, descReside, tipoResidencia, tipoEntrada, acessibilidadeBanheiro,
      acessibilidadeArea, acessibilidadePorta, atendeNecessidadeStr, atendeCondicoesStr, seguraStr, ofereceAlivioStr, adequadaStr, lateralidadeManual, condicaoVisual, condicaoAuditiva, condicaoCognitiva, expressao, recepcao,
      condicaoPsico, condSeveraStr, presencaDor, alimentacao, vestirse, banho, higiene, controleVesical, controleIntestinal, condMotora, reflexo, deficit;
  final Map<String, bool>  qualBanheiro, motivoAvaliacao, usoCadeira, qualAssento, quaisTransporte, condicaoResp;
  final List<String> sistemaSuplementar;
  final Map<String, String> possuiUlcera;
  final List<Map<String, String>> eqpRespiratorio, ulcera;
  final Function toggleView;
  Atendimento9({this.possuiUlcera, this.deficit, this.toggleView, this.estadoMatrimonial, this.grauEscolaridade, this.ocupacao, this.diagAttendance, this.queixaPrincipal, this.historicoAtual, this.qualCirurgia, this.medicacao, this.descAmput, this.processoDoenca, this.motivoAvaliacao,
    this.usoCadeira, this.descLocal, this.descAssento, this.distanciaPercorrida, this.horaUtilizada, this.qualAssento, this.qualBanheiro, this.comoSenta, this.descBanheiro, this.acessibilidadePorta, this.acessibilidadeArea, this.acessibilidadeBanheiro, this.tipoEntrada, this.tipoResidencia, this.descReside,
    this.quaisTransporte, this.descSenta, this.usaTransporte, this.atendeNecessidadeStr, this.atendeCondicoesStr, this.seguraStr, this.adequadaStr, this.ofereceAlivioStr, this.condicaoAuditiva, this.condicaoCognitiva, this.condicaoVisual, this.expressao,
    this.lateralidadeManual, this.recepcao, this.condicaoResp, this.eqpRespiratorio, this.condSeveraStr, this.condicaoPsico, this.presencaDor, this.sistemaSuplementar, this.ulcera, this.alimentacao, this.banho, this.condMotora, this.controleIntestinal, this.controleVesical, this.higiene, this.reflexo, this.vestirse});

  @override
  _Atendimento9State createState() => _Atendimento9State();

}

class _Atendimento9State extends State<Atendimento9> {

  bool loading = false;
  List<String> tonus = [''];
  Map<String, String> tonusMuscular = <String, String>{};
  int hiperAxialValue, hiperMembSupValue, hiperMembInfValue, hiperCabecaValue, hipoAxialValue, hipoMembSupValue, hipoMembInfValue, hipoCabecaValue,
  ataxiaValue, atetoseValue, tremorValue, rigidezValue, discinesiaValue;
  List<bool> errorBox = [false, false, false, false, false, false, false, false, false, false, false, false, false];
  final _formkey = GlobalKey<FormState>();

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
                Text('Tônus muscular', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 25.0),

                //Hipertonia axial
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
                      TextForm(text: 'Hipertonia axial *'),
                      SingleCustomRadio(
                        namedButton: tonus = ['Ausente ','Moderada', 'Severa'],
                        onAnswer: (value) {
                          setState(() {
                            hiperAxialValue = value;
                            errorBox[0] = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Hipertonia membros superiores
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
                      TextForm(text: 'Hipertonia membros superiores *'),
                      SingleCustomRadio(
                        namedButton: ['Ausente ','Moderada', 'Severa'],
                        onAnswer: (value) {
                          setState(() {
                            hiperMembSupValue = value;
                            errorBox[1] = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Hipertonia membros inferiores
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
                      TextForm(text: 'Hipertonia membros inferiores *'),
                      SingleCustomRadio(
                        namedButton: ['Ausente ','Moderada', 'Severa'],
                        onAnswer: (value) {
                          setState(() {
                            hiperMembInfValue = value;
                            errorBox[2] = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Hipertonia cabeça
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
                      TextForm(text: 'Hipertonia cabeça *'),
                      SingleCustomRadio(
                        namedButton: ['Ausente ','Moderada', 'Severa'],
                        onAnswer: (value) {
                          setState(() {
                            hiperCabecaValue = value;
                            errorBox[3] = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Hipotonia axial
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
                      TextForm(text: 'Hipotonia axial *'),
                      SingleCustomRadio(
                        namedButton: ['Ausente','Moderada', 'Severa'],
                        onAnswer: (value) {
                          setState(() {
                            hipoAxialValue = value;
                            errorBox[4]= false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Hipotonia membros superiores
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
                      TextForm(text: 'Hipotonia membros superiores *'),
                      SingleCustomRadio(
                        namedButton: ['Ausente ','Moderada', 'Severa'],
                        onAnswer: (value) {
                          setState(() {
                            hipoMembSupValue = value;
                            errorBox[5] = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Hipotonia membros inferiores
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
                      TextForm(text: 'Hipotonia membros inferiores *'),
                      SingleCustomRadio(
                        namedButton: ['Ausente ','Moderada', 'Severa'],
                        onAnswer: (value) {
                          setState(() {
                            hipoMembInfValue = value;
                            errorBox[6] = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Hipotonia cabeça
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
                      TextForm(text: 'Hipotonia cabeça'),
                      SingleCustomRadio(
                        namedButton: ['Ausente ','Moderada', 'Severa'],
                        onAnswer: (value) {
                          setState(() {
                            hipoCabecaValue = value;
                            errorBox[7] = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Ataxia
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
                      TextForm(text: 'Ataxia *'),
                      SingleCustomRadio(
                        namedButton: ['Ausente ','Moderada', 'Severa'],
                        onAnswer: (value) {
                          setState(() {
                            ataxiaValue = value;
                            errorBox[8] = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Atetose
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
                      TextForm(text: 'Atetose *'),
                      SingleCustomRadio(
                        namedButton: ['Ausente ','Moderada', 'Severa'],
                        onAnswer: (value) {
                          setState(() {
                            atetoseValue = value;
                            errorBox[9] = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Tremor
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
                      TextForm(text: 'Tremor *'),
                      SingleCustomRadio(
                        namedButton: ['Ausente ','Moderada', 'Severa'],
                        onAnswer: (value) {
                          setState(() {
                            tremorValue = value;
                            errorBox[10] = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Rigidez
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
                      TextForm(text: 'Rigidez *'),
                      SingleCustomRadio(
                        namedButton: ['Ausente ','Moderada', 'Severa'],
                        onAnswer: (value) {
                          setState(() {
                            rigidezValue = value;
                            errorBox[11] = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Discinesia
                Container(
                  padding: errorBox[12] ? EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10
                  ): EdgeInsets.all(0),
                  decoration: errorBox[12] ? BoxDecoration(
                      border: Border.all(color: Colors.red)
                  ) : BoxDecoration(
                      border: Border.all(color: Colors.transparent)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextForm(text: 'Discinesia *'),
                      SingleCustomRadio(
                        namedButton: ['Ausente ','Moderada', 'Severa'],
                        onAnswer: (value) {
                          setState(() {
                            discinesiaValue = value;
                            errorBox[12] = false;
                          });
                        },
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
                              SlideRightRoute(widget: Atendimento8())
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
                            tonusMuscular = {
                              'Hipertonia Axial' : tonus[hiperAxialValue],
                              'Hipertonia membros superiores': tonus[hiperMembSupValue],
                              'Hipertonia membros inferiores': tonus[hiperMembInfValue],
                              'Hipertonia cabeca' : tonus[hiperCabecaValue],
                              'Hipotonia Axial' : tonus[hipoAxialValue],
                              'Hipotonia membros superiores': tonus[hipoMembSupValue],
                              'Hipotonia membros inferiores': tonus[hipoMembInfValue],
                              'Hipotonia cabeca' : tonus[hipoCabecaValue],
                              'Ataxia': tonus[ataxiaValue],
                              'Atetose': tonus[atetoseValue],
                              'Tremor': tonus[tremorValue],
                              'Rigidez': tonus[rigidezValue],
                              'Discinesia': tonus[discinesiaValue],
                            };
                            Navigator.push(
                                context,
                                SlideRightRoute5(widget: Atendimento10(
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
                                  quaisTransporte: widget.quaisTransporte,
                                  usaTransporte: widget.usaTransporte,
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
                                  sistemaSuplementar: widget.sistemaSuplementar,
                                  condicaoPsico: widget.condicaoPsico,
                                  condicaoResp: widget.condicaoResp,
                                  condSeveraStr: widget.condSeveraStr,
                                  eqpRespiratorio: widget.eqpRespiratorio,
                                  presencaDor: widget.presencaDor,
                                  ulcera: widget.ulcera,
                                  possuiUlcera:  widget.possuiUlcera,
                                  alimentacao: widget.alimentacao,
                                  vestirse: widget.vestirse,
                                  banho: widget.banho,
                                  higiene: widget.higiene,
                                  controleVesical: widget.controleVesical,
                                  controleIntestinal: widget.controleIntestinal,
                                  condMotora: widget.condMotora,
                                  reflexo: widget.condMotora,
                                  tonus: tonusMuscular,
                                  deficit: widget.deficit,
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
      if (hiperAxialValue == null)
        errorBox[0] = true;
      if (hiperMembSupValue == null)
        errorBox[1] = true;
      if (hiperMembInfValue == null)
        errorBox[2] = true;
      if (hiperCabecaValue == null)
        errorBox[3] = true;
      if (hipoAxialValue == null)
        errorBox[4] = true;
      if (hipoMembSupValue == null)
        errorBox[5] = true;
      if (hipoMembInfValue == null)
        errorBox[6] = true;
      if (hipoCabecaValue == null)
        errorBox[7] = true;
      if (ataxiaValue == null)
        errorBox[8] = true;
      if (atetoseValue == null)
        errorBox[9] = true;
      if (tremorValue == null)
        errorBox[10] = true;
      if (rigidezValue == null)
        errorBox[11] = true;
      if (discinesiaValue == null)
        errorBox[12] = true;
    });
  }
}
