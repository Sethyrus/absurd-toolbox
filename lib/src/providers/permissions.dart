import 'package:absurd_toolbox/src/helpers.dart';
import 'package:absurd_toolbox/src/models/app_permissions.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsProvider with ChangeNotifier {
  AppPermissions _permissions = AppPermissions();

  AppPermissions get permissions {
    return AppPermissions(
      storage: _permissions.storage,
      microphone: _permissions.microphone,
    );
  }

  void setPermission(
    PermissionName name,
    PermissionStatus status,
  ) {
    log(key: "Set permission: $name", value: status);
    switch (name) {
      case PermissionName.Storage:
        {
          _permissions.storage = status;
          break;
        }
      case PermissionName.Microphone:
        {
          _permissions.microphone = status;
          break;
        }
    }

    notifyListeners();
  }
}
