import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/topic/topic_repo.dart';
import 'package:flutter/material.dart';

class OverlaySearchWidget extends StatefulWidget {
  const OverlaySearchWidget({
    super.key,
    this.topicRepo,
    this.diagnosisRepo,
    required this.success,
  });

  final TopicRepo? topicRepo;
  final DiagnosisRepo? diagnosisRepo;

  final Function(String id) success;

  @override
  State<OverlaySearchWidget> createState() => _OverlaySearchWidgetState();
}

class _OverlaySearchWidgetState extends State<OverlaySearchWidget> {
  String? searchText;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController controllerText = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> ids = [];
    if (widget.diagnosisRepo != null) {
      ids = widget.diagnosisRepo!.ids();
    }

    if (widget.topicRepo != null) {
      ids = widget.topicRepo!.ids();
    }

    List<String> finalList = [];
    if (searchText != null && searchText!.isNotEmpty) {
      for (var id in ids) {
        if (widget.diagnosisRepo != null) {
          String value = widget.diagnosisRepo!.value(id, 'locale');
          if (value.toLowerCase().contains(searchText!.toLowerCase())) {
            finalList.add(id);
          }
        }

        if (widget.topicRepo != null) {
          String value = widget.topicRepo!.value(id, 'locale');
          if (value.toLowerCase().contains(searchText!.toLowerCase())) {
            finalList.add(id);
          }
        }
      }
    } else {
      finalList = List<String>.from(ids).toList();
    }
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 380, maxHeight: 56),
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 11,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
            ),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  searchText = text;
                });
              },
              maxLines: 1,
              textCapitalization: TextCapitalization.words,
              style: Theme.of(context).textTheme.bodyLarge,
              controller: controllerText,
              textAlign: TextAlign.justify,
              decoration: const InputDecoration(
                hintText: 'Search',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 18,
                ),
                counterText: '',
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)),
              ),
              child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                child: SizedBox(
                  height: 200,
                  width: 380,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: finalList.length,
                      itemBuilder: (context, index) {
                        return itemWidget(finalList[index]);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  Widget itemWidget(String id) {
    String text = 'Select All';
    if (id != '-1' && widget.diagnosisRepo != null) {
      text = widget.diagnosisRepo!.value(id, 'locale');
    }
    if (id != '-1' && widget.topicRepo != null) {
      text = widget.topicRepo!.value(id, 'locale');
    }
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        widget.success(id);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 11,
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
        ),
      ),
    );
  }
}

class SelectedWidget extends StatelessWidget {
  final String text;

  const SelectedWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        border: Border.all(color: Colors.black.withOpacity(0.1), width: 1.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
