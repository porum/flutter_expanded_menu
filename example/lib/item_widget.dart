import 'package:flutter/material.dart';
import 'package:example/item.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key? key,
    required this.data,
    this.onTap,
  }) : super(key: key);

  final Item data;
  final Function(Item)? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage(data.assetIcon), width: 24, height: 24),
              Visibility(
                visible: data.name.isNotEmpty,
                child: Text(
                  data.name,
                  style: const TextStyle(color: Colors.black, fontSize: 9),
                ),
              ),
            ],
          ),
        ),
        _buildRedPoint(),
      ],
    );
  }

  _buildRedPoint() {
    if (data.unreadCount <= 0) {
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
              data.unreadCount <= 999 ? "${data.unreadCount}" : "999+",
              style: const TextStyle(color: Colors.white, fontSize: 9),
            ),
          ),
        ),
      ),
    );
  }
}
