import 'package:example/item.dart';
import 'package:example/item_widget.dart';
import 'package:example/anchor_widget.dart';
import 'package:example/value_changed_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_menu/flutter_expanded_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MenuDataChangedListener notifier = MenuDataChangedListener(true);

  var items = [
    Item("健康监控", "assets/images/ic_health_manager.png", 6),
    Item("地图管理", "assets/images/ic_map_manager.png", 0),
    Item("排班管理", "assets/images/ic_schedule_manager.png", 0),
    Item("任务管理", "assets/images/ic_task_manager.png", 0),
    Item("机器设置", "assets/images/ic_robot_settings.png", 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expanded Menu Demo'),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 10,
            top: 10,
            child: ExpandedMenuWidget<Item>(
              size: 48,
              direction: Axis.horizontal,
              anchorDirection: AxisDirection.left,
              itemsContainerAlignment: Alignment.topLeft,
              menuItems: items,
              notifier: notifier,
              itemBuilder: (_, index, item) {
                return ItemWidget(data: item);
              },
              anchorBuilder: (_, items, isExpand) {
                return AnchorWidget(items: items, isExpand: isExpand);
              },
              onAnchorTap: (isExpand) {},
              onItemTap: (item) {},
            ),
          ),
          Positioned(
            left: 10,
            top: 100,
            child: ExpandedMenuWidget<Item>(
              size: 48,
              direction: Axis.horizontal,
              anchorDirection: AxisDirection.left,
              itemsContainerAlignment: Alignment.topRight,
              menuItems: items,
              notifier: notifier,
              itemBuilder: (_, index, item) {
                return ItemWidget(data: item);
              },
              anchorBuilder: (_, items, isExpand) {
                return AnchorWidget(items: items, isExpand: isExpand);
              },
              onAnchorTap: (isExpand) {},
              onItemTap: (item) {},
            ),
          ),
          Positioned(
            left: 10,
            top: 200,
            child: ExpandedMenuWidget<Item>(
              size: 48,
              direction: Axis.horizontal,
              anchorDirection: AxisDirection.left,
              itemsContainerAlignment: Alignment.topCenter,
              menuItems: items,
              notifier: notifier,
              itemBuilder: (_, index, item) {
                return ItemWidget(data: item);
              },
              anchorBuilder: (_, items, isExpand) {
                return AnchorWidget(items: items, isExpand: isExpand);
              },
              onAnchorTap: (isExpand) {},
              onItemTap: (item) {},
            ),
          ),
          Positioned(
            right: 10,
            top: 300,
            child: ExpandedMenuWidget<Item>(
              size: 48,
              direction: Axis.horizontal,
              anchorDirection: AxisDirection.right,
              itemsContainerAlignment: Alignment.topRight,
              menuItems: items,
              notifier: notifier,
              itemBuilder: (_, index, item) {
                return ItemWidget(data: item);
              },
              anchorBuilder: (_, items, isExpand) {
                return AnchorWidget(items: items, isExpand: isExpand);
              },
              onAnchorTap: (isExpand) {},
              onItemTap: (item) {},
            ),
          ),
          Positioned(
            left: 10,
            top: 400,
            child: ExpandedMenuWidget<Item>(
              size: 48,
              direction: Axis.vertical,
              anchorDirection: AxisDirection.up,
              itemsContainerAlignment: Alignment.topLeft,
              menuItems: items,
              notifier: notifier,
              itemBuilder: (_, index, item) {
                return ItemWidget(data: item);
              },
              anchorBuilder: (_, items, isExpand) {
                return AnchorWidget(items: items, isExpand: isExpand);
              },
              onAnchorTap: (isExpand) {},
              onItemTap: (item) {},
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: ExpandedMenuWidget<Item>(
              size: 48,
              direction: Axis.vertical,
              anchorDirection: AxisDirection.down,
              itemsContainerAlignment: Alignment.bottomLeft,
              menuItems: items,
              notifier: notifier,
              itemBuilder: (_, index, item) {
                return ItemWidget(data: item);
              },
              anchorBuilder: (_, items, isExpand) {
                return AnchorWidget(items: items, isExpand: isExpand);
              },
              onAnchorTap: (isExpand) {},
              onItemTap: (item) {},
            ),
          ),
        ],
      ),
    );
  }
}
