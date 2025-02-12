import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendEmail(Map<String, dynamic> map) async {
  final url = Uri.parse('https://api.sendgrid.com/v3/mail/send');
  final response = await http.post(
    url,
    headers: {
      ///TODO: need add token
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'personalizations': [
        {
          'to': [
            {'email': map['email']}
          ],
          'subject': "You have a registered account in the ECG Practice Application",
        }
      ],
      'from': {
        'email': 'ecgpracticeapp@gmail.com',
      },
      'content': [
        {
          'type': 'text/plain',
          'value': "You have a registered account in the ECG Practice Application\nemail: ${map['email']}\n password: ${map['password']}\nlink to the app: not avalible yet",
        }
      ],
    }),
  );

  if (response.statusCode == 202) {
    print('Email sent successfully!');
  } else {
    print('Failed to send email: ${response.body}');
  }
}