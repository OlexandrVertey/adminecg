import 'package:adminecg/common/models/user_model/user_model.dart';
import 'package:adminecg/ui/user_management_page/user_management_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {

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
              // if (value.state.listUserModel != null)
              // Expanded(
              //   child: ListView.builder(
              //     padding: EdgeInsets.zero,
              //     shrinkWrap: true,
              //     itemCount: value.state.listUserModel!.length,
              //     itemBuilder: (context, index) {
              //       UserModel item = value.state.listUserModel![index];
              //       return _itemUserWidget(item: item);
              //     },
              //   ),
              // ),
            ],
          );
        },
    );
  }

  Widget _itemUserWidget({required UserModel item}) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.red,
      child: Row(
        children: [
          Text(
            item.fullName!,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              // color: AppTheme.textColorLight,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
