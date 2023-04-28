import 'package:assurance/controllers/global_controller_usuario.dart';
import 'package:assurance/modules/home/controllers/home_controller.dart';
import 'package:assurance/modules/inicio_about/pages/about_page.dart';
import 'package:assurance/modules/inicio_actividad/pages/actividad_page.dart';
import 'package:assurance/modules/inicio_clientes/pages/clientes_page.dart';
import 'package:assurance/modules/inicio_gastos_ingresos/pages/gastos_ingresos_page.dart';
import 'package:assurance/modules/inicio_notas/pages/notas_page.dart';
import 'package:assurance/modules/inicio_polizas/pages/polizas_menu_page.dart';
import 'package:assurance/modules/inicio_polizas_pendientes/pages/polizas_pendientes_page.dart';
import 'package:get/get.dart';

class InicioController extends GetxController {
  GlobalControllerUsuario globalControllerUsuario =
      Get.find<GlobalControllerUsuario>();
  HomeController homeController = Get.find<HomeController>();

  @override
  void onReady() {
    super.onReady();
  }

  void toRoutes(String route) {
    switch (route) {
      case 'misPolizas':
        Get.to(() => PolizasMenuPage());
        break;
      case 'misClientes':
        Get.to(() => ClientesPage());
        break;
      case 'polizasPendientes':
        Get.to(() => PolizasPendientesPage());
        break;
      case 'gastosIngresos':
        Get.to(() => GastosIngresosPage());
        break;
      case 'notas':
        Get.to(() => NotasPage());
        break;
      case 'miActividad':
        Get.to(() => ActividadPage());
        break;
      case 'about':
        Get.to(() => AboutPage());
        break;
    }
  }

  void toPerfil() {
    homeController.setIndex(1);
  }
}
