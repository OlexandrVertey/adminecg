import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectDialogWidget extends StatefulWidget {
  const SelectDialogWidget({super.key});

  @override
  State<SelectDialogWidget> createState() => _SelectDialogWidgetState();
}

class _SelectDialogWidgetState extends State<SelectDialogWidget> with TickerProviderStateMixin {
  Animation<double>? _animationSport;
  AnimationController? _controllerShowSport;
  // AnimationController? _controllerRotationSport;
  bool _rotationSport = false;

  @override
  void initState() {
    super.initState();
    _controllerShowSport = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    // _controllerRotationSport = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 300),
    //   upperBound: 0.5,
    // );
    _animationSport = CurvedAnimation(
      parent: _controllerShowSport!,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controllerShowSport!.dispose();
    // _controllerRotationSport!.dispose();
  }

  _showSport() {
    if (_animationSport!.status != AnimationStatus.completed) {
      _controllerShowSport!.forward();
    } else {
      _controllerShowSport!.animateBack(
        0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animationSport!,
      axis: Axis.vertical,
      child: InkWell(
        onTap: () {
          setState(() {
            if (_rotationSport) {
              _controllerShowSport!..forward(from: 0.0);
            } else {
              _controllerShowSport!..reverse(from: 0.5);
            }
            _rotationSport = !_rotationSport;
            _showSport();
          });
        },
        child: Container(
          height: 50,
          width: 100,
          color: Colors.grey,
          child: Column(
            children: [
              Container(
                height: 50,
                width: 100,
                color: Colors.red,
              ),
              Container(
                height: 50,
                width: 100,
                color: Colors.blue,
              ),
              Container(
                height: 50,
                width: 100,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// SvgPicture.asset("assets/images/svg/edit.svg")
// SvgPicture.asset("assets/images/svg/delete.svg"),