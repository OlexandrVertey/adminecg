import 'package:adminecg/common/firebase_collections/firebase_collections.dart';
import 'package:adminecg/common/models/learning/learning_model.dart';
import 'package:flutter/foundation.dart';

class LearningRepo {
  final LearningCollection collection;
  LearningRepo(this.collection);

  List<LearningModel> list = [];

  Future<void> getList() async {
    try {
      final diagnosis = await collection.collectionReference.get();
      if (kDebugMode) {
        print('Event fetch. Success = ${diagnosis.docs.length}');
      }
      list = diagnosis.docs
          .map((e) => LearningModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Event fetch. Error = $e');
    }
  }

  Future add(LearningModel model) async {
    try {
      await collection.collectionReference
          .doc(model.id)
          .set(model.toJson())
          .then((_) async {
        await getList();
      });
      if (kDebugMode) {
        print('Event add. Success');
      }
    } catch (e) {
      print('Event add. Error = $e');
    }
  }

  Future edit(LearningModel model) async {
    try {
      await collection.collectionReference.doc(model.id).set(model.toJson()).then((_) async {
        await getList();
      });

      if (kDebugMode) {
        print('Event edit. Success');
      }
    } catch (e) {
      print('Event edit. Error = $e');
    }
  }

  Future remove(LearningModel model) async {
    try {
      await collection.collectionReference
          .doc(model.id)
          .delete()
          .then((_) async {
        await getList();
      });
      if (kDebugMode) {
        print('Event remove. Success ${model.id}');
      }
    } catch (e) {
      print('Event remove. Error = $e');
    }
  }
}