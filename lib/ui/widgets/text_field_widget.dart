import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controllerText;
  final String hintTextField;
  final TextInputType textInputType;
  final bool showEye;
  final int maxLines;
  final bool obscureText;
  final Function(String)? callBackTextField;
  final Function()? callBackHidePassword;

  const TextFieldWidget({
    super.key,
    required this.controllerText,
    required this.hintTextField,
    required this.textInputType,
    this.showEye = false,
    this.maxLines = 1,
    this.obscureText = false,
    this.callBackTextField,
    this.callBackHidePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          onChanged: (text) {
            if (callBackTextField != null) {
              callBackTextField!(text);
            }
          },
          maxLines: maxLines,
          obscureText: obscureText,
          textCapitalization: TextCapitalization.words,
          style: Theme.of(context).textTheme.bodyLarge,
          controller: controllerText,
          textAlign: TextAlign.justify,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.1),
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.1),
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            hintText: hintTextField,
            contentPadding: EdgeInsets.only(
              left: 15,
              right: showEye ? 50 : 15,
              top: 18,
              bottom: 18,
            ),
            counterText: '',
          ),
          keyboardType: textInputType,
          textInputAction: TextInputAction.next,
        ),
        showEye
          ? Positioned(
              top: 14,
              right: 15,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => callBackHidePassword!(),
                child: SvgPicture.asset("assets/images/svg/eye.svg"),
              ),
            )
          : const SizedBox(),
      ],
    );
  }
}
