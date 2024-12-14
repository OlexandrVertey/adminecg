import 'package:adminecg/common/models/user_model/user_model.dart';
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
  final bool _editUser = false;
  final int _selectedIndex = 0;

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
                        // deleteUser: () => value.deleteUser(userUid: item.userUid!),
                        updateUser: () {
                          value.updateUser(userUid: item.userUid!,
                            fullName: '',
                            email: '',
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
    );
  }

  Widget _itemUserWidget({
    required UserModel item,
    required int index,
    // required Function() deleteUser,
    required Function() updateUser,
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
            child: _editUser && _selectedIndex == index
              ? _itemTextFieldWidget(controller: _userNameController, width: 83)
              : Text(
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
            child: _editUser && _selectedIndex == index
              ? _itemTextFieldWidget(controller: _emailController, width: 190)
              : Text(
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
            // onTap: () => deleteUser(),
            onTap: () => showDialog(
                context: context,
                builder: (_) => DeleteUserDialog(title: 'Delete User', userUid: item.userUid!),
            ),
            child: SvgPicture.asset("assets/images/svg/delete.svg"),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => EditUserDialog(
                  title: 'Edit User',
                  userUid: item.userUid!,
                  userNameController: _userNameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
              );
              // setState(() {
              //   _editUser = !_editUser;
              //   _selectedIndex = index;
              //   if (_editUser) {
              //     _userNameController.text = item.fullName!;
              //     _emailController.text = item.email!;
              //   }
              //
              //     if (!_editUser && _selectedIndex == index) {
              //       print('---Page Update user OnTap');
              //       context.read<UserManagementProvider>().updateUser(
              //         userUid: item.userUid!,
              //         fullName: _userNameController.text,
              //         email: _emailController.text,
              //       );
              //   }
              // });
            },
            child: SvgPicture.asset(
              width: 20,
              height: 20,
              "assets/images/svg/${_editUser && _selectedIndex == index ? "save.svg" : "edit.svg"}",
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

  Widget _itemTextFieldWidget({required TextEditingController controller, required double width}) {
    return SizedBox(
      width: width,
      child: TextField(
        maxLines: 1,
        onChanged: (text) {},
        textCapitalization: TextCapitalization.words,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: const Color(0xff1A1919),
          fontSize: 12,
        ),
        controller: controller,
        textAlign: TextAlign.start,
          decoration: const InputDecoration(
            isDense: true,
            border: InputBorder.none,
          ),
      ),
    );
  }
}
