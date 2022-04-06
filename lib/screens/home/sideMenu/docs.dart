import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lumen/models/user.dart';
import '../home.dart';
import 'package:lumen/services/database.dart';
import 'package:lumen/shared/loading.dart';
import 'package:provider/provider.dart';

class Docs extends StatelessWidget {

  final String typeUser;
  Docs({this.typeUser});

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
        stream: typeUser == 'Client' ? DatabaseService(uid: user.uid).userData : typeUser == 'Company' ? DatabaseService(uid: user.uid).userDataCompany : DatabaseService(uid: user.uid).userDataProfessional,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFF6848AE),
                elevation: 0.0,
                centerTitle: true,
                title: Text('Documentos'),
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
              body: Column(
                  children: [
                    Expanded(
                          child: SizedBox(
                            height: 50.0,
                            child: ListView.separated(
                              padding: const EdgeInsets.all(8),
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                    contentPadding: EdgeInsets.only(top: 10,bottom: 10,left: 8,right: 8),
                                    leading: Icon(Icons.description, color: index == 0 || index == 4? Colors.indigo[400] : index == 1 || index == 3 ? Colors.amber[400] : Colors.deepOrange[400], size: 50,),
                                    title: Text(index == 0 || index == 4? 'Pré-Atendimento' : index == 1 || index == 3 ? 'Atendimento' : 'Prescrição', style: TextStyle(color: Colors.black54,fontSize: 14.5),),
                                    trailing: Text(DateFormat("dd/MM/yyyy").format(DateTime.now().subtract(Duration(days: 2*index))), style: TextStyle(color: Colors.black54),),
                                    onTap: () { /* react to the tile being tapped */ }
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) => const Divider(),
                            ),
                          ),
                        ),
                  ],
                ),
            );
          } else {
            return Loading();
          }
        });
  }
}
