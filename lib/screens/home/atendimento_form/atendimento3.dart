import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/shared/loading.dart';
import 'atendimento2.dart';
import 'atendimento4.dart';


// ignore: must_be_immutable
class Atendimento3 extends StatefulWidget {

  final String estadoMatrimonial, grauEscolaridade, ocupacao, diagAttendance, queixaPrincipal, historicoAtual, qualCirurgia, medicacao, descAmput, processoDoenca;
  final Map<String, bool> motivoAvaliacao;
  final Function toggleView;
  Atendimento3({this.toggleView, this.estadoMatrimonial, this.grauEscolaridade, this.ocupacao, this.diagAttendance, this.queixaPrincipal, this.historicoAtual, this.qualCirurgia, this.medicacao, this.descAmput, this.processoDoenca, this.motivoAvaliacao});

  @override
  _Atendimento3State createState() => _Atendimento3State();

}

class _Atendimento3State extends State<Atendimento3> {

  final _formkey = GlobalKey<FormState>();
  String  descLocal = '', descAssento = '', descBanheiro = '', error = '', comoSenta = '';
  bool loading = false, naCasa = false, naEscola = false, naRua = false, transportePublico = false, transporteParticular = false, outrosLocais = false, noParque = false, naIgreja = false,
  naCama = false, camaSuporte = false, camaHospitalar = false, sofa = false, outrosAssentos = false, vasoSanitario = false, vasoAdaptado = false,
  cadeiraBanho = false, cadeiraBanhoPerso = false, outrosBanheiros = false;
  List<String> distanciaPercorrida = ['Até 1km', '1-5km', 'Mais de 5km'], horaUtilizada = ['Menos de 1 hora', 'Entre 1-3 horas', 'Entre 3-5 horas', 'Entre 5-8 horas', 'Mais de 8 horas'];
  int distanciaValue, horaValue;
  List<bool> errorBox = [false, false, false, false, false];
  Map<String, bool> usoCadeira = <String, bool>{}, qualAssento = <String, bool>{}, qualBanheiro = <String, bool>{};

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
          child: Container(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Estilo de vida e ambiente', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                  SizedBox(height: 30.0),

                  //Onde o usuário utilizará a cadeira de rodas?
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
                        TextForm(text: 'Onde o usuário utilizará a cadeira de rodas? *'),
                        CustomCheckbox(textBox: 'Casa', onAnswer: (value) {setState(() {naCasa = value;errorBox[2] = false;});},),
                        CustomCheckbox(textBox: 'Escola', onAnswer: (value) {setState(() {naEscola = value;errorBox[2] = false;});},),
                        CustomCheckbox(textBox: 'Parque', onAnswer: (value) {setState(() {noParque = value;errorBox[2] = false;});},),
                        CustomCheckbox(textBox: 'Transporte Público', onAnswer: (value) {setState(() {transportePublico = value;errorBox[2] = false;});},),
                        CustomCheckbox(textBox: 'Transporte Particular', onAnswer: (value) {setState(() {transporteParticular = value;errorBox[2] = false;});},),
                        CustomCheckbox(textBox: 'Rua', onAnswer: (value) {setState(() {naRua = value;errorBox[2] = false;});},),
                        CustomCheckbox(textBox: 'Igreja', onAnswer: (value) {setState(() {naIgreja = value;errorBox[2] = false;});},),
                        CustomCheckbox(textBox: 'Outros', onAnswer: (value) {setState(() {outrosLocais = value;errorBox[2] = false;},);}),
                        if (outrosLocais)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 5.0),
                              TextForm(text: 'Quais'),
                              CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val){setState(() => descLocal = val);},)
                            ],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),

                  //Distância percorrida por dia
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
                        TextForm(text: 'Distância percorrida por dia *'),
                        SingleCustomRadio(namedButton: distanciaPercorrida, onAnswer: (value) {setState(() {distanciaValue = value; errorBox[0] = false;});},),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),

                  //Horas de uso da cadeira de rodas por dia
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
                        TextForm(text: 'Horas de uso da cadeira de rodas por dia *'),
                        SingleCustomRadio(namedButton: horaUtilizada, onAnswer: (value) {setState(() {horaValue = value;errorBox[1] = false;});},),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),

                  //Quando fora da cadeira de rodas, onde o usuário-se senta ou deita, e como (postura e superfície)?
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
                        TextForm(text: 'Quando fora da cadeira de rodas, onde o usuário-se senta ou deita? *'),
                        CustomCheckbox(textBox: 'Cama', onAnswer: (value) {setState(() {naCama = value; errorBox[3] = false;});}),
                        CustomCheckbox(textBox: 'Cama com suporte de adequação postural', onAnswer: (value) {setState(() {camaSuporte = value; errorBox[3] = false; },);}),
                        CustomCheckbox(textBox: 'Cama Hospitalar', onAnswer: (value) {setState(() {camaHospitalar = value; errorBox[3] = false;},);}),
                        CustomCheckbox(textBox: 'Sofá', onAnswer: (value) {setState(() {sofa = value; errorBox[3] = false;},);}),
                        CustomCheckbox(textBox: 'Outros', onAnswer: (value) {setState(() {outrosAssentos = value; errorBox[3] = false;},);}),
                        if (outrosAssentos)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 5.0),
                              TextForm(text: 'Descreva'),
                              CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => descAssento = val);},),
                            ],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),

                  TextForm(text: 'Como o usuário senta ou deita? (postura e superfície) *'),
                  CustomForm(validator: (val) => val.isEmpty ? '' : null,obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => comoSenta = val);},),
                  SizedBox(height: 30.0),

                  //Tipo de banheiro (em caso de transferência)
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
                        TextForm(text: 'Tipo de banheiro (em caso de transferência) *'),
                        CustomCheckbox(textBox: 'Vaso sanitário', onAnswer: (value) {setState(() {vasoSanitario = value; errorBox[4] = false;},);}),
                        CustomCheckbox(textBox: 'Adaptado', onAnswer: (value) {setState(() {vasoAdaptado = value; errorBox[4] = false;},);}),
                        CustomCheckbox(textBox: 'Cadeira de banho', onAnswer: (value) {setState(() {cadeiraBanho = value; errorBox[4] = false;},);}),
                        CustomCheckbox(textBox: 'Cadeira de banho personalizada', onAnswer: (value) {setState(() {cadeiraBanhoPerso = value; errorBox[4] = false;},);}),
                        CustomCheckbox(textBox: 'Outros', onAnswer: (value) {setState(() {outrosBanheiros = value; errorBox[4] = false;},);}),
                        if (outrosBanheiros)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 5.0),
                              TextForm(text: 'Descreva'),
                              CustomForm(hintText: 'Descreva neste campo',obscureText: false,keyboardType: TextInputType.streetAddress, validator: (val) => val.isEmpty ? 'Descreva neste campo' : null, onChanged: (val) {setState(() => descBanheiro = val);},),
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
                                SlideRightRoute(widget: Atendimento2())
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
                            if (_formkey.currentState.validate()){
                              usoCadeira = {
                                'Casa' : naCasa,
                                'Escola': naEscola,
                                'Parque': noParque,
                                'Transporte Público': transportePublico,
                                'Transporte Psrticular': transporteParticular,
                                'Rua': naRua,
                                'Igreja': naIgreja,
                                'Outros': outrosLocais,
                              };
                              qualAssento = {
                                'Cama' : naCama,
                                'Cama com suporte de adequação postural': camaSuporte,
                                'Cama Hospitalar': camaHospitalar,
                                'Sofá': sofa,
                                'Outros': outrosAssentos,
                              };
                              qualBanheiro = {
                                'Vaso Sanitário' : vasoSanitario,
                                'Adaptado': vasoAdaptado,
                                'Cadeira de banho': cadeiraBanho,
                                'Cadeira de banho personalizada': cadeiraBanhoPerso,
                                'Outros': outrosBanheiros,
                              };
                              try {
                                Navigator.push(
                                  context,
                                  SlideRightRoute4(
                                      widget: Atendimento4(
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
                                        usoCadeira: usoCadeira,
                                        descLocal: descLocal,
                                        distanciaPercorrida: distanciaPercorrida[distanciaValue],
                                        horaUtilizada: horaUtilizada[horaValue],
                                        qualAssento: qualAssento,
                                        descAssento: descAssento,
                                        comoSenta: comoSenta,
                                        qualBanheiro: qualBanheiro,
                                        descBanheiro: descBanheiro,
                                      )),
                                );
                              } catch (e){
                                if (e.toString() == 'Invalid argument(s)')
                                  errorTest();
                              }
                            } else
                              errorTest();
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
      ),
    );
  }
  errorTest(){
    setState(() {
      if (distanciaValue == null)
        errorBox[0] = true;
      if (horaValue == null)
        errorBox[1] = true;
      if (naCasa == false && naEscola == false && noParque == false && transportePublico == false && transporteParticular == false && naRua == false &&
          naIgreja == false && outrosLocais == false)
        errorBox[2] = true;
      if (naCama == false && camaSuporte == false && camaHospitalar == false && sofa == false && outrosAssentos == false)
        errorBox[3] = true;
      if (vasoSanitario == false && vasoAdaptado == false && cadeiraBanho == false && cadeiraBanhoPerso == false && outrosBanheiros == false)
        errorBox[4] = true;
    });
  }
}
