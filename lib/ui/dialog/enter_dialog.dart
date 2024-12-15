import 'package:adminecg/ui/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class EnterDialog {
  static Future<void> show(
    BuildContext context,
    String title,
    Function(String en, String he) success, {
    String? imagePath,
    String? currentValue,
  }) async {
    TextEditingController controllerEn =
        TextEditingController(text: currentValue);
    TextEditingController controllerHe =
    TextEditingController(text: currentValue);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Text'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Enter EN version'),
                TextFieldWidget(
                  controllerText: controllerEn,
                  hintTextField: 'EN version',
                  textInputType: TextInputType.text,
                ),
                SizedBox(height: 16,),
                Text('Enter HE version'),
                TextFieldWidget(
                  controllerText: controllerHe,
                  hintTextField: 'HE version',
                  textInputType: TextInputType.text,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                if(controllerEn.text.isNotEmpty || controllerHe.text.isNotEmpty ){
                  Navigator.of(context).pop();
                  success(controllerEn.text, controllerHe.text);
                }
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
