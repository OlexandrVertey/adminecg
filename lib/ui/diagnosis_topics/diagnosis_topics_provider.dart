import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/diagnosis/diagnosis_model.dart';
import 'package:adminecg/common/models/topic/topic_model.dart';
import 'package:adminecg/common/models/user_model/user_model.dart';
import 'package:adminecg/common/repo/delete_user_repo/delete_user_repo.dart';
import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/get_all_users_repo/get_all_users_repo.dart';
import 'package:adminecg/common/repo/get_user_repo/get_user_repo.dart';
import 'package:adminecg/common/repo/register_repo/register_repo.dart';
import 'package:adminecg/common/repo/set_user_repo/set_user_repo.dart';
import 'package:adminecg/common/repo/topic/topic_repo.dart';
import 'package:adminecg/common/repo/update_user_repo/update_user_repo.dart';
import 'package:adminecg/common/shared_preference/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

}

class DiagnosisTopicsState {
  List<DiagnoseModel> diagnoseListModel = [];
  List<TopicModel> topicListModel = [];
}
