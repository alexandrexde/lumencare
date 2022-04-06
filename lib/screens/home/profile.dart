import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lumen/common_widgets/listForm.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/services/database.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';
import 'home.dart';


class Profile extends StatefulWidget {
  final String typeUser;
  Profile({this.typeUser});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _currentName;
  String email;
  String error;
  DateTime _dateTime;


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
      ),
    );

    final user = Provider.of<Users>(context);

    return Scaffold(
      //todo: melhorar UI
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF6848AE),
        elevation: 0.0,
        centerTitle: true,
        title: Text('Perfil'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) {
                return Home();
              }),
            );
          },
        ),
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
            stream: widget.typeUser == 'Client' ? DatabaseService(uid: user.uid).userData : widget.typeUser == 'Company' ? DatabaseService(uid: user.uid).userDataCompany : DatabaseService(uid: user.uid).userDataProfessional,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                User userr = _auth.currentUser;
                UserData userData = snapshot.data;
                return Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      //nome
                      SizedBox(height: 20.0),
                      TextForm(text: 'Nome'),
                      CustomForm(
                        hintText: 'Digite seu nome',
                        initialValue: userData.name,
                        enabled: true,
                        obscureText: false,
                        validator: (val) =>
                        val.isEmpty ? 'Digite seu nome' : null,
                        onChanged: (val) {
                          setState(() => _currentName = val);
                        },
                      ),

                      //email
                      SizedBox(height: 30.0),
                      TextForm(text: 'Email'),
                      CustomForm(
                        hintText: 'Digite seu email',
                        initialValue: userr.email,
                        enabled: false,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) => val.isEmpty ? 'Digite um e-mail' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
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
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.transparent,
                          ),
                          child: Text(
                            _dateTime == null
                                ? DateFormat.yMMMMd("pt_BR").format(DateTime.parse(userData.data.toDate().toString()))
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

                      SizedBox(height: 35.0),

                      //atualizar
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
                            'ATUALIZAR',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          onPressed: () async {
                            DateTime dateNull = DateTime.parse(userData.data.toDate().toString());
                            if (_dateTime == null) {
                              _dateTime = dateNull;
                            }
                            if (_formkey.currentState.validate()) {
                              widget.typeUser == 'Client' ? await DatabaseService(uid: user.uid)
                                  .updateUserData(
                                  _currentName ?? userData.name,
                                  _dateTime ?? userData.data,
                                  userData.typeUser ?? userData.typeUser
                              ) :
                              widget.typeUser == 'Company' ? await DatabaseService(uid: user.uid)
                                  .updateUserDataCompany(
                                  _currentName ?? userData.name,
                                  _dateTime ?? userData.data,
                                  userData.typeUser ?? userData.typeUser
                              ) : await DatabaseService(uid: user.uid)
                                  .updateUserDataProfessional(
                                  _currentName ?? userData.name,
                                  _dateTime ?? userData.data,
                                  userData.typeUser ?? userData.typeUser
                              );
                              Navigator.of(context).popUntil((route) => route.isFirst);
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

