import 'package:animated_check/animated_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/common_widgets/app_bar.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/services/database.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';


class Prescricao5 extends StatefulWidget {

  final typeUser;
  final String  uid;
  final Map<String, dynamic> pageData, pageData1, pageData2, pageData3;
  
  Prescricao5({this.typeUser, this.uid, this.pageData1, this.pageData, this.pageData2, this.pageData3});

  @override
  _Prescricao5State createState() => _Prescricao5State();
}

class _Prescricao5State extends State<Prescricao5> with SingleTickerProviderStateMixin {
  final _formkey = GlobalKey<FormState>();

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
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }
  void _resetCheck() {
    _animationController.reverse();
  }

  String error;
  bool pressed = false;

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

    return pressed ? Scaffold(
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
    ) :
    Scaffold(
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
                  return Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text('Opções de equipamentos prescritos', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                        SizedBox(height: 25),

                        Text('Opção 1', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                        SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextForm(text: 'Modelo',),
                            CustomForm(hintText: 'Preencha o modelo', obscureText: false,),
                            SizedBox(height: 25,),

                            TextForm(text: 'Fabricante',),
                            CustomForm(hintText: 'Preencha o fabricante', obscureText: false,),
                            SizedBox(height: 25,),

                            TextForm(text: 'Opcionais de fábrica',),
                            CustomForm(hintText: 'Preencha os opcionais de fábrica', obscureText: false,),
                            SizedBox(height: 25,),

                            Text('Medidas da cadeira de rodas', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                            SizedBox(height: 25,),

                            TextForm(text: 'Comprimento',),
                            CustomForm(hintText: 'Preencha o comprimento', obscureText: false,),
                            SizedBox(height: 25,),

                            TextForm(text: 'Largura',),
                            CustomForm(hintText: 'Preencha a largura', obscureText: false,),
                            SizedBox(height: 25,),

                            TextForm(text: 'Altura',),
                            CustomForm(hintText: 'Preencha a altura', obscureText: false,),
                            SizedBox(height: 25,),
                          ],
                        ),

                        Text('Opção 2', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                        SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextForm(text: 'Modelo',),
                            CustomForm(hintText: 'Preencha o modelo', obscureText: false,),
                            SizedBox(height: 25,),

                            TextForm(text: 'Fabricante',),
                            CustomForm(hintText: 'Preencha o fabricante', obscureText: false,),
                            SizedBox(height: 25,),

                            TextForm(text: 'Opcionais de fábrica',),
                            CustomForm(hintText: 'Preencha os opcionais de fábrica', obscureText: false,),
                            SizedBox(height: 25,),

                            Text('Medidas da cadeira de rodas', style: TextStyle(color: Color(0xFF6935AE),fontSize: 18, fontWeight: FontWeight.bold),),
                            SizedBox(height: 25,),

                            TextForm(text: 'Comprimento',),
                            CustomForm(hintText: 'Preencha o comprimento', obscureText: false,),
                            SizedBox(height: 25,),

                            TextForm(text: 'Largura',),
                            CustomForm(hintText: 'Preencha a largura', obscureText: false,),
                            SizedBox(height: 25,),

                            TextForm(text: 'Altura',),
                            CustomForm(hintText: 'Preencha a altura', obscureText: false,),
                            SizedBox(height: 30,),
                          ],
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
                                setState(() => pressed = true);
                                //TODO: ENVIAR DADOS PARA O BANCO DE DADOS
                                _showCheck();
                              }
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
      ),
    );
  }
}


