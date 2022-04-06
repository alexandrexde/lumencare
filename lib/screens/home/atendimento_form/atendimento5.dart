import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/shared/loading.dart';
import 'atendimento4.dart';
import 'atendimento6.dart';

class SimpleModel {
  String title;
  bool isChecked;
  SimpleModel(this.title, this.isChecked);
}
List<SimpleModel> createModel(){
  List<SimpleModel> _items = <SimpleModel>[
    SimpleModel('Sim', false),
    SimpleModel('Não', false),
  ];
  return _items;
}
// ignore: must_be_immutable
class Atendimento5 extends StatefulWidget {

  final String estadoMatrimonial, grauEscolaridade, ocupacao, diagAttendance, queixaPrincipal, historicoAtual, qualCirurgia, medicacao, descAmput, processoDoenca,
      descAssento, descLocal, distanciaPercorrida, horaUtilizada,  comoSenta, descBanheiro, descSenta, usaTransporte, descReside, tipoResidencia, tipoEntrada, acessibilidadeBanheiro,
      acessibilidadeArea, acessibilidadePorta;
  final Map<String, bool>  qualBanheiro, motivoAvaliacao, usoCadeira, qualAssento, quaisTransporte;
  final Function toggleView;
  Atendimento5({this.toggleView, this.estadoMatrimonial, this.grauEscolaridade, this.ocupacao, this.diagAttendance, this.queixaPrincipal, this.historicoAtual, this.qualCirurgia, this.medicacao, this.descAmput, this.processoDoenca, this.motivoAvaliacao,
    this.usoCadeira, this.descLocal, this.descAssento, this.distanciaPercorrida, this.horaUtilizada, this.qualAssento, this.qualBanheiro, this.comoSenta, this.descBanheiro, this.acessibilidadePorta, this.acessibilidadeArea, this.acessibilidadeBanheiro, this.tipoEntrada, this.tipoResidencia, this.descReside,
  this.quaisTransporte, this.descSenta, this.usaTransporte});

  @override
  _Atendimento5State createState() => _Atendimento5State();

}

class _Atendimento5State extends State<Atendimento5> {

  final _formkey = GlobalKey<FormState>();
  String error = '', descCondicao = '';
  List<String> atendeNecessidadeStr = <String>[''], atendeCondicoesStr = <String>[''], adequadaStr = <String>[''], seguraStr = <String>[''], ofereceAlivioStr = <String>[''];
  bool loading = false;
  int atendeValue, seguraValue, alivioValue, condicoesValue, suporteValue;
  List<bool> errorBox = [false, false, false, false, false];

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
                      Text('Cadeira de rodas atual',style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                      SizedBox(height: 30.0),

                      //A cadeira de rodas atende às necessidades do usuário?
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
                            TextForm(text: 'A cadeira de rodas atende às necessidades do usuário? *'),
                            SingleCustomRadio(namedButton: atendeNecessidadeStr = ['Sim', 'Não'], onAnswer: (value) {setState(() {atendeValue = value; errorBox[0] = false;});},),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //A cadeira de rodas atende às condições do ambiente do usuário?
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
                            TextForm(text: 'A cadeira de rodas atende às condições do ambiente do usuário? *'),
                            SingleCustomRadio(namedButton: atendeCondicoesStr = ['Sim', 'Não'], onAnswer: (value) {setState(() {condicoesValue = value;errorBox[1] = false;});},),
                            if(condicoesValue == 1)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5.0),
                                  TextForm(text: 'Por quê?'),
                                  CustomForm(obscureText: false, hintText: 'Descreva neste campo', onChanged: (val) {setState(() => descCondicao = val);},)
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //A cadeira de rodas é adequada e oferece suporte postural?
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
                            TextForm(text: 'A cadeira de rodas é adequada e oferece suporte postural? *'),
                            SingleCustomRadio(namedButton: adequadaStr = ['Sim', 'Não'], onAnswer: (value) {setState(() {suporteValue = value;errorBox[2] = false;});},),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //A cadeira de rodas é segura e durável?
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
                            TextForm(text: 'A cadeira de rodas é segura e durável? *'),
                            SingleCustomRadio(namedButton: seguraStr = ['Sim', 'Não'], onAnswer: (value) {setState(() {seguraValue = value;errorBox[3] = false;});},),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //A almofada oferece alívio adequado da pressão (se o usuário corre risco de desenvolver úceras/feridas)?
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
                            TextForm(text: 'A almofada oferece alívio adequado da pressão (se o usuário corre risco de desenvolver úceras/feridas)? *'),
                            SingleCustomRadio(namedButton: ofereceAlivioStr = ['Sim', 'Não'], onAnswer: (value) {setState(() {alivioValue = value;errorBox[4] = false;});},),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      Text(
                        //error text
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                      ),

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
                                    SlideRightRoute(widget: Atendimento4())
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
                                        widget: Atendimento6(
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
                                          atendeNecessidadeStr: atendeNecessidadeStr[atendeValue],
                                          atendeCondicoesStr: condicoesValue == 1 ? descCondicao : atendeCondicoesStr[condicoesValue],
                                          seguraStr: seguraStr[seguraValue],
                                          adequadaStr: adequadaStr[suporteValue],
                                          ofereceAlivioStr: ofereceAlivioStr[alivioValue],
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
                ),
        ),
      ),
    );
  }
  errorTest(){
    setState(() {
      if (atendeValue == null)
        errorBox[0] = true;
      if (condicoesValue == null)
        errorBox[1] = true;
      if (suporteValue == null)
        errorBox[2] = true;
      if (seguraValue == null)
        errorBox[3] = true;
      if (alivioValue == null)
        errorBox[4] = true;
    });
  }
}
