import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/ui/widgets/app_button.dart';
import 'package:adminecg/ui/widgets/select_dialog_widget.dart';
import 'package:adminecg/ui/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class EditUserDialog extends StatelessWidget {
  const EditUserDialog({super.key,
    required this.title,
    required this.userUid,
    required this.userNameController,
    required this.emailController,
    required this.passwordController,
  });

  final String title;
  final String userUid;
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(35),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26.0),
      ),
      content: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            // textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 28),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Name",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 14, color: Colors.black),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 370,
            child: TextFieldWidget(
              controllerText: userNameController,
              hintTextField: 'User Name',
              textInputType: TextInputType.text,
              callBackTextField: (text) {
                // value.loginButtonIsActive();
              },
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Email",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 14, color: Colors.black),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 370,
            child: TextFieldWidget(
              controllerText: emailController,
              hintTextField: 'Email',
              textInputType: TextInputType.text,
              callBackTextField: (text) {
                // value.loginButtonIsActive();
              },
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Password",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 14, color: Colors.black),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 370,
            child: TextFieldWidget(
              controllerText: passwordController,
              hintTextField: 'Password',
              textInputType: TextInputType.text,
              callBackTextField: (text) {
                // value.loginButtonIsActive();
              },
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Organization",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 14, color: Colors.black),
            ),
          ),


          const SizedBox(height: 20),
          const SelectDialogWidget(),


          const SizedBox(height: 30),
          AppButton(
            width: 370,
            text: 'Update & Send Login Details',
            isActive: true,
            // onTap: () => context.read<UserManagementProvider>().deleteUser(userUid: userUid),
            onTap: () {},
          ),
          const  SizedBox(height: 20),
          AppButton(
            width: 370,
            text: 'Update User',
            isActive: false,
            onTap: () => context.backPage(),
          ),
        ],
      ),
    );
  }
}
