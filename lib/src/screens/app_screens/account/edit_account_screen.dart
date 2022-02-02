import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:absurd_toolbox/src/widgets/profile/change_password_form.dart';
import 'package:absurd_toolbox/src/widgets/profile/change_profile_details_form.dart';
import 'package:flutter/material.dart';

class EditAccountScreen extends StatelessWidget {
  static const String routeName = '/edit_account';

  const EditAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Layout(
        secondaryColor: Theme.of(context).primaryColorDark,
        primaryColor: Theme.of(context).primaryColor,
        textThemeStyle: TextThemeStyle.light,
        title: "Editar cuenta",
        tabBarItems: const [
          Tab(child: Text('Perfil', style: TextStyle(color: Colors.white))),
          Tab(child: Text('Contraseña', style: TextStyle(color: Colors.white))),
        ],
        content: const TabBarView(
          children: [
            ChangeProfileDetailsForm(),
            ChangePasswordForm(),
          ],
        ),
      ),
    );
  }
}
