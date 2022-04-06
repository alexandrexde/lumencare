import 'package:brasil_fields/brasil_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/screens/home/prescricao_form/prescricao2.dart';
import 'package:lumen/services/database.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';



class Prescricao extends StatefulWidget {

  final typeUser;
  const Prescricao({Key key,this.typeUser}) : super(key: key);

  @override
  _PrescricaoState createState() => _PrescricaoState();
}

class _PrescricaoState extends State<Prescricao>{
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<String> faixaEtaria = [''], tipoCadeira = [''], tipoAlmofada = [''];
  String error, altura, peso, larguraAssento, alturaAssento, compAssento, descAlmofada;
  int tipoAssentoPersoValue, tipoAssentoLadoValue, faixaEtariaValue, tipoCadeiraValue, tipoAssentoValue, tipoAssentoOriginalValue, tipoAssentoRigidoValue, tipoAlmofadaValue, tipoAssentoProfunValue, tipoAssentoAltValue;
  Map<String,dynamic> pageData;
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

    final user = Provider.of<Users>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(title: 'Prescrição'),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 50.0,
          ),
          child: Container(
            child:  StreamBuilder<UserData>(
              stream: widget.typeUser == 'Client' ? DatabaseService(uid: user.uid).userData : widget.typeUser == 'Company' ? DatabaseService(uid: user.uid).userDataCompany : DatabaseService(uid: user.uid).userDataProfessional,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  User users = _auth.currentUser;
                  String uid = 'US8OS6rBg3SoN2M1EaHjKbBey7b2';
                  return Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextForm(text: '* Obrigatório'),
                        SizedBox(height: 15),

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
                              TextForm(text: 'Faixa etária'),
                              SizedBox(height: 10),
                              SingleCustomRadio(namedButton: faixaEtaria = ['Infantil', 'Juvenil', 'Adulto', 'Idoso'],
                                onAnswer: (value){ setState(() {faixaEtariaValue = value;errorBox[0] = false;});},),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),

                        //Altura
                        TextForm(text: 'Altura aproximada *'),
                        CustomForm (
                          hintText: 'Digite sua altura',
                          keyboardType: TextInputType.number,
                          validator: (val) => val.isEmpty ? 'Digite sua altura (em cm)' : null,
                          onChanged: (val) {
                            setState(() => altura = val);
                          },
                          obscureText: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            AlturaInputFormatter(),
                          ],
                        ),
                        SizedBox(height: 30.0),

                        //peso
                        TextForm(text: 'Peso aproximado *'),
                        CustomForm(
                          hintText: 'Digite seu peso',
                          keyboardType: TextInputType.number,
                          validator: (val) => val.isEmpty ? 'Digite seu peso' : null,
                          onChanged: (val) {
                            setState(() => peso = val);
                          },
                          obscureText: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            PesoInputFormatter(),
                          ],
                        ),
                        SizedBox(height: 30.0),

                        Text('Medida da cadeira de rodas', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                        SizedBox(height: 25.0),


                        TextForm(text: 'Largura do assento *'),
                        CustomForm(
                          hintText: 'Digite neste campo',
                          keyboardType: TextInputType.number,
                          validator: (val) => val.isEmpty ? 'O campo não pode estar vazio' : null,
                          onChanged: (val) {
                            setState(() => larguraAssento = val);
                          },
                          obscureText: false,
                        ),
                        SizedBox(height: 30.0),

                        TextForm(text: 'Profundidade ou comprimento do assento *'),
                        CustomForm(
                          hintText: 'Digite neste campo',
                          keyboardType: TextInputType.number,
                          validator: (val) => val.isEmpty ? 'O campo não pode estar vazio' : null,
                          onChanged: (val) {
                            setState(() => compAssento = val);
                          },
                          obscureText: false,
                        ),
                        SizedBox(height: 30.0),

                        TextForm(text: 'Altura do encosto *'),
                        CustomForm(
                          hintText: 'Digite neste campo',
                          keyboardType: TextInputType.number,
                          validator: (val) => val.isEmpty ? 'O campo não pode estar vazio' : null,
                          onChanged: (val) {
                            setState(() => alturaAssento = val);
                          },
                          obscureText: false,
                        ),
                        SizedBox(height: 30.0),

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
                              TextForm(text: 'Tipo de cadeira de rodas *'),
                              SizedBox(height: 10),
                              SingleCustomRadio(namedButton: tipoCadeira = ['Cadeira de rodas manual simples', 'Cadeira de rodas dobrável em X', 'Cadeira de rodas monobloco', 'Cadeira de rodas reclinável','Cadeira de rodas motorizada','Cadeira de rodas com elevação automática', 'Cadeira de rodas postural', 'Cadeira de rodas pediátrica', 'Cadeira de banho'],
                                onAnswer: (value){ setState(() {tipoCadeiraValue = value;errorBox[1] = false;});},),
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
                              TextForm(text: 'Tipo de assento *'),
                              ACustomRadio(
                                namedButton: 'Original',
                                onAnswer: (value) {
                                  setState(() {
                                    tipoAssentoValue = value;
                                    errorBox[2] = false;
                                  });
                                },
                                groupValue: tipoAssentoValue,
                                index: 0,
                              ),
                              if (tipoAssentoValue == 0)
                                Container(
                                  padding: EdgeInsets.only(left: 23, right: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ACustomRadio(
                                        namedButton: 'Flexível',
                                        onAnswer: (value) {
                                          setState(() {
                                            tipoAssentoOriginalValue = value;
                                          });
                                        },
                                        groupValue: tipoAssentoOriginalValue,
                                        index: 0,
                                      ),
                                      ACustomRadio(
                                        namedButton: 'Rígido',
                                        onAnswer: (value) {
                                          setState(() {
                                            tipoAssentoOriginalValue = value;
                                          });
                                        },
                                        groupValue: tipoAssentoOriginalValue,
                                        index: 1,
                                      ),
                                      if (tipoAssentoOriginalValue == 1)
                                        Container(
                                          padding: EdgeInsets.only(left: 23, right: 5),
                                          child: Column(
                                            children: [
                                              ACustomRadio(
                                                namedButton: 'Fixo',
                                                onAnswer: (value) {
                                                  setState(() {
                                                    tipoAssentoRigidoValue = value;
                                                  });
                                                },
                                                groupValue: tipoAssentoRigidoValue,
                                                index: 0,
                                              ),
                                              ACustomRadio(
                                                namedButton: 'Removível',
                                                onAnswer: (value) {
                                                  setState(() {
                                                    tipoAssentoRigidoValue = value;
                                                  });
                                                },
                                                groupValue: tipoAssentoRigidoValue,
                                                index: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      SizedBox(height: 20),
                                      TextForm(text: 'Almofada'),
                                      SizedBox(height: 10),
                                      Column(
                                        children: [
                                          SingleCustomRadio(namedButton: tipoAlmofada = ['Plana', 'Anatômica', 'Outra'],
                                            onAnswer: (value){ setState(() {tipoAlmofadaValue = value;});},),
                                          if (tipoAlmofadaValue == 2)
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(height: 5.0),
                                                TextForm(text: 'Descreva'),
                                                CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => descAlmofada = val);},),
                                              ],
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: 25),
                                    ],
                                  ),
                                ),
                              if (users.uid == 'uid')
                                Column(
                                  children: [
                                    ACustomRadio(
                                      namedButton: 'Personalizado',
                                      onAnswer: (value) {
                                        setState(() {
                                          tipoAssentoValue = value;
                                        });
                                      },
                                      groupValue: tipoAssentoValue,
                                      index: 1,
                                    ),
                                    if (tipoAssentoValue == 1)
                                      Container(
                                        padding: EdgeInsets.only(left: 23, right: 5),
                                        child: Column(
                                          children: [
                                            ACustomRadio(
                                              namedButton: 'Almofada plana',
                                              onAnswer: (value) {
                                                setState(() {
                                                  tipoAssentoPersoValue = value;
                                                });
                                              },
                                              groupValue: tipoAssentoPersoValue,
                                              index: 0,
                                            ),
                                            ACustomRadio(
                                              namedButton: 'Almofada ergonômica',
                                              onAnswer: (value) {
                                                setState(() {
                                                  tipoAssentoPersoValue = value;
                                                });
                                              },
                                              groupValue: tipoAssentoPersoValue,
                                              index: 1,
                                            ),
                                            ACustomRadio(
                                              namedButton: 'Almofada ergonômica assimétrica profundidade',
                                              onAnswer: (value) {
                                                setState(() {
                                                  tipoAssentoPersoValue = value;
                                                });
                                              },
                                              groupValue: tipoAssentoPersoValue,
                                              index: 2,
                                            ),
                                            if (tipoAssentoPersoValue == 2)
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SingleCustomRadio(namedButton: ['Maior profundidade lado Direito', ' Maior profundidade lado esquerdo '],
                                                      onAnswer: (value){ setState(() {tipoAssentoProfunValue = value;});},),
                                                  ],
                                                ),
                                              ),
                                            ACustomRadio(
                                              namedButton: 'Almofada ergonômica assimétrica altura',
                                              onAnswer: (value) {
                                                setState(() {
                                                  tipoAssentoPersoValue = value;
                                                });
                                              },
                                              groupValue: tipoAssentoPersoValue,
                                              index: 3,
                                            ),
                                            if (tipoAssentoPersoValue == 3)
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SingleCustomRadio(namedButton: ['Maior altura lado Direito', ' Maior altura lado esquerdo'],
                                                      onAnswer: (value){ setState(() {tipoAssentoAltValue = value;});},),
                                                  ],
                                                ),
                                              ),
                                            ACustomRadio(
                                              namedButton: 'Abdutor de quadril removível',
                                              onAnswer: (value) {
                                                setState(() {
                                                  tipoAssentoPersoValue = value;
                                                });
                                              },
                                              groupValue: tipoAssentoPersoValue,
                                              index: 4,
                                            ),
                                            ACustomRadio(
                                              namedButton: 'Apoios laterais adutores de quadril',
                                              onAnswer: (value) {
                                                setState(() {
                                                  tipoAssentoPersoValue = value;
                                                });
                                              },
                                              groupValue: tipoAssentoPersoValue,
                                              index: 5,
                                            ),
                                            ACustomRadio(
                                              namedButton: 'Freio abdutor para frente',
                                              onAnswer: (value) {
                                                setState(() {
                                                  tipoAssentoPersoValue = value;
                                                });
                                              },
                                              groupValue: tipoAssentoPersoValue,
                                              index: 6,
                                            ),
                                            ACustomRadio(
                                              namedButton: 'Elevação de pelvis',
                                              onAnswer: (value) {
                                                setState(() {
                                                  tipoAssentoPersoValue = value;
                                                });
                                              },
                                              groupValue: tipoAssentoPersoValue,
                                              index: 7,
                                            ),
                                            ACustomRadio(
                                              namedButton: 'Elevação de pelvis',
                                              onAnswer: (value) {
                                                setState(() {
                                                  tipoAssentoPersoValue = value;
                                                });
                                              },
                                              groupValue: tipoAssentoPersoValue,
                                              index: 8,
                                            ),
                                            if (tipoAssentoPersoValue == 8)
                                              Container(
                                                padding: EdgeInsets.only(left: 23, right: 5),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SingleCustomRadio(namedButton: ['Lado Direito', ' Lado esquerdo'],
                                                      onAnswer: (value){ setState(() {tipoAssentoLadoValue = value;});},),
                                                    SizedBox(height: 25),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                  ],
                                )
                              else
                                Tooltip(
                                  message: "Essa opção não está disponível no momento",
                                  // ignore: missing_required_param
                                  child: RadioListTile<int>(
                                    title: new Text(
                                      'Personalizado',
                                      style: TextStyle(color: Colors.black54, fontSize: 16),
                                    ),
                                    value: 1,
                                    toggleable: false,
                                    activeColor: Color(0xFF6848AE),
                                  ),
                                ),
                            ],
                          ),
                        ),


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
                                    try {
                                      pageData = {
                                        'Faixa etária': faixaEtaria[faixaEtariaValue],
                                        'Altura aproximada': altura,
                                        'Peso': peso,
                                        'Largura do assento': larguraAssento,
                                        'Profundidade ou comprimento do assento': compAssento,
                                        'Altura do encosto': altura,
                                        'Tipo de cadeira de rodas': tipoCadeira[tipoCadeiraValue],
                                        'Tipo de assento': tipoAssentoValue == 0 ? tipoAssentoOriginalValue == 0 ? 'Flexível': tipoAssentoRigidoValue == 0 ? 'Fixo' : 'Removível' : 'Personalizado (Manutenção "TODO")',
                                        'Almofada': tipoAlmofadaValue == 2 ? descAlmofada : tipoAlmofada[tipoAlmofadaValue]
                                      };
                                      Navigator.push(
                                        context,
                                        SlideRightRoute4(widget: Prescricao2(
                                          typeUser: widget.typeUser,
                                          uid: uid,
                                          pageData: pageData,
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
                  );
                } else {
                  return Loading();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
 void errorTest(){
    setState(() {
      if (faixaEtariaValue == null)
        errorBox[0] = true;
      if (tipoCadeiraValue == null)
        errorBox[1] = true;
      if (tipoAssentoValue == null)
        errorBox[2] = true;
    });
  }
}


