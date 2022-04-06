import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lumen/models/Attendance.dart';
import 'package:lumen/models/preAttendance.dart';
import 'package:lumen/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //colection reference
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('userData');

  final CollectionReference userDataCollectionProfessional =
  FirebaseFirestore.instance.collection('userDataProfessional');

  final CollectionReference userDataCollectionCompany =
  FirebaseFirestore.instance.collection('userDataCompany');

  final CollectionReference userDataCollectionAttendance =
  FirebaseFirestore.instance.collection('userDataAttendance');

  final CollectionReference userDataCollectionPreAttendance =
  FirebaseFirestore.instance.collection('userDataPreAttendance');

  //update user data
  Future updateUserData(String name, DateTime data, String typeUser) async {
    return await userDataCollection.doc(uid).set({
      'Nome': name,
      'Data de nascimento': data,
      'Tipo do usuário': typeUser
    });
  }
  Future updateUserDataProfessional(String name, DateTime data, String typeUser) async {
    return await userDataCollectionProfessional.doc(uid).set({
      'Nome': name,
      'Data de nascimento': data,
      'Tipo do usuário': typeUser
    });
  }

  Future updateUserDataCompany(String name, DateTime data, String typeUser) async {
    return await userDataCollectionCompany.doc(uid).set({
      'Nome': name,
      'Data de nascimento': data,
      'Tipo do usuário': typeUser
    });
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['Nome'],
      data: snapshot.data()['Data de nascimento'],
      typeUser: snapshot.data()['Tipo do usuário'],
    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userDataCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
  Stream<UserData> get userDataProfessional {
    return userDataCollectionProfessional.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
  Stream<UserData> get userDataCompany {
    return userDataCollectionCompany.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future<void> createForm(preForm formData) async {
    return userDataCollectionPreAttendance.add(formData.toMap());
  }
  Future<void> createFormAtt(FormATT formData) async {
    return userDataCollectionAttendance.add(formData.toMap());
  }
}
