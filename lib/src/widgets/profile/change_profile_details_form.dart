import 'package:absurd_toolbox/src/models/user_profile.dart';
import 'package:absurd_toolbox/src/services/user_profile_service.dart';
import 'package:absurd_toolbox/src/widgets/_general/input.dart';
import 'package:flutter/material.dart';

class ChangeProfileDetailsForm extends StatefulWidget {
  const ChangeProfileDetailsForm({Key? key}) : super(key: key);

  @override
  State<ChangeProfileDetailsForm> createState() =>
      _ChangeProfileDetailsFormState();
}

class _ChangeProfileDetailsFormState extends State<ChangeProfileDetailsForm> {
  final _form = GlobalKey<FormState>();
  bool _initialized = false;
  UserProfile _originalProfile = UserProfile(
    email: "",
    username: "",
    description: "",
    avatar: "",
  );
  UserProfile _editedProfile = UserProfile(
    email: "",
    username: "",
    description: "",
    avatar: "",
  );

  @override
  void initState() {
    final userProfile = userProfileService.userProfileSync;

    setState(() {
      _originalProfile = userProfile.clone();
      _editedProfile = userProfile.clone();
      _initialized = true;
    });

    super.initState();
  }

  _submitForm() {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();

      if (!_originalProfile.isSameAs(_editedProfile)) {
        userProfileService.updateProfile(_editedProfile);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _initialized
        ? Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Input(
                      initialValue: _editedProfile.username,
                      labelText: "Nombre de usuario",
                      onSaved: (val) => _editedProfile = UserProfile(
                        email: _editedProfile.email,
                        username: val!,
                        description: _editedProfile.description,
                        avatar: _editedProfile.avatar,
                      ),
                      validator: (val) {
                        if (val == null || val == "") {
                          return "El nombre de usuario no puede estar vacío";
                        } else if (val.length < 3) {
                          return "El nombre de usuario no puede tener menos de 3 caracteres";
                        }

                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    Input(
                      initialValue: _editedProfile.description,
                      labelText: "Descripción del perfil",
                      onSaved: (val) => _editedProfile = UserProfile(
                        email: _editedProfile.email,
                        username: _editedProfile.username,
                        description: val!,
                        avatar: _editedProfile.avatar,
                      ),
                      maxLines: 6,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text("Guardar cambios"),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
