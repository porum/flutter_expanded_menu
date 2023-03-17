import 'package:flutter/widgets.dart';

typedef ItemBuilder<T> = Widget Function(BuildContext context, int index, T data);

typedef AnchorBuilder<T> = Widget Function(BuildContext context, List<T> items, bool isExpand);

typedef OnItemTap<T> = void Function(T data);

typedef OnAnchorTap = void Function(bool isExpand);