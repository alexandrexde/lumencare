import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lumen/common_widgets/maintenance.dart';
import 'package:lumen/common_widgets/transition.dart';
import 'package:lumen/screens/home/connectWithClient.dart';
import 'package:lumen/screens/home/profile.dart';
import 'package:lumen/screens/home/sideMenu/connect.dart';
import 'package:lumen/screens/home/sideMenu/coursesClasses.dart';
import 'package:lumen/screens/home/sideMenu/historic.dart';
import 'package:lumen/screens/home/sideMenu/schedule.dart';
import 'package:lumen/services/auth.dart';
import 'docs.dart';

class NavDrawer extends StatelessWidget {
  final String typeUser;
  NavDrawer({this.typeUser});
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFF6848ae),
                Color(0xFF8e48ae),
              ], stops: [
                0.0,
                0.695
              ], transform: GradientRotation(2.13959913 * pi)),
              image: DecorationImage(
                scale: 50,
                fit: BoxFit.fitHeight,
                image: AssetImage('images/cover.png', ),
              ),
            ),
            child: null,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () {
              Navigator.push(
                context,
                SlideRightRoute5(
                    widget: Profile(
                  typeUser: typeUser,
                )),
              );
            },
          ),
          typeUser == 'Client'
              ? ListTile(
                  leading: Icon(Icons.group_add),
                  title: Text('Conectar a Profissional'),
                  onTap: () {
                    Navigator.push(
                      context,
                      SlideRightRoute5(
                          widget: ConnectProfessional(
                        typeUser: typeUser,
                      )),
                    );
                  },
                )
              : SizedBox(),
          typeUser == 'Professional'
              ? ListTile(
                  leading: Icon(Icons.group_add),
                  title: Text('Conectar a Cliente'),
                  onTap: () {
                    Navigator.push(
                      context,
                      SlideRightRoute5(
                          widget: ConnectWithClient(
                        typeUser: typeUser,
                      )),
                    );
                  },
                )
              : SizedBox(),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Histórico'),
            onTap: () {
              Navigator.push(
                  context,
                  SlideRightRoute5(
                      widget: Maintanance()) //Historic(typeUser: typeUser,)),
                  );
            },
          ),
          ListTile(
            leading: Icon(Icons.video_library),
            title: Text('Cursos e Aulas'),
            onTap: () {
              Navigator.push(
                  context,
                  SlideRightRoute5(
                      widget:
                          Maintanance()) //CoursesClasses(typeUser: typeUser,)),
                  );
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Documentos'),
            onTap: () {
              Navigator.push(
                context,
                SlideRightRoute5(
                    widget: Docs(
                  typeUser: typeUser,
                )),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Agenda'),
            onTap: () {
              Navigator.push(
                  context,
                  SlideRightRoute5(
                      widget: Maintanance()) //Schedule(typeUser: typeUser,)),
                  );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
