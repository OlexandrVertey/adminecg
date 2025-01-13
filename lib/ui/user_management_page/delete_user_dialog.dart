import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/ui/user_management_page/user_management_provider.dart';
import 'package:adminecg/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DeleteUserDialog extends StatelessWidget {
  const DeleteUserDialog({super.key,
    required this.title,
    required this.userUid,
    required this.userEmail,
    required this.userName,
    required this.isUser,
  });

  final String title;
  final String userUid;
  final String userEmail;
  final String userName;
  final bool isUser;

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
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 28),
          ),
          SvgPicture.asset("assets/images/svg/delete_user.svg"),
          const  SizedBox(height: 30),
          AppButton(
            text: 'Yes  (Delete)',
            isActive: true,
            onTap: () => isUser
                ? context.read<UserManagementProvider>().deleteUser(
                      context: context,
                      userUid: userUid,
                      userEmail: userEmail,
                      userName: userName,
                    )
                : context.read<UserManagementProvider>().deleteOrganization(context: context, id: userUid),
          ),
          const  SizedBox(height: 20),
          AppButton(
            text: 'No  (Go Back)',
            isActive: false,
            onTap: () => context.backPage(),
          ),
        ],
      ),
    );
  }
}
