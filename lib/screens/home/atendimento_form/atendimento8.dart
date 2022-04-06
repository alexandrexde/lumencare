import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/shared/loading.dart';
import 'atendimento9.dart';


// ignore: must_be_immutable
class Atendimento8 extends StatefulWidget {
  final String estadoMatrimonial, grauEscolaridade, ocupacao, diagAttendance, queixaPrincipal, historicoAtual, qualCirurgia, medicacao, descAmput, processoDoenca,
      descAssento, descLocal, distanciaPercorrida, horaUtilizada,  comoSenta, descBanheiro, descSenta, usaTransporte, descReside, tipoResidencia, tipoEntrada, acessibilidadeBanheiro,
      acessibilidadeArea, acessibilidadePorta, atendeNecessidadeStr, atendeCondicoesStr, seguraStr, ofereceAlivioStr, adequadaStr, lateralidadeManual, condicaoVisual, condicaoAuditiva, condicaoCognitiva, expressao, recepcao,
      condicaoPsico, condSeveraStr, presencaDor;
  final Map<String, bool>  qualBanheiro, motivoAvaliacao, usoCadeira, qualAssento, quaisTransporte, condicaoResp;
  final List<String> sistemaSuplementar;
  final Map<String, String> possuiUlcera;
  final List<Map<String, String>> eqpRespiratorio, ulcera;
  final Function toggleView;
  Atendimento8({this.possuiUlcera, this.toggleView, this.estadoMatrimonial, this.grauEscolaridade, this.ocupacao, this.diagAttendance, this.queixaPrincipal, this.historicoAtual, this.qualCirurgia, this.medicacao, this.descAmput, this.processoDoenca, this.motivoAvaliacao,
    this.usoCadeira, this.descLocal, this.descAssento, this.distanciaPercorrida, this.horaUtilizada, this.qualAssento, this.qualBanheiro, this.comoSenta, this.descBanheiro, this.acessibilidadePorta, this.acessibilidadeArea, this.acessibilidadeBanheiro, this.tipoEntrada, this.tipoResidencia, this.descReside,
    this.quaisTransporte, this.descSenta, this.usaTransporte, this.atendeNecessidadeStr, this.atendeCondicoesStr, this.seguraStr, this.adequadaStr, this.ofereceAlivioStr, this.condicaoAuditiva, this.condicaoCognitiva, this.condicaoVisual, this.expressao,
    this.lateralidadeManual, this.recepcao, this.condicaoResp, this.eqpRespiratorio, this.condSeveraStr, this.condicaoPsico, this.presencaDor, this.sistemaSuplementar, this.ulcera});

  @override
  _Atendimento8State createState() => _Atendimento8State();

}

class _Atendimento8State extends State<Atendimento8> {

  bool loading = false;
  List<String> alimentacao = <String>[''], vestirse = <String>[''], banho = <String>[''], higiene = <String>[''], controleVesical = <String>[''], controleIntestinal = <String>[''], condMotora = <String>[''], deficit = <String>[''];
  String alimentacaoStr, vestirStr, banhoStr, higieneStr, controleVesicalStr, controleIntesStr;
  int alimentacaoValue, vestirValue, banhoValue, higieneValue, controleVesicalValue, controleIntesValue, condMotoraValue, reflexoValue, deficitValue;
  final _formkey = GlobalKey<FormState>();
  List<bool> errorBox = [false, false, false, false, false, false, false, false, false];

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
                Text('Atividades de vida diária' , style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 25.0),

                //Alimentação
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
                      TextForm(text: 'Alimentação *'),
                      SingleCustomRadio(
                        namedButton: alimentacao = ['Independente ','Depedência Assistida','Dependência total', 'Dependência equipamento'],
                        onAnswer: (value) {
                          setState(() {
                            alimentacaoValue = value;
                            errorBox[0] = false;
                          });
                        },
                      ),
                      if(alimentacaoValue == 3)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            TextForm(text: 'Descreva:'),
                            CustomForm(
                              obscureText: false,
                              hintText: 'Descreva neste campo',
                              onChanged: (val) {
                                setState(() => alimentacaoStr = val);
                              },
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Vestir-se / despir-se
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
                      TextForm(text: 'Vestir-se / despir-se *'),
                      SingleCustomRadio(
                        namedButton: vestirse = ['Independente ','Depedência Assistida','Dependência total', 'Dependência equipamento'],
                        onAnswer: (value) {
                          setState(() {
                            vestirValue = value;
                            errorBox[1] = false;
                          });
                        },
                      ),
                      if(vestirValue == 3)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            TextForm(text: 'Descreva:'),
                            CustomForm(
                              obscureText: false,
                              hintText: 'Descreva neste campo',
                              onChanged: (val) {
                                setState(() => vestirStr = val);
                              },
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Banho
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
                      TextForm(text: 'Banho *'),
                      SingleCustomRadio(
                        namedButton: banho = ['Independente ','Depedência Assistida','Dependência total', 'Dependência equipamento'],
                        onAnswer: (value) {
                          setState(() {
                            banhoValue = value;
                            errorBox[2] = false;
                          });
                        },
                      ),
                      if(banhoValue == 3)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            TextForm(text: 'Descreva:'),
                            CustomForm(
                              obscureText: false,
                              hintText: 'Descreva neste campo',
                              onChanged: (val) {
                                setState(() => banhoStr = val);
                              },
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Higiêne pessoal
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
                      TextForm(text: 'Higiêne pessoal *'),
                      SingleCustomRadio(
                        namedButton: higiene = ['Independente ','Depedência Assistida','Dependência total', 'Dependência equipamento'],
                        onAnswer: (value) {
                          setState(() {
                            higieneValue = value;
                            errorBox[3] = false;
                          });
                        },
                      ),
                      if(higieneValue == 3)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            TextForm(text: 'Descreva:'),
                            CustomForm(
                              obscureText: false,
                              hintText: 'Descreva neste campo',
                              onChanged: (val) {
                                setState(() => higieneStr = val);
                              },
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),


                //Controle vesical
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
                      TextForm(text: 'Controle vesical *'),
                      SingleCustomRadio(
                        namedButton: controleVesical = ['Continente  ','Incontinente'],
                        onAnswer: (value) {
                          setState(() {
                            controleVesicalValue = value;
                            errorBox[4] = false;
                          });
                        },
                      ),
                      if(controleVesicalValue == 1)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            TextForm(text: 'Descreva:'),
                            CustomForm(
                              obscureText: false,
                              hintText: 'Descreva neste campo',
                              onChanged: (val) {
                                setState(() => controleVesicalStr = val);
                                errorBox[4] = false;
                              },
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Controle intestinal
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
                      TextForm(text: 'Controle intestinal *'),
                      SingleCustomRadio(
                        namedButton: controleIntestinal = ['Continente  ','Incontinente'],
                        onAnswer: (value) {
                          setState(() {
                            controleIntesValue = value;
                            errorBox[5] = false;
                          });
                        },
                      ),
                      if(controleIntesValue == 1)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            TextForm(text: 'Descreva:'),
                            CustomForm(
                              obscureText: false,
                              hintText: 'Descreva neste campo',
                              onChanged: (val) {
                                setState(() => controleIntesStr = val);
                              },
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Condição neuromotora
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
                      TextForm(text: 'Condição neuromotora *'),
                      SingleCustomRadio(
                        namedButton: condMotora = ['Normal','Alterado'],
                        onAnswer: (value) {
                          setState(() {
                            condMotoraValue = value;
                            errorBox[6] = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Reflexos
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
                      TextForm(text: 'Reflexos *'),
                      SingleCustomRadio(
                        namedButton: ['Normal','Alterado'],
                        onAnswer: (value) {
                          setState(() {
                            reflexoValue = value;
                            errorBox[7] = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                //Déficit neurológico
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
                      TextForm(text: 'Déficit neurológico *'),
                      SingleCustomRadio(
                        namedButton: deficit = ['Diparesia','Hemiparesia direita', 'Hemiparesia esquerda', 'Paraplegia', 'Tetraparesia'],
                        onAnswer: (value) {
                          setState(() {
                            deficitValue = value;
                            errorBox[8] = false;
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
                            Navigator.push(
                                context,
                                SlideRightRoute(widget: Atendimento9(
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
                                  sistemaSuplementar: widget.sistemaSuplementar,
                                  condicaoPsico: widget.condicaoPsico,
                                  condicaoResp: widget.condicaoResp,
                                  condSeveraStr: widget.condSeveraStr,
                                  eqpRespiratorio: widget.eqpRespiratorio,
                                  presencaDor: widget.presencaDor,
                                  ulcera: widget.ulcera,
                                  possuiUlcera:  widget.possuiUlcera,
                                  alimentacao: alimentacaoValue == 3 ? alimentacaoStr : alimentacao[alimentacaoValue],
                                  vestirse: vestirValue == 3 ? vestirStr : vestirse[vestirValue],
                                  banho: banhoValue == 3 ? banhoStr : banho[banhoValue],
                                  higiene: higieneValue == 3 ? higieneStr : higiene[higieneValue],
                                  controleVesical: controleVesicalValue == 1 ? controleVesicalStr : controleVesical[controleVesicalValue],
                                  controleIntestinal: controleIntesValue == 1 ? controleIntesStr : controleIntestinal[controleIntesValue],
                                  condMotora: condMotora[condMotoraValue],
                                  reflexo: condMotora[reflexoValue],
                                  deficit: deficit[deficitValue],
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
      if (alimentacaoValue == null)
        errorBox[0] = true;
      if (vestirValue == null)
        errorBox[1] = true;
      if (banhoValue == null)
        errorBox[2] = true;
      if (higieneValue == null)
        errorBox[3] = true;
      if (controleVesicalValue == null)
        errorBox[4] = true;
      if (controleIntesValue == null)
        errorBox[5] = true;
      if (condMotoraValue == null)
        errorBox[6] = true;
      if (reflexoValue == null)
        errorBox[7] = true;
      if (deficitValue == null)
        errorBox[8] = true;
    });
  }
}
