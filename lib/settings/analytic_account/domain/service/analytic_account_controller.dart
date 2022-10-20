

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../database/db_firestore.dart';

class AnalyticState {
  List<String> listAddress = [];

  AnalyticState({this.listAddress = const []});
}

class AnalyticController extends StateNotifier<AnalyticState> {
  AnalyticController([AnalyticState? state]) : super(AnalyticState()) {
    readAllAnalytic('Conta q será vinculada');
  }

  saveAllAnalytic(String cod, String name) async {
    late FirebaseFirestore db;
    db = DBFirestore.get();
    final data = {'cod': cod, 'data': DateTime.now()};
    await db.collection(name).doc().set(data);
  }

  readAllAnalytic(String name) async {
    late FirebaseFirestore db;
    db = DBFirestore.get();
    List<String> listAddress = [];
    final snapshot = await db.collection(name).get();
    print(snapshot.docs);
      for (var i = 0; i < snapshot.docs.length; i++) {
        var name = snapshot.docs[i].get('cod');
        listAddress.add(name.toString());

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
