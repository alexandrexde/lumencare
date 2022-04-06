import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/screens/home/prescricao_form/prescricao3.dart';
import 'package:lumen/services/database.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';


class Prescricao2 extends StatefulWidget {

  final typeUser;
  final Map<String, dynamic> pageData;
  final String uid;
  const Prescricao2({Key key,this.typeUser,this.pageData, this.uid}) : super(key: key);

  @override
  _Prescricao2State createState() => _Prescricao2State();
}

class _Prescricao2State extends State<Prescricao2>{
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<String> apoioPePerso= ['Plataforma acolchoado', 'Plataforma acolchoado com apoio de pernas/panturrilhas', 'Caixote acolchoado', 'Faixas para tornozelos e pés'],
      apoioBracoPerso = ['Plano acolchoado estreito', 'Plano acolchoado largo', 'Calha acolchoado', 'Frontal acolchoado'],
      apoioCabecaPerso  = ['Articulado ', 'Regulável em altura', 'Regulável em profundidade','Regulagem de inclinação','Prolongamento de abas'],
      apoioTronco  = ['Unilateral direito', 'Unilateral esquerdo', 'Bilateral','Outro'],
      regiaoApoio = ['Superior', 'Central', 'Inferior'],
      apoioCabeca  = ['Articulado/Angulação', 'Regulável em altura', 'Regulável em profundidade','Com apoio cervical','Outro'],
      apoioBraco = ['Fixo', 'Rebatível', 'Removível e ajustável em altura','Protetor de roupas', 'Outro'],
      apoioPe = ['Apoio de pés bipartidos', 'Apoio de pés plataforma', 'Apoio de pés elevável', 'Apoio de pé ajustável em altura', 'Outro'],
      cinto = ['Pélvico', 'Torácico', 'Torácico de quatro pontos','Diagonal ', 'Abdutor em Y','Peiteira','Outro'];
  String error, descEncosto, descAlmofadaEncosto, descApoioTronco, descApoioCabeca, descApoioBraco, descApoioPe, descCinto;
  int regiaoApoioEsqValue = 0, rebativel = 0, apoioPeGroupPersoValue = 0, apoioBracoGroupPersoValue = 0, apoioCabecaPersoGroupValue = 0,
      cintoValue, cintoGroupValue = 0, apoioPeValue, apoioPeGroupValue = 0, apoioBracoValue, apoioBracoGroupValue = 0,
      apoioCabecaValue, apoioCabecaGroupValue = 0, regiaoApoioValue = 0, apoioTroncoPersoValue = 0, apoioTroncoValue, apoioTroncoGroupValue = 0,
      tipoEncostoPersoValue = 0, faixaEtariaValue = 0, tipoCadeiraValue = 0, tipoEncostoOriginalValue = 0, tipoEncostoRigidoValue = 0,
      tipoEncostoValue, tipoAlmofadaValue = 0;
  List<bool> cintoPerso = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,];
  List<bool> errorBox = [false, false, false, false, false, false];
  bool enabled = false;
  Map<String, dynamic> pageData1 = Map<String, dynamic>();

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
                  User userr = _auth.currentUser;
                  return Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                              TextForm(text: 'Tipo de encosto *'),
                              Column(children: [
                                ACustomRadio(
                                  namedButton: 'Rebatível',
                                  onAnswer: (value) {
                                    setState(() {
                                      tipoEncostoValue = value;
                                      errorBox[0] = false;
                                    });
                                  },
                                  groupValue: tipoEncostoValue,
                                  index: -1,
                                ),
                                ACustomRadio(
                                  namedButton: 'Original',
                                  onAnswer: (value) {
                                    setState(() {
                                      errorBox[0] = false;
                                      tipoEncostoValue = value;
                                    });
                                  },
                                  groupValue: tipoEncostoValue,
                                  index: 0,
                                ),
                                if (tipoEncostoValue == 0)
                                  Container(
                                    padding: EdgeInsets.only(left: 23, right: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ACustomRadio(
                                          namedButton: 'Flexível',
                                          onAnswer: (value) {
                                            setState(() {
                                              tipoEncostoOriginalValue = value;
                                            });
                                          },
                                          groupValue: tipoEncostoOriginalValue,
                                          index: 0,
                                        ),
                                        ACustomRadio(
                                          namedButton: 'Rígido',
                                          onAnswer: (value) {
                                            setState(() {
                                              tipoEncostoOriginalValue = value;
                                            });
                                          },
                                          groupValue: tipoEncostoOriginalValue,
                                          index: 1,
                                        ),
                                        if (tipoEncostoOriginalValue == 1)
                                          Container(
                                            padding: EdgeInsets.only(left: 23, right: 5),
                                            child: Column(
                                              children: [
                                                ACustomRadio(
                                                  namedButton: 'Almofada plana',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      tipoEncostoRigidoValue = value;
                                                    });
                                                  },
                                                  groupValue: tipoEncostoRigidoValue,
                                                  index: 0,
                                                ),
                                                ACustomRadio(
                                                  namedButton: 'Almofada ergonômica',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      tipoEncostoRigidoValue = value;
                                                    });
                                                  },
                                                  groupValue: tipoEncostoRigidoValue,
                                                  index: 1,
                                                ),
                                                ACustomRadio(
                                                  namedButton: 'Fixo',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      tipoEncostoRigidoValue = value;
                                                    });
                                                  },
                                                  groupValue: tipoEncostoRigidoValue,
                                                  index: 2,
                                                ),
                                                ACustomRadio(
                                                  namedButton: 'Removível',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      tipoEncostoRigidoValue = value;
                                                    });
                                                  },
                                                  groupValue: tipoEncostoRigidoValue,
                                                  index: 3,
                                                ),
                                                ACustomRadio(
                                                  namedButton: 'Outros encostos',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      tipoEncostoRigidoValue = value;
                                                    });
                                                  },
                                                  groupValue: tipoEncostoRigidoValue,
                                                  index: 4,
                                                ),
                                                if (tipoEncostoRigidoValue == 4)
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      SizedBox(height: 5.0),
                                                      TextForm(text: 'Descreva'),
                                                      CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => descEncosto = val);},),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                if (userr.uid == widget.uid)
                                  Column(
                                    children: [
                                      ACustomRadio(
                                        namedButton: 'Personalizado',
                                        onAnswer: (value) {
                                          setState(() {
                                            tipoEncostoValue = value;
                                            errorBox[0] = false;
                                          });},
                                        groupValue: tipoEncostoValue,
                                        index: 1,
                                      ),
                                      if (tipoEncostoValue == 1)
                                        Container(
                                          padding: EdgeInsets.only(left: 23, right: 5),
                                          child: Column(
                                            children: [
                                              ACustomRadio(
                                                namedButton: 'Almofada plana',
                                                onAnswer: (value) {
                                                  setState(() {
                                                    tipoEncostoPersoValue = value;
                                                  });},
                                                groupValue: tipoEncostoPersoValue,
                                                index: 0,
                                              ),
                                              ACustomRadio(
                                                namedButton: 'Almofada egornômica',
                                                onAnswer: (value) {
                                                  setState(() {
                                                    tipoEncostoPersoValue = value;
                                                  });},
                                                groupValue: tipoEncostoPersoValue,
                                                index: 1,
                                              ),
                                              ACustomRadio(
                                                namedButton: 'Almofada egornômica escavada',
                                                onAnswer: (value) {
                                                  setState(() {
                                                    tipoEncostoPersoValue = value;
                                                  });},
                                                groupValue: tipoEncostoPersoValue,
                                                index: 2,
                                              ),
                                              ACustomRadio(
                                                namedButton: 'Encosto egornômico com almofada lombar',
                                                onAnswer: (value) {
                                                  setState(() {
                                                    tipoEncostoPersoValue = value;
                                                  });},
                                                groupValue: tipoEncostoPersoValue,
                                                index: 3,
                                              ),
                                              ACustomRadio(
                                                namedButton: 'Almofada moldada',
                                                onAnswer: (value) {
                                                  setState(() {
                                                    tipoEncostoPersoValue = value;
                                                  });},
                                                groupValue: tipoEncostoPersoValue,
                                                index: 4,
                                              ),
                                              ACustomRadio(
                                                namedButton: 'Almofada digitalizada',
                                                onAnswer: (value) {
                                                  setState(() {
                                                    tipoEncostoPersoValue = value;
                                                  });},
                                                groupValue: tipoEncostoPersoValue,
                                                index: 5,
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

                                      toggleable: true,
                                      onChanged: (int value) {setState(() {tipoEncostoValue = value;});},
                                      activeColor: Color(0xFF6848AE),
                                    ),
                                  ),

                              ],),
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
                              TextForm(text: 'Apoio de tronco *'),
                              Column(
                                children: [
                                  ACustomRadio(
                                    namedButton: 'Original',
                                    onAnswer: (value) {
                                      setState(() {
                                        apoioTroncoValue = value;
                                        errorBox[1] = false;
                                      });
                                    },
                                    groupValue: apoioTroncoValue,
                                    index: 0,
                                  ),
                                  if (apoioTroncoValue == 0)
                                    Container(
                                      padding: EdgeInsets.only(left: 23, right: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              SingleCustomRadio(namedButton: apoioTronco,
                                                onAnswer: (value){ setState(() {apoioTroncoGroupValue = value;});},),
                                              if (apoioTroncoGroupValue == 3)
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    SizedBox(height: 5.0),
                                                    TextForm(text: 'Descreva'),
                                                    CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => descApoioTronco = val);},),
                                                  ],
                                                ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  if (userr.uid == widget.uid)
                                    Column(
                                      children: [
                                        ACustomRadio(
                                          namedButton: 'Personalizado',
                                          onAnswer: (value) {
                                            setState(() {
                                              apoioTroncoValue = value;
                                              errorBox[1] = false;
                                            });},
                                          groupValue: apoioTroncoValue,
                                          index: 1,
                                        ),
                                        if (apoioTroncoValue == 1)
                                          Container(
                                            padding: EdgeInsets.only(left: 23, right: 5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                ACustomRadio(
                                                  namedButton: 'Unilateral',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      apoioTroncoPersoValue = value;
                                                    });},
                                                  groupValue: apoioTroncoPersoValue,
                                                  index: 0,
                                                ),
                                                ACustomRadio(
                                                  namedButton: 'Bilateral',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      apoioTroncoPersoValue = value;
                                                    });},
                                                  groupValue: apoioTroncoPersoValue,
                                                  index: 1,
                                                ),
                                                ACustomRadio(
                                                  namedButton: 'Três pontos',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      apoioTroncoPersoValue = value;
                                                    });},
                                                  groupValue: apoioTroncoPersoValue,
                                                  index: 2,
                                                ),
                                                ACustomRadio(
                                                  namedButton: 'Plano',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      apoioTroncoPersoValue = value;
                                                    });},
                                                  groupValue: apoioTroncoPersoValue,
                                                  index: 3,
                                                ),
                                                ACustomRadio(
                                                  namedButton: 'Curvo',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      apoioTroncoPersoValue = value;
                                                    });},
                                                  groupValue: apoioTroncoPersoValue,
                                                  index: 4,
                                                ),
                                                ACustomRadio(
                                                  namedButton: 'Regulagem em altura',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      apoioTroncoPersoValue = value;
                                                    });},
                                                  groupValue: apoioTroncoPersoValue,
                                                  index: 5,
                                                ),
                                                ACustomRadio(
                                                  namedButton: 'Regulagem em profundidade',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      apoioTroncoPersoValue = value;
                                                    });},
                                                  groupValue: apoioTroncoPersoValue,
                                                  index: 6,
                                                ),
                                                ACustomRadio(
                                                  namedButton: 'Removível',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      apoioTroncoPersoValue = value;
                                                    });},
                                                  groupValue: apoioTroncoPersoValue,
                                                  index: 7,
                                                ),
                                                SizedBox(height: 25),

                                                TextForm(text: 'Região do apoio direito'),
                                                SizedBox(height: 10),
                                                SingleCustomRadio(namedButton: regiaoApoio ,
                                                  onAnswer: (value){ setState(() {regiaoApoioValue = value;});},),

                                                TextForm(text: 'Região do apoio esquerdo'),
                                                SizedBox(height: 10),
                                                SingleCustomRadio(namedButton: regiaoApoio,
                                                  onAnswer: (value){ setState(() {regiaoApoioEsqValue = value;});},),
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
                              TextForm(text: 'Apoio de Cabeça *'),
                              Column(
                                children: [
                                  ACustomRadio(
                                    namedButton: 'Original',
                                    onAnswer: (value) {
                                      setState(() {
                                        apoioCabecaValue = value;
                                        errorBox[2] = false;
                                      });
                                    },
                                    groupValue: apoioCabecaValue,
                                    index: 0,
                                  ),
                                  if (apoioCabecaValue == 0)
                                    Container(
                                      padding: EdgeInsets.only(left: 23, right: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              SingleCustomRadio(namedButton: apoioCabeca,
                                                onAnswer: (value){ setState(() {apoioCabecaGroupValue = value;});},),
                                              if (apoioCabecaGroupValue == 4)
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    SizedBox(height: 5.0),
                                                    TextForm(text: 'Descreva'),
                                                    CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => descApoioCabeca = val);},),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (userr.uid == widget.uid)
                                    Column(
                                      children: [
                                        ACustomRadio(
                                          namedButton: 'Personalizado',
                                          onAnswer: (value) {
                                            setState(() {
                                              apoioCabecaValue = value;
                                              errorBox[2] = false;
                                            });},
                                          groupValue: apoioCabecaValue,
                                          index: 1,
                                        ),
                                        if (apoioCabecaValue == 1)
                                          Container(
                                            padding: EdgeInsets.only(left: 23, right: 5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SingleCustomRadio(namedButton: apoioCabecaPerso,
                                                  onAnswer: (value){ setState(() {apoioCabecaPersoGroupValue = value;});},),
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
                              TextForm(text: 'Apoios de braços *'),
                              Column(
                                children: [
                                  ACustomRadio(
                                    namedButton: 'Ausentes',
                                    onAnswer: (value) {
                                      setState(() {
                                        apoioBracoValue = value;
                                        errorBox[3] = false;
                                      });
                                    },
                                    groupValue: apoioBracoValue,
                                    index: 2,
                                  ),
                                  ACustomRadio(
                                    namedButton: 'Original',
                                    onAnswer: (value) {
                                      setState(() {
                                        apoioBracoValue = value;
                                        errorBox[3] = false;
                                      });
                                    },
                                    groupValue: apoioBracoValue,
                                    index: 0,
                                  ),
                                  if (apoioBracoValue == 0)
                                    Container(
                                      padding: EdgeInsets.only(left: 23, right: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              SingleCustomRadio(namedButton: apoioBraco ,
                                                onAnswer: (value){ setState(() {apoioBracoGroupValue = value;});},),
                                              if (apoioBracoGroupValue == 4)
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    SizedBox(height: 5.0),
                                                    TextForm(text: 'Descreva'),
                                                    CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => descApoioBraco = val);},),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (userr.uid == widget.uid)
                                    Column(
                                      children: [
                                        ACustomRadio(
                                          namedButton: 'Personalizado',
                                          onAnswer: (value) {
                                            setState(() {
                                              apoioBracoValue = value;
                                              errorBox[3] = false;
                                            });},
                                          groupValue: apoioBracoValue,
                                          index: 1,
                                        ),
                                        if (apoioBracoValue == 1)
                                          Container(
                                            padding: EdgeInsets.only(left: 23, right: 5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SingleCustomRadio(namedButton: apoioBracoPerso,
                                                  onAnswer: (value){ setState(() {apoioBracoGroupPersoValue = value;});},),
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
                            ],
                          ),
                        ),
                        SizedBox(height: 25),

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
                              TextForm(text: 'Apoios de pés *'),
                              Column(
                                children: [
                                  ACustomRadio(
                                    namedButton: 'Original',
                                    onAnswer: (value) {
                                      setState(() {
                                        apoioPeValue = value;
                                        errorBox[4] = false;
                                      });
                                    },
                                    groupValue: apoioPeValue,
                                    index: 0,
                                  ),
                                  if (apoioPeValue == 0)
                                    Container(
                                      padding: EdgeInsets.only(left: 23, right: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              SingleCustomRadio(namedButton: apoioPe ,
                                                onAnswer: (value){ setState(() {apoioPeGroupValue = value;});},),
                                              if (apoioPeGroupValue == 4)
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    SizedBox(height: 5.0),
                                                    TextForm(text: 'Descreva'),
                                                    CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => descApoioPe = val);},),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (userr.uid == widget.uid)
                                    Column(
                                      children: [
                                        ACustomRadio(
                                          namedButton: 'Personalizado',
                                          onAnswer: (value) {
                                            setState(() {
                                              apoioPeValue = value;
                                              errorBox[4] = false;
                                            });},
                                          groupValue: apoioPeValue,
                                          index: 1,
                                        ),
                                        if (apoioPeValue == 1)
                                          Container(
                                            padding: EdgeInsets.only(left: 23, right: 5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SingleCustomRadio(namedButton: apoioPePerso ,
                                                  onAnswer: (value){ setState(() {apoioPeGroupPersoValue = value;});},),
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
                            ],
                          ),
                        ),
                        SizedBox(height: 25),

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
                              TextForm(text: 'Cintos (sistema de segurança) *'),
                              Column(
                                children: [
                                  ACustomRadio(
                                    namedButton: 'Original',
                                    onAnswer: (value) {
                                      setState(() {
                                        errorBox[5] = false;
                                        cintoValue = value;
                                      });
                                    },
                                    groupValue: cintoValue,
                                    index: 0,
                                  ),
                                  if (cintoValue == 0)
                                    Container(
                                      padding: EdgeInsets.only(left: 23, right: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              SingleCustomRadio(namedButton: cinto ,
                                                onAnswer: (value){ setState(() {cintoGroupValue = value;});},),
                                              if (cintoGroupValue == 6)
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    SizedBox(height: 5.0),
                                                    TextForm(text: 'Descreva'),
                                                    CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => descCinto = val);},),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (userr.uid == widget.uid)
                                    Column(
                                      children: [
                                        ACustomRadio(
                                          namedButton: 'Personalizado',
                                          onAnswer: (value) {
                                            setState(() {
                                              errorBox[5] = false;
                                              cintoValue = value;
                                            });},
                                          groupValue: cintoValue,
                                          index: 1,
                                        ),
                                        if (cintoValue == 1)
                                          Container(
                                            padding: EdgeInsets.only(left: 23, right: 5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CustomCheckbox(
                                                  textBox: 'Velcro',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      cintoPerso[0] = value;
                                                    });
                                                  },
                                                ),
                                                CustomCheckbox(
                                                  textBox: 'Fivela',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      cintoPerso[1] = value;
                                                    });
                                                  },
                                                ),
                                                CustomCheckbox(
                                                  textBox: 'Pélvico',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      cintoPerso[2] = value;
                                                    });
                                                  },
                                                ),
                                                CustomCheckbox(
                                                  textBox: 'Torácico',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      cintoPerso[3] = value;
                                                    });
                                                  },
                                                ),
                                                CustomCheckbox(
                                                  textBox: 'Torácico de quatro pontos',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      cintoPerso[4] = value;
                                                    });
                                                  },
                                                ),
                                                CustomCheckbox(
                                                  textBox: 'Diagonal',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      cintoPerso[5] = value;
                                                    });
                                                  },
                                                ),
                                                CustomCheckbox(
                                                  textBox: 'Abdutor em Y',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      cintoPerso[6] = value;
                                                    });
                                                  },
                                                ),
                                                CustomCheckbox(
                                                  textBox: 'Peiteira',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      cintoPerso[7] = value;
                                                    });
                                                  },
                                                ),
                                                CustomCheckbox(
                                                  textBox: 'Entre-apoios de troncos',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      cintoPerso[8] = value;
                                                    });
                                                  },
                                                ),
                                                CustomCheckbox(
                                                  textBox: 'Faixa de antebraços',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      cintoPerso[9] = value;
                                                    });
                                                  },
                                                ),
                                                CustomCheckbox(
                                                  textBox: 'Faixa de cotovelos',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      cintoPerso[10] = value;
                                                    });
                                                  },
                                                ),
                                                CustomCheckbox(
                                                  textBox: 'Faixa de cabeça',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      cintoPerso[11] = value;
                                                    });
                                                  },
                                                ),
                                                CustomCheckbox(
                                                  textBox: 'Faixa de joelho',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      cintoPerso[12] = value;
                                                    });
                                                  },
                                                ),
                                                CustomCheckbox(
                                                  textBox: 'Faixa de tornozelos',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      cintoPerso[13] = value;
                                                    });
                                                  },
                                                ),
                                                CustomCheckbox(
                                                  textBox: 'Faixa de pés',
                                                  onAnswer: (value) {
                                                    setState(() {
                                                      cintoPerso[14] = value;
                                                    });
                                                  },
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
                            ],
                          ),
                        ),
                        SizedBox(height: 25),


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
                                  errorTest();
                                  for(int i = 0; i < errorBox.length; i++) {
                                    if (errorBox[0] == true)
                                      if (errorBox[1] == true)
                                        if (errorBox[2] == true)
                                          if (errorBox[3] == true)
                                            if (errorBox[4] == true)
                                              if (errorBox[5] == true)
                                                enabled = true;
                                  }
                                  try {
                                    pageData1 = {
                                      'Tipo de encosto': tipoEncostoValue == -1 ? 'Rebatível': tipoEncostoValue == 0 ? tipoEncostoOriginalValue == 0 ? 'Flexível' : 'Rígido' : 'Personalizado (Manutenção "TODO")',
                                      'Apoio de Tronco' : apoioTroncoValue == 0 ? apoioTroncoGroupValue == 3 ? descApoioTronco : apoioTronco[apoioTroncoGroupValue] : 'Personalizado (Manutenção "TODO")',
                                      'Apoio de Cabeça' : apoioCabecaValue == 0 ? apoioCabecaGroupValue == 4 ? descApoioCabeca : apoioCabeca[apoioCabecaGroupValue] : 'Personalizado (Manutenção "TODO")',
                                      'Apoio de Braços': apoioBracoValue == 2 ? 'Ausentes' : apoioBracoValue == 0 ? apoioBracoGroupValue == 3 ? descApoioBraco : apoioBraco[apoioBracoGroupValue] : 'Personalizado (Manutenção "TODO")',
                                      'Apoio de pés': apoioPeValue == 0 ? apoioPeGroupValue == 4 ? descApoioPe : apoioPe[apoioPeGroupValue] : 'Personalizado (Manutenção "TODO")',
                                      'Cintos': cintoValue == 0 ? cintoGroupValue == 6 ? descCinto: cinto[cintoGroupValue]: 'Personalizado (Manutenção "TODO")',
                                    };
                                   if (enabled == false)
                                     Navigator.push(
                                      context,
                                      SlideRightRoute4(widget: Prescricao3(
                                        typeUser: widget.typeUser,
                                        uid: widget.uid,
                                        pageData: widget.pageData,
                                        pageData1: pageData1,
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
      if (tipoEncostoValue == null)
        errorBox[0] = true;
      if (apoioTroncoValue == null)
        errorBox[1] = true;
      if (apoioCabecaValue == null)
        errorBox[2] = true;
      if (apoioBracoValue == null)
        errorBox[3] = true;
      if (apoioPeValue == null)
        errorBox[4] = true;
      if (cintoValue == null)
        errorBox[5] = true;
    });
  }
}


