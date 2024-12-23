import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/diagnosis/diagnosis_model.dart';
import 'package:adminecg/common/models/topic/topic_model.dart';
import 'package:adminecg/common/theme/app_theme.dart';
import 'package:adminecg/ui/diagnosis_topics/diagnosis_topics_provider.dart';
import 'package:adminecg/ui/dialog/enter_dialog.dart';
import 'package:adminecg/ui/widgets/app_button.dart';
import 'package:adminecg/ui/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DiagnosisTopicsPage extends StatefulWidget {
  const DiagnosisTopicsPage({super.key});

  @override
  State<DiagnosisTopicsPage> createState() => _DiagnosisTopicsPageState();
}

class _DiagnosisTopicsPageState extends State<DiagnosisTopicsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<DiagnosisTopicsProvider>().getDiagnoseModel();
      context.read<DiagnosisTopicsProvider>().getTopicModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DiagnosisTopicsProvider>(
      builder: (context, value, child) {
        return Wrap(
          children: [
            Container(
              width: 460,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(26.0)),
                border: Border.all(color: const Color(0xffD9D9D9), width: 1.3),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add New Diagnosis',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontSize: 22),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Diagnosis  List',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: AppTheme.textColorLight),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => showDialog(
                          context: context,
                          builder: (_) => EnterDialog.show(
                              context: context,
                              title: 'Add New Diagnose',
                              callBack: (en, he) {
                                value.addNewDiagnose(
                                  context: context,
                                  en: en,
                                  he: he,
                                );
                              }),
                        ),
                        child: _addNewItem(item: 'Add New Diagnose'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (value.state.diagnoseListModel.isNotEmpty)
                    SizedBox(
                      width: 460,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: value.state.diagnoseListModel.length,
                        itemBuilder: (context, index) {
                          var item = value.state.diagnoseListModel[index];
                          return _itemWidget(
                            item: item.titleEn,
                            index: index,
                            edit: () {
                              showDialog(
                                context: context,
                                  builder: (_) => EnterDialog.show(
                                      context: context,
                                      title: 'Edit Diagnose',
                                      callBack: (en, he) {
                                        var newModel = DiagnoseModel(
                                            id: item.id,
                                            titleEn: en,
                                            titleHe: he);
                                        value.editDiagnose(context, newModel);
                                      }),
                              );
                            },
                            remove: () {
                              value.removeDiagnose(item);
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Container(
              width: 460,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(26.0)),
                border: Border.all(color: const Color(0xffD9D9D9), width: 1.3),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add New Topic',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontSize: 22),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Topic  List',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: AppTheme.textColorLight),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => showDialog(
                            context: context,
                            builder: (_) => EnterDialog.show(
                                context: context,
                                title: 'Add New Topic',
                                callBack: (en, he) {
                                  value.addNewTopic(
                                      context: context, en: en, he: he);
                                })),
                        child: _addNewItem(item: 'Add New Topic'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (value.state.topicListModel.isNotEmpty)
                    SizedBox(
                      width: 460,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: value.state.topicListModel.length,
                        itemBuilder: (context, index) {
                          var item = value.state.topicListModel[index];
                          return _itemWidget(
                            item: item.titleEn,
                            index: index,
                            edit: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => EnterDialog.show(
                                      context: context,
                                      title: 'Edit Topic',
                                      callBack: (en, he) {
                                        value.editTopic(
                                            context,
                                            TopicModel(
                                                id: item.id,
                                                titleEn: en,
                                                titleHe: he));
                                      }));
                            },
                            remove: () {
                              value.removeTopic(item);
                            },
                          );
                        },
                      ),
                    ),
                  // _topicList(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _itemWidget({
    required String item,
    required int index,
    required Function() edit,
    required Function() remove,
  }) {
    return Container(
      height: 30,
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 25,
            child: Text(
              index < 9 ? "0${index + 1}" : "${index + 1}",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: const Color(0xff1A1919),
                    fontSize: 12,
                  ),
            ),
          ),
          const SizedBox(width: 37),
          SizedBox(
            width: 83,
            child: Text(
              item,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: const Color(0xff1A1919),
                    fontSize: 12,
                  ),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: edit,
            child: SvgPicture.asset(
              width: 20,
              height: 20,
              "assets/images/svg/edit.svg",
            ),
          ),
          SizedBox(
            width: 16,
          ),
          InkWell(
            onTap: remove,
            child: SvgPicture.asset(
              width: 20,
              height: 20,
              "assets/images/svg/delete.svg",
            ),
          ),
        ],
      ),
    );
  }

  Widget _addNewItem({required String item}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      height: 56,
      width: 200,
      decoration: BoxDecoration(
        color: const Color(0xff0A4E74),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        border: Border.all(color: const Color(0xff0A4E74), width: 1.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Colors.white,
                ),
          ),
          const Icon(Icons.add, color: Colors.white)
        ],
      ),
    );
  }
}
