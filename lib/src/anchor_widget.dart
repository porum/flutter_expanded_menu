import 'package:flutter/material.dart';

class AnchorWidget extends StatelessWidget {
  const AnchorWidget({
    Key? key,
    required this.dimension,
    required this.anchorBuilder,
    required this.onTap,
    required this.radius,
  }) : super(key: key);

  final double dimension;
  final Widget Function() anchorBuilder;
  final VoidCallback onTap;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: Stack(
        children: [
          anchorBuilder(),
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
