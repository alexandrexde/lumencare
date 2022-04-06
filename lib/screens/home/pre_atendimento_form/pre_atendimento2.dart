import 'dart:ui';
import 'package:animated_check/animated_check.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/models/preAttendance.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/services/database.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';


// ignore: must_be_immutable
class PreAtendimento2 extends StatefulWidget {

  final String  estado, currentName, sexo, diagnostico, peso, altura, nomeMedico, especialidadeMedico, contatoMedico, currentTelefone, currentCep, currentLogradouro, currentCidade, currentBairro, numCasa, complemento, responsavelLegal, typeUser;
  DateTime dateTime;
  
  final Function toggleView;
  PreAtendimento2({this.toggleView, this.currentName, this.diagnostico, this.peso, this.altura, this.nomeMedico, this.especialidadeMedico, this.contatoMedico, this.currentTelefone, this.currentCep, this.currentLogradouro, this.currentCidade, this.currentBairro, this.numCasa, this.complemento,
    this.sexo, this.dateTime, this.responsavelLegal, this.typeUser, this.estado});

  @override
  _PreAtendimento2State createState() => _PreAtendimento2State();

}

class _PreAtendimento2State extends State<PreAtendimento2> with SingleTickerProviderStateMixin {

  final _formkey = GlobalKey<FormState>();
  bool loading = false, pressed = false;
  int  possuiExameValue;
  bool naoFaz = false,  defIntelectual = false, defAuditiva = false, defCognitiva = false, autismo = false, demencial = false, baixaVisao = false, semDef = false;
  String  ruaResp, error = "", responsavelFiscal, cpfLegal, emailLegal,numCasaResp, complementoResp, bairroResp, cidadeResp, cepResp, telefoneResp;
  List<String> possuiExame;
  Map<String, bool> diagnostico;
  AnimationController _animationController;
  Animation<double> _animation;
  double sizeAnimation = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    _animation = new Tween<double>(begin: 0, end: 1).animate(new CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCirc));
  }
  void _showCheck() {
    _animationController.forward().then((value) {
      Navigator.pop(context);
      Navigator.pop(context);
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
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                    color: Color(0xFF6848AE),
                    borderRadius: BorderRadius.all(Radius.circular(170))
                ),
                child: AnimatedCheck(
                  color: Colors.white,//Color(0xFF6848AE),
                  progress: _animation,
                  size: 170,
                ),
              ),
            ]  ,
          )
      ),
    )
        : Scaffold(
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
                return Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Pré diagnóstico
                      TextForm(text: 'O cliente possui algum desses diagnósticos da lista abaixo?'),
                      SizedBox(height: 25.0),
                      CustomCheckbox(textBox: 'Deficiência visual ou baixa visão', onAnswer: (val){setState(() { baixaVisao = val;}); },),
                      CustomCheckbox(textBox: 'Deficiência auditiva', onAnswer: (val){setState((){defAuditiva = val;});},),
                      CustomCheckbox(textBox: 'Deficiência intelectual', onAnswer: (val){setState(() => defIntelectual = val); },),
                      CustomCheckbox(textBox: 'Deficiência cognitiva', onAnswer: (val){setState(() => defCognitiva = val);},),
                      CustomCheckbox(textBox: 'Autismo', onAnswer: (val){setState(() => autismo = val);},),
                      CustomCheckbox(textBox: 'Processo demencial', onAnswer: (val){setState(() => demencial = val);},),
                      CustomCheckbox(textBox: 'Não', onAnswer: (val){setState(() => semDef = val);},),
                      SizedBox(height: 30.0),

                      //Exames complementares
                      TextForm(text: 'Possui exames complementares de imagem ou relatórios de especialistas do último ano para trazer no dia da avaliação?'),
                      SizedBox(height: 15.0),
                      SingleCustomRadio(namedButton: possuiExame = ['Sim','Não'], onAnswer: (val){setState(() {possuiExameValue = val;});},),
                      SizedBox(height: 30.0),

                      Text( 'Informações do responsável fiscal', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),

                      //Nome do Responsável
                      SizedBox(height: 25.0),
                      TextForm(text: 'Nome Completo'),
                      CustomForm(
                        //form field name
                        obscureText: false,
                        hintText: 'Digite o nome do responsável',
                        //validator: (val) =>
                        //val.isEmpty ? 'Digite o nome do responsável' : null,
                        onChanged: (val) {
                          setState(() => responsavelFiscal = val);
                        },
                      ),
                      SizedBox(height: 30.0),

                      //CPF do Responsável
                      TextForm(text: 'CPF'),
                      CustomForm(
                        obscureText: false,
                        //form field name
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                        hintText: 'Digite o cpf',
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        //validator: (val) =>
                        //val.isEmpty ? 'Digite o cpf' : null,
                        onChanged: (val) {
                          setState(() => cpfLegal = val);
                        },
                      ),
                      SizedBox(height: 30.0),

                      //Logradouro do Responsável
                      TextForm(text: 'Rua'),
                      CustomForm(
                        obscureText: false,
                        //form field name
                        //initialValue: userData.ruaResp == userData.logradouro ? userData.logradouro : userData.ruaResp,
                        hintText: 'Digite o logradouro',
                        keyboardType: TextInputType.streetAddress,
                        //validator: (val) =>
                        //val.isEmpty ? 'Digite o logradouro' : null,
                        onChanged: (val) {
                          setState(() => ruaResp = val);
                        },
                      ),
                      SizedBox(height: 30.0),

                      //Número do Responsável
                      TextForm(text: 'Número'),
                      CustomForm(
                        obscureText: false,
                        //form field name
                        //initialValue: userData.numCasaResp == userData.numCasa ? userData.numCasa : userData.numCasaResp,
                        hintText: 'Digite o número',
                        keyboardType: TextInputType.streetAddress,
                        //validator: (val) =>
                        //val.isEmpty ? 'Digite o número' : null,
                        onChanged: (val) {
                          setState(() => numCasaResp = val);
                        },
                      ),
                      SizedBox(height: 30.0),

                      //Complemento do Responsável
                      TextForm(text: 'Complemento'),
                      CustomForm(
                        obscureText: false,
                        //form field name
                        //initialValue: userData.complementoResp  == userData.complemento ?  userData.complemento : userData.complementoResp,
                        hintText: 'Digite o complemento',
                        keyboardType: TextInputType.streetAddress,
                        onChanged: (val) {
                          setState(() => complementoResp = val);
                        },
                      ),
                      SizedBox(height: 30.0),

                      //Bairro do Responsável
                      TextForm(text: 'Bairro'),
                      CustomForm(
                        obscureText: false,
                        //form field name
                        //initialValue: userData.bairroResp == userData.bairro ? userData.bairro : userData.bairroResp,
                        hintText: 'Digite o bairro',
                        keyboardType: TextInputType.streetAddress,
                        //validator: (val) =>
                        //val.isEmpty ? 'Digite o bairro' : null,
                        onChanged: (val) {
                          setState(() => bairroResp = val);
                        },
                      ),
                      SizedBox(height: 30.0),

                      //Cidade do Responsável
                      TextForm(text: 'Cidade'),
                      CustomForm(
                        obscureText: false,
                        //form field name
                        //initialValue: userData.cidadeResp == userData.cidade ? userData.cidade : userData.cidadeResp,
                        hintText: 'Digite a cidade',
                        keyboardType: TextInputType.text,
                        //validator: (val) =>
                        //val.isEmpty ? 'Digite a cidade' : null,
                        onChanged: (val) {
                          setState(() => cidadeResp = val);
                        },
                      ),
                      SizedBox(height: 30.0),

                      //Cep do Responsável
                      TextForm(text: 'Cep'),
                      CustomForm(
                        obscureText: false,
                        //form field name
                        //initialValue: userData.cepResp == userData.cep ? userData.cep : userData.cepResp,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CepInputFormatter(),
                        ],
                        hintText: 'Digite o Cep',
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        // validator: (val) => val.isEmpty ? 'Digite o cep' : null,
                        onChanged: (val) {
                          setState(() => cepResp = val);
                        },
                      ),
                      SizedBox(height: 30.0),

                      //Telefone do Responsável
                      TextForm(text: 'Telefone'),
                      CustomForm(
                        obscureText: false,
                        //form field name
                        //initialValue: userData.telefoneResp == userData.telefone ? userData.telefone : userData.telefoneResp,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        hintText: 'Digite o numero de telefone',
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        //validator: (val) =>
                        //    val.isEmpty ? 'Digite o numero de telefone' : null,
                        onChanged: (val) {
                          setState(() => telefoneResp = val);
                        },
                      ),
                      SizedBox(height: 30.0),


                      //Email do Responsável
                      TextForm(text: 'Email'),
                      CustomForm(
                        obscureText: false,
                        //form field email
                        //initialValue: userData.emailLegal,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Digite o email',
                        //validator: (val) => val.isEmpty ? 'Digite um e-mail' : null,
                        onChanged: (val) {
                          setState(() => emailLegal = val);
                        },
                      ),
                      SizedBox(height: 30.0),


                      //error widget
                      Text(
                        //error text
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                      ),


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
                            _resetCheck();
                            //setState(() => sizeAnimation = 200);
                            // _showMyDialog();
                            diagnostico = {
                              'Deficiência visual ou baixa visão' : baixaVisao,
                              'Deficiência auditiva' : defAuditiva,
                              'Deficiência intelectual': defIntelectual,
                              'Deficiência cognitiva' : defCognitiva,
                              'Autismo' : autismo,
                              'Processo demencial' : demencial,
                              'Não' : semDef,
                            };
                            DateTime dateNull = DateTime.parse(userData.data.toDate().toString());
                            if (widget.dateTime == null) {
                              widget.dateTime = dateNull;
                            }
                            if (_formkey.currentState.validate()) {
                              await DatabaseService(uid: user.uid).createForm(preForm(
                                nomeResponsavel: widget.responsavelLegal,
                                contatoMedico: widget.contatoMedico,
                                responsavelFiscal: responsavelFiscal,
                                cpfLegal: cpfLegal,
                                ruaResp: ruaResp,
                                numCasaResp: numCasaResp,
                                complementoResp: complementoResp,
                                bairroResp: bairroResp,
                                cidadeResp: cidadeResp,
                                cepResp: cepResp,
                                telefoneResp: telefoneResp,
                                emailLegal: emailLegal,
                                uid: user.uid,
                                hour: DateTime.now(),
                                diagnostico: diagnostico,

                                //Adição
                                sexo: widget.sexo,
                                //possuiResponsavel: userData.possuiResponsavel,
                                telefone: widget.currentTelefone,
                                cep: widget.currentCep,
                                logradouro: widget.currentLogradouro,
                                bairro: widget.currentBairro,
                                cidade: widget.currentCidade,
                                estado: widget.estado,
                                peso: widget.peso,
                                altura: widget.altura,
                                nomeMedico: widget.nomeMedico,
                                especialidadeMedico: widget.especialidadeMedico,
                                possuiExame: possuiExame[possuiExameValue],
                                //outrosMedicos: userData.outrosMedicos,
                                //comoEncontrou: userData.comoEncontrou,
                                //outrosEqp: userData.outrosEqp,
                                //quaisEqp: userData.quaisEqp,
                                numCasa: widget.numCasa,
                                complemento: widget.complemento,
                              ));
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(
                                  widget.currentName ?? userData.name,
                                  widget.dateTime ?? userData.data,
                                  userData.typeUser ?? userData.typeUser
                              );
                              setState(() => pressed = true);
                              _showCheck();
                            }
                            FocusScope.of(context).unfocus();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 35.0,
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
}
