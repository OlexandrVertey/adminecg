import 'package:adminecg/common/models/user_model/user_model.dart';
import 'package:adminecg/common/theme/app_theme.dart';
import 'package:adminecg/ui/user_management_page/delete_user_dialog.dart';
import 'package:adminecg/ui/user_management_page/edit_user_dialog.dart';
import 'package:adminecg/ui/user_management_page/user_management_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      context.read<UserManagementProvider>().getUserModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagementProvider>(
        builder: (context, value, child) {
          return Column(
            children: [
              SizedBox(
                width: 743,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add New User',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 22),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Users  List',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.textColorLight),
                        ),
                      ],
                    ),
                    InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => showDialog(
                        context: context,
                        builder: (_) => EditUserDialog(
                          title: 'Add New User',
                          userNameController: _userNameController,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          nameButton: 'Create & Send Login Details',
                          callBack: () => value.registerUser(
                            context: context,
                            userName: _userNameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        alignment: Alignment.center,
                        height: 56,
                        width: 180,
                        decoration: BoxDecoration(
                          color: const Color(0xff0A4E74),
                          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                          border: Border.all(color: const Color(0xff0A4E74), width: 1.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add New User',
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const Icon(Icons.add, color: Colors.white)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 743,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _titleItemWidget(title: 'No.'),
                        const SizedBox(width: 37),
                        _titleItemWidget(title: 'Name'),
                        const SizedBox(width: 100),
                        _titleItemWidget(title: 'Email'),
                        const SizedBox(width: 180),
                        _titleItemWidget(title: 'Organization'),
                        const SizedBox(width: 60),
                        _titleItemWidget(title: 'Status'),
                        const SizedBox(width: 70),
                        _titleItemWidget(title: 'Edit'),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: 690,
                      height: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    if (value.state.listUserModel.isNotEmpty)
                    SizedBox(
                      width: 690,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: value.state.listUserModel.length,
                        itemBuilder: (context, index) {
                          UserModel item = value.state.listUserModel[index];
                          return _itemUserWidget(
                            item: item,
                            index: index,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
    );
  }

  Widget _itemUserWidget({
    required UserModel item,
    required int index,
  }) {
    return Container(
      height: 25,
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 25,
            child: Text(
              index < 10 ? "0${index + 1}" : "${index + 1}",
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
                  item.fullName!,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: const Color(0xff1A1919),
                    fontSize: 12,
                  ),
                ),
          ),
          const SizedBox(width: 55),
          SizedBox(
            width: 190,
            child: Text(
              item.email!,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xff1A1919),
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 25),
          SizedBox(
            width: 80,
            child: Text(
              'Organization',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xff1A1919),
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 60),
          SizedBox(
            width: 50,
            child: Text(
              'Status',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xff1A1919),
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 36),
          InkWell(
            onTap: () => showDialog(
                context: context,
                builder: (_) => DeleteUserDialog(title: 'Delete User', userUid: item.userUid!),
            ),
            child: SvgPicture.asset("assets/images/svg/delete.svg"),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              _userNameController.text = item.fullName!;
              _emailController.text = item.email!;
              _passwordController.text = item.password!;
              showDialog(
                context: context,
                builder: (_) => EditUserDialog(
                  title: 'Edit User',
                  userUid: item.userUid!,
                  userNameController: _userNameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  nameButton: 'Update & Send Login Details',
                  callBack: () => context.read<UserManagementProvider>().updateUser(
                    context: context,
                    userUid: item.userUid!,
                    fullName: _userNameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                ),
              );
            },
            child: SvgPicture.asset(
              width: 20,
              height: 20,
              "assets/images/svg/edit.svg",
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleItemWidget({required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        color: const Color(0xff656575),
      ),
    );
  }
}
