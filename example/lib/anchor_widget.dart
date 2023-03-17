import 'package:flutter/material.dart';

import 'item.dart';

class AnchorWidget extends StatelessWidget {
  const AnchorWidget({
    Key? key,
    required this.items,
    required this.isExpand,
  }) : super(key: key);

  final bool isExpand;
  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        const Center(
          child: Image(
            image: AssetImage('assets/images/ic_module_entrance.png'),
            width: 24,
            height: 24,
          ),
        ),
        Visibility(
          visible: !isExpand,
          child: _buildRedPoint(),
        ),
      ],
    );
  }

  _buildRedPoint() {
    var unreadCount = items
        .map((e) => e.unreadCount)
        .reduce((value, element) => value + element);
    if (unreadCount <= 0) {
      return const SizedBox.shrink();
    }
    return Positioned(
      top: 5,
      right: 5,
      child: Container(
        height: 12,
        constraints: const BoxConstraints(minWidth: 12),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              unreadCount <= 999 ? "$unreadCount" : "999+",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
