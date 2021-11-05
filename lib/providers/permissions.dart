import 'package:absurd_toolbox/models/permission_control.dart';
import 'package:flutter/material.dart';

class Permissions with ChangeNotifier {
  List<PermissionControl> _items = [];

  List<PermissionControl> get items {
    return [..._items];
  }

  void setPermission() {}
}
