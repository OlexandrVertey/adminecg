import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryIconWidget extends StatefulWidget {
  const CategoryIconWidget({super.key, required this.onChange, required this.currentIcon});
  final Function(String selectedItem)onChange;
  final String currentIcon;

  @override
  State<CategoryIconWidget> createState() => _CategoryIconWidgetState();
}

class _CategoryIconWidgetState extends State<CategoryIconWidget> {

  final List<String> svgItems = [
    'assets/images/svg/category_1.svg',
    'assets/images/svg/category_2.svg',
    'assets/images/svg/category_3.svg',
    'assets/images/svg/category_4.svg',
    'assets/images/svg/category_5.svg',
    'assets/images/svg/category_6.svg',
  ];

  String? selectedSvg;

  @override
  void initState() {
    if(widget.currentIcon != '-1'){
      selectedSvg = 'assets/images/svg/category_${widget.currentIcon}.svg';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedSvg,
      items: svgItems.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              SvgPicture.asset(
                value,
                width: 24,
                height: 24,
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        String a = newValue!.split('_').last;
        String updated = a.replaceAll(RegExp(r'\.svg\b'), '');
        widget.onChange(updated);
        setState(() {
          selectedSvg = newValue;
        });
      },
    );
  }
}
