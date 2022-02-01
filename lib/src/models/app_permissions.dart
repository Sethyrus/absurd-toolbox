import 'package:permission_handler/permission_handler.dart';

enum PermissionName {
  storage,
  microphone,
}

class AppPermissions {
  PermissionStatus? storage;
  PermissionStatus? microphone;

  AppPermissions({
    this.storage,
    this.microphone,
  });
}
