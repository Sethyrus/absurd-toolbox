import 'package:absurd_toolbox/widgets/_general/layout.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  static const String routeName = '/edit_profile';

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      statusBarColor: Colors.indigo.shade700,
      themeColor: Colors.indigo.shade400,
      title: "Editar perfil",
      showAppBar: true,
      content: Center(
        child: Text("Editar perfil"),
      ),
    );
  }
}
