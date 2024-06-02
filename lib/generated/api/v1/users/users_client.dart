// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/user.dart';
import '../models/user_array.dart';
import '../models/user_single.dart';

part 'users_client.g.dart';

@RestApi()
abstract class UsersClient {
  factory UsersClient(Dio dio, {String? baseUrl}) = _UsersClient;

  /// List all users.
  ///
  /// List all the users in this instance of Firefly III.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  @GET('/v1/users')
  Future<UserArray> listUser({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  /// Store a new user.
  ///
  /// Creates a new user. The data required can be submitted as a JSON body or as a list of parameters. The user will be given a random password, which they can reset using the "forgot password" function.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @FormUrlEncoded()
  @POST('/v1/users')
  Future<UserSingle> storeUser({
    @Body() required User body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Get a single user.
  ///
  /// Gets all info of a single user.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The user ID.
  @GET('/v1/users/{id}')
  Future<UserSingle> getUser({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Update an existing user's information.
  ///
  /// Update existing user.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The user ID.
  @FormUrlEncoded()
  @PUT('/v1/users/{id}')
  Future<UserSingle> updateUser({
    @Path('id') required String id,
    @Body() required User body,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Delete a user.
  ///
  /// Delete a user. You cannot delete the user you're authenticated with. This cannot be undone. Be careful!
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [id] - The user ID.
  @DELETE('/v1/users/{id}')
  Future<void> deleteUser({
    @Path('id') required String id,
    @Header('X-Trace-Id') String? xTraceId,
  });
}
