import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

enum ToastType {success, error, info, warning }

class Toast {
  static show({String? message, BuildContext? context, ToastType type = ToastType.info}) {
    String text = 'develop';
    Color textColor = Colors.black87;
    Color backgroundColor = Colors.white;
    // String icon = UiImages.toastInfo;

    if (message != null) {
      text = message;
    }

    // switch (type) {
    //   case MessageType.success:
    //     icon = UiImages.toastSuccess;
    //     break;
    //   case MessageType.error:
    //     icon = UiImages.toastError;
    //     break;
    //   case MessageType.info:
    //     icon = UiImages.toastInfo;
    //     break;
    //   case MessageType.warning:
    //     icon = UiImages.toastWarning;
    //     break;
    //   default:
    //     icon = UiImages.toastInfo;
    //     break;
    // }

    Future.delayed(
      const Duration(
        milliseconds: 400,
      ),
          () => BotToast.showAttachedWidget(
        onlyOne: true,
        duration: Duration(
          seconds: 3,
        ),
        target: Offset(
          0,
          0,
        ),
        attachedBuilder: (_) => LayoutBuilder(
          builder: (
              BuildContext context,
              size,
              ) {

            return _messageWidget(
              context, text,
              textColor,
              'icon',
              backgroundColor,
            );
          },
        ),
      ),
    );
  }

  static Widget _messageWidget(BuildContext context, String text, Color textColor, String icon, Color backgroundColor) {

    var style = TextStyle(
        color: textColor,
        fontSize: 14
    );
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingSize = 88;
    double iconSize = 40;
    double textSize = _getTextWidgetSize(text, style).width;
    return Container(
      child: Align(
        alignment: Alignment(
          0,
          -0.7,
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            28,
          ),
          child: Card(
            elevation: 4,
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(
                12.0,
              ),
              child: screenWidth < paddingSize + iconSize + textSize
                  ? _bigMessageWidget(
                text,
                textColor,
                icon,
              )
                  : _smallMessageWidget(
                text,
                textColor,
                icon,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _bigMessageWidget(String text, Color textColor, String icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Container(
        //   width: 34,
        //   height: 34,
        //   child: SvgPicture.asset(
        //     icon,
        //     width: 34,
        //     height: 34,
        //   ),
        // ),
        // SizedBox(
        //   height: 6,
        // ),
        Text(
          text,
          style: TextStyle(
              color: textColor,
              fontSize: 14
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  static Widget _smallMessageWidget(String text, Color textColor, String icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Container(
        //   width: 34,
        //   height: 34,
        //   child: SvgPicture.asset(
        //     icon,
        //     width: 34,
        //     height: 34,
        //   ),
        // ),
        // SizedBox(
        //   width: 6,
        // ),
        Text(
          text,
          style: TextStyle(color: textColor),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  static Size _getTextWidgetSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
