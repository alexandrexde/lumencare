import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String uid;
  Users({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final Timestamp data;
  final String typeUser;

  UserData({this.uid, this.name, this.data, this.typeUser});
}
