import 'package:adminecg/common/firebase_collections/firebase_collections.dart';
import 'package:adminecg/common/models/topic/topic_model.dart';
import 'package:flutter/foundation.dart';

class TopicRepo{

  TopicRepo(this.collection);
  final TopicCollection collection;
  List<TopicModel>list = [];

  Future fetch() async {
    try {
      final diagnosis = await collection.collectionReference.get();
      if (kDebugMode) {
        print('Topics fetch. Topics = ${diagnosis.docs.length}');
      }
      if (diagnosis.docs.isNotEmpty) {
        list = diagnosis.docs
            .map((e) =>
            TopicModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('Topics fetch. Error = $e');
    }
  }

  Future add(String en, String he) async {
    String id = list.length.toString();
    try {
      await collection.collectionReference
          .doc(list.length.toString())
          .set(TopicModel(id: id, titleEn: en, titleHe: he).toJson());
      await fetch();
      if (kDebugMode) {
        print('Topics add. Success');
      }
    } catch (e) {
      print('Topics add. Error = $e');
    }
  }

  Future edit(TopicModel model) async {
    try {
      await collection.collectionReference
          .doc(model.id)
          .set(model.toJson());
      await fetch();

      if (kDebugMode) {
        print('Topics edit. Success');
      }
    } catch (e) {
      print('Topics edit. Error = $e');
    }
  }

  Future remove(TopicModel model) async {
    try {
      await collection.collectionReference.doc(model.id).delete();
      if (kDebugMode) {
        print('Topics remove. Success');
      }
    } catch (e) {
      print('Topics remove. Error = $e');
    }
  }

}