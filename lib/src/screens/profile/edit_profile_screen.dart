import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  static const String routeName = '/edit_profile';

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      statusBarColor: Colors.indigo.shade800,
      themeColor: Colors.indigo,
      themeStyle: ThemeStyle.light,
      title: "Editar perfil",
      content: const Center(
        child: Text("Editar perfil"),
      ),
    );
  }
}
