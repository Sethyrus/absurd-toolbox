import 'dart:async';
import 'package:absurd_toolbox/src/blocs/auth_bloc.dart';
import 'package:absurd_toolbox/src/blocs/connectivity_bloc.dart';
import 'package:absurd_toolbox/src/helpers.dart';
import 'package:absurd_toolbox/src/models/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class UserProfileBloc {
  final _userProfileFetcher = BehaviorSubject<UserProfile>()
    ..startWith(
      UserProfile(
        email: '',
        username: '',
        description: '',
        avatar: '',
      ),
    );
  StreamSubscription<DocumentSnapshot<Object?>>? _firebaseUserProfileSub;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Stream<UserProfile> get userProfile => _userProfileFetcher.stream;

  void createProfile() async {
    final User? userData = await authBloc.userData.first;

    final newUser = UserProfile(
      email: userData?.email ?? "",
      username: userData?.email?.substring(
            0,
            userData.email?.indexOf("@"),
          ) ??
          "",
      description: "Perfil de Absurd Toolbox",
      avatar:
          "https://firebasestorage.googleapis.com/v0/b/absurdtoolbox.appspot.com/o/public%2Fuser-2451533-2082543.png?alt=media",
    ).toJson();

    log(key: "Create new user profile", value: newUser);

    _usersCollection.doc(userData!.uid).set(newUser);
  }

  void initUserProfileSubscription() {
    log(
      key: "Trying to init user profile subscription",
      value: "Already started: ${_firebaseUserProfileSub != null}",
    );

    connectivityBloc.hasNetwork.listen((hasNetwork) {
      if (hasNetwork) {
        if (_firebaseUserProfileSub == null) {
          _firebaseUserProfileSub = _usersCollection
              .doc(authBloc.userIdSync)
              .snapshots()
              .listen((valueChanges) {
            log(key: "User profile changed", value: valueChanges.data());
            final data = valueChanges.data() as Map<String, dynamic>?;

            if (data == null) {
              createProfile();
            } else {
              _userProfileFetcher.sink.add(UserProfile.fromJson(data));
            }
          });
        }
      } else {
        cancelSubscriptions();
      }
    });
  }

  void cancelSubscriptions() {
    _firebaseUserProfileSub?.cancel();
    _firebaseUserProfileSub = null;
  }

  void dispose() {
    _firebaseUserProfileSub?.cancel();
    _firebaseUserProfileSub = null;
    _userProfileFetcher.close();
  }
}

final userProfileBloc = UserProfileBloc();
