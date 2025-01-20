import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/topic/topic_repo.dart';
import 'package:flutter/material.dart';

class SelectDialogContentWidget extends StatefulWidget {
  const SelectDialogContentWidget({
    super.key,
    required this.title,
    required this.items,
    this.diagnosisRepo,
    this.onSelect,
    this.topicRepo,
  });

  final String title;
  final List<String> items;
  final DiagnosisRepo? diagnosisRepo;
  final TopicRepo? topicRepo;
  final Function(String)? onSelect;

  @override
  State<SelectDialogContentWidget> createState() => _SelectDialogContentWidgetState();
}

class _SelectDialogContentWidgetState extends State<SelectDialogContentWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final _animationDuration = const Duration(milliseconds: 300);
  final ScrollController _scrollController = ScrollController();

  bool _isExpanded = false;
  String? _selectedText;


  @override
  void initState() {
    super.initState();

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

  String? selectedText(String? text, bool isList) {
    if(text == null){
      return null;
    }
    if(text.isEmpty || text == '-1' || text.isEmpty){
      if(isList){
        return 'Select All';
      }
      return widget.title;
    }
    if (widget.topicRepo != null) {
      return '${widget.topicRepo!.value(text, 'locale')}';
    }

    if (widget.diagnosisRepo != null) {
      return '${widget.diagnosisRepo!.value(text, 'locale')}';
    }
    return text;
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
                  selectedText(_selectedText, false) ?? widget.title,
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
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 11,
                          ),
                          child: Text(
                            selectedText(item, true) ?? '',
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
