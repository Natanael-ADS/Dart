import 'dart:async';

import 'package:functions_framework/functions_framework.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

@CloudFunction()
FutureOr<Response> function(Request request) async {
  Router router = Router();

  router.get('/', (Request request) {
    return Response.ok('vaziu');
  });

  router.get('/sobre', (Request request) {
    return Response.ok('sobre kkkk');
  });

  router.get('/sobre/<id>', (Request request, String id) {
    try {
      int.parse(id);
    } catch (e) {
      return Response.internalServerError(body: e);
    }

    return Response.ok('sobre id: $id');
  });

  return router(request);
}
