import 'package:permission_handler/permission_handler.dart';

enum PermissionName {
  storage,
  microphone,
  notifications,
}

class AppPermissions {
  PermissionStatus? storage;
  PermissionStatus? microphone;
  PermissionStatus? notifications;

  AppPermissions({
    this.storage,
    this.microphone,
    this.notifications,
  });
}
