import 'package:adminecg/common/theme/app_theme.dart';
import 'package:adminecg/ui/user_management_page/user_management_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainManagementPage extends StatefulWidget {
  const MainManagementPage({super.key});

  @override
  State<MainManagementPage> createState() => _MainManagementPageState();
}

class _MainManagementPageState extends State<MainManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
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
                  Container(
                    width: 260,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Color(0xff0C4F75),
                    ),
                    child: _itemManagementWidget(),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 100),
            UserManagementPage(),
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
