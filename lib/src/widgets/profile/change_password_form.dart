import 'package:flutter/material.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({Key? key}) : super(key: key);

  // _submitForm() {}

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Cambiar contraseña - En desarrollo"));
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Form(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Column(
    //           children: const [
    //             AuthInput(
    //               labelText: "Contraseña anterior",
    //             ),
    //             AuthInput(
    //               labelText: "Nueva contraseña",
    //             ),
    //             AuthInput(
    //               labelText: "Confirmar contraseña",
    //             ),
    //           ],
    //         ),
    //         ElevatedButton(
    //           onPressed: _submitForm,
    //           child: const Text("Guardar cambio"),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
