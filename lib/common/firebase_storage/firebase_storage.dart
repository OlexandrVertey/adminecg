import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class Storage{
  late firebase_storage.Reference _ref;
  firebase_storage.Reference get storageReference => this._ref;
}

class DiagnoseStorage extends Storage {
  DiagnoseStorage() {
    this._ref = firebase_storage.FirebaseStorage.instance.ref();
  }
}