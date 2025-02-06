import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/ui/login_page/login_page_provider.dart';
import 'package:adminecg/ui/widgets/app_button.dart';
import 'package:adminecg/ui/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
                      Text(
                        'Application Management Panel',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 26),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 100),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(26.0)),
                      border: Border.all(color: const Color(0xffD9D9D9), width: 1.3),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 12),
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
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 12),
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
                              }
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Spacer(),
                        AppButton(
                          text: 'Login',
                          isActive: value.state.loginButtonIsActive,
                          onTap: () {
                            if (value.state.userNameController.text == 'nadav7415@gmail.com'
                                && value.state.passwordController.text == 'A!dmin74150603') {
                              context.openMainManagementPage();
                            }
                            // if (value.state.loginButtonIsActive
                            //     && value.state.userNameController.text == 'admin'
                            //     && value.state.passwordController.text == 'Qwer1234!') {
                            //   context.openMainManagementPage();
                            // }
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
