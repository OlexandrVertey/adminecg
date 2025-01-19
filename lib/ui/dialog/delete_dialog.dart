import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(35),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Delete $title?',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 28),
          ),
          SvgPicture.asset("assets/images/svg/delete_user.svg"),
          const SizedBox(height: 30),
          AppButton(
            text: 'Yes (Delete)',
            isActive: true,
            onTap: () {
              context.backPage();
              onTap();
            },
          ),
          const SizedBox(height: 20),
          AppButton(
            text: 'No (Go Back)',
            isActive: false,
            onTap: () => context.backPage(),
          ),
        ],
      ),
    );
  }

  static void show(
    BuildContext context,
    String title,
    Function() onTap,
  ) {
    showDialog(
      context: context,
      builder: (_) => DeleteDialog(
        title: title,
        onTap: onTap,
      ),
    );
  }
}
