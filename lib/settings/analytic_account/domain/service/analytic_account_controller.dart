import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../database/db_firestore.dart';

class AnalyticState {
  List<String> listAddress = [];

  AnalyticState({this.listAddress = const []});
}

class AnalyticController extends StateNotifier<AnalyticState> {
  AnalyticController([AnalyticState? state]) : super(AnalyticState()) {
    //readAllAnalytic(name);
  }

  saveAllAnalytic(String cod, String name) async {
    late FirebaseFirestore db;
    db = DBFirestore.get();
    final data = {
      'cod': FieldValue.arrayUnion([cod])
    };
    List<String> listAddress = [];
    final snapshot = await db.collection(name).get();
    if (snapshot.docs.isNotEmpty) {
      for (var i = 0; i < snapshot.docs.length; i++) {
        var cod = snapshot.docs[i].get('cod');
        listAddress.add(cod.toString());
      }
      if (listAddress.contains(cod) == false) {
        await db.collection(name).doc('uid').update(data);
      } else {}
    } else {
      await db.collection(name).doc('uid').set(data);
      listAddress.add(cod.toString());
    }
    state = AnalyticState(listAddress: listAddress);
    return listAddress;
  }

  readByCodAnalytic(String name) async {
    late FirebaseFirestore db;
    db = DBFirestore.get();
    List<String> listAddress = [];
    final snapshot = await db.collection(name).get();
    if (snapshot.docs.isNotEmpty) {
      for (var i = 0; i < snapshot.docs.length; i++) {
        var cod = snapshot.docs[i].get('cod');
        listAddress.add(cod.toString());
      }
    } else {
      print('COLEÇÃO VAZIA');
    }
    state = AnalyticState(listAddress: listAddress);
    return listAddress;
  }
  readAllAnalytic(String name) async {
    late FirebaseFirestore db;
    db = DBFirestore.get();
    List<String> listAddress = [];

    final snapshot = await db.collection(name).get();
    if (snapshot.docs.isNotEmpty) {
      for (var i = 0; i < snapshot.docs.length; i++) {
        var cod = snapshot.docs[i].get('cod');
        listAddress.add(cod.toString());
      }
    } else {
      print('COLEÇÃO VAZIA');
    }
    state = AnalyticState(listAddress: listAddress);
    return listAddress;
  }
// Future<List<String>> remove(String name) async {
//   final preferences = await SharedPreferences.getInstance();
//   var listAddress = preferences.getStringList('name');
//   listAddress!.remove(name);
//   await preferences.setStringList('name', listAddress);
//   state = SharedState(listAddress: listAddress);
//   return listAddress;
// }
}
