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

class OrganizationsCollection extends Collection {
  OrganizationsCollection() {
    _ref = cloud_firestore.FirebaseFirestore.instance.collection('Organizations');
  }
}

class TopicCollection extends Collection {
  TopicCollection() {
    _ref = cloud_firestore.FirebaseFirestore.instance.collection('Topic');
  }
}

class DiagnosisCollection extends Collection {
  DiagnosisCollection() {
    _ref = cloud_firestore.FirebaseFirestore.instance.collection('Diagnosis');
  }
}

class EventCollection extends Collection {
  EventCollection() {
    _ref = cloud_firestore.FirebaseFirestore.instance.collection('Event');
  }
}

class LearningCollection extends Collection {
  LearningCollection() {
    _ref = cloud_firestore.FirebaseFirestore.instance.collection('Learning');
  }
}


