import 'package:adminecg/ui/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class EnterDialog {
  static Future<void> show(
    BuildContext context,
    String title,
    Function(String) success, {
    String? imagePath,
    String? currentValue,
  }) async {
    TextEditingController controller =
        TextEditingController(text: currentValue);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                TextFieldWidget(
                  controllerText: controller,
                  hintTextField: 'full name',
                  textInputType: TextInputType.text,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
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
