import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/shared/loading.dart';
import 'atendimento.dart';
import 'atendimento3.dart';

// ignore: must_be_immutable
class Atendimento2 extends StatefulWidget {
  final String estadoMatrimonial, grauEscolaridade, ocupacao, diagAttendance;

  final Function toggleView;
  Atendimento2(
      {this.toggleView,
      this.estadoMatrimonial,
      this.grauEscolaridade,
      this.ocupacao,
      this.diagAttendance});

  @override
  _Atendimento2State createState() => _Atendimento2State();
}

class _Atendimento2State extends State<Atendimento2> {
  final _formkey = GlobalKey<FormState>();
  Map<String, bool> motivoAvaliacao = <String, bool>{};
  List<String> simNao = ['Sim', 'Não'], processoDoencaList = ['Estável', 'Progressiva'];
  List<bool> errorBox = [false, false, false, false];
  int realizouCirurgia,
      qualCirurgiaValue,
      medicacaoValue,
      processoDoencaValue,
      numCirurgia;
  String queixaPrincipal,incipal,
      historicoAtual,
      qualCirurgia = 'Não',
      medicacao = 'Não',
      processoDoenca = 'Não',
      dataCirurgia = '',
  error = '';
  bool semCadeira = false, cadeiraQuebrada = false, cadeiraInvalida = false;
  bool loading = false;

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

                        //Queixa principal
                        TextForm(text: 'Queixa principal *'),
                        CustomForm(
                          obscureText: false,
                          hintText: 'Digite a queixa principal',
                          onChanged: (val) {
                            setState(() => queixaPrincipal = val);
                          },
                          validator: (val) => val.isEmpty ? '' : null,
                        ),
                        SizedBox(height: 30.0),

                        //Histórico atual e progresso da doença:
                        TextForm(text: 'Histórico atual e pregresso da doença *'),
                        CustomForm(
                          obscureText: false,
                          validator: (val) => val.isEmpty ? '' : null,
                          hintText: 'Digite o histórico atual',
                          onChanged: (val) {
                            setState(() => historicoAtual = val);
                          },
                        ),
                        SizedBox(height: 30.0),

                        //Já realizou cirurgias?
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
                              TextForm(text: 'Já realizou cirurgias? *'),
                              SingleCustomRadio(
                                namedButton: simNao,
                                onAnswer: (value) {
                                  setState(() {
                                    realizouCirurgia = value;
                                    errorBox[0] = false;
                                  });
                                },
                              ),
                              //if (realizouCirurgia == 0)
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     for (int index = 1; index  <= numCirurgia; ++index)
                                //       new Container(
                                //         decoration: BoxDecoration(
                                //             border: Border(
                                //                 bottom: BorderSide(
                                //                     width: 5,
                                //                     color: Color(0xFF6848AE)))),
                                //         padding: EdgeInsets.only(left: 23, right: 5),
                                //         child: Column(
                                //           crossAxisAlignment: CrossAxisAlignment.start,
                                //           children: <Widget>[
                                //             SizedBox(height: 15.0),
                                //             TextForm(text: 'Qual?'),
                                //             SingleCustomRadio(
                                //               namedButton: [
                                //                 'Coluna',
                                //                 'Quadril',
                                //                 'Membros superiores',
                                //                 'Membros inferiores',
                                //                 'Outros'
                                //               ],
                                //               onAnswer: (value) {
                                //                 setState(() {
                                //                   qualCirurgiaValue = value;
                                //                 });
                                //               },
                                //             ),
                                //             if (qualCirurgiaValue == 4)
                                //               Column(
                                //                 crossAxisAlignment: CrossAxisAlignment.start,
                                //                 children: <Widget>[
                                //                   SizedBox(height: 5.0),
                                //                   TextForm(text: 'Descreva:'),
                                //                   CustomForm(
                                //                     obscureText: false,
                                //                     hintText: 'Descreva a cirurgia',
                                //                     onChanged: (val) {
                                //                       setState(() => qualCirurgia = val);
                                //                     },
                                //                   )
                                //                 ],
                                //               ),
                                //             SizedBox(height: 20.0),
                                //             TextForm(text: 'Quando realizou?'),
                                //             CustomForm(
                                //               obscureText: false,
                                //               inputFormatters: [
                                //                 FilteringTextInputFormatter.digitsOnly,
                                //                 DataInputFormatter(),
                                //               ],
                                //               hintText: 'Digite a data da cirurgia',
                                //               onChanged: (val) {
                                //                 setState(() => dataCirurgia = val);
                                //               },
                                //             ),
                                //             SizedBox(height: 30.0),
                                //           ],
                                //         ),
                                //       ),
                                //     SizedBox(height: 30.0),
                                //     Container(
                                //       padding: EdgeInsets.only(left: 23, right: 23, bottom: 25),
                                //       child: Row(
                                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             FloatingActionButton(
                                //               child: const Icon(Icons.delete),
                                //               backgroundColor: Color(0xFF6848AE),
                                //               onPressed: () {
                                //                 setState(() {
                                //                   if(numCirurgia > 1)
                                //                     numCirurgia--;
                                //                 });
                                //               },
                                //             ),
                                //             FloatingActionButton(
                                //               child: const Icon(Icons.add),
                                //               backgroundColor: Color(0xFF6848AE),
                                //               onPressed: () {
                                //                 setState(() => numCirurgia++);
                                //               },
                                //             ),
                                //           ]
                                //       ),
                                //     ),
                                //   ],
                                // ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.0),

                        //Faz uso de medicação? Se sim, quais?
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
                              TextForm(text: 'Faz uso de medicação? *'),
                              SizedBox(height: 5.0),
                              SingleCustomRadio(
                                namedButton: simNao,
                                onAnswer: (value) {
                                  setState(() {
                                    medicacaoValue = value;
                                    errorBox[1] = false;
                                  });
                                },
                              ),
                              if (medicacaoValue == 0)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 5.0),
                                    TextForm(text: 'Quais?'),
                                    CustomForm(
                                      obscureText: false,
                                      hintText: 'Digite a(s) medicação(ões)',
                                      onChanged: (val) {
                                        setState(() => medicacao = val);
                                      },
                                    )
                                  ],
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.0),

                        //Processo da doença
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
                              TextForm(text: 'Processo da doença *'),
                              SingleCustomRadio(
                                namedButton: processoDoencaList,
                                onAnswer: (value) {
                                  setState(() {
                                    processoDoencaValue = value;
                                    errorBox[2] = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.0),


                        //Qual motivo da avaliação?
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
                              TextForm(text: 'Qual motivo da avaliação?'),
                              CustomCheckbox(
                                textBox: 'Não possui cadeira de rodas',
                                onAnswer: (value) {
                                  setState(() {
                                    semCadeira = value;
                                    errorBox[3] = false;
                                  });
                                },
                              ),
                              CustomCheckbox(
                                textBox: 'Cadeira de rodas está quebrada',
                                onAnswer: (value) {
                                  setState(() {
                                    cadeiraQuebrada = value;
                                    errorBox[3] = false;
                                  });
                                },
                              ),
                              CustomCheckbox(
                                textBox:
                                'Cadeira de rodas que não atende suas necessidades',
                                onAnswer: (value) {
                                  setState(() {
                                    cadeiraInvalida = value;
                                    errorBox[3] = false;
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
                                  Navigator.pop(context,
                                      SlideRightRoute(widget: Atendimento()));
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
                                onPressed: () {
                                  if (_formkey.currentState.validate()){
                                    motivoAvaliacao = {
                                      'Não possui cadeira de rodas' : semCadeira,
                                      'Cadeira de rodas está quebrada': cadeiraQuebrada,
                                      'Cadeira de rodas que não atende suas necessidades': cadeiraInvalida,
                                    };


                                      try {
                                        Navigator.push(
                                          context,
                                          SlideRightRoute4(
                                              widget: Atendimento3(
                                                estadoMatrimonial:
                                                widget.estadoMatrimonial,
                                                grauEscolaridade: widget.grauEscolaridade,
                                                ocupacao: widget.ocupacao,
                                                diagAttendance: widget.diagAttendance,
                                                queixaPrincipal: queixaPrincipal,
                                                historicoAtual: historicoAtual,
                                                qualCirurgia: simNao[realizouCirurgia],
                                                medicacao: medicacaoValue == 0 ? medicacao : simNao[medicacaoValue],
                                                processoDoenca: processoDoencaList[processoDoencaValue],
                                                motivoAvaliacao: motivoAvaliacao,
                                              )),
                                        );
                                      } catch (e){
                                        if (e.toString() == 'Invalid argument(s)')
                                          errorTest();
                                      }
                                  } else {
                                    errorTest();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))),
            ),
          );
  }
  errorTest(){
    setState(() {
      if (realizouCirurgia == null)
        errorBox[0] = true;
      if (medicacaoValue == null)
        errorBox[1] = true;
      if (processoDoencaValue == null)
        errorBox[2] = true;
      if (semCadeira == false && cadeiraQuebrada == false && cadeiraInvalida == false)
        errorBox[3] = true;
    });
  }
}

