import 'package:assurance/modules/perfil/controllers/perfil_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerfilController>(
        init: PerfilController(),
        builder: (_) {
          return Scaffold();
        });
  }
}
