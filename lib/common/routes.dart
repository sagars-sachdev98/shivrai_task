import 'package:get/get.dart';
import 'package:shivrai_task/view/dashboard.view.dart';
//all the routes
class Routes {
  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: '/dashboard',
      page: () => DashBoardView(),
    )
  ];
}
