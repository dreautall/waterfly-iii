// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/currency_v2_array.dart';

part 'currencies_client.g.dart';

@RestApi()
abstract class CurrenciesClient {
  factory CurrenciesClient(Dio dio, {String? baseUrl}) = _CurrenciesClient;

  /// List all currencies.
  ///
  /// List all the currencies in the system.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [limit] - Number of items per page. The default pagination is per 50 items.
  ///
  /// [page] - Page number. The default pagination is per 50 items.
  @GET('/v2/currencies')
  Future<CurrencyV2Array> listCurrencies({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });
}
