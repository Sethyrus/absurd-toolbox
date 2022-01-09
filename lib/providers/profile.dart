import 'package:absurd_toolbox/models/profile_data.dart';
import 'package:absurd_toolbox/providers/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile with ChangeNotifier {
  final Auth _authProvider;
  ProfileData _profileData = ProfileData(
    email: '',
    username: '',
    description: '',
  );
  bool _loading = false;
  bool _loaded = false;
  CollectionReference _profilesCollection =
      FirebaseFirestore.instance.collection('profiles');

  Profile(this._authProvider);

  ProfileData get profileData {
    return ProfileData(
      email: _profileData.email,
      username: _profileData.username,
      description: _profileData.description,
    );
  }

  void createProfile() {
    _profilesCollection.doc(_authProvider.userID).set(
          ProfileData(
            email: _authProvider.userData?.email ?? "",
            username: _authProvider.userData?.email?.substring(
                  0,
                  _authProvider.userData?.email?.indexOf("@"),
                ) ??
                "",
            description: "Perfil de Absurd Toolbox",
          ).toJson(),
        );
  }

  void reloadProfileData() {
    if (!_loaded && !_loading) {
      _loading = true;

      _profilesCollection
          .doc(_authProvider.userID)
          .snapshots()
          .listen((valueChanges) {
        final data = valueChanges.data() as Map<String, dynamic>?;

        if (data == null) {
          createProfile();
        } else {
          _profileData = ProfileData.fromJson(data);
        }

        _loaded = true;
        _loading = false;

        notifyListeners();
      });
    }
  }
}
