import 'package:animated_check/animated_check.dart';
import 'package:flutter/material.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:lumen/services/database.dart';

class CurrentEquipament8 extends StatefulWidget {
  final String typeUser;
  const CurrentEquipament8({Key key, @required this.typeUser}) : super(key: key);
  @override
  _CurrentEquipament8State createState() => _CurrentEquipament8State();
}

class _CurrentEquipament8State extends State<CurrentEquipament8> with SingleTickerProviderStateMixin {
  final _formkey = GlobalKey<FormState>();
  String error, complementaresDesc;
  List<String> simNao = ['Sim', 'Não'];
  int limpa, lubrifica, pneus, porcas, raios, estofado, ferrugem, almofada, reparos, adequada;
  AnimationController _animationController;
  Animation<double> _animation;
  double sizeAnimation = 0;
  bool pressed = false;

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
      appBar: AppBarWidget(
        title: 'Equipamento',
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 50.0,
          ),
          child: StreamBuilder<UserData>(
            stream: widget.typeUser == 'Client'
                ? DatabaseService(uid: user.uid).userData
                : widget.typeUser == 'Company'
                    ? DatabaseService(uid: user.uid).userDataCompany
                    : DatabaseService(uid: user.uid).userDataProfessional,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Cuidados com a cadeira de rodas em casa', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                      SizedBox(height: 25),

                      TextForm(text: 'Limpar a cadeira de rodas e a almofada',),
                      SizedBox(height: 10),
                      SingleCustomRadio(namedButton: simNao,
                        onAnswer: (value){ setState(() {limpa = value;});},),
                      SizedBox(height: 25),

                      TextForm(text: 'Lubrificar as partes móveis',),
                      SizedBox(height: 10),
                      SingleCustomRadio(namedButton: simNao,
                        onAnswer: (value){ setState(() {lubrifica = value;});},),
                      SizedBox(height: 25),

                      TextForm(text: 'Calibrar os pneus',),
                      SizedBox(height: 10),
                      SingleCustomRadio(namedButton: simNao,
                        onAnswer: (value){ setState(() {pneus = value;});},),
                      SizedBox(height: 25),

                      TextForm(text: 'Apertar porcas e parafusos (se frouxos)',),
                      SizedBox(height: 10),
                      SingleCustomRadio(namedButton: simNao,
                        onAnswer: (value){ setState(() {porcas = value;});},),
                      SizedBox(height: 25),

                      TextForm(text: 'Apertar os raios (se frouxos)',),
                      SizedBox(height: 10),
                      SingleCustomRadio(namedButton: simNao,
                        onAnswer: (value){ setState(() {raios = value;});},),
                      SizedBox(height: 25),

                      TextForm(text: 'Verificar estofado do encosto',),
                      SizedBox(height: 10),
                      SingleCustomRadio(namedButton: simNao,
                        onAnswer: (value){ setState(() {estofado = value;});},),
                      SizedBox(height: 25),

                      TextForm(text: 'Verificar se há ferrugem',),
                      SizedBox(height: 10),
                      SingleCustomRadio(namedButton: simNao,
                        onAnswer: (value){ setState(() {ferrugem = value;});},),
                      SizedBox(height: 25),

                      TextForm(text: 'Verificar a almofada',),
                      SizedBox(height: 10),
                      SingleCustomRadio(namedButton: simNao,
                        onAnswer: (value){ setState(() {almofada = value;});},),
                      SizedBox(height: 25),

                      Text('O que fazer se houver problemas', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                      SizedBox(height: 25),

                      TextForm(text: 'A cadeira de rodas precisar de reparos?',),
                      SizedBox(height: 10),
                      SingleCustomRadio(namedButton: simNao,
                        onAnswer: (value){ setState(() {reparos = value;});},),
                      SizedBox(height: 25),

                      TextForm(text: 'A cadeira de rodas não for mais adequada ou confortável',),
                      SizedBox(height: 10),
                      SingleCustomRadio(namedButton: simNao,
                        onAnswer: (value){ setState(() {adequada = value;});},),
                      SizedBox(height: 25),

                      TextForm(text: 'Se houverem orientações complementares para o usuário e/ou familiares, descreva'),
                      CustomForm(obscureText: false,hintText: 'Descreva neste campo', onChanged:(val) {setState(() => complementaresDesc = val);},),
                      SizedBox(height: 40),

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
                            if (_formkey.currentState.validate()) {
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
