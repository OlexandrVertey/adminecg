import 'package:flutter/material.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({super.key, required this.list});

  final List<Widget> list;

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  @override
  void initState() {
    list = widget.list;
    super.initState();
  }

  List<Widget> list = [];

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Column(
        children: [
          const Text('Content'),
          Expanded(
            child: ReorderableListView(
              // scrollController: scrollController,
              // shrinkWrap: true,
              onReorder: _onReorder,
              children: [
                for (int index = 0; index < list.length; index++)
                  Card(
                    key: Key('value$index'),
                    child: Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      key: Key('value$index'),
                      height: 20,
                      child: list[index],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// Widget body (){
//   return Scrollbar(
//     controller: yourScrollController,
//     thumbVisibility: true,
//     child: SingleChildScrollView(
//       controller: yourScrollController,
//       child: Column(
//         children: [
//           SizedBox(height: 16),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               "Content",
//               style: Theme.of(context)
//                   .textTheme
//                   .labelMedium
//                   ?.copyWith(fontSize: 14, color: Colors.black),
//             ),
//           ),
//           const SizedBox(height: 12),
//           ContentWidget(scrollController: yourScrollController),
//           const SizedBox(height: 30),
//         ],
//       ),
//     ),
//   );
// }
}
