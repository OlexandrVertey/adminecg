import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/topic/topic_repo.dart';
import 'package:adminecg/common/theme/app_theme.dart';
import 'package:adminecg/ui/content_management/content_management_module.dart';
import 'package:adminecg/ui/diagnosis_topics/diagnosis_topics_module.dart';
import 'package:adminecg/ui/user_management_page/user_management_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

double leftBar = 260;

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
            const SizedBox(width: 20),
            Expanded(
              child: IndexedStack(
                index: index,
                children: list,
              ),
            ),
          ],
        ),
      ),
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
    double width = MediaQuery.of(context).size.width;
    bool isSmallMenu = (organisation + userTable + leftBar + 50) > width;
    return Container(
      width: isSmallMenu ? 100 : leftBar,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
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
            'assets/images/svg/content_management.svg',
          ),
          _itemWidget(
            context,
            2,
            'Diagnisis & Topics',
            'assets/images/svg/content_management.svg',
          ),
          const Spacer(),
          if(!isSmallMenu)SvgPicture.asset('assets/images/svg/illustrations.svg'),
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
    double width = MediaQuery.of(context).size.width;
    bool isSmallMenu = (organisation + userTable + leftBar + 50) > width;
    return InkWell(
      onTap: () => onChange(index),
      child: Container(
        width: isSmallMenu ? 50 : leftBar,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: isSelected ? AppTheme.accessColor : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 15,
              height: 15,
              child: SvgPicture.asset(assets, color: !isSelected ? AppTheme.accessColor : Colors.white,),
            ),
            if(!isSmallMenu)const SizedBox(width: 12),
            if(!isSmallMenu)Text(
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
