import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffer_order/models/coffee.dart';
import 'package:coffer_order/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //Collection Reference
  final CollectionReference coffeeReference =
      FirebaseFirestore.instance.collection('coffee');

  Future updateUserData(String sugars, String name, int strength) async {
    return await coffeeReference.doc(uid).set({
      'sugar': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // getting coffee order list from snapshot
  List<Coffee> _coffeeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Coffee(
        name: e.get('name') ?? '',
        sugar: e.get('sugar') ?? "0",
        strength: e.get('strength') ?? 0,
      );
    }).toList();
  }

  // getting userData from document snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name') ?? '',
      sugar: snapshot.get('sugar') ?? "0",
      strength: snapshot.get("strength") ?? 0,
    );
  }

  // getting coffee order list from snapshot via stream
  Stream<List<Coffee>> get coffeeOrder {
    return coffeeReference.snapshots().map(_coffeeListFromSnapshot);
  }

  // getting userdata from document snapshot via stream
  Stream<UserData> get userData {
    return coffeeReference.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
