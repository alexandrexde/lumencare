// --- Maintanance Widget refactored ---
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lumen/screens/home/home.dart';

class Maintanance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6848AE),
        elevation: 0.0,
        centerTitle: true,
        title: Text('Em Manutenção'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'Oops!',
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Icon(
                  Icons.warning,
                  color: Colors.black38,
                  size: 100.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Página em construção.',
                  style: TextStyle(color: Colors.black38, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Aguarde novidade!',
                  style: TextStyle(color: Colors.black38, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 145,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Home();
                      }),
                    );
                  },
                  child: Text(
                    'Voltar à página inicial',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
