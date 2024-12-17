import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/diagnosis/diagnosis_model.dart';
import 'package:adminecg/common/models/topic/topic_model.dart';
import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/topic/topic_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiagnosisTopicsProvider extends ChangeNotifier {
  DiagnosisTopicsProvider({
    required this.diagnosisRepo,
    required this.topicRepo,
  });

  final DiagnosisRepo diagnosisRepo;
  final TopicRepo topicRepo;


  DiagnosisTopicsState state = DiagnosisTopicsState();

  void updatePage() {
    notifyListeners();
  }
  Future<void> getDiagnoseModel() async {
    state.diagnoseListModel = await diagnosisRepo.getListDiagnoseModel();
    updatePage();
  }
  Future<void> getTopicModel() async {
    state.topicListModel = await topicRepo.getListTopicModel();
    updatePage();
  }

  Future<void> addNewDiagnose({required BuildContext context, required String en, required String he}) async {
    await diagnosisRepo.addDiagnose(en: en, he: he);
    await getDiagnoseModel();
    context.backPage();
}

  Future<void> addNewTopic({required BuildContext context, required String en, required String he}) async {
    await topicRepo.addTopic(en: en, he: he);
    await getTopicModel();
    context.backPage();
  }

  Future<void> editDiagnose(BuildContext context, DiagnoseModel model) async {
    await diagnosisRepo.edit(model);
    await getDiagnoseModel();
    context.backPage();
  }

  Future<void> removeDiagnose(DiagnoseModel model) async {
    await diagnosisRepo.remove(model);
    await getDiagnoseModel();
    updatePage();
  }

  Future<void> editTopic(BuildContext context, TopicModel model) async {
    await topicRepo.edit(model);
    await getTopicModel();
    context.backPage();
  }

  Future<void> removeTopic(TopicModel model) async {
    await topicRepo.remove(model);
    await getTopicModel();
    updatePage();
  }

}

class DiagnosisTopicsState {
  List<DiagnoseModel> diagnoseListModel = [];
  List<TopicModel> topicListModel = [];
}
