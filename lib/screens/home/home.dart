import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumen/models/user.dart';
import 'package:lumen/screens/home/homeProfessional.dart';
import 'package:lumen/screens/home/homeUser.dart';
import 'package:lumen/services/database.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';
import 'homeCompany.dart';

class Home extends StatelessWidget {



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

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          if (snapshot.hasData && userData.typeUser == 'Client') {
            return homeUser();
          } else {
            return StreamBuilder<UserData>(
                stream: DatabaseService(uid: user.uid).userDataProfessional,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return homeProfessional();
                  } else {
                    return StreamBuilder<UserData>(
                        stream: DatabaseService(uid: user.uid).userDataCompany,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return homeCompany();
                          } else {
                            return Loading();
                          }
                        });
                  }
                });
          }
        });
  }
}
