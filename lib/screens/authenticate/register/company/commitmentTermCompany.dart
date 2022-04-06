import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/screens/authenticate/register/company/registerCompany.dart';
import 'package:lumen/screens/authenticate/sign_in.dart';
import 'package:lumen/shared/loading.dart';


class CommitmentTermCompany extends StatefulWidget {
  final Function toggleView;
  final String email, password, error, name, telefone, cep, logradouro, bairro, cidade, diagnostico, peso, altura, nomeMedico, especialidadeMedico, possuiExame, diagnosticoOrientado, outrosMedicos;
  final List<String> checked, checked1;
  String salutatione = "Acre (AC)", quaisEqp = '';
  final DateTime dateTime;
  List<String> usaOutros;
  final List<String> comoEncontrou;
  CommitmentTermCompany(
      {Key key,
        this.toggleView,
        this.email,
        this.password,
        this.error,
        this.name,
        this.telefone,
        this.cep,
        this.logradouro,
        this.bairro,
        this.cidade,
        this.salutatione,
        this.dateTime,
        this.checked,
        this.checked1,

        this.diagnostico,
        this.peso,
        this.altura,
        this.nomeMedico,
        this.especialidadeMedico,
        this.possuiExame,
        this.diagnosticoOrientado,
        this.outrosMedicos,
        this.usaOutros,
        this.comoEncontrou,
        this.quaisEqp,

      })
      : super(key: key);

  @override
  _CommitmentTermCompanyState createState() => _CommitmentTermCompanyState();
}

class _CommitmentTermCompanyState extends State<CommitmentTermCompany> {
  final _formkey = GlobalKey<FormState>();
  bool loading = false, isEnabled = false, checkBoxValue = false;
  String error = '';


  Widget _buildForm() {
    return Form(
        key: _formkey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 25.0),
              Text(
                'Termos de uso',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25.0),
              Text(
                '1. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentry.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '2. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentry.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '3. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentry.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '4. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentry.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 25.0),
              CheckboxListTile(
                title: Text(
                  'Estou de acordo com os termos de uso.',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
                activeColor: Color(0xFF6848AE),
                value: checkBoxValue,
                onChanged: (bool value) {
                  setState(() {
                    checkBoxValue = value;
                  });
                  checkBoxValue ? isEnabled = true : isEnabled = false;
                },
              ),
              SizedBox(height: 25.0),
              Text(
                //error text
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  //button
                    elevation: 5.0,
                    color: Color(0xFF6848AE),
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      'CONTINUAR',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    onPressed: isEnabled
                        ? ()  {
                      Navigator.push(context, SlideRightRoute(widget: RegisterCompany()));
                    }
                        : null
                ),
              ),
              SizedBox(height: 40.0),
            ]));
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
    return loading
        ? Loading()
        : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(title: 'Acordo de termos de serviço'),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildForm(),
              Container(
                alignment: Alignment.centerRight,
                height: 20.0,
                child: Image.asset('images/logo_roxa.png'),
              ),
            ],
          ),
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        ),
      ),
    );
  }
}
