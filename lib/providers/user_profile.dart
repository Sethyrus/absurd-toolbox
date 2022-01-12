import 'dart:async';
import 'package:absurd_toolbox/models/profile_data.dart';
import 'package:absurd_toolbox/providers/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProfile with ChangeNotifier {
  final Auth _authProvider;
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

  UserProfile(this._authProvider);

  UserProfileData get userProfileData {
    return UserProfileData(
      email: _profileData.email,
      username: _profileData.username,
      description: _profileData.description,
      avatar: _profileData.avatar,
    );
  }

  void createProfile() {
    _profilesCollection.doc(_authProvider.userID).set(
          UserProfileData(
            email: _authProvider.userData?.email ?? "",
            username: _authProvider.userData?.email?.substring(
                  0,
                  _authProvider.userData?.email?.indexOf("@"),
                ) ??
                "",
            description: "Perfil de Absurd Toolbox",
            avatar:
                "https://firebasestorage.googleapis.com/v0/b/absurdtoolbox.appspot.com/o/public%2Fuser-2451533-2082543.png?alt=media",
          ).toJson(),
        );
  }

  void reloadProfileData() {
    if (!_loaded && !_loading) {
      _loading = true;

      _sub = _profilesCollection
          .doc(_authProvider.userID)
          .snapshots()
          .listen((valueChanges) {
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
    _sub?.cancel();
  }
}
