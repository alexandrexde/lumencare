import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Document extends StatelessWidget {
  final String title;
  final int type;
  final DateTime dateTime;
  Document({this.dateTime, this.title, this.type});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return
           ListTile(
            contentPadding: EdgeInsets.only(top: 10,bottom: 10,left: 8,right: 8),
              leading: Icon(Icons.description, color: type == 0 ? Color.fromARGB(217, 133, 165, 245) : type == 1? Colors.amber[200] : Colors.lightGreenAccent, size: 60,),
              title: Text(title, style: TextStyle(color: Colors.black54),),
              trailing: Text(DateFormat.yMMMMd("pt_BR").format(dateTime), style: TextStyle(color: Colors.black54),),
              onTap: () { /* react to the tile being tapped */ }
          );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
