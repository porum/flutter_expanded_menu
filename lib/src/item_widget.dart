import 'package:flutter/material.dart';

class ItemWidget<T> extends StatelessWidget {
  const ItemWidget({
    Key? key,
    required this.dimension,
    required this.onTap,
    required this.radius,
    required this.itemBuilder,
  }) : super(key: key);

  final double dimension;
  final double radius;
  final Widget Function() itemBuilder;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: Stack(
        children: [
          itemBuilder(),
          Material(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(radius),
            type: MaterialType.transparency,
            child: InkWell(onTap: () => onTap.call()),
          ),
        ],
      ),
    );
  }
}
