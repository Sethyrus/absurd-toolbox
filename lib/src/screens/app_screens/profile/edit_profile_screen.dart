import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  static const String routeName = '/edit_profile';

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      secondaryColor: Theme.of(context).primaryColorDark,
      primaryColor: Theme.of(context).primaryColor,
      themeStyle: ThemeStyle.light,
      title: "Editar perfil",
      content: const Center(
        child: Text("Editar perfil"),
      ),
    );
  }
}
