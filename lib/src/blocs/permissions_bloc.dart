import 'package:absurd_toolbox/src/helpers.dart';
import 'package:absurd_toolbox/src/models/app_permissions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

class PermissionsBloc {
  final _permissionsFetcher = BehaviorSubject<AppPermissions>()
    ..startWith(AppPermissions());

  AppPermissions get permissionsSync =>
      _permissionsFetcher.valueOrNull ?? AppPermissions();
  Stream<AppPermissions> get permissions => _permissionsFetcher.stream;

  void setPermission(
    PermissionName name,
    PermissionStatus status,
  ) {
    log(key: "Set permission name: $name, with value: $status");

    switch (name) {
      case PermissionName.Storage:
        {
          _permissionsFetcher.sink.add(permissionsSync..storage = status);
          break;
        }
      case PermissionName.Microphone:
        {
          _permissionsFetcher.sink.add(permissionsSync..microphone = status);
          break;
        }
    }
  }

  void dispose() {
    _permissionsFetcher.close();
  }
}

final permissionsBloc = PermissionsBloc();
