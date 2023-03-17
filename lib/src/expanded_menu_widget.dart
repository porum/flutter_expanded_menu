import 'package:flutter/material.dart';
import 'anchor_widget.dart';
import 'item_widget.dart';
import 'typedefs.dart';

class ExpandedMenuWidget<T> extends StatefulWidget {
  final double size;
  final Axis direction;
  final AxisDirection anchorDirection;
  final Alignment itemsContainerAlignment;
  final Decoration? backgroundBuilder;
  final double radius;
  final bool defaultExpand;
  final Duration? duration;
  final Curve? curve;
  final List<T> menuItems;
  final ItemBuilder<T> itemBuilder;
  final AnchorBuilder<T> anchorBuilder;
  final OnAnchorTap? onAnchorTap;
  final OnItemTap<T>? onItemTap;
  final ValueNotifier notifier;

  const ExpandedMenuWidget({
    Key? key,
    required this.size,
    this.direction = Axis.horizontal,
    this.anchorDirection = AxisDirection.left,
    this.itemsContainerAlignment = Alignment.bottomLeft,
    this.backgroundBuilder,
    this.radius = 12,
    this.defaultExpand = true,
    this.duration,
    this.curve,
    required this.menuItems,
    required this.itemBuilder,
    required this.anchorBuilder,
    this.onAnchorTap,
    required this.notifier,
    this.onItemTap,
  })  : assert((direction == Axis.horizontal &&
                (anchorDirection == AxisDirection.left ||
                    anchorDirection == AxisDirection.right)) ||
            (direction == Axis.vertical &&
                (anchorDirection == AxisDirection.up ||
                    anchorDirection == AxisDirection.down))),
        super(key: key);

  @override
  State<ExpandedMenuWidget<T>> createState() => _ExpandedMenuState<T>();
}

class _ExpandedMenuState<T> extends State<ExpandedMenuWidget<T>>
    with SingleTickerProviderStateMixin {
  late bool _isExpand;
  late Axis _direction;
  late Decoration _backgroundBuilder;

  @override
  void initState() {
    super.initState();
    _isExpand = widget.defaultExpand;
    _direction = widget.direction;
    _backgroundBuilder =
        widget.backgroundBuilder ?? _buildDefaultBackgroundDecoration();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.notifier,
      builder: (BuildContext context, value, Widget? child) {
        return Container(
          width: _direction == Axis.horizontal ? null : widget.size,
          height: _direction == Axis.horizontal ? widget.size : null,
          decoration: _backgroundBuilder,
          child: Flex(
            direction: _direction,
            mainAxisSize: MainAxisSize.min,
            children: _buildChildren(context),
          ),
        );
      },
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    var anchor = AnchorWidget(
      dimension: widget.size,
      radius: widget.radius,
      anchorBuilder: () =>
          widget.anchorBuilder(context, widget.menuItems, _isExpand),
      onTap: () {
        setState(() {
          _isExpand = !_isExpand;
        });
        widget.onAnchorTap?.call(_isExpand);
      },
    );

    List<Widget> children;
    if (widget.direction == Axis.horizontal) {
      if (widget.anchorDirection == AxisDirection.left) {
        children = <Widget>[anchor, _buildItemsContainer(context)];
      } else {
        children = <Widget>[_buildItemsContainer(context), anchor];
      }
    } else {
      if (widget.anchorDirection == AxisDirection.up) {
        children = <Widget>[anchor, _buildItemsContainer(context)];
      } else {
        children = <Widget>[_buildItemsContainer(context), anchor];
      }
    }
    return children;
  }

  Widget _buildItemsContainer(BuildContext context) {
    var containerLength = widget.menuItems.length * widget.size;

    return TweenAnimationBuilder<double>(
      tween: Tween(end: _isExpand ? 1.0 : 0.0),
      duration: widget.duration ?? const Duration(milliseconds: 500),
      curve: widget.curve ?? Curves.easeOutQuint,
      child: Flex(
        direction: _direction,
        mainAxisSize: MainAxisSize.min,
        children: _buildItems(context),
      ),
      builder: (_, double value, Widget? child) {
        var currentLength = containerLength * value;
        return SizedBox(
          width: _direction == Axis.horizontal ? currentLength : null,
          height: _direction == Axis.horizontal ? null : currentLength,
          child: ClipRRect(
            clipper: Clipper(
              containerLength,
              _direction == Axis.horizontal ? currentLength : widget.size,
              _direction == Axis.horizontal ? widget.size : currentLength,
              _direction,
              widget.radius,
            ),
            child: OverflowBox(
              maxHeight: _direction == Axis.horizontal ? null : containerLength,
              maxWidth: _direction == Axis.horizontal ? containerLength : null,
              alignment: widget.itemsContainerAlignment,
              child: child,
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    return List.generate(widget.menuItems.length, (index) {
      var item = widget.menuItems[index];
      return ItemWidget<T>(
        dimension: widget.size,
        radius: widget.radius,
        itemBuilder: () => widget.itemBuilder(context, index, item),
        onTap: () => widget.onItemTap?.call(item),
      );
    });
  }

  Decoration _buildDefaultBackgroundDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(widget.radius),
      boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 8)],
    );
  }
}

class Clipper extends CustomClipper<RRect> {
  Clipper(
    this.containerLength,
    this.width,
    this.height,
    this.direction,
    double radius,
  ) : radius = Radius.circular(radius);

  double containerLength;
  double width;
  double height;
  Axis direction;
  Radius radius;

  @override
  RRect getClip(Size size) {
    if (direction == Axis.horizontal) {
      return RRect.fromRectAndCorners(Rect.fromLTWH(0, 0, width, height),
          topRight: radius, bottomRight: radius);
    } else {
      return RRect.fromRectAndCorners(Rect.fromLTWH(0, 0, width, height),
          topLeft: radius, topRight: radius);
    }
  }

  @override
  bool shouldReclip(covariant CustomClipper<RRect> oldClipper) {
    return false;
  }
}
