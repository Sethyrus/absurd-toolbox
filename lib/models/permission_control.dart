import 'package:permission_handler/permission_handler.dart';

enum AppPermission {
  storage,
}

class PermissionControl {
  final AppPermission name;
  PermissionStatus status;

  PermissionControl({
    required this.name,
    required this.status,
  });
}
