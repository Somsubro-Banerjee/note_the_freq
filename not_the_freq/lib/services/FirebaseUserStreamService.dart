import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:not_the_freq/models/user-model.dart';

class FirebaseUserStreamService {
FirebaseFirestore _fireStoreDataBase = FirebaseFirestore.instance;
  Stream<List<UserModel>> getUserList() {
    return _fireStoreDataBase.collection('user')
        .snapshots()
        .map((snapShot) => snapShot.docs
        .map((document) => UserModel.fromJson(document.data()))
        .toList());
  }
}