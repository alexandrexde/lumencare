import 'package:animated_check/animated_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/models/Attendance.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/services/database.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';
import '../home.dart';
import 'atendimento.dart';


// ignore: must_be_immutable
class Atendimento10 extends StatefulWidget {
  final String estadoMatrimonial, grauEscolaridade, ocupacao, diagAttendance, queixaPrincipal, historicoAtual, qualCirurgia, medicacao, descAmput, processoDoenca,
      descAssento, descLocal, distanciaPercorrida, horaUtilizada,  comoSenta, descBanheiro, descSenta, usaTransporte, descReside, tipoResidencia, tipoEntrada, acessibilidadeBanheiro,
      acessibilidadeArea, acessibilidadePorta, atendeNecessidadeStr, atendeCondicoesStr, seguraStr, ofereceAlivioStr, adequadaStr, lateralidadeManual, condicaoVisual, condicaoAuditiva, condicaoCognitiva, expressao, recepcao,
      condicaoPsico, condSeveraStr, presencaDor, alimentacao, vestirse, banho, higiene, controleVesical, controleIntestinal, condMotora, reflexo, deficit;
  final Map<String, bool>  qualBanheiro, motivoAvaliacao, usoCadeira, qualAssento, quaisTransporte, condicaoResp;
  final Map<String, String> tonus, possuiUlcera;
  final List<String> sistemaSuplementar;
  final List<Map<String, String>> eqpRespiratorio, ulcera;
  final Function toggleView;
  Atendimento10({this.possuiUlcera, this.toggleView, this.estadoMatrimonial, this.grauEscolaridade, this.ocupacao, this.diagAttendance, this.queixaPrincipal, this.historicoAtual, this.qualCirurgia, this.medicacao, this.descAmput, this.processoDoenca, this.motivoAvaliacao,
    this.usoCadeira, this.descLocal, this.descAssento, this.distanciaPercorrida, this.horaUtilizada, this.qualAssento, this.qualBanheiro, this.comoSenta, this.descBanheiro, this.acessibilidadePorta, this.acessibilidadeArea, this.acessibilidadeBanheiro, this.tipoEntrada, this.tipoResidencia, this.descReside,
    this.quaisTransporte, this.descSenta, this.usaTransporte, this.atendeNecessidadeStr, this.atendeCondicoesStr, this.seguraStr, this.adequadaStr, this.ofereceAlivioStr, this.condicaoAuditiva, this.condicaoCognitiva, this.condicaoVisual, this.expressao,
    this.lateralidadeManual, this.recepcao, this.condicaoResp, this.eqpRespiratorio, this.condSeveraStr, this.condicaoPsico, this.presencaDor, this.sistemaSuplementar, this.ulcera, this.alimentacao, this.banho, this.condMotora, this.controleIntestinal, this.controleVesical, this.higiene, this.reflexo, this.vestirse, this.tonus, this.deficit});

  @override
  _Atendimento10State createState() => _Atendimento10State();

}

class _Atendimento10State extends State<Atendimento10> with SingleTickerProviderStateMixin  {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool loading = false, pressed = false;
  bool braco = false, bracoEsquerdo = false, bracoDireito = false, membInf = false, membInfEsq = false, membInfDir = false, empurrado = false, queixo = false, outrosImpulsos = false;
  int pelveGroupValue, troncoGroupValue, cabecaValue, ombrosValue, troncoValue, pelveValue,pelveValue1,pelveValue2,pelveValue3, quadrilValue, joelhoDireitoValue, joelhoEsquerdoValue, posicionamentoPeValue, posicionamentoPeValue1, posicionamentoPeValue2, posicionamentoPeValue3, posicionamentoPeValue4, possuiHabValue, troncoValue2, troncoValue3, troncoValue4,
  controleCadeiraValue, cabecaFlexValue, depressaoValue, retracaoValue, elevacaoValue, tipoPropusaoValue;
  String outraPropStr, troncoStr, pelveStr, joelhoDireitoStr, joelhoEsquerdoStr, outrosImpulsosStr, controleCadeiraStr, outroPosicStr;
  bool alinhado = false, protusao = false, protusaoDireita = false, protusaoEsquerda = false, retracao = false, retracaoDireita = false, retracaoEsquerda = false, elevacao = false, elevacaoDireita = false, elevacaoEsquerda = false, depressao = false, depressaoDireita = false, depressaoEsquerda = false,
  gibosidadeDireita = false, gibosidadeEsquerda = false, rotacaoDireita = false, rotacaoEsquerda = false, dorsiflexaoDireita = false, dorsiflexaoEsquerda = false, flexaoDireita = false, flexaoEsquerda = false, inversaoDireita = false, inversaoEsquerda = false, eversaoDireita = false, eversaoEsquerda = false ;
  final _formkey = GlobalKey<FormState>();
  Map<String, dynamic> postura = <String, dynamic>{}, ombro = <String, dynamic>{}, tronco2 = <String, dynamic>{}, pelve2 = <String, dynamic>{}, posPe = <String, dynamic>{}, impulso = <String, dynamic>{};
  List<String> controleCadeira = [''], propulsao = [''], quadril = [''], joelho = [''], cabeca = ['','','',''], cabeca2 = [''], tronco = ['','',''], troncoGroup = ['','','','',''];
  AnimationController _animationController;
  Animation<double> _animation;
  double sizeAnimation = 0;
  List<bool> errorBox = [false, false, false, false, false, false, false, false, false, false, false];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    _animation = new Tween<double>(begin: 0, end: 1).animate(new CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCirc));
  }
  void _showCheck() {
    _animationController.forward().then((value) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }
  void _resetCheck() {
    _animationController.reverse();
  }

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

    final user = Provider.of<Users>(context);

    return pressed
        ? Scaffold(
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    color: Color(0xFF6848AE),
                    borderRadius: BorderRadius.all(Radius.circular(200))
                ),
                child: AnimatedCheck(
                  color: Colors.white,//Color(0xFF6848AE),
                  progress: _animation,
                  size: 200,
                ),
              ),
            ]  ,
          )
      ),
    )
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
          child:StreamBuilder<UserData>(
            stream: DatabaseService(uid: user.uid).userDataCompany,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                User user = _auth.currentUser;
                return Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Text('Postura', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 25.0),

                      //Cabe??a e pesco??o
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
                            TextForm(text: 'Cabe??a e pesco??o *'),
                            ACustomRadio(
                              namedButton: cabeca[0] = 'Neutra',
                              onAnswer: (value) {
                                setState(() {
                                  cabecaValue = value;
                                  errorBox[0] = false;
                                });
                              },
                              groupValue: cabecaValue,
                              index: 0,
                            ),
                            ACustomRadio(
                              namedButton: cabeca[1] = 'Hiperextens??o',
                              onAnswer: (value) {
                                setState(() {
                                  cabecaValue = value;
                                  errorBox[0] = false;
                                });
                              },
                              groupValue: cabecaValue,
                              index: 1,
                            ),
                            ACustomRadio(
                              namedButton: cabeca[2] = 'Flex??o lateral',
                              onAnswer: (value) {
                                setState(() {
                                  cabecaValue = value;
                                  errorBox[0] = false;
                                });
                              },
                              groupValue: cabecaValue,
                              index: 2,
                            ),
                            if(cabecaValue == 2)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 23, right: 5),
                                    child: SingleCustomRadio(
                                      namedButton: cabeca2 = ['Flex??o lateral direita', 'Flex??o lateral esquerda'],
                                      onAnswer: (value) {
                                        setState(() {
                                          cabecaFlexValue = value;
                                          errorBox[0] = false;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ACustomRadio(
                              namedButton: cabeca[3] = 'Flex??o',
                              onAnswer: (value) {
                                setState(() {
                                  cabecaValue = value;
                                  errorBox[0] = false;
                                });
                              },
                              groupValue: cabecaValue,
                              index: 3,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //Ombros
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
                            TextForm(text: 'Ombros *'),
                            CustomCheckbox(textBox: 'Alinhados', onAnswer: (val){setState(() { alinhado = val;errorBox[1] = false;}); },),
                            CustomCheckbox(textBox: 'Protus??o', onAnswer: (val){setState(() { protusao = val;errorBox[1] = false;}); },),
                            if(protusao)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 23, right: 5),
                                    child: Column(
                                      children: [
                                        CustomCheckbox(textBox: 'direita', onAnswer: (val){setState(() { protusaoDireita = val;}); },),
                                        CustomCheckbox(textBox: 'esquerda', onAnswer: (val){setState(() { protusaoEsquerda = val;}); },),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            CustomCheckbox(textBox: 'Retra????o', onAnswer: (val){setState(() { retracao = val;errorBox[1] = false;}); },),
                            if(retracao)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 23, right: 5),
                                    child: Column(
                                      children: [
                                        CustomCheckbox(textBox: 'direita', onAnswer: (val){setState(() { retracaoDireita = val;}); },),
                                        CustomCheckbox(textBox: 'esquerda', onAnswer: (val){setState(() { retracaoEsquerda = val;}); },),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            CustomCheckbox(textBox: 'Eleva????o', onAnswer: (val){setState(() { elevacao = val;errorBox[1] = false;}); },),
                            if(elevacao)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 23, right: 5),
                                    child: Column(
                                      children: [
                                        CustomCheckbox(textBox: 'direita', onAnswer: (val){setState(() { elevacaoDireita = val;}); },),
                                        CustomCheckbox(textBox: 'esquerda', onAnswer: (val){setState(() { elevacaoEsquerda = val;}); },),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            CustomCheckbox(textBox: 'Depress??o', onAnswer: (val){setState(() { depressao = val;errorBox[1] = false;}); },),
                            if(depressao)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 23, right: 5),
                                    child: Column(
                                      children: [
                                        CustomCheckbox(textBox: 'direita', onAnswer: (val){setState(() { depressaoDireita = val;}); },),
                                        CustomCheckbox(textBox: 'esquerda', onAnswer: (val){setState(() { depressaoEsquerda = val;}); },),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //Tronco
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
                            TextForm(text: 'Tronco *'),
                            RadioListTile<int>(
                              title: new Text(
                                tronco[0] ='Flex??vel',
                                style: TextStyle(color: Colors.black54, fontSize: 16),
                              ),
                              value: 0,
                              groupValue: troncoValue,
                              onChanged: (int value) {setState(() {troncoValue = value;errorBox[2] = false;});},
                              activeColor: Color(0xFF6848AE),
                            ),
                            if (troncoValue == 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 23, right: 5),
                                    child: Column(
                                      children: [
                                        RadioListTile<int>(
                                          title: new Text(
                                            troncoGroup[0] = 'Gibosidade',
                                            style: TextStyle(color: Colors.black54, fontSize: 16),
                                          ),
                                          value: 3,
                                          groupValue: troncoGroupValue,
                                          toggleable: true,
                                          onChanged: (int value) {setState(() {troncoGroupValue = value;});},
                                          activeColor: Color(0xFF6848AE),
                                        ),
                                        if (troncoGroupValue == 3)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: Column(
                                                  children: [
                                                    CustomCheckbox(textBox: 'direita', onAnswer: (val){setState(() { gibosidadeDireita = val;}); },),
                                                    CustomCheckbox(textBox: 'esquerda', onAnswer: (val){setState(() { gibosidadeEsquerda = val;}); },),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        RadioListTile<int>(
                                          title: new Text(
                                            troncoGroup[1] ='Escoliose',
                                            style: TextStyle(color: Colors.black54, fontSize: 16),
                                          ),
                                          value: 4,
                                          groupValue: troncoGroupValue,
                                          toggleable: true,
                                          onChanged: (int value) {setState(() {troncoGroupValue = value;});},
                                          activeColor: Color(0xFF6848AE),
                                        ),
                                        if (troncoGroupValue == 4)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: SingleCustomRadio(namedButton: ['direita', 'esquerda', 'em S'],
                                                  onAnswer:(value) { setState(() {troncoValue3 = value;});},),
                                              ),
                                            ],
                                          ),
                                        RadioListTile<int>(
                                          title: new Text(
                                            troncoGroup[2] ='Cifose',
                                            style: TextStyle(color: Colors.black54, fontSize: 16),
                                          ),
                                          value: 5,
                                          groupValue: troncoGroupValue,
                                          toggleable: true,
                                          onChanged: (int value) {setState(() {troncoGroupValue = value;});},
                                          activeColor: Color(0xFF6848AE),
                                        ),
                                        if (troncoGroupValue == 5)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: SingleCustomRadio(namedButton: ['direita', 'esquerda'],
                                                  onAnswer:(value) { setState(() {troncoValue4 = value;});},),
                                              ),
                                            ],
                                          ),
                                        RadioListTile<int>(
                                          title: new Text(
                                            troncoGroup[3] ='Hiperlordose',
                                            style: TextStyle(color: Colors.black54, fontSize: 16),
                                          ),
                                          value: 6,
                                          groupValue: troncoGroupValue,
                                          toggleable: true,
                                          onChanged: (int value) {setState(() {troncoGroupValue = value;});},
                                          activeColor: Color(0xFF6848AE),
                                        ),
                                        RadioListTile<int>(
                                          title: new Text(
                                            troncoGroup[4] ='Outros',
                                            style: TextStyle(color: Colors.black54, fontSize: 16),
                                          ),
                                          value: 7,
                                          groupValue: troncoGroupValue,
                                          toggleable: true,
                                          onChanged: (int value) {setState(() {troncoGroupValue = value;});},
                                          activeColor: Color(0xFF6848AE),
                                        ),
                                        if(troncoGroupValue == 7)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(height: 5.0),
                                              TextForm(text: 'Descreva:'),
                                              CustomForm(
                                                obscureText: false,
                                                hintText: 'Descreva neste campo',
                                                onChanged: (val) {
                                                  setState(() => troncoStr = val);
                                                },
                                              )
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            RadioListTile<int>(
                              title: new Text(
                                tronco[1] ='Parcialmente flex??vel',
                                style: TextStyle(color: Colors.black54, fontSize: 16),
                              ),
                              value: 1,
                              groupValue: troncoValue,

                              onChanged: (int value) {setState(() {troncoValue = value;errorBox[2] = false;});},
                              activeColor: Color(0xFF6848AE),
                            ),
                            if (troncoValue == 1)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 23, right: 5),
                                    child: Column(
                                      children: [
                                        RadioListTile<int>(
                                          title: new Text(
                                            'Gibosidade',
                                            style: TextStyle(color: Colors.black54, fontSize: 16),
                                          ),
                                          value: 3,
                                          groupValue: troncoGroupValue,
                                          toggleable: true,
                                          onChanged: (int value) {setState(() {troncoGroupValue = value;});},
                                          activeColor: Color(0xFF6848AE),
                                        ),
                                        if (troncoGroupValue == 3)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: Column(
                                                  children: [
                                                    CustomCheckbox(textBox: 'direita', onAnswer: (val){setState(() { gibosidadeDireita = val;}); },),
                                                    CustomCheckbox(textBox: 'esquerda', onAnswer: (val){setState(() { gibosidadeEsquerda = val;}); },),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        RadioListTile<int>(
                                          title: new Text(
                                            'Escoliose',
                                            style: TextStyle(color: Colors.black54, fontSize: 16),
                                          ),
                                          value: 4,
                                          groupValue: troncoGroupValue,
                                          toggleable: true,
                                          onChanged: (int value) {setState(() {troncoGroupValue = value;});},
                                          activeColor: Color(0xFF6848AE),
                                        ),
                                        if (troncoGroupValue == 4)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: SingleCustomRadio(namedButton: ['direita', 'esquerda', 'em S'],
                                                  onAnswer:(value) { setState(() {troncoValue3 = value;});},),
                                              ),
                                            ],
                                          ),
                                        RadioListTile<int>(
                                          title: new Text(
                                            'Cifose',
                                            style: TextStyle(color: Colors.black54, fontSize: 16),
                                          ),
                                          value: 5,
                                          groupValue: troncoGroupValue,
                                          toggleable: true,
                                          onChanged: (int value) {setState(() {troncoGroupValue = value;});},
                                          activeColor: Color(0xFF6848AE),
                                        ),
                                        if (troncoGroupValue == 5)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: SingleCustomRadio(namedButton: ['direita', 'esquerda'],
                                                  onAnswer:(value) { setState(() {troncoValue4 = value;});},),
                                              ),
                                            ],
                                          ),
                                        RadioListTile<int>(
                                          title: new Text(
                                            'Hiperlordose',
                                            style: TextStyle(color: Colors.black54, fontSize: 16),
                                          ),
                                          value: 6,
                                          groupValue: troncoGroupValue,
                                          toggleable: true,
                                          onChanged: (int value) {setState(() {troncoGroupValue = value;});},
                                          activeColor: Color(0xFF6848AE),
                                        ),
                                        RadioListTile<int>(
                                          title: new Text(
                                            'Outros',
                                            style: TextStyle(color: Colors.black54, fontSize: 16),
                                          ),
                                          value: 7,
                                          groupValue: troncoGroupValue,
                                          toggleable: true,
                                          onChanged: (int value) {setState(() {troncoGroupValue = value;});},
                                          activeColor: Color(0xFF6848AE),
                                        ),
                                        if(troncoGroupValue == 7)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(height: 5.0),
                                              TextForm(text: 'Descreva:'),
                                              CustomForm(
                                                obscureText: false,
                                                hintText: 'Descreva neste campo',
                                                onChanged: (val) {
                                                  setState(() => troncoStr = val);
                                                },
                                              )
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            RadioListTile<int>(
                              title: new Text(
                                tronco[2] ='R??gido',
                                style: TextStyle(color: Colors.black54, fontSize: 16),
                              ),
                              value: 2,
                              groupValue: troncoValue,
                              onChanged: (int value) {setState(() {troncoValue = value;errorBox[2] = false;});},
                              activeColor: Color(0xFF6848AE),
                            ),
                            if (troncoValue == 2)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 23, right: 5),
                                    child: Column(
                                      children: [
                                        RadioListTile<int>(
                                          title: new Text(
                                            'Gibosidade',
                                            style: TextStyle(color: Colors.black54, fontSize: 16),
                                          ),
                                          value: 3,
                                          groupValue: troncoGroupValue,
                                          onChanged: (int value) {setState(() {troncoGroupValue = value;});},
                                          activeColor: Color(0xFF6848AE),
                                        ),
                                        if (troncoGroupValue == 3)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: Column(
                                                  children: [
                                                    CustomCheckbox(textBox: 'direita', onAnswer: (val){setState(() { gibosidadeDireita = val;}); },),
                                                    CustomCheckbox(textBox: 'esquerda', onAnswer: (val){setState(() { gibosidadeEsquerda = val;}); },),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        RadioListTile<int>(
                                          title: new Text(
                                            'Escoliose',
                                            style: TextStyle(color: Colors.black54, fontSize: 16),
                                          ),
                                          value: 4,
                                          groupValue: troncoGroupValue,
                                          onChanged: (int value) {setState(() {troncoGroupValue = value;});},
                                          activeColor: Color(0xFF6848AE),
                                        ),
                                        if (troncoGroupValue == 4)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: SingleCustomRadio(namedButton: ['direita', 'esquerda', 'em S'],
                                                  onAnswer:(value) { setState(() {troncoValue3 = value;});},),
                                              ),
                                            ],
                                          ),
                                        RadioListTile<int>(
                                          title: new Text(
                                            'Cifose',
                                            style: TextStyle(color: Colors.black54, fontSize: 16),
                                          ),
                                          value: 5,
                                          groupValue: troncoGroupValue,
                                          onChanged: (int value) {setState(() {troncoGroupValue = value;});},
                                          activeColor: Color(0xFF6848AE),
                                        ),
                                        if (troncoGroupValue == 5)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: SingleCustomRadio(namedButton: ['direita', 'esquerda'],
                                                  onAnswer:(value) { setState(() {troncoValue4 = value;});},),
                                              ),
                                            ],
                                          ),
                                        RadioListTile<int>(
                                          title: new Text(
                                            'Hiperlordose',
                                            style: TextStyle(color: Colors.black54, fontSize: 16),
                                          ),
                                          value: 6,
                                          groupValue: troncoGroupValue,
                                          onChanged: (int value) {setState(() {troncoGroupValue = value;});},
                                          activeColor: Color(0xFF6848AE),
                                        ),
                                        RadioListTile<int>(
                                          title: new Text(
                                            'Outros',
                                            style: TextStyle(color: Colors.black54, fontSize: 16),
                                          ),
                                          value: 7,
                                          groupValue: troncoGroupValue,
                                          onChanged: (int value) {setState(() {troncoGroupValue = value;});},
                                          activeColor: Color(0xFF6848AE),
                                        ),
                                        if(troncoGroupValue == 7)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(height: 5.0),
                                              TextForm(text: 'Descreva:'),
                                              CustomForm(
                                                obscureText: false,
                                                hintText: 'Descreva neste campo',
                                                onChanged: (val) {
                                                  setState(() => troncoStr = val);
                                                },
                                              )
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //Pelve
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
                            TextForm(text: 'Pelve *'),
                            ACustomRadio(
                              namedButton: 'Flex??vel',
                              onAnswer: (value) {
                                setState(() {
                                  pelveValue = value;
                                  errorBox[3] = false;
                                });
                              },
                              groupValue: pelveValue,
                              index: 0,
                            ),
                            if(pelveValue == 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 23, right: 5),
                                    child: Column(
                                      children: [
                                        RadioListTile<int>(
                                          title: new Text(
                                            'Gibosidade',
                                            style: TextStyle(color: Colors.black54, fontSize: 16),
                                          ),
                                          value: 2,
                                          groupValue: pelveGroupValue,
                                          toggleable: true,
                                          onChanged: (int value) {setState(() {pelveGroupValue = value;});},
                                          activeColor: Color(0xFF6848AE),
                                        ),
                                        ACustomRadio(
                                          namedButton: 'Neutra',
                                          onAnswer: (value) {
                                            setState(() {
                                              pelveGroupValue = value;
                                            });
                                          },
                                          groupValue: pelveGroupValue,
                                          index: 3,
                                        ),
                                        ACustomRadio(
                                          namedButton: 'Anterovers??o',
                                          onAnswer: (value) {
                                            setState(() {
                                              pelveGroupValue = value;
                                            });
                                          },
                                          groupValue: pelveGroupValue,
                                          index: 4,
                                        ),
                                        ACustomRadio(
                                          namedButton: 'Retrovers??o',
                                          onAnswer: (value) {
                                            setState(() {
                                              pelveGroupValue = value;
                                            });
                                          },
                                          groupValue: pelveGroupValue,
                                          index: 5,
                                        ),
                                        ACustomRadio(
                                          namedButton: 'Inclina????o',
                                          onAnswer: (value) {
                                            setState(() {
                                              pelveGroupValue = value;
                                            });
                                          },
                                          groupValue: pelveGroupValue,
                                          index: 6,
                                        ),
                                        if(pelveGroupValue == 6)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: SingleCustomRadio(namedButton: ['direita', 'esquerda'],
                                                  onAnswer:(value) { setState(() {pelveValue1 = value;});},),
                                              ),
                                            ],
                                          ),
                                        ACustomRadio(
                                          namedButton: 'Rota????o',
                                          onAnswer: (value) {
                                            setState(() {
                                              pelveGroupValue = value;
                                            });
                                          },
                                          groupValue: pelveGroupValue,
                                          index: 7,
                                        ),
                                        if(pelveGroupValue == 7)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: Column(
                                                  children: [
                                                    CustomCheckbox(textBox: 'direita', onAnswer: (val){setState(() { rotacaoDireita = val;}); },),
                                                    CustomCheckbox(textBox: 'esquerda', onAnswer: (val){setState(() { rotacaoEsquerda = val;}); },),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ACustomRadio(
                                          namedButton: 'Outros',
                                          onAnswer: (value) {
                                            setState(() {
                                              pelveGroupValue = value;
                                            });
                                          },
                                          groupValue: pelveGroupValue,
                                          index: 8,
                                        ),
                                        if(pelveGroupValue == 8)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(height: 5.0),
                                              TextForm(text: 'Descreva:'),
                                              CustomForm(
                                                obscureText: false,
                                                hintText: 'Descreva neste campo',
                                                onChanged: (val) {
                                                  setState(() => pelveStr = val);
                                                },
                                              )
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ACustomRadio(
                              namedButton: 'Parcialmente flex??vel',
                              onAnswer: (value) {
                                setState(() {
                                  pelveValue = value;
                                  errorBox[3] = false;
                                });
                              },
                              groupValue: pelveValue,
                              index: 1,
                            ),
                            if(pelveValue == 1)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 23, right: 5),
                                    child: Column(
                                      children: [
                                        RadioListTile<int>(
                                          title: new Text(
                                            'Gibosidade',
                                            style: TextStyle(color: Colors.black54, fontSize: 16),
                                          ),
                                          value: 3,
                                          groupValue: troncoGroupValue,
                                          toggleable: true,
                                          onChanged: (int value) {setState(() {troncoGroupValue = value;});},
                                          activeColor: Color(0xFF6848AE),
                                        ),
                                        ACustomRadio(
                                          namedButton: 'Neutra',
                                          onAnswer: (value) {
                                            setState(() {
                                              pelveGroupValue = value;
                                            });
                                          },
                                          groupValue: pelveGroupValue,
                                          index: 3,
                                        ),
                                        ACustomRadio(
                                          namedButton: 'Anterovers??o',
                                          onAnswer: (value) {
                                            setState(() {
                                              pelveGroupValue = value;
                                            });
                                          },
                                          groupValue: pelveGroupValue,
                                          index: 4,
                                        ),
                                        ACustomRadio(
                                          namedButton: 'Retrovers??o',
                                          onAnswer: (value) {
                                            setState(() {
                                              pelveGroupValue = value;
                                            });
                                          },
                                          groupValue: pelveGroupValue,
                                          index: 5,
                                        ),
                                        ACustomRadio(
                                          namedButton: 'Inclina????o',
                                          onAnswer: (value) {
                                            setState(() {
                                              pelveGroupValue = value;
                                            });
                                          },
                                          groupValue: pelveGroupValue,
                                          index: 6,
                                        ),
                                        if(pelveGroupValue == 6)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: SingleCustomRadio(namedButton: ['direita', 'esquerda'],
                                                  onAnswer:(value) { setState(() {pelveValue1 = value;});},),
                                              ),
                                            ],
                                          ),
                                        ACustomRadio(
                                          namedButton: 'Rota????o',
                                          onAnswer: (value) {
                                            setState(() {
                                              pelveGroupValue = value;
                                            });
                                          },
                                          groupValue: pelveGroupValue,
                                          index: 7,
                                        ),
                                        if(pelveGroupValue == 7)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: Column(
                                                  children: [
                                                    CustomCheckbox(textBox: 'direita', onAnswer: (val){setState(() { rotacaoDireita = val;}); },),
                                                    CustomCheckbox(textBox: 'esquerda', onAnswer: (val){setState(() { rotacaoEsquerda = val;}); },),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ACustomRadio(
                                          namedButton: 'Outros',
                                          onAnswer: (value) {
                                            setState(() {
                                              pelveGroupValue = value;
                                            });
                                          },
                                          groupValue: pelveGroupValue,
                                          index: 8,
                                        ),
                                        if(pelveGroupValue == 8)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: SingleCustomRadio(namedButton: ['direita', 'esquerda'],
                                                  onAnswer:(value) { setState(() {pelveValue3 = value;});},),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ACustomRadio(
                              namedButton: 'R??gida',
                              onAnswer: (value) {
                                setState(() {
                                  pelveValue = value;
                                  errorBox[3] = false;
                                });
                              },
                              groupValue: pelveValue,
                              index: 2,
                            ),
                            if(pelveValue == 2)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 23, right: 5),
                                    child: Column(
                                      children: [
                                        RadioListTile<int>(
                                          title: new Text(
                                            'Gibosidade',
                                            style: TextStyle(color: Colors.black54, fontSize: 16),
                                          ),
                                          value: 3,
                                          groupValue: troncoGroupValue,
                                          toggleable: true,
                                          onChanged: (int value) {setState(() {troncoGroupValue = value;});},
                                          activeColor: Color(0xFF6848AE),
                                        ),
                                        ACustomRadio(
                                          namedButton: 'Neutra',
                                          onAnswer: (value) {
                                            setState(() {
                                              pelveGroupValue = value;
                                            });
                                          },
                                          groupValue: pelveGroupValue,
                                          index: 3,
                                        ),
                                        ACustomRadio(
                                          namedButton: 'Anterovers??o',
                                          onAnswer: (value) {
                                            setState(() {
                                              pelveGroupValue = value;
                                            });
                                          },
                                          groupValue: pelveGroupValue,
                                          index: 4,
                                        ),
                                        ACustomRadio(
                                          namedButton: 'Retrovers??o',
                                          onAnswer: (value) {
                                            setState(() {
                                              pelveGroupValue = value;
                                            });
                                          },
                                          groupValue: pelveGroupValue,
                                          index: 5,
                                        ),
                                        ACustomRadio(
                                          namedButton: 'Inclina????o',
                                          onAnswer: (value) {
                                            setState(() {
                                              pelveGroupValue = value;
                                            });
                                          },
                                          groupValue: pelveGroupValue,
                                          index: 6,
                                        ),
                                        if(pelveGroupValue == 6)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: SingleCustomRadio(namedButton: ['direita', 'esquerda'],
                                                  onAnswer:(value) { setState(() {pelveValue1 = value;});},),
                                              ),
                                            ],
                                          ),
                                        ACustomRadio(
                                          namedButton: 'Rota????o',
                                          onAnswer: (value) {
                                            setState(() {
                                              pelveGroupValue = value;
                                            });
                                          },
                                          groupValue: pelveGroupValue,
                                          index: 7,
                                        ),
                                        if(pelveGroupValue == 7)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: Column(
                                                  children: [
                                                    CustomCheckbox(textBox: 'direita', onAnswer: (val){setState(() { rotacaoDireita = val;}); },),
                                                    CustomCheckbox(textBox: 'esquerda', onAnswer: (val){setState(() { rotacaoEsquerda = val;}); },),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ACustomRadio(
                                          namedButton: 'Outros',
                                          onAnswer: (value) {
                                            setState(() {
                                              pelveGroupValue = value;
                                            });
                                          },
                                          groupValue: pelveGroupValue,
                                          index: 8,
                                        ),
                                        if(pelveGroupValue == 8)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: SingleCustomRadio(namedButton: ['direita', 'esquerda'],
                                                  onAnswer:(value) { setState(() {pelveValue3 = value;});},),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //Quadril
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
                            TextForm(text: 'Quadril *'),
                            SingleCustomRadio(
                              namedButton: quadril = ['Neutra','Abdu????o', 'Adu????o', 'Fixo', 'Parcialmente flex??vel', 'Subluxado'],
                              onAnswer: (value) {
                                setState(() {
                                  quadrilValue = value;
                                  errorBox[4] = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //Joelho
                      TextForm(text: 'Joelho'),
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
                            TextForm(text: 'Direito *'),
                            SingleCustomRadio(
                              namedButton: joelho = ['Flex??vel','Parcialmente flex??vel', 'R??gidez Flex??o', 'Rigidez Extens??o','Outros'],
                              onAnswer: (value) {
                                setState(() {
                                  joelhoDireitoValue = value;
                                  errorBox[5] = false;
                                });
                              },
                            ),
                            if(joelhoDireitoValue == 4)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5.0),
                                  TextForm(text: 'Descreva:'),
                                  CustomForm(
                                    obscureText: false,
                                    hintText: 'Descreva neste campo',
                                    onChanged: (val) {
                                      setState(() => joelhoDireitoStr = val);
                                    },
                                  )
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0),
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
                            TextForm(text: 'Esquerdo *'),
                            SingleCustomRadio(
                              namedButton: ['Flex??vel','Parcialmente flex??vel', 'R??gidez Flex??o', 'Rigidez Extens??o','Outros'],
                              onAnswer: (value) {
                                setState(() {
                                  joelhoEsquerdoValue = value;
                                  errorBox[6] = false;
                                });
                              },
                            ),
                            if(joelhoEsquerdoValue == 4)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5.0),
                                  TextForm(text: 'Descreva:'),
                                  CustomForm(
                                    obscureText: false,
                                    hintText: 'Descreva neste campo',
                                    onChanged: (val) {
                                      setState(() => joelhoEsquerdoStr = val);
                                    },
                                  )
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //Posicionamento dos p??s
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
                            TextForm(text: 'Posicionamento dos p??s *'),
                            ACustomRadio(
                              namedButton: 'Neutros',
                              onAnswer: (value) {
                                setState(() {
                                  posicionamentoPeValue = value;
                                  errorBox[7] = false;
                                });
                              },
                              groupValue: posicionamentoPeValue,
                              index: 0,
                            ),
                            ACustomRadio(
                              namedButton: 'Dorsiflex??o',
                              onAnswer: (value) {
                                setState(() {
                                  posicionamentoPeValue = value;
                                  errorBox[7] = false;
                                });
                              },
                              groupValue: posicionamentoPeValue,
                              index: 1,
                            ),
                            if (posicionamentoPeValue == 1)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 23, right: 5),
                                    child: Column(
                                      children: [
                                        CustomCheckbox(textBox: 'direita', onAnswer: (val){setState(() { dorsiflexaoDireita = val;}); },),
                                        CustomCheckbox(textBox: 'esquerda', onAnswer: (val){setState(() { dorsiflexaoEsquerda = val;}); },),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ACustomRadio(
                              namedButton: 'Flex??o plantar',
                              onAnswer: (value) {
                                setState(() {
                                  posicionamentoPeValue = value;
                                  errorBox[7] = false;
                                });
                              },
                              groupValue: posicionamentoPeValue,
                              index: 2,
                            ),
                            if (posicionamentoPeValue == 2)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 23, right: 5),
                                    child: Column(
                                      children: [
                                        CustomCheckbox(textBox: 'direita', onAnswer: (val){setState(() { flexaoDireita = val;}); },),
                                        CustomCheckbox(textBox: 'esquerda', onAnswer: (val){setState(() { flexaoEsquerda = val;}); },),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ACustomRadio(
                              namedButton: 'Invers??o',
                              onAnswer: (value) {
                                setState(() {
                                  posicionamentoPeValue = value;
                                  errorBox[7] = false;
                                });
                              },
                              groupValue: posicionamentoPeValue,
                              index: 3,
                            ),
                            if (posicionamentoPeValue == 3)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 23, right: 5),
                                    child: Column(
                                      children: [
                                        CustomCheckbox(textBox: 'direita', onAnswer: (val){setState(() { inversaoDireita = val;}); },),
                                        CustomCheckbox(textBox: 'esquerda', onAnswer: (val){setState(() { inversaoEsquerda = val;}); },),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ACustomRadio(
                              namedButton: 'Evers??o',
                              onAnswer: (value) {
                                setState(() {
                                  posicionamentoPeValue = value;
                                  errorBox[7] = false;
                                });
                              },
                              groupValue: posicionamentoPeValue,
                              index: 4,
                            ),
                            if (posicionamentoPeValue == 4)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 23, right: 5),
                                    child: Column(
                                      children: [
                                        CustomCheckbox(textBox: 'direita', onAnswer: (val){setState(() { eversaoDireita = val;}); },),
                                        CustomCheckbox(textBox: 'esquerda', onAnswer: (val){setState(() { eversaoEsquerda = val;}); },),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ACustomRadio(
                              namedButton: 'Outro',
                              onAnswer: (value) {
                                setState(() {
                                  posicionamentoPeValue = value;
                                  errorBox[7] = false;
                                });
                              },
                              groupValue: posicionamentoPeValue,
                              index: 5,
                            ),
                            if(posicionamentoPeValue == 5)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5.0),
                                  TextForm(text: 'Descreva:'),
                                  CustomForm(
                                    obscureText: false,
                                    hintText: 'Descreva neste campo',
                                    onChanged: (val) {
                                      setState(() => outroPosicStr = val);
                                    },
                                  )
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      TextForm(text: 'Habilidades para propuls??o da cadeira'),
                      SizedBox(height: 30.0),

                      //Possui habilidade adequadas para a condu????o segura de uma cadeira de rodas?
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
                            TextForm(text: 'Possui habilidade adequadas para a condu????o segura de uma cadeira de rodas? *'),
                            SingleCustomRadio(
                              namedButton: ['Sim','N??o'],
                              onAnswer: (value) {
                                setState(() {
                                  possuiHabValue = value;
                                  errorBox[8] = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //Possui habilidade adequadas para a condu????o segura de uma cadeira de rodas?
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
                            TextForm(text: 'Tipo de propuls??o *'),
                            SingleCustomRadio(
                              namedButton: propulsao = ['Propuls??o pela pessoa com defici??ncia','Propuls??o pelo acompanhante','Propuls??o por motor'],
                              onAnswer: (value) {
                                setState(() {
                                  tipoPropusaoValue = value;
                                  errorBox[9] = false;
                                });
                              },
                            ),
                            if(tipoPropusaoValue == 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5.0),
                                  TextForm(text: 'M??todo de impuls??o'),
                                  CustomForm(
                                    obscureText: false,
                                    hintText: 'Descreva neste campo',
                                    onChanged: (val) {
                                      setState(() => outraPropStr = val);
                                    },
                                  )
                                ],
                              ),
                            if(tipoPropusaoValue == 2)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5.0),
                                  //Controle cadeira de rodas motorizada
                                  TextForm(text: 'Controle cadeira de rodas motorizada'),
                                  SingleCustomRadio(
                                    namedButton: controleCadeira = ['Joystick m??o direita','Joystick m??o esquerda','Joystick alternativo'],
                                    onAnswer: (value) {
                                      setState(() {
                                        controleCadeiraValue = value;
                                      });
                                    },
                                  ),
                                  if(controleCadeiraValue == 2)
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        TextForm(text: 'Descreva:'),
                                        CustomForm(
                                          obscureText: false,
                                          hintText: 'Descreva neste campo',
                                          onChanged: (val) {
                                            setState(() => controleCadeiraStr = val);
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

                      //Como o usu??rio impulsionar?? a cadeira de rodas?
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
                            TextForm(text: 'Como o usu??rio impulsionar?? a cadeira de rodas? *'),
                            CustomCheckbox(textBox: 'Bra??o', onAnswer: (val){setState(() { braco = val;errorBox[10] = false;}); },),
                            if(braco)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 23, right: 5),
                                    child: Column(
                                      children: [
                                        CustomCheckbox(textBox: 'Bra??o direito', onAnswer: (val){setState(() { bracoDireito = val;}); },),
                                        CustomCheckbox(textBox: 'Bra??o esquerdo', onAnswer: (val){setState(() { bracoEsquerdo = val;}); },),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            CustomCheckbox(textBox: 'Membro inferior', onAnswer: (val){setState(() { membInf = val;errorBox[10] = false;}); },),
                            if(membInf)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 23, right: 5),
                                    child: Column(
                                      children: [
                                        CustomCheckbox(textBox: 'Membro inferior esquerdo', onAnswer: (val){setState(() { membInfEsq = val;}); },),
                                        CustomCheckbox(textBox: 'Membro inferior direito', onAnswer: (val){setState(() { membInfDir = val;}); },),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            CustomCheckbox(textBox: 'Empurrado por auxiliar', onAnswer: (val){setState(() { empurrado = val;errorBox[10] = false;}); },),
                            CustomCheckbox(textBox: 'Queixo ou cabe??a', onAnswer: (val){setState(() { queixo = val;errorBox[10] = false;}); },),
                            CustomCheckbox(textBox: 'Outros', onAnswer: (val){setState(() { outrosImpulsos = val;errorBox[10] = false;}); },),
                            if(outrosImpulsos)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5.0),
                                  TextForm(text: 'Descreva:'),
                                  CustomForm(
                                    obscureText: false,
                                    hintText: 'Descreva neste campo',
                                    onChanged: (val) {
                                      setState(() => outrosImpulsosStr = val);
                                    },
                                  )
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),



                      //enviar
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 5.0,
                            primary: Color(0xFF6848AE),
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Text(
                            'ENVIAR',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          onPressed: () async {
                            try {
                              _resetCheck();
                              FocusScope.of(context).unfocus();
                              ombro = {
                                'Alinhados':alinhado,
                                'Protus??o': protusao ? protusaoDireita &&  protusaoEsquerda ?  'Protus??o direita e esquerda' : protusaoDireita ? 'Protus??o direita' : protusaoEsquerda ? 'Protus??o esquerda' : 'Nenhum campo selecionado' : false,
                                'Retra????o': retracao ? retracaoDireita &&  retracaoEsquerda ?  'Retra????o direita e esquerda' : retracaoDireita ? 'Retra????o direita' : retracaoEsquerda ? 'Retra????o esquerda' : 'Nenhum campo selecionado' : false,
                                'Eleva????o': elevacao ? elevacaoDireita &&  elevacaoEsquerda ?  'Eleva????o direita e esquerda' : elevacaoDireita ? 'Eleva????o direita' : elevacaoEsquerda ? 'Eleva????o esquerda' : 'Nenhum campo selecionado' : false,
                                'Depress??o': depressao ? depressaoDireita &&  depressaoEsquerda ?  'Depress??o direita e esquerda' : depressaoDireita ? 'Depress??o direita' : depressaoEsquerda ? 'Depress??o esquerda' : 'Nenhum campo selecionado' : false,
                              };
                              tronco2 = {
                                'Gibosidade' : troncoGroupValue == 3 ? gibosidadeDireita &&  gibosidadeEsquerda ?  'Gibosidade direita e esquerda' : gibosidadeDireita ? 'Gibosidade direita' : gibosidadeEsquerda ? 'Gibosidade esquerda' : 'Nenhum campo selecionado' : false,
                                'Escoliose': troncoGroupValue == 4 ? troncoValue3 == 0 ? 'Escoliose direita' : troncoValue3 == 1 ? 'Escoliose esquerda' : troncoValue3 == 2 ? 'Escoliose em S' : 'Nenhum campo selecionado' : false,
                                'Cifose': troncoGroupValue == 5 ? troncoValue4 == 0 ? 'Cifose direita' : troncoValue4 == 1 ? 'Cifose esquerda' : 'Nenhum campo selecionado' : false,
                                'Hiperlordose': troncoGroupValue == 6 ? 'Hiperlordose': false,
                                'Outros': troncoGroupValue == 7 ? troncoStr : false,
                              };
                              pelve2 = {
                                'Gibosidade' : pelveGroupValue == 2 ? true : false,
                                'Neutra':pelveGroupValue == 3 ? true : false,
                                'Anterovers??o':pelveGroupValue == 4 ? true : false,
                                'Retrovers??o':pelveGroupValue == 5 ? true : false,
                                'Inclina????o': pelveGroupValue == 6 ? pelveValue1 == 0 ? 'Inclina????o direita' : pelveValue1 == 1 ? 'Inclina????o esquerda' : 'Nenhum campo selecionado' : false,
                                'Rota????o': pelveGroupValue == 7 ? rotacaoDireita &&  rotacaoEsquerda ?  'Rota????o direita e esquerda' : rotacaoDireita ? 'Rota????o direita' : rotacaoEsquerda ? 'Rota????o esquerda' : 'Nenhum campo selecionado' : false,
                                'Outros': pelveGroupValue == 8 ? pelveStr : false,
                              };
                              posPe = {
                                'Neutros': posicionamentoPeValue == 0 ? true : false,
                                'Dorsiflex??o': posicionamentoPeValue == 1 ? dorsiflexaoDireita &&  dorsiflexaoEsquerda ?  'Dorsiflex??o direita e esquerda' : dorsiflexaoDireita ? 'Dorsiflex??o direita' : dorsiflexaoEsquerda ? 'Dorsiflex??o esquerda' : 'Nenhum campo selecionado' : false,
                                'Flex??o plantar' :posicionamentoPeValue == 2 ? flexaoDireita &&  flexaoEsquerda ?  'Flex??o plantar direita e esquerda' : flexaoDireita ? 'Flex??o plantar direita' : flexaoEsquerda ? 'Flex??o plantar esquerda' : 'Nenhum campo selecionado' : false,
                                'Invers??o' :posicionamentoPeValue == 3 ? inversaoDireita &&  inversaoEsquerda ?  'Invers??o direita e esquerda' : inversaoDireita ? 'Invers??o direita' : inversaoEsquerda ? 'Invers??o esquerda' : 'Nenhum campo selecionado' : false,
                                'Evers??o' :posicionamentoPeValue == 4 ? eversaoEsquerda &&  eversaoDireita?  'Evers??o direita e esquerda' : eversaoDireita ? 'Evers??o direita' : eversaoEsquerda ? 'Evers??o esquerda' : 'Nenhum campo selecionado' : false,
                                'Outro': posicionamentoPeValue == 5 ? outroPosicStr : false,
                              };
                              impulso = {
                                'Bra??o': braco ? bracoDireito &&  bracoEsquerdo ?  'Bra??o direito e esquerdo' : bracoDireito ? 'Bra??o direita' : bracoEsquerdo ? 'Bra??o esquerda' : 'Nenhum campo selecionado' : false,
                                'Membro Inferior': membInf ? membInfDir &&  membInfEsq ?  'Membro Inferior direito e esquerdo' : membInfDir ? 'Membro Inferior direita' : membInfEsq ? 'Membro Inferior esquerda' : 'Nenhum campo selecionado' : false,
                                'Empurrado por auxiliar': empurrado,
                                'Queixo ou cabe??a': queixo,
                                'Outros': outrosImpulsos ? outrosImpulsosStr : false,
                              };
                              postura = {
                                'Cabe??a e pesco??o': cabecaValue == 2 ? cabeca2[cabecaFlexValue] : cabeca[cabecaValue],
                                'Ombros': ombro,
                                'Tronco': tronco[troncoValue],
                                'Tronco 2': tronco2,
                                'Pelve': tronco[pelveValue],
                                'Pelve 2': pelve2,
                                'Quadril': quadril[quadrilValue],
                                'Joelho Direito': joelho[joelhoDireitoValue],
                                'Joelho Esquerdo': joelho[joelhoEsquerdoValue],
                                'Posicionamento dos p??s': posPe,
                                'Possui habilidade adequadas para a condu????o segura de uma cadeira de rodas?': possuiHabValue == 0 ? 'Sim':'N??o',
                                'Tipo de propuls??o': tipoPropusaoValue == 0 ? outraPropStr : tipoPropusaoValue == 2 ? controleCadeiraValue == 2 ? controleCadeiraStr : controleCadeira[controleCadeiraValue] : propulsao[tipoPropusaoValue],
                                'Como o usu??rio impulsionar?? a cadeira de rodas?': impulso,
                              };
                              DatabaseService(uid: user.uid).createFormAtt(FormATT(
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
                                  alimentacao: widget.alimentacao,
                                  vestirse: widget.vestirse,
                                  banho: widget.banho,
                                  higiene: widget.higiene,
                                  controleVesical: widget.controleVesical,
                                  controleIntestinal: widget.controleIntestinal,
                                  condMotora: widget.condMotora,
                                  reflexo: widget.condMotora,
                                  tonus: widget.tonus,
                                  postura: postura,
                                  joelhoDireito: joelhoDireitoValue == 4 ? joelhoDireitoStr : joelho[joelhoDireitoValue],
                                  joelhoEsquerdo: joelhoEsquerdoValue == 4 ? joelhoEsquerdoStr : joelho[joelhoEsquerdoValue],
                                  uid: user.uid,
                                  hour: DateTime.now(),
                                  deficit: widget.deficit
                              ));
                              setState(() => pressed = true);
                              _showCheck();
                            } catch (e){
                              if (e.toString() == 'Invalid argument(s)')
                                errorTest();
                            }
                          },
                        ),
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
    );
  }
  void errorTest(){
    setState(() {
      if (cabecaValue == null)
        errorBox[0] = true;
      if (alinhado == false && protusao == false && retracao == false && elevacao == false && depressao == false)
        errorBox[1] = true;
      if (troncoValue == null)
        errorBox[2] = true;
      if (pelveValue == null)
        errorBox[3] = true;
      if (quadrilValue == null)
        errorBox[4] = true;
      if (joelhoDireitoValue == null)
        errorBox[5] = true;
      if (joelhoEsquerdoValue == null)
        errorBox[6] = true;
      if (posicionamentoPeValue == null)
        errorBox[7] = true;
      if (possuiHabValue == null)
        errorBox[8] = true;
      if (tipoPropusaoValue == null)
        errorBox[9] = true;
      if (braco == false && membInf == false && empurrado == false && queixo == false && outrosImpulsos == false)
        errorBox[10] = true;
    });
  }
}
