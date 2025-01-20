import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendEmail(Map<String, dynamic> map) async {
  // final url = Uri.parse('https://api.sendgrid.com/v3/mail/send');
  // final response = await http.post(
  //   url,
  //   headers: {
  //     'Authorization': 'Bearer QShi0DRjSNK9JDVraCBE0w',
  //     'Content-Type': 'application/json',
  //   },
  //   body: jsonEncode({
  //     'personalizations': [
  //       {
  //         'to': [
  //           {'email': toEmail}
  //         ],
  //         'subject': subject,
  //       }
  //     ],
  //     'content': [
  //       {
  //         'type': 'text/plain',
  //         'value': message,
  //       }
  //     ],
  //   }),
  // );
  //
  // if (response.statusCode == 202) {
  //   print('Email sent successfully!');
  // } else {
  //   print('Failed to send email: ${response.body}');
  // }
}