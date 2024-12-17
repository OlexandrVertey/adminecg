import 'package:adminecg/common/firebase_collections/firebase_collections.dart';
import 'package:adminecg/common/models/event/event_model.dart';
import 'package:flutter/foundation.dart';

class EventRepo{

  EventRepo(this.collection);
  final EventCollection collection;



  List<EventModel> list = [];

  Future<List<EventModel>> getList() async {
    try {
      final diagnosis = await collection.collectionReference.get();
      if (kDebugMode) {
        print('Event fetch. Topics = ${diagnosis.docs.length}');
      }
      if (diagnosis.docs.isNotEmpty) {
        list = diagnosis.docs.map((e) => EventModel.fromJson(e.data() as Map<String, dynamic>)).toList();
        return list;
      }
    } catch (e) {
      print('Event fetch. Error = $e');
    }
    return [];
  }

  Future add(EventModel model) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      await collection.collectionReference.doc(model.id)
          .set(model.toJson());
      await getList();
      if (kDebugMode) {
        print('Event add. Success');
      }
    } catch (e) {
      print('Event add. Error = $e');
    }
  }

  Future edit(EventModel model) async {
    try {
      await collection.collectionReference.doc(model.id).set(model.toJson());
      await getList();

      if (kDebugMode) {
        print('Event edit. Success');
      }
    } catch (e) {
      print('Event edit. Error = $e');
    }
  }

  Future remove(EventModel model) async {
    try {
      await collection.collectionReference.doc(model.id).delete();
      await getList();
      if (kDebugMode) {
        print('Event remove. Success');
      }
    } catch (e) {
      print('Event remove. Error = $e');
    }
  }

}