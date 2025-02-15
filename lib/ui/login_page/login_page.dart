import 'dart:convert';

import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/ui/login_page/login_page_provider.dart';
import 'package:adminecg/ui/widgets/app_button.dart';
import 'package:adminecg/ui/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginPageProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(80.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset("assets/images/png/app_logo.png"),
                    const SizedBox(height: 40),
                    SvgPicture.asset("assets/images/svg/get_started.svg"),
                    const SizedBox(height: 60),
                    InkWell(child: Text(
                      'Application Management Panel',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 26),
                    ), onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const TempTestRequest()));
                    },),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 100),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(26.0)),
                    border:
                        Border.all(color: const Color(0xffD9D9D9), width: 1.3),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontSize: 12),
                      ),
                      const SizedBox(height: 11),
                      SizedBox(
                        width: 500,
                        child: TextFieldWidget(
                          controllerText: value.state.userNameController,
                          hintTextField: 'full name',
                          textInputType: TextInputType.text,
                          callBackTextField: (text) {
                            value.loginButtonIsActive();
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Password',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontSize: 12),
                      ),
                      const SizedBox(height: 11),
                      SizedBox(
                        width: 500,
                        child: TextFieldWidget(
                            controllerText: value.state.passwordController,
                            hintTextField: 'password',
                            textInputType: TextInputType.text,
                            callBackTextField: (text) {
                              value.loginButtonIsActive();
                            },
                            showEye: true,
                            obscureText: _obscureText,
                            callBackHidePassword: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            }),
                      ),
                      const SizedBox(height: 15),
                      const Spacer(),
                      AppButton(
                        text: 'Login',
                        isActive: value.state.loginButtonIsActive,
                        onTap: () {
                          if (value.state.userNameController.text ==
                                  'nadav7415@gmail.com' &&
                              value.state.passwordController.text ==
                                  'A!dmin74150603') {
                            context.openMainManagementPage();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TempTestRequest extends StatefulWidget {
  const TempTestRequest({super.key});

  @override
  State<TempTestRequest> createState() => _TempTestRequestState();
}

class _TempTestRequestState extends State<TempTestRequest> {
  String status = 'Sleep';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(status),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                sendEmail();
              },
              child: Text('run'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> sendEmail() async {
    updateStatus('runing');
    final url = Uri.parse('https://api.sendgrid.com/v3/mail/send');
    try{
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "https://api.sendgrid.com", // Required for CORS support to work
          "Access-Control-Allow-Credentials": 'true', // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
        body: jsonEncode({
          'personalizations': [
            {
              'to': [
                {'email': 'bulasovmikhailo@gmail.com'}
              ],
              'subject': 'subject',
            }
          ],
          'from': {
            'email': 'ecgpracticeapp@gmail.com',
          },
          'content': [
            {
              'type': 'text/plain',
              'value': 'message',
            }
          ],
        }),
      );

      if (response.statusCode == 202) {
        updateStatus('Email sent successfully!');
      } else {
        updateStatus('Failed to send email: ${response.body}');
      }
    } catch (e){
      updateStatus('$e');
    }
  }

  void updateStatus(String text){
    setState(() {
      status = text;
    });
  }
}
