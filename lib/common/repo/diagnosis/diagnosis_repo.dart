import 'package:adminecg/common/firebase_collections/firebase_collections.dart';
import 'package:adminecg/common/models/diagnosis/diagnosis_model.dart';
import 'package:flutter/foundation.dart';

class DiagnosisRepo {
  DiagnosisRepo(this.collection);

  final DiagnosisCollection collection;

  List<DiagnosisModel> list = [];

  Future fetch() async {
    try {
      final diagnosis = await collection.collectionReference.get();
      if (kDebugMode) {
        print('Diagnosis fetch. Diagnisis = ${diagnosis.docs.length}');
      }
      if (diagnosis.docs.isNotEmpty) {
        list = diagnosis.docs
            .map((e) =>
                DiagnosisModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('Diagnosis fetch. Error = $e');
    }
  }

  Future add(String en, String he) async {
    String id = list.length.toString();
    try {
      await collection.collectionReference
          .doc(list.length.toString())
          .set(DiagnosisModel(id: id, titleEn: en, titleHe: he).toJson());
      await fetch();
      if (kDebugMode) {
        print('Diagnosis add. Success');
      }
    } catch (e) {
      print('Diagnosis add. Error = $e');
    }
  }

  Future edit(DiagnosisModel model) async {
    try {
      await collection.collectionReference
          .doc(model.id)
          .set(model.toJson());
      await fetch();

      if (kDebugMode) {
        print('Diagnosis edit. Success');
      }
    } catch (e) {
      print('Diagnosis edit. Error = $e');
    }
  }

  Future remove(DiagnosisModel model) async {
    try {
      await collection.collectionReference.doc(model.id).delete();
      if (kDebugMode) {
        print('Diagnosis remove. Success');
      }
    } catch (e) {
      print('Diagnosis remove. Error = $e');
    }
  }
}
