import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/organization_model/organization_model.dart';
import 'package:adminecg/ui/widgets/app_button.dart';
import 'package:adminecg/ui/widgets/select_dialog_widget.dart';
import 'package:adminecg/ui/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

class EditUserDialog extends StatefulWidget {
  const EditUserDialog({super.key,
    required this.title,
    this.userUid = '',
    required this.userNameController,
    required this.emailController,
    required this.passwordController,
    required this.callBack,
    required this.nameButton,
    this.organisationId,
    this.selectedOrgId,
    this.organisations,
  });

  final String title;
  final String userUid;
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function(String? organisation, String states, String duration) callBack;
  final String nameButton;
  final String? organisationId;
  final String? selectedOrgId;
  final List<OrganizationModel>? organisations;

  @override
  State<EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  DateTime? _durationDateTime;
  final ScrollController _scrollController = ScrollController();
  bool _statesButtonPremium = false;
  bool _statesButtonFree = false;

  String? organisation;
  List<String> listOrg = [];
  @override
  void initState() {
    listOrg.clear();
    widget.organisations?.forEach((element){
      listOrg.add(element.name??'no name');
      if(element.id == widget.organisationId){
        organisation = element.name;
      }
      if (element.id == widget.selectedOrgId) {
        organisation = element.name;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(35),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.0)),
      content: Scrollbar(
        thumbVisibility: true,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
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
                    controllerText: widget.userNameController,
                    hintTextField: widget.userNameController.text,
                    textInputType: TextInputType.text,
                    callBackTextField: (text) {},
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
                    controllerText: widget.emailController,
                    hintTextField: widget.emailController.text,
                    textInputType: TextInputType.text,
                    callBackTextField: (text) {},
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
                    controllerText: widget.passwordController,
                    hintTextField: widget.passwordController.text,
                    textInputType: TextInputType.text,
                    callBackTextField: (text) {},
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
                const SizedBox(height: 12),
                SelectDialogWidget(title: 'Organization', items: listOrg, currentValue: organisation, onSelect: (s)=> organisation = s),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'States',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 14, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                      text: 'Premium ',
                      isActive: _statesButtonPremium,
                      width: 155,
                      onTap: () {
                        setState(() {
                          _statesButtonPremium = true;
                          _statesButtonFree = false;
                        });
                      },
                    ),
                    AppButton(
                      text: 'Free ',
                      isActive: _statesButtonFree,
                      width: 155,
                      onTap: () {
                        setState(() {
                          _statesButtonFree = true;
                          _statesButtonPremium = false;
                          _durationDateTime = null;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Duration',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 14, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 10),
                // const SelectDialogWidget(title: 'Time Duration', items: ['1 Months|', '2 Months|', '3 Months|', 'Year']),

                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () async {
                    if (_statesButtonPremium) {
                      await showRoundedDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 1),
                        lastDate: DateTime(DateTime.now().year + 1),
                        borderRadius: 16,
                      ).then((value) {
                        setState(() {
                          print('---_durationDateTime _ = ${value}');
                          _durationDateTime = value;
                        });
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                      border: Border.all(color: Colors.black.withOpacity(0.1), width: 1.3),
                    ),
                    child: Text(
                      _durationDateTime != null
                          ? _durationDateTime.toString().substring(0, _durationDateTime.toString().length - 7)
                          : 'Selected Duration',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 14),
                    ),
                  ),
                ),


                const SizedBox(height: 25),
                AppButton(
                  width: 370,
                  text: widget.nameButton,
                  isActive: true,
                  onTap: () => widget.callBack(
                    getOrgId(),
                    _statesButtonPremium ? 'Premium' : _statesButtonFree ? 'Free' : '',
                    _durationDateTime != null ? _durationDateTime.toString() : '',
                  ),
                ),
                const  SizedBox(height: 20),
                AppButton(
                  width: 370,
                  text: 'No (Go Back)',
                  isActive: false,
                  onTap: () => context.backPage(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? getOrgId(){
    if(organisation == null){
      return null;
    }
    OrganizationModel? model;
    widget.organisations?.forEach((element){
      if(element.name == organisation){
        model = element;
      }
    });
    return model?.id;

  }
}
