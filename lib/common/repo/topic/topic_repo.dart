import 'package:adminecg/common/firebase_collections/firebase_collections.dart';
import 'package:adminecg/common/models/topic/topic_model.dart';
import 'package:flutter/foundation.dart';

class TopicRepo {
  TopicRepo({required this.topicCollection});

  final TopicCollection topicCollection;

  List<TopicModel> list = [];

  Future<List<TopicModel>> getListTopicModel() async {
    try {
      final diagnosis = await topicCollection.collectionReference.get();
      if (kDebugMode) {
        print('Topics fetch. Topics = ${diagnosis.docs.length}');
      }
      if (diagnosis.docs.isNotEmpty) {
        list = diagnosis.docs.map((e) => TopicModel.fromJson(e.data() as Map<String, dynamic>)).toList();
        return list;
      }
    } catch (e) {
      print('Topics fetch. Error = $e');
    }
    return [];
  }

  Future addTopic({required String en, required String he}) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      await topicCollection.collectionReference.doc(id)
          .set(TopicModel(id: id, titleEn: en, titleHe: he).toJson());
      await getListTopicModel();
      if (kDebugMode) {
        print('Topics add. Success');
      }
    } catch (e) {
      print('Topics add. Error = $e');
    }
  }

  Future edit(TopicModel model) async {
    try {
      await topicCollection.collectionReference.doc(model.id).set(model.toJson());
      await getListTopicModel();

      if (kDebugMode) {
        print('Topics edit. Success');
      }
    } catch (e) {
      print('Topics edit. Error = $e');
    }
  }

  Future remove(TopicModel model) async {
    try {
      await topicCollection.collectionReference.doc(model.id).delete();
      if (kDebugMode) {
        print('Topics remove. Success');
      }
    } catch (e) {
      print('Topics remove. Error = $e');
    }
  }
}
