import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/topic/topic_repo.dart';
import 'package:adminecg/common/theme/app_theme.dart';
import 'package:adminecg/ui/content_management/content_management_module.dart';
import 'package:adminecg/ui/diagnosis_topics/diagnosis_topics_module.dart';
import 'package:adminecg/ui/user_management_page/user_management_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MainManagementPage extends StatefulWidget {
  const MainManagementPage({super.key});

  @override
  State<MainManagementPage> createState() => _MainManagementPageState();
}

class _MainManagementPageState extends State<MainManagementPage> {
  late final List<Widget> list;
  int index = 0;

  @override
  void initState() {
    list = [
      const UserManagementPage(),
      const ContentManagementModule(),
      const DiagnosisTopicsModule(),
    ];
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<DiagnosisRepo>().getListDiagnoseModel();
      context.read<TopicRepo>().getListTopicModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LeftAdminBar(
              currentIndex: index,
              onChange: (index) {
                setState(() {
                  this.index = index;
                });
              },
            ),
            const SizedBox(width: 100),
            Expanded(child: list[index]),
          ],
        ),
      ),
    );
  }

  Widget _itemManagementWidget() {
    return Row(
      children: [
        SvgPicture.asset("assets/images/svg/user.svg"),
        const SizedBox(width: 12),
        Text(
          'User Management',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                // color: AppTheme.textColorLight,
                color: Colors.white,
              ),
        ),
      ],
    );
  }
}

class LeftAdminBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onChange;

  const LeftAdminBar({
    super.key,
    required this.currentIndex,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Image.asset("assets/images/png/app_logo.png"),
          const SizedBox(height: 40),
          _itemWidget(
            context,
            0,
            'User Management',
            'assets/images/svg/user.svg',
          ),
          _itemWidget(
            context,
            1,
            'Content Management',
            'assets/images/svg/user.svg',
          ),
          _itemWidget(
            context,
            2,
            'Diagnisis & Topics',
            'assets/images/svg/user.svg',
          ),
        ],
      ),
    );
  }

  Widget _itemWidget(
    BuildContext context,
    int index,
    String text,
    String assets,
  ) {
    bool isSelected = index == currentIndex;
    return InkWell(
      onTap: () => onChange(index),
      child: Container(
        width: 260,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: isSelected ? AppTheme.accessColor : Colors.white,
        ),
        child: Row(
          children: [
            SvgPicture.asset(assets),
            const SizedBox(width: 12),
            Text(
              text,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    // color: AppTheme.textColorLight,
                    color: isSelected ? Colors.white : Colors.black54,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
