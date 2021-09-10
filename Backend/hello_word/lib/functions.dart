import 'dart:async';

import 'package:functions_framework/functions_framework.dart';
import 'package:hello_word/user_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

@CloudFunction()
FutureOr<Response> function(Request request) async {
  final router = Router();

  router.mount('/user/', UserService().router);

  return router(request);
}
