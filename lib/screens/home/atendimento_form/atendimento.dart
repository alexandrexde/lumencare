import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'atendimento2.dart';


class Atendimento extends StatefulWidget {

  @override
  _AtendimentoState createState() => _AtendimentoState();
}

class _AtendimentoState extends State<Atendimento>{
  final _formkey = GlobalKey<FormState>();
  int estadoMatrimonialValue, grauEscolaridadeValue, ocupacaoValue, diagnosticoAttendanceValue, diagnosticoAttendanceValue2;
  List<String> estadoMatrimonial = <String>['Solteiro', 'Casado', 'Divorciado', 'Separado', 'Viúvo'],
      grauEscolaridade= <String>['Não frequentou a escola', 'Não completou a educação formal', 'Educação infantil', 'Ensino fundamental', 'Ensino médio', 'Ensino superior'
        ,'Pós-graduação',],
      ocupacao= <String>['Emprego assalariado', 'Trabalha por conta própria (autônomo)', 'Não assalariado', 'Estudante', 'Dona de casa', 'Aposentado',
        'Desempregado', 'Outro'],
      diagnosticoAttendance= <String>['Paralisia cerebral','Doença neuromuscular','Doença neurodegenerativa','Pólio','Lesão Medular','AVC/Trombose cerebral',
        'Fragilidade','Espasmos ou movimentos involutário','Amputação','Outro'], anotherDiag= <String>['acima do joelho direito', 'abaixo do joelho direito', 'acima do joelho esquerdo', 'abaixo do joelho esquerdo'];
  String outraOcupacao, outroDiagnostico, error = '';
  List<bool> errorBox = [false, false, false, false];

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

    return Scaffold(
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
                Text('ENTREVISTA DE AVALIAÇÃO', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                SizedBox(height: 10),
                TextForm(text: '* Obrigatório'),
                SizedBox(height: 15),
                // Text('Profissional responsável pela avaliação: '),
                // SizedBox(height: 25),

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
                      TextForm(text: 'Estado Matrimonial Atual *'),
                      SizedBox(height: 10),
                      SingleCustomRadio(namedButton: estadoMatrimonial,
                        onAnswer: (value){ setState(() {estadoMatrimonialValue = value; errorBox[0] = false;});},),
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
                      TextForm(text: 'Grau de Escolaridade Atual *'),
                      SizedBox(height: 10),
                      SingleCustomRadio(namedButton: grauEscolaridade ,onAnswer: (value) { setState(() {grauEscolaridadeValue = value;errorBox[1] = false;});},),
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
                      TextForm(text: 'Ocupação Atual *'),
                      SizedBox(height: 10),
                      SingleCustomRadio(namedButton: ocupacao , onAnswer: (value) { setState(() {ocupacaoValue = value; errorBox[2] = false;});},),
                      if(ocupacaoValue == 7)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            TextForm(text: 'Qual?'),

                            TextFormField(
                              //form field name
                              cursorColor: Color(0xFF6848AE),
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF6848AE),
                                    width: 2.0,
                                  ),
                                ),
                                contentPadding: EdgeInsets.all(8.0),
                                hintText: 'Digite a ocupação',
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.4),
                                  fontSize: 14.0,
                                ),
                              ),
                              onChanged: (val) {
                                setState(() => outraOcupacao = val);
                              },
                            ),
                          ],
                        ),
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
                      TextForm(text: 'Diagnóstico médico *'),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          RadioListTile<int>(
                            title: new Text(
                              diagnosticoAttendance[0],
                              style: TextStyle(color: Colors.black54, fontSize: 16),
                            ),
                            value: 1,
                            groupValue: diagnosticoAttendanceValue,
                            onChanged: (int value) {setState(() {diagnosticoAttendanceValue = value; errorBox[3] = false;});},
                            activeColor: Color(0xFF6848AE),
                          ),
                          RadioListTile<int>(
                            title: new Text(
                              diagnosticoAttendance[1] ,
                              style: TextStyle(color: Colors.black54, fontSize: 16),
                            ),
                            value: 2,
                            groupValue: diagnosticoAttendanceValue,
                            onChanged: (int value) {setState(() {diagnosticoAttendanceValue = value;errorBox[3] = false;});},
                            activeColor: Color(0xFF6848AE),
                          ),
                          RadioListTile<int>(
                            title: new Text(
                              diagnosticoAttendance[2] ,
                              style: TextStyle(color: Colors.black54, fontSize: 16),
                            ),
                            value: 3,
                            groupValue: diagnosticoAttendanceValue,
                            onChanged: (int value) {setState(() {diagnosticoAttendanceValue = value;errorBox[3] = false;});},
                            activeColor: Color(0xFF6848AE),
                          ),
                          RadioListTile<int>(
                            title: new Text(
                              diagnosticoAttendance[3] ,
                              style: TextStyle(color: Colors.black54, fontSize: 16),
                            ),
                            value: 4,
                            groupValue: diagnosticoAttendanceValue,
                            onChanged: (int value) {setState(() {diagnosticoAttendanceValue = value;errorBox[3] = false;});},
                            activeColor: Color(0xFF6848AE),
                          ),
                          RadioListTile<int>(
                            title: new Text(
                              diagnosticoAttendance[4],
                              style: TextStyle(color: Colors.black54, fontSize: 16),
                            ),
                            value: 5,
                            groupValue: diagnosticoAttendanceValue,
                            onChanged: (int value) {setState(() {diagnosticoAttendanceValue = value;errorBox[3] = false;});},
                            activeColor: Color(0xFF6848AE),
                          ),
                          RadioListTile<int>(
                            title: new Text(
                              diagnosticoAttendance[5],
                              style: TextStyle(color: Colors.black54, fontSize: 16),
                            ),
                            value: 6,
                            groupValue: diagnosticoAttendanceValue,
                            onChanged: (int value) {setState(() {diagnosticoAttendanceValue = value;errorBox[3] = false;});},
                            activeColor: Color(0xFF6848AE),
                          ),
                          RadioListTile<int>(
                            title: new Text(
                              diagnosticoAttendance[6],
                              style: TextStyle(color: Colors.black54, fontSize: 16),
                            ),
                            value: 7,
                            groupValue: diagnosticoAttendanceValue,
                            onChanged: (int value) {setState(() {diagnosticoAttendanceValue = value;errorBox[3] = false;});},
                            activeColor: Color(0xFF6848AE),
                          ),
                          RadioListTile<int>(
                            title: new Text(
                              diagnosticoAttendance[7],
                              style: TextStyle(color: Colors.black54, fontSize: 16),
                            ),
                            value: 8,
                            groupValue: diagnosticoAttendanceValue,
                            onChanged: (int value) {setState(() {diagnosticoAttendanceValue = value;});},
                            activeColor: Color(0xFF6848AE),
                          ),
                          RadioListTile<int>(
                            title: new Text(
                              diagnosticoAttendance[8],
                              style: TextStyle(color: Colors.black54, fontSize: 16),
                            ),
                            value: 9,
                            groupValue: diagnosticoAttendanceValue,
                            onChanged: (int value) {setState(() {diagnosticoAttendanceValue = value;errorBox[3] = false;});},
                            activeColor: Color(0xFF6848AE),
                          ),
                          if (diagnosticoAttendanceValue == 9)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 23, right: 5),
                                  child: SingleCustomRadio(namedButton: anotherDiag,
                                    onAnswer:(value) { setState(() {diagnosticoAttendanceValue2 = value;errorBox[3] = false;});},),
                                ),
                              ],
                            ),
                          RadioListTile<int>(
                            title: new Text(
                              diagnosticoAttendance[9],
                              style: TextStyle(color: Colors.black54, fontSize: 16),
                            ),
                            value: 10,
                            groupValue: diagnosticoAttendanceValue,
                            toggleable: true,
                            onChanged: (int value) {setState(() {diagnosticoAttendanceValue = value;errorBox[3] = false;});},
                            activeColor: Color(0xFF6848AE),
                          ),
                          if(diagnosticoAttendanceValue == 10)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                TextForm(text: 'Qual?'),
                                TextFormField(
                                  //form field name
                                  cursorColor: Color(0xFF6848AE),
                                  decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF6848AE),
                                        width: 2.0,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.all(8.0),
                                    hintText: 'Digite o diagnóstico',
                                    hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.4),
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  onChanged: (val) {
                                    setState(() => outroDiagnostico = val);
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.0),

                //error widget
                // Text(
                //   //error text
                //   error,
                //   style: TextStyle(
                //     color: Colors.red,
                //     fontSize: 14.0,
                //   ),
                // ),

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

                          if (_formkey.currentState.validate()) {
                            if(diagnosticoAttendanceValue == 9){
                              outroDiagnostico = 'Amputação ' + anotherDiag[diagnosticoAttendanceValue2];
                            }
                            try {
                                Navigator.push(
                                  context,
                                  SlideRightRoute4(
                                      widget: Atendimento2(
                                        estadoMatrimonial: estadoMatrimonial[estadoMatrimonialValue],
                                        grauEscolaridade: grauEscolaridade[grauEscolaridadeValue],
                                        ocupacao: ocupacaoValue == 7 ? outraOcupacao : ocupacao[ocupacaoValue],
                                        diagAttendance: diagnosticoAttendanceValue == 9 || diagnosticoAttendanceValue == 10 ? outroDiagnostico : diagnosticoAttendance[diagnosticoAttendanceValue],
                                      )),
                                );
                            } catch (e){
                              if (e.toString() == 'Invalid argument(s)')
                                setState(() {
                                  //error = 'Preencha os campos vazios';
                                  if (estadoMatrimonialValue == null)
                                    errorBox[0] = true;
                                  if (grauEscolaridadeValue == null)
                                    errorBox[1] = true;
                                  if (ocupacaoValue == null)
                                    errorBox[2] = true;
                                  if (diagnosticoAttendanceValue == null)
                                    errorBox[3] = true;
                                  if (diagnosticoAttendanceValue == 9)
                                    if (diagnosticoAttendanceValue2 == null)
                                      errorBox[3] = true;
                                } );
                            }
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
      ),
    );
  }
}


