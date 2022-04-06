import 'package:flutter/material.dart';
import 'package:lumen/screens/home/home.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  AppBarWidget({this.title});

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Image.asset('images/WhiteLogo.png'),
          iconSize: 60,
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ],
      backgroundColor: Color(0xFF6848AE),
      elevation: 0.0,
      centerTitle: true,
      title: Text(widget.title),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
