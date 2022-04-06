import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/screens/authenticate/sign_in.dart';
import 'package:lumen/services/auth.dart';
import 'package:lumen/shared/loading.dart';

class RegisterProfessional extends StatefulWidget {
  final Function toggleView;
  RegisterProfessional({this.toggleView});

  @override
  _RegisterProfessionalState createState() => _RegisterProfessionalState();
}

class _RegisterProfessionalState extends State<RegisterProfessional> {
  final _formkey = GlobalKey<FormState>();
  String email = '', password = '', error = '', name = '', telefone = '', cep = '', logradouro = '', bairro = '', cidade = '', _salutatione = "Acre (AC)", sexo = '', possuiResponsavel = '', numCasa = "", complemento = '';
  int sexoValue, possuiResponsavelValue;
  final AuthService _auth = AuthService();
  bool loading = false;
  DateTime _dateTime;
  bool _showPassword = false;

  Widget _buildForm() {

    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //nome
          SizedBox(height: 20.0),
          TextForm(text: 'Nome'),
          CustomForm(hintText: 'Digite seu nome', onChanged: (val) {setState(() => name = val);},validator: (val) => val.isEmpty ? 'Digite seu nome' : null,obscureText: false,),

          //email
          SizedBox(height: 30.0),
          TextForm(text: 'Email'),
          CustomForm(hintText: 'Digite seu email',onChanged: (val) {setState(() => email = val);},validator: (val) => val.isEmpty ? 'Digite um e-mail' : null, keyboardType: TextInputType.emailAddress,obscureText: false,),

          //senha
          SizedBox(height: 30.0),
          TextForm(text: 'Senha'),
          TextFormField(
            obscureText: !_showPassword,
            cursorColor: Color(0xFF6848AE),
            validator: (val) => val.isEmpty ? '' : null,
            onChanged: (val) {
              setState(() => password = val);
            },
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: (){
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
                child: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Color(0xFF6848AE),
                ),
              ),
              contentPadding: EdgeInsets.only(left: 8, top: 13),
              hintText: 'Digite sua senha',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF6848AE),
                  width: 2.0,
                ),
              ),
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.4),
                fontSize: 14.0,
              ),
            ),
          ),

          //Data de nascimento
          SizedBox(height: 30.0),
          TextForm(text: 'Data de nascimento'),
          SizedBox(height: 8.0),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black.withOpacity(0.4)))),
            width: 350,
            alignment: Alignment.bottomLeft,
            child: FlatButton(
              color: Colors.transparent,
              child: Text(
                _dateTime == null
                    ? 'Escolha a data'
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
                  });
                });
              },
            ),
          ),
          SizedBox(height: 45.0),

          //button
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
                'REGISTRAR',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if (_formkey.currentState.validate()) {


                  setState(() {
                    loading = true;
                  });
                  dynamic result = await _auth.registerProfessionalWithEmailAndPassword(
                      email, password, name, _dateTime);
                  await _auth.signOut();
                  switch (result) {
                    case 1:
                      loading = false;
                      setState(() => error = 'Email em uso. Tente novamente');
                      break;
                    default:
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => _verifyScreen(),
                      );
                      break;
                  }
                }
              },
            ),
          ),
          SizedBox(
            height: 25.0,
          ),

          //error widget
          Text(
            //error text
            error,
            style: TextStyle(
              color: Colors.red,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
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
      appBar: AppBarWidget(title: 'Criar Profissional'),
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
  _verifyScreen() {
    return AlertDialog(
      title: Text('Verifique seu email'),
      content: Text(
          'Um email para verificar sua senha foi enviado para $email'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: Text(
            'Voltar',
            style: TextStyle(
              color: Color(0xFF6848AE),
            ),
          ),
        ),
      ],
    );
  }
}

