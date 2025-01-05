import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/ui/widgets/app_button.dart';
import 'package:adminecg/ui/widgets/select_dialog_widget.dart';
import 'package:adminecg/ui/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class EditOrganizationDialog extends StatefulWidget {
  const EditOrganizationDialog({super.key,
    required this.title,
    required this.organizationNameController,
    required this.callBack,
    required this.nameButton,
  });

  final String title;
  final TextEditingController organizationNameController;
  final Function({required String premium}) callBack;
  final String nameButton;

  @override
  State<EditOrganizationDialog> createState() => _EditOrganizationDialogState();
}

class _EditOrganizationDialogState extends State<EditOrganizationDialog> {
  final ScrollController _scrollController = ScrollController();
  bool _statesButtonPremium = false;
  bool _statesButtonFree = false;

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
                    controllerText: widget.organizationNameController,
                    hintTextField: widget.organizationNameController.text,
                    textInputType: TextInputType.text,
                    callBackTextField: (text) {},
                  ),
                ),
                // const SizedBox(height: 12),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     'States',
                //     style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 14, color: Colors.black),
                //   ),
                // ),
                // const SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     AppButton(
                //       text: 'Premium ',
                //       isActive: _statesButtonPremium,
                //       width: 155,
                //       onTap: () {
                //         setState(() {
                //           _statesButtonPremium = true;
                //           _statesButtonFree = false;
                //         });
                //       },
                //     ),
                //     AppButton(
                //       text: 'Free ',
                //       isActive: _statesButtonFree,
                //       width: 155,
                //       onTap: () {
                //         setState(() {
                //           _statesButtonFree = true;
                //           _statesButtonPremium = false;
                //         });
                //       },
                //     ),
                //   ],
                // ),
                const SizedBox(height: 25),
                AppButton(
                  width: 370,
                  text: widget.nameButton,
                  isActive: true,
                  onTap: () => widget.callBack(
                    premium: _statesButtonPremium
                      ? 'true'
                      : _statesButtonFree
                        ? 'false'
                        : '',
                  ),
                ),
                const  SizedBox(height: 20),
                AppButton(
                  width: 370,
                  text: 'No  (Go Back)',
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
}
