import 'package:flutter/material.dart';

class SelectDialogWidget extends StatefulWidget {
  const SelectDialogWidget({
    super.key,
    required this.title,
    required this.firstItem,
    required this.secondItem,
  });

  final String title;
  final String firstItem;
  final String secondItem;

  @override
  State<SelectDialogWidget> createState() => _SelectDialogWidgetState();
}

class _SelectDialogWidgetState extends State<SelectDialogWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  final _animationDuration = const Duration(milliseconds: 300);

  bool _isExpanded = false;
  String _selectedText = '';

  @override
  void initState() {
    super.initState();
    _selectedText = widget.title;
    _controller = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            _isExpanded ? _controller.reverse() : _controller.forward();
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 11,
            ),
            decoration: BoxDecoration(
              borderRadius: _isExpanded
                  ? const BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0),
                    )
                  : const BorderRadius.all(Radius.circular(15.0)),
              border: Border.all(color: Colors.black.withOpacity(0.1), width: 1.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedText,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
                ),
                _isExpanded
                    ? const Icon(Icons.keyboard_arrow_down, color: Colors.grey)
                    : const Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.grey,
                      )
              ],
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
          ),
          axisAlignment: -1,
          axis: Axis.vertical,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 11,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
              border: Border(
                left: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.3),
                right: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.3),
                bottom: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.3),
              ),
            ),
            child: Column(
              children: [
                InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    _isExpanded ? _controller.reverse() : _controller.forward();
                    setState(() {
                      _isExpanded = !_isExpanded;
                      _selectedText = widget.firstItem;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 11,
                    ),
                    child: Text(
                      widget.firstItem,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
                    ),
                  ),
                ),
                InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    _isExpanded ? _controller.reverse() : _controller.forward();
                    setState(() {
                      _isExpanded = !_isExpanded;
                      _selectedText = widget.secondItem;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 11,
                    ),
                    child: Text(
                      widget.secondItem,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
