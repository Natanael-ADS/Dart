import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
part 'user_service.g.dart';

class UserService {
  @Route.get('/')
  FutureOr<Response> getND(Request request) async {
    return Response.ok('N/D');
  }

  @Route.get('/All')
  FutureOr<Response> getAll(Request request) async {
    return Response.ok('getAll users!');
  }

  Router get router => _$UserServiceRouter(this);
}
