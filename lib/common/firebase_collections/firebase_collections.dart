import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;

class Collection {
  late cloud_firestore.CollectionReference _ref;


  cloud_firestore.CollectionReference get collectionReference => _ref;

}


class UsersCollection extends Collection {
  UsersCollection() {
    _ref = cloud_firestore.FirebaseFirestore.instance.collection('Users');
  }
}