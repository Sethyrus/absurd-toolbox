import 'dart:async';
import 'package:absurd_toolbox/src/blocs/auth_bloc.dart';
import 'package:absurd_toolbox/src/helpers.dart';
import 'package:absurd_toolbox/src/models/profile_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile with ChangeNotifier {
  UserProfileData _profileData = UserProfileData(
    email: '',
    username: '',
    description: '',
    avatar: '',
  );
  bool _loading = false;
  bool _loaded = false;
  CollectionReference _profilesCollection =
      FirebaseFirestore.instance.collection('users');
  StreamSubscription<DocumentSnapshot<Object?>>? _sub;

  UserProfileData get userProfileData {
    return UserProfileData(
      email: _profileData.email,
      username: _profileData.username,
      description: _profileData.description,
      avatar: _profileData.avatar,
    );
  }

  void createProfile() async {
    log(key: "Create new profile");

    final User? userData = await authBloc.userData.first;

    _profilesCollection.doc(userData!.uid).set(
          UserProfileData(
            email: userData.email ?? "",
            username: userData.email?.substring(
                  0,
                  userData.email?.indexOf("@"),
                ) ??
                "",
            description: "Perfil de Absurd Toolbox",
            avatar:
                "https://firebasestorage.googleapis.com/v0/b/absurdtoolbox.appspot.com/o/public%2Fuser-2451533-2082543.png?alt=media",
          ).toJson(),
        );
  }

  void reloadProfileData() {
    log(key: "Start listening for user profile changes");

    final String? userId = authBloc.userIdSync;

    if (!_loaded && !_loading) {
      _loading = true;

      _sub = _profilesCollection.doc(userId).snapshots().listen((valueChanges) {
        log(key: "User profile changed", value: valueChanges.data());
        final data = valueChanges.data() as Map<String, dynamic>?;

        if (data == null) {
          createProfile();
        } else {
          _profileData = UserProfileData.fromJson(data);
        }

        _loaded = true;
        _loading = false;

        notifyListeners();
      });
    }
  }

  void cancelSubscriptions() {
    log(key: "Cancel user profile subscriptions");
    _sub?.cancel();
  }
}
