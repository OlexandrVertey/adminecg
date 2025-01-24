import 'package:adminecg/common/models/organization_model/organization_model.dart';
import 'package:adminecg/common/models/user_model/user_model.dart';
import 'package:adminecg/common/theme/app_theme.dart';
import 'package:adminecg/ui/user_management_page/delete_user_dialog.dart';
import 'package:adminecg/ui/user_management_page/edit_organization_dialog.dart';
import 'package:adminecg/ui/user_management_page/edit_user_dialog.dart';
import 'package:adminecg/ui/user_management_page/user_management_provider.dart';
import 'package:adminecg/ui/widgets/app_button_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


double userTable = 860;
double organisation = 340;

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _organizationNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ScrollController _scrollControllerUser = ScrollController();
  final ScrollController _scrollControllerOrg = ScrollController();
  final ScrollController _scrollControllerAll = ScrollController();

  bool _selectedOrg = false;
  String? _selectedOrgId;
  int? _selectedOrgIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      context.read<UserManagementProvider>().getUserModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
    return Consumer<UserManagementProvider>(
        builder: (context, value, child) {
          return Container(
            child: Row(children: [
              Container(
                width: organisation,
                margin: const EdgeInsets.only(right: 10, bottom: 10),
                child: Column(
                  children: [
                    SizedBox(
                      width: organisation,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'User Management',
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 22),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Organizations  List',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.textColorLight),
                              ),
                            ],
                          ),
                          AppButtonAdd(
                            text: '',
                            width: 45,
                            onTap: () => showDialog(
                              context: context,
                              builder: (_) => EditOrganizationDialog(
                                title: 'Add New Organization',
                                organizationNameController: _organizationNameController,
                                nameButton: 'Update & Send Login Details',
                                callBack: ({required String premium}) {
                                  context.read<UserManagementProvider>().registerOrganization(
                                    context: context,
                                    id: date.millisecondsSinceEpoch.toString(),
                                    name: _organizationNameController.text,
                                    premium: premium,
                                  );
                                  _organizationNameController.clear();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        width: organisation,
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
                                InkWell(child: _titleItemWidget(title: 'Organization Name'), onTap: (){
                                  context.read<UserManagementProvider>().sortOrg(sort: OrgSort.name);
                                },),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              width: 300,
                              height: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            if (value.state.listUserModel.isNotEmpty)
                              Expanded(
                                child: Scrollbar(
                                  controller: _scrollControllerOrg,
                                  thumbVisibility: true,
                                  child: SizedBox(
                                    width: 300,
                                    height: MediaQuery.of(context).size.height * 0.8,
                                    child: ScrollConfiguration(
                                      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                      child: ListView.builder(
                                        controller: _scrollControllerOrg,
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: value.state.listOrganizationModel.length,
                                        itemBuilder: (context, index) {
                                          OrganizationModel item = value.state.listOrganizationModel[index];
                                          return _itemOrganizationWidget(
                                            item: item,
                                            index: index,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: userTable,
                child: Column(
                  children: [
                    SizedBox(
                      width: userTable,
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
                          AppButtonAdd(
                            text: 'Add New User',
                            onTap: () {
                              _userNameController.clear();
                              _emailController.clear();
                              _passwordController.clear();
                              showDialog(
                                context: context,

                                builder: (_) => EditUserDialog(
                                  title: 'Add New User',
                                  userNameController: _userNameController,
                                  emailController: _emailController,
                                  passwordController: _passwordController,
                                  organisations: value.state.listOrganizationModel,
                                  nameButton: 'Create & Send Login Details',
                                  selectedOrgId: _selectedOrgId,
                                  callBack: (organisation, states, duration) => value.registerUser(
                                    context: context,
                                    userName: _userNameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    organisation: organisation,
                                    states: states,
                                    duration: duration,//endPlans
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        width: userTable,
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
                                InkWell(child: _titleItemWidget(title: 'Name'), onTap: (){
                                  context.read<UserManagementProvider>().sortUser(sort: UserSort.name);
                                },),
                                const SizedBox(width: 100),
                                InkWell(child: _titleItemWidget(title: 'Email'), onTap: (){
                                  context.read<UserManagementProvider>().sortUser(sort: UserSort.email);
                                },),
                                const SizedBox(width: 180),
                                InkWell(child: _titleItemWidget(title: 'Organization')),
                                const SizedBox(width: 60),
                                InkWell(child: _titleItemWidget(title: 'Status')),
                                const SizedBox(width: 50),
                                InkWell(child: _titleItemWidget(title: 'Terms of Use')),
                                const SizedBox(width: 50),
                                _titleItemWidget(title: 'Edit'),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              width: 840,
                              height: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            if (value.state.listUserModel.isNotEmpty)
                              Expanded(
                                child: Scrollbar(
                                  controller: _scrollControllerUser,
                                  thumbVisibility: true, // Додайте цей параметр
                                  child: SizedBox(
                                    width: 840,
                                    height: MediaQuery.of(context).size.height * 0.8,
                                    child: ScrollConfiguration(
                                      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                      child: ListView.builder(
                                        controller: _scrollControllerUser,
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: value.state.listUserModel.length,
                                        itemBuilder: (context, index) {
                                          bool showUser = _selectedOrgId == value.state.listUserModel[index].organisation && _selectedOrg;
                                          bool showAllUser = !_selectedOrg;
                                          UserModel item = value.state.listUserModel[index];
                                          return _itemUserWidget(
                                            list: value.state.listOrganizationModel,
                                            item: item,
                                            index: index,
                                            showUser: showUser,
                                            showAllUser: showAllUser,
                                          );
                                          // }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],),
          );
        },
    );
  }

  Widget _itemUserWidget({
    required UserModel item,
    required int index,
    required List<OrganizationModel> list,
    required bool showUser,
    required bool showAllUser,
  }) {
    if (showUser || showAllUser) {
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
              _getOrganizationName(organizationId: item.organisation ?? '', listOrganizationModel: list),
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
              // item.plans ?? '',
                _getStatusUser(item: item),

              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xff1A1919),
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 40),
          SizedBox(
            width: 90,
            child: Text(
              item.userRegisterDate?.substring(0, item.userRegisterDate!.length - 7) ?? '',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xff1A1919),
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 20),
          InkWell(
            onTap: () => showDialog(
                context: context,
                builder: (_) => DeleteUserDialog(
                  title: 'Delete User',
                  userUid: item.userUid!,
                  isUser: true,
                  userEmail: item.email!,
                  userName: item.fullName!,
                ),
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
                  organisationId: item.organisation,
                  organisations: list,
                  nameButton: 'Update & Send Login Details',
                  selectedOrgId: _selectedOrgId,
                  callBack: (organisation, states, duration) => context.read<UserManagementProvider>().updateUser(
                    context: context,
                    userUid: item.userUid!,
                    fullName: _userNameController.text,
                    organisation: organisation,
                    email: _emailController.text,
                    password: _passwordController.text,
                    states: states,
                    duration: duration,
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
    } else {
      return const SizedBox();
    }
  }

  Widget _itemOrganizationWidget({
    required OrganizationModel item,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedOrgId = item.id;
          if (_selectedOrgIndex != index && !_selectedOrg) {
            _selectedOrgIndex = index;
            _selectedOrg = true;
          } else if (_selectedOrgIndex != index && _selectedOrg) {
            _selectedOrgIndex = index;
            _selectedOrg = true;
          } else if (_selectedOrgIndex == index && _selectedOrg) {
            _selectedOrgIndex = index;
            _selectedOrg = false;
          } else if (_selectedOrgIndex == index && !_selectedOrg) {
            _selectedOrgIndex = index;
            _selectedOrg = true;
          } else {
            _selectedOrg = false;
            _selectedOrgIndex = null;
          }
        });
      },
      child: Container(
        height: 40,
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
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                color: _selectedOrgIndex == index && _selectedOrg ? const Color(0xff0A4E74) : Colors.transparent,
              ),
              width: 83,
              child: Text(
                item.name!,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: _selectedOrgIndex == index && _selectedOrg ? Colors.white : const Color(0xff1A1919),
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 90),
            InkWell(
              onTap: () => showDialog(
                context: context,
                builder: (_) => DeleteUserDialog(
                  title: 'Delete Organization',
                  userUid: item.id!,
                  isUser: false,
                  userEmail: '',
                  userName: '',
                ),
              ),
              child: SvgPicture.asset("assets/images/svg/delete.svg"),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                _organizationNameController.text = item.name!;
                print('---updateOrganization onTap ${_organizationNameController.text}');
                showDialog(
                  context: context,
                  builder: (_) => EditOrganizationDialog(
                    title: 'Edit Organization',
                    organizationNameController: _organizationNameController,
                    nameButton: 'Update & Send Login Details',
                    callBack: ({required String premium}) =>
                        context.read<UserManagementProvider>().updateOrganization(
                      context: context,
                      id: item.id!,
                      name: _organizationNameController.text,
                      premium: premium,
                    ),
                  ),
                  //     EditUserDialog(
                  //   title: 'Edit User',
                  //   userUid: item.userUid!,
                  //   userNameController: _userNameController,
                  //   emailController: _emailController,
                  //   passwordController: _passwordController,
                  //   nameButton: 'Update & Send Login Details',
                  //   callBack: () => context.read<UserManagementProvider>().updateUser(
                  //     context: context,
                  //     userUid: item.userUid!,
                  //     fullName: _userNameController.text,
                  //     email: _emailController.text,
                  //     password: _passwordController.text,
                  //   ),
                  // ),
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

  String _getOrganizationName({
    required String organizationId,
    required List<OrganizationModel> listOrganizationModel,
  }){
    for (var element in listOrganizationModel) {
      if (organizationId == element.id) {
        return element.name ?? '';
      }
    }
    return '';
  }

  String _getStatusUser({required UserModel item}) {
    if (item.startPlans != null && item.startPlans!.isNotEmpty && item.endPlans != null && item.endPlans!.isNotEmpty) {
      DateTime now = DateTime.now();
      DateTime startPlan = DateTime.parse(item.startPlans!);
      DateTime endPlan = DateTime.parse(item.endPlans!);
      Duration difference = endPlan.difference(startPlan);
      if (difference.inDays < 8 && now.isBefore(DateTime.parse(item.endPlans!))) {return 'Trial';}
      if (now.isAfter(DateTime.parse(item.endPlans!))) {return 'Free';}
      if (now.isBefore(DateTime.parse(item.endPlans!))) {return 'Premium';}
    }
    return 'Free';
  }

}
