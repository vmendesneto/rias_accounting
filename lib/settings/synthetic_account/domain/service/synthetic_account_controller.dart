import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../database/db_firestore.dart';

class SharedState {
  List<String> listAddress = [];
  List<String> listAddressObrig = [];
  SharedState({this.listAddress = const [],this.listAddressObrig = const []});
}

class SharedController extends StateNotifier<SharedState> {
  SharedController([SharedState? state]) : super(SharedState()) {
    //readAllSynthetic();
  }

  saveAllSynthetic(String name) async {
    late FirebaseFirestore db;
    db = DBFirestore.get();
    final data = {'name': name.toUpperCase()};
    await db.collection('sinteticas').doc().set(data, SetOptions(merge: true));
  }

  readAllSynthetic() async {
    late FirebaseFirestore db;
    db = DBFirestore.get();
    List<String> listAddress = [];
    final snapshot = await db.collection('sinteticas').get();
    if (snapshot.docs.isNotEmpty) {
      for (var i = 0; i < snapshot.docs.length; i++) {
        var name = snapshot.docs[i].get('name');
        listAddress.add(name.toString());
      }
    }
    state = SharedState(listAddress: listAddress);
    return listAddress;
  }
inicitial() async {
  await readAllSyntObrig();
  if (state.listAddressObrig.contains('FRETE')) {} else {
    await saveAllSyntObrig('FRETE');
  }
  await readAllSynthetic();
}
  saveAllSyntObrig(String name) async {
    late FirebaseFirestore db;
    db = DBFirestore.get();
    final data = {'name': name.toUpperCase()};
    await db.collection('sinteticasobrigatorias').doc().set(data, SetOptions(merge: true));
  }

    readAllSyntObrig() async {
      late FirebaseFirestore db;
      db = DBFirestore.get();
      List<String> listAddress = [];
      final snapshot = await db.collection('sinteticasobrigatorias').get();
      if (snapshot.docs.isNotEmpty) {
        for (var i = 0; i < snapshot.docs.length; i++) {
          var name = snapshot.docs[i].get('name');
          listAddress.add(name.toString());
        }
      }
      state = SharedState(listAddressObrig: listAddress);
      return listAddress;
    }
}
// Future<List<String>> remove(String name) async {
//   final preferences = await SharedPreferences.getInstance();
//   var listAddress = preferences.getStringList('name');
//   listAddress!.remove(name);
//   await preferences.setStringList('name', listAddress);
//   state = SharedState(listAddress: listAddress);
//   return listAddress;
// }

