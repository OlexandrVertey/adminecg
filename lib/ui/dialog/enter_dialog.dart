import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/ui/widgets/app_button.dart';
import 'package:adminecg/ui/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class EnterDialog {
  static Widget show({
    required BuildContext context,
    required String title,
    required Function(String en) callBack,
  }) {

    final TextEditingController itemEnController = TextEditingController();

    return AlertDialog(
      contentPadding: const EdgeInsets.all(35),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.0)),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "EN version",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontSize: 14, color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 370,
              child: TextFieldWidget(
                controllerText: itemEnController,
                hintTextField: 'EN',
                textInputType: TextInputType.text,
                callBackTextField: (text) {},
              ),
            ),
            const SizedBox(height: 12),
            const SizedBox(height: 25),
            AppButton(
              width: 370,
              text: 'Ok',
              isActive: true,
              onTap: () {
                context.backPage();
                callBack(itemEnController.text);
              }
            ),
            const SizedBox(height: 20),
            AppButton(
              width: 370,
              text: 'Cancel',
              isActive: false,
              onTap: () {
                context.backPage();
              },
            ),
          ],
        ),
      ),
    );
  }
}
