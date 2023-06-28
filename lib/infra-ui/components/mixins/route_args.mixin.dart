import 'package:flutter/widgets.dart';

mixin RouteArgs<T> {
  T parseRoute(BuildContext context) =>
      ModalRoute.of(context)!.settings.arguments as T;
}
