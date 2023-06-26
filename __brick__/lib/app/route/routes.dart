import 'package:{{project_name.snakeCase()}}/pages/home.dart';
import 'package:{{project_name.snakeCase()}}/pages/second/second.dart';
import 'package:fluro/fluro.dart';

class Routes {
  static FluroRouter router = FluroRouter();
  static String home = '/';
  static String second = '/second';


  static void configureRouters(FluroRouter router) {
    router.define(home, handler: Handler(handlerFunc: (context, paramaters) {
      return const MyHomePage(title: '',);
    }));

    router.define(second,
        handler: Handler(handlerFunc: (context, paramaters) {
      return const SecondPage();
    }));


  }
}