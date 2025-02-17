import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;

Future<void> sendEmail(Map<String, dynamic> map) async {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('sendEmail');
  try {
    final response = await callable.call({
      'toEmail': map['email'],
      'subject': 'You have a registered account in the ECG Practice Application',
      'content': "You have a registered account in the ECG Practice Application\nemail: ${map['email']}\n password: ${map['password']}\nlink to the app: not avalible yet",
    });
  } catch (e) {}
}