import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/shared/loading.dart';
import 'atendimento3.dart';
import 'atendimento5.dart';


// ignore: must_be_immutable
class Atendimento4 extends StatefulWidget {

  final String estadoMatrimonial, grauEscolaridade, ocupacao, diagAttendance, queixaPrincipal, historicoAtual, qualCirurgia, medicacao, descAmput, processoDoenca,
  descAssento, descLocal, distanciaPercorrida, horaUtilizada,  comoSenta, descBanheiro;
  final Map<String, bool>  qualBanheiro, motivoAvaliacao, usoCadeira, qualAssento;
  final Function toggleView;
  Atendimento4({this.toggleView, this.estadoMatrimonial, this.grauEscolaridade, this.ocupacao, this.diagAttendance, this.queixaPrincipal, this.historicoAtual, this.qualCirurgia, this.medicacao, this.descAmput, this.processoDoenca, this.motivoAvaliacao,
  this.usoCadeira, this.descLocal, this.descAssento, this.distanciaPercorrida, this.horaUtilizada, this.qualAssento, this.qualBanheiro, this.comoSenta, this.descBanheiro});

  @override
  _Atendimento4State createState() => _Atendimento4State();

}

class _Atendimento4State extends State<Atendimento4> {

  final _formkey = GlobalKey<FormState>();
  String descTransporte = '', descSenta = 'Não', descReside = 'Reside sozinho', error = '', descTipoReside = '', descTipoEntrada = '';
  Map<String, bool> quaisTransporte = <String, bool>{};
  List<String>  usaTransporte  = ['Sim', 'Não'], tipoResidencia = <String>['',''], tipoEntrada = <String>['',''], acessibilidadeBanheiro = <String>['',''], acessibilidadePorta = <String>['',''], acessibilidadeArea = <String>['',''];
  bool loading = false, noCarro = false, noTaxi = false, noOnibus = false, naAmbulancia = false, outroTransporte = false;
  int sitValue, usuarioUsaValue, resideValue, residenciaValue, entradaValue, banheiroValue, areaValue, portasValue;
  List<bool> errorBox = [false, false, false, false, false, false, false, false];

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
          child:
                 Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //Senta na cadeira de rodas durante o transporte?
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
                            TextForm(text: 'Senta na cadeira de rodas durante o transporte? *'),
                            SingleCustomRadio(namedButton: usaTransporte, onAnswer: (value) {setState(() {sitValue = value; errorBox[0] = false;});},),
                            if(sitValue == 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5.0),
                                  TextForm(text: 'Descreva'),
                                  CustomForm(obscureText: false, hintText: 'Descreva neste campo', onChanged: (val) {setState(() => descSenta = val);},)
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //O usuário usa transporte público/privado com regularidade?
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
                            TextForm(text: 'O usuário usa transporte público/privado com regularidade? *'),
                            SingleCustomRadio(namedButton: usaTransporte, onAnswer: (value) {setState(() {usuarioUsaValue = value;errorBox[1] = false;});},),
                            if(usuarioUsaValue == 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5.0),
                                  TextForm(text: 'Que tipo?'),
                                  CustomCheckbox(textBox:  'Carro', onAnswer: (val) {setState(() {noCarro = val;});},),
                                  CustomCheckbox(textBox: 'Taxi', onAnswer: (val) {setState(() {noTaxi = val;});},),
                                  CustomCheckbox(textBox: 'Ônibus', onAnswer: (val) {setState(() {noOnibus = val;});},),
                                  CustomCheckbox(textBox: 'Ambulância', onAnswer: (val) {setState(() {naAmbulancia = val;});},),
                                  CustomCheckbox(textBox:  'Outro', onAnswer: (val) {setState(() {outroTransporte = val;});},),
                                  if (outroTransporte)
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        TextForm(text: 'Descreva'),
                                        CustomForm(obscureText: false, hintText: 'Descreva neste campo', onChanged: (val) {setState(() => descTransporte = val);},)
                                      ],
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //Reside com alguém?
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
                            TextForm(text: 'Reside com alguém? *'),
                            SingleCustomRadio(namedButton: ['Reside sozinho', 'Reside com outros'], onAnswer: (value) {setState(() {resideValue = value;errorBox[2] = false;});},),
                            if(resideValue == 1)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5.0),
                                  TextForm(text: 'Descreva com quem'),
                                  CustomForm(hintText: 'Descreva neste campo',onChanged: (val) {setState(() => descReside = val);},obscureText: false,)
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //Residência
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
                            TextForm(text: 'Residência *'),
                            SingleCustomRadio(namedButton: tipoResidencia = ['Casa', 'Apartamento', 'Casa de repouso', 'Outro'], onAnswer: (value) {setState(() {residenciaValue = value;errorBox[3] = false;});},),
                            if(residenciaValue == 3)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5.0),
                                  TextForm(text: 'Descreva a residência'),
                                  CustomForm(hintText: 'Descreva neste campo',onChanged: (val) {setState(() => descTipoReside = val);},obscureText: false,)
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //Entrada
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
                            TextForm(text: 'Entrada *'),
                            SingleCustomRadio(namedButton: tipoEntrada = ['Escadas', 'Elevador', 'Rampa de acesso', 'Outro'], onAnswer: (value) {setState(() {entradaValue = value;errorBox[4] = false;});},),
                            if(entradaValue == 3)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5.0),
                                  TextForm(text: 'Descreva o tipo de entrada'),
                                  CustomForm(hintText: 'Descreva neste campo',onChanged: (val) {setState(() => descTipoEntrada = val);},obscureText: false,)
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //Banheiro
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
                            TextForm(text: 'Banheiro *'),
                            SingleCustomRadio(namedButton: acessibilidadeBanheiro = ['Acessível', 'Não acessível'], onAnswer: (value) {setState(() {banheiroValue = value;errorBox[5] = false;});},),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //Área de convivência
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
                            TextForm(text: 'Área de convivência *'),
                            SingleCustomRadio(namedButton: acessibilidadePorta = ['Acessível', 'Não acessível'], onAnswer: (value) {setState(() {areaValue = value;errorBox[6] = false;});},),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //Portas
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
                            TextForm(text: 'Portas *'),
                            SingleCustomRadio(namedButton: acessibilidadeArea = ['Acessível', 'Não acessível'], onAnswer: (value) {setState(() {portasValue = value;errorBox[7] = false;});},),
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
                                    SlideRightRoute(widget: Atendimento3())
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
                                quaisTransporte = {
                                  'Carro': noCarro,
                                  'Taxi': noTaxi,
                                  'Ônibus': noOnibus,
                                  'Ambulância': naAmbulancia,
                                  'Outro': outroTransporte
                                };
                                try {
                                  Navigator.push(
                                    context,
                                    SlideRightRoute4(
                                        widget: Atendimento5(
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
                                          descSenta: descSenta,
                                          usaTransporte: usaTransporte[usuarioUsaValue],
                                          quaisTransporte: quaisTransporte,
                                          descReside: descReside,
                                          tipoResidencia: residenciaValue == 3 ? descTipoReside : tipoResidencia[residenciaValue],
                                          tipoEntrada: entradaValue == 3 ? descTipoEntrada : tipoEntrada[entradaValue],
                                          acessibilidadeBanheiro: acessibilidadeBanheiro[banheiroValue],
                                          acessibilidadeArea: acessibilidadeArea[areaValue],
                                          acessibilidadePorta: acessibilidadePorta[portasValue],
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
      if (sitValue == null)
        errorBox[0] = true;
      if (usuarioUsaValue == null)
        errorBox[1] = true;
      if (resideValue == null)
        errorBox[2] = true;
      if (residenciaValue == null)
        errorBox[3] = true;
      if (entradaValue == null)
        errorBox[4] = true;
      if (banheiroValue == null)
        errorBox[5] = true;
      if (areaValue == null)
        errorBox[6] = true;
      if (portasValue == null)
        errorBox[7] = true;
    });
  }
}
