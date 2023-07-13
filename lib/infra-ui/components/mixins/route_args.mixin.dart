import 'package:flutter/widgets.dart';

mixin RouteArgsMixin<T> {
  T parseRoute(BuildContext context) =>
      ModalRoute.of(context)!.settings.arguments as T;
}
