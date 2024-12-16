import 'package:adminecg/common/firebase_collections/firebase_collections.dart';
import 'package:adminecg/common/models/diagnosis/diagnosis_model.dart';
import 'package:flutter/foundation.dart';

class DiagnosisRepo {
  DiagnosisRepo({required this.diagnosisCollection});

  final DiagnosisCollection diagnosisCollection;

  List<DiagnoseModel> list = [];

  List<String> ids() {
    List<String> list = ['-1'];
    for (var value in this.list) {
      list.add(value.id);
    }
    return list;
  }

  String value(String id, String locale) {
    if (id == '-1') {
      return '';
    }
    final index = list.indexWhere((e) => e.id == id);
    print('---------- $index');
    if (index >= 0) {
      return list[index].titleEn;
    }
    return '';
  }

  Future<List<DiagnoseModel>> getListDiagnoseModel() async {
    try {
      final diagnosis = await diagnosisCollection.collectionReference.get();
      if (kDebugMode) {
        print('Diagnosis fetch. Diagnisis = ${diagnosis.docs.length}');
      }
      if (diagnosis.docs.isNotEmpty) {
        list = diagnosis.docs.map((e) => DiagnoseModel.fromJson(e.data() as Map<String, dynamic>)).toList();
        return list;
      }
    } catch (e) {
      print('Diagnosis fetch. Error = $e');
    }
    return [];
  }

  Future<void> addDiagnose({required String en, required String he}) async {
    String id = list.length.toString();
    try {
      await diagnosisCollection.collectionReference.doc(list.length.toString())
          .set(DiagnoseModel(id: id, titleEn: en, titleHe: he).toJson());
      await getListDiagnoseModel();
      if (kDebugMode) {
        print('Diagnosis add. Success');
      }
    } catch (e) {
      print('Diagnosis add. Error = $e');
    }
  }

  Future edit(DiagnoseModel model) async {
    try {
      await diagnosisCollection.collectionReference.doc(model.id).set(model.toJson());
      await getListDiagnoseModel();

      if (kDebugMode) {
        print('Diagnosis edit. Success');
      }
    } catch (e) {
      print('Diagnosis edit. Error = $e');
    }
  }

  Future remove(DiagnoseModel model) async {
    try {
      await diagnosisCollection.collectionReference.doc(model.id).delete();
      if (kDebugMode) {
        print('Diagnosis remove. Success');
      }
    } catch (e) {
      print('Diagnosis remove. Error = $e');
    }
  }
}
