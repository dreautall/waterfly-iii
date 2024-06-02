// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/piggy_bank_v2_array.dart';

part 'piggy_banks_client.g.dart';

@RestApi()
abstract class PiggyBanksClient {
  factory PiggyBanksClient(Dio dio, {String? baseUrl}) = _PiggyBanksClient;

  /// List all piggy banks.
  ///
  /// List all the piggy banks the user has made.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  @GET('/v2/piggy-banks')
  Future<PiggyBankV2Array> listPiggyBanks({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });
}
