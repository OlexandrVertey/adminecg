import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/topic/topic_repo.dart';
import 'package:flutter/material.dart';

class SelectDialogWidget extends StatefulWidget {
  const SelectDialogWidget({
    super.key,
    required this.title,
    required this.items,
    this.diagnosisRepo,
    this.onSelect,
    this.currentValue,
    this.topicRepo,
  });

  final String title;
  final List<String> items;
  final DiagnosisRepo? diagnosisRepo;
  final TopicRepo? topicRepo;
  final Function(String)? onSelect;
  final String? currentValue;

  @override
  State<SelectDialogWidget> createState() => _SelectDialogWidgetState();
}

class _SelectDialogWidgetState extends State<SelectDialogWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final _animationDuration = const Duration(milliseconds: 300);
  final ScrollController _scrollController = ScrollController();

  bool _isExpanded = false;
  bool _isSelected = false;
  String _selectedText = '';

  @override
  void initState() {
    super.initState();
    print('---widget.currentValue = ${widget.currentValue}');
    print('---widget.title = ${widget.title}');
    _selectedText = widget.currentValue ?? widget.title;
    print('---_selectedText = ${_selectedText}');
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

  String selectedText() {
    print('---selectedText 1');
    if (widget.topicRepo != null) {
      return '${_isSelected ? '' : widget.title} ${widget.topicRepo != null ? widget.topicRepo!.value(_selectedText, 'locale') : _selectedText}';
    }

    if (widget.diagnosisRepo != null) {
      return '${_isSelected ? '' : widget.title} ${widget.diagnosisRepo != null ? widget.diagnosisRepo!.value(_selectedText, 'locale') : _selectedText}';
    }
    return _selectedText;
  }

  String valueText(String item) {
    if (widget.topicRepo != null) {
      return widget.topicRepo!.value(item, 'locale');
    }

    if (widget.diagnosisRepo != null) {
      return widget.diagnosisRepo!.value(item, 'locale');
    }
    return item;
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
              border:
                  Border.all(color: Colors.black.withOpacity(0.1), width: 1.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedText(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 14),
                ),
                _isExpanded
                    ? const Icon(Icons.keyboard_arrow_up, color: Colors.grey)
                    : const Icon(
                        Icons.keyboard_arrow_down,
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
                left: BorderSide(
                    color: Colors.black.withOpacity(0.1), width: 1.3),
                right: BorderSide(
                    color: Colors.black.withOpacity(0.1), width: 1.3),
                bottom: BorderSide(
                    color: Colors.black.withOpacity(0.1), width: 1.3),
              ),
            ),
            child: Scrollbar(
              thumbVisibility: true,
              controller: _scrollController,
              child: SizedBox(
                height: widget.items.length > 10 ? 200 : widget.items.length * 38,
                width: 155,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: widget.items.length,
                    itemBuilder: (context, index) {
                      var item = widget.items[index];
                      return InkWell(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          if (widget.onSelect != null) {
                            widget.onSelect!(item);
                          }
                          _isExpanded
                              ? _controller.reverse()
                              : _controller.forward();
                          setState(() {
                            _isExpanded = !_isExpanded;
                            _selectedText = item;
                            _isSelected = true;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 11,
                          ),
                          child: Text(
                            valueText(item),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: 14),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
