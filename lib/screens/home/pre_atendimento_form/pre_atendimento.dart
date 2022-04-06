import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/screens/home/pre_atendimento_form/pre_atendimento2.dart';
import 'package:lumen/services/database.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';

class PreAtendimento extends StatefulWidget {

  final String typeUser;
  PreAtendimento({this.typeUser});

  @override
  _PreAtendimentoState createState() => _PreAtendimentoState();
}

class _PreAtendimentoState extends State<PreAtendimento> {
  final _formkey = GlobalKey<FormState>();


  String actualAge, _currentName, error, sexo, nomeMedico, especialidadeMedico, contatoMedico, novoDiagnostico, peso, altura, idade, responsavelLegal;

  DateTime _dateTime;
  int age, day2, month2, sexoValue, groupValue;
  String  _salutatione = "Acre (AC)", comoEncontrou, _currentLogradouro, _currentTelefone, _currentCep, _currentCidade, _currentBairro, numCasa, complemento;
  List<String> namedButton = ['Masculino', 'Feminino'];

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
      //todo: melhorar UI
      backgroundColor: Colors.white,
      appBar: AppBarWidget(title: 'Pré-Atendimento',),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 50.0,
          ),
          child: StreamBuilder<UserData>(
            stream: widget.typeUser == 'Client' ? DatabaseService(uid: user.uid).userData : widget.typeUser == 'Company' ? DatabaseService(uid: user.uid).userDataCompany : DatabaseService(uid: user.uid).userDataProfessional,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserData userData = snapshot.data;
                age = int.parse(DateFormat.y().format(DateTime.parse(userData.data.toDate().toString())));
                month2 = userData.data.toDate().month;
                day2 = userData.data.toDate().day;


                return Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //nome
                      SizedBox(height: 20.0),
                      TextForm(text: 'Nome Completo'),
                      CustomForm(hintText: 'Digite seu nome',onChanged: (val) {setState(() => _currentName = val);},validator: (val) => val.isEmpty ? 'Digite seu nome' : null,
                        initialValue: userData.name,obscureText: false,),

                      //Nome do Responsável
                      SizedBox(height: 20.0),
                      TextForm(text: 'Nome do responsável legal'),
                      CustomForm(
                        hintText: 'Digite o nome do responsável',
                        onChanged: (val) {
                          setState(() => responsavelLegal = val);
                        },
                        validator: (val) =>
                        val.isEmpty ? 'Digite o nome do responsável' : null,
                        obscureText: false,
                      ),

                      //Data de nascimento
                      SizedBox(height: 30.0),
                      TextForm(text: 'Data de nascimento'),
                      SizedBox(height: 8.0),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black.withOpacity(0.4)))),
                        width: 350,
                        alignment: Alignment.bottomLeft,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.transparent,
                          ),
                          child: Text(
                            _dateTime == null
                                ? DateFormat.yMMMMd("pt_BR").format(
                                    DateTime.parse(
                                        userData.data.toDate().toString()))
                                : DateFormat.yMMMMd("pt_BR").format(_dateTime),
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.33),
                              fontSize: 14.0,
                            ),
                          ),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1920),
                              lastDate: DateTime.now(),
                              builder: (BuildContext context, Widget child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Colors.deepPurple,
                                      onPrimary: Colors.white,
                                      surface: Color(0xFF6848AE),
                                      onSurface: Color(0xFF6848AE),
                                    ),
                                  ),
                                  child: child,
                                );
                              },
                            ).then((date) {
                              setState(() {
                                _dateTime = date;
                                age = int.parse(DateFormat.y().format(DateTime.parse(_dateTime.toString())));
                                month2 = _dateTime.month;
                                day2 = _dateTime.day;
                                actualAge = discoverAge();
                              });
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 35.0),

                      //idade
                      //todo: adicionar linhas e validação
                      TextForm(text: 'Idade'),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black.withOpacity(0.4)))),
                        width: 350,
                        height: 45.0,
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                        child: Text(
                          theActualAge(),
                          style: TextStyle(
                            fontSize: 14.0, color: theActualAge() == 'Preencha sua data de nascimento' ? Colors.black.withOpacity(0.4) : Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),

                      //diagnostico medico
                      //todo: adicionar linhas e validação
                      TextForm(text: 'Diagnóstico médico'),
                      CustomForm(
                        hintText: 'Digite o diagnóstico',
                        validator: (val) => val.isEmpty ? 'Digite o diagnóstico' : null,
                        onChanged: (val) {
                          setState(() => novoDiagnostico = val);
                        },
                        obscureText: false,
                        keyboardType: TextInputType.streetAddress,
                      ),
                      SizedBox(height: 30.0),


                      //peso
                      TextForm(text: 'Peso aproximado'),
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

                      //Altura
                      TextForm(text: 'Altura aproximada'),
                      CustomForm(
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

                      //Gênero
                      TextForm(text: 'Sexo'),
                      SizedBox(height: 15.0),
                      SingleCustomRadio(namedButton: ['Masculino', 'Feminino'], onAnswer: (val){setState(() {sexoValue = val;if(sexoValue == 0) sexo = 'Masculino'; else sexo = 'Feminino';});},),

                      //nome medico responsavel
                      //todo: validar
                      SizedBox(height: 25.0),
                      TextForm(text: 'Nome do médico responsável'),
                      CustomForm(
                        hintText: 'Digite o nome do médico',
                        keyboardType: TextInputType.name,
                        validator: (val) => val.isEmpty ? 'Digite o nome do médico' : null,
                        onChanged: (val) {
                          setState(() => nomeMedico = val);
                        },
                        obscureText: false,
                      ),
                      SizedBox(height: 30.0),

                      //especialidade do medico
                      TextForm(text: 'Especialidade do médico'),
                      CustomForm(
                        hintText: 'Digite a especialidade',
                        keyboardType: TextInputType.text,
                        validator: (val) => val.isEmpty ? 'Digite a especialidade' : null,
                        onChanged: (val) {
                          setState(() => especialidadeMedico = val);
                        },
                        obscureText: false,
                      ),
                      SizedBox(height: 30.0),

                      //contato do medico
                      TextForm(text: 'Contato do médico'),
                      CustomForm(
                        hintText: 'Digite o contato',
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        validator: (val) => val.isEmpty ? 'Digite o contato' : null,
                        onChanged: (val) {
                          setState(() => contatoMedico = val);},
                        obscureText: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                      ),
                      SizedBox(height: 30.0),

                      //Telefone
                      TextForm(text: 'Telefone'),
                      CustomForm(
                        //form field name
                        obscureText: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        hintText: 'Digite o numero de telefone',
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        validator: (val) =>
                        val.isEmpty ? 'Digite o numero de telefone' : null,
                        onChanged: (val) {
                          setState(() => _currentTelefone = val);
                        },
                      ),
                      SizedBox(height: 30.0),

                      //Logradouro
                      TextForm(text: 'Rua'),
                      CustomForm(
                        hintText: 'Digite o logradouro',
                        keyboardType: TextInputType.streetAddress,
                        validator: (val) =>
                        val.isEmpty ? 'Digite o logradouro' : null,
                        onChanged: (val) {
                          setState(() => _currentLogradouro = val);
                        },
                        obscureText: false,
                      ),
                      SizedBox(height: 30.0),

                      //Número
                      TextForm(text: 'Número'),
                      CustomForm(
                        //form field name
                        obscureText: false,
                        hintText: 'Digite o número',
                        keyboardType: TextInputType.streetAddress,
                        validator: (val) =>
                        val.isEmpty ? 'Digite o número' : null,
                        onChanged: (val) {
                          setState(() => numCasa = val);
                        },
                      ),
                      SizedBox(height: 30.0),

                      //Complemento
                      TextForm(text: 'Complemento'),
                      CustomForm(
                        //form field name
                        obscureText: false,
                        hintText: 'Digite o complemento',
                        keyboardType: TextInputType.streetAddress,
                        onChanged: (val) {
                          setState(() => complemento = val);
                        },
                      ),
                      SizedBox(height: 30.0),

                      //Bairro
                      TextForm(text: 'Bairro'),
                      CustomForm(
                        //form field name
                        obscureText: false,
                        hintText: 'Digite o bairro',
                        keyboardType: TextInputType.streetAddress,
                        validator: (val) =>
                        val.isEmpty ? 'Digite o bairro' : null,
                        onChanged: (val) {
                          setState(() => _currentBairro = val);
                        },
                      ),
                      SizedBox(height: 30.0),

                      //Cidade
                      TextForm(text: 'Cidade'),
                      CustomForm(
                        //form field name
                        obscureText: false,
                        hintText: 'Digite a cidade',
                        keyboardType: TextInputType.text,
                        validator: (val) =>
                        val.isEmpty ? 'Digite a cidade' : null,
                        onChanged: (val) {
                          setState(() => _currentCidade = val);
                        },
                      ),
                      SizedBox(height: 30.0),

                      //Cep
                      TextForm(text: 'Cep'),
                      CustomForm(
                        //form field name
                        obscureText: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CepInputFormatter(),
                        ],
                        hintText: 'Digite o Cep',
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        validator: (val) => val.isEmpty ? 'Digite o cep' : null,
                        onChanged: (val) {
                          setState(() => _currentCep = val);
                        },
                      ),
                      SizedBox(height: 30.0),

                      //Estado
                      TextForm(text: 'Estado'),
                      SizedBox(height: 8.0),
                      Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5, left: 9),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton(
                          items: _states
                              .map((String item) => DropdownMenuItem<String>(
                              child: Container(
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                  ),
                                ),
                                width: 279,
                              ),
                              value: item))
                              .toList(),
                          onChanged: (String value) {
                            setState(() {
                              this._salutatione = value;
                            });
                          },
                          value: _salutatione,
                        ),
                      ),
                      SizedBox(height: 40.0),



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
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  SlideRightRoute5(
                                      widget: PreAtendimento2(
                                        currentName: _currentName,
                                        dateTime: _dateTime,
                                        diagnostico: novoDiagnostico,
                                        peso: peso,
                                        altura: altura,
                                        sexo: sexo,
                                        nomeMedico: nomeMedico,
                                        especialidadeMedico: especialidadeMedico,
                                        contatoMedico: contatoMedico,
                                        responsavelLegal: responsavelLegal,
                                        currentLogradouro: _currentLogradouro,
                                        numCasa: numCasa,
                                        complemento: complemento,
                                        currentBairro: _currentBairro,
                                        currentCep: _currentCep,
                                        currentCidade: _currentCidade,
                                        currentTelefone: _currentTelefone,
                                        estado: _salutatione,
                                        typeUser: widget.typeUser,
                                  )),
                                );
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
    );
  }
  String discoverAge() {
    age = 2021 - age;
    DateTime currentDate = DateTime.now();
    int month1 = currentDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    idade = age.toString();
    return idade;
  }
  String theActualAge() {
    if (actualAge == null) {
      if (idade == null && age >= 2021) {
        return 'Preencha sua data de nascimento';
      } else {
        return discoverAge();
      }
    } else {
      return actualAge;
    }
  }
}
final _states = [
  "Acre (AC)",
  "Alagoas (AL)",
  "Amapá (AP)",
  "Amazonas (AM)",
  "Bahia (BA)",
  "Ceará (CE)",
  "Distrito Federal (DF)",
  "Espírito Santo (ES)",
  "Goiás (GO)",
  "Maranhão (MA)",
  "Mato Grosso (MT)",
  "Mato Grosso do Sul (MS)",
  "Minas Gerais (MG)",
  "Pará (PA)",
  "Paraíba (PB)",
  "Paraná (PR)",
  "Pernambuco (PE)",
  "Piauí (PI)",
  "Rio de Janeiro (RJ)",
  "Rio Grande do Norte (RN)",
  "Rio Grande do Sul (RS)",
  "Rondônia (RO)",
  "Roraima (RR)",
  "Santa Catarina (SC)",
  "São Paulo (SP)",
  "Sergipe (SE)",
  "Tocantins (TO)",
];

