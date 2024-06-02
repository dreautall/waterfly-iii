// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/data_destroy_object.dart';
import '../models/export_file_filter.dart';

part 'data_client.g.dart';

@RestApi()
abstract class DataClient {
  factory DataClient(Dio dio, {String? baseUrl}) = _DataClient;

  /// Bulk update transaction properties. For more information, see https://docs.firefly-iii.org/references/firefly-iii/api/specials/.
  ///
  /// Allows you to update transactions in bulk.
  ///
  /// [query] - The JSON query.
  @POST('/v1/data/bulk/transactions')
  Future<void> bulkUpdateTransactions({
    @Query('query') required String query,
  });

  /// Endpoint to destroy user data.
  ///
  /// A call to this endpoint deletes the requested data type. Use it with care and always with user permission.
  /// The demo user is incapable of using this endpoint.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [objects] - The type of data that you wish to destroy. You can only use one at a time.
  @DELETE('/v1/data/destroy')
  Future<void> destroyData({
    @Query('objects') required DataDestroyObject objects,
    @Header('X-Trace-Id') String? xTraceId,
  });

  /// Export account data from Firefly III.
  ///
  /// This endpoint allows you to export your accounts from Firefly III into a file. Currently supports CSV exports only.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [type] - The file type the export file (CSV is currently the only option).
  @GET('/v1/data/export/accounts')
  Future<String> exportAccounts({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') ExportFileFilter? type,
  });

  /// Export bills from Firefly III.
  ///
  /// This endpoint allows you to export your bills from Firefly III into a file. Currently supports CSV exports only.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [type] - The file type the export file (CSV is currently the only option).
  @GET('/v1/data/export/bills')
  Future<String> exportBills({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') ExportFileFilter? type,
  });

  /// Export budgets and budget amount data from Firefly III.
  ///
  /// This endpoint allows you to export your budgets and associated budget data from Firefly III into a file. Currently supports CSV exports only.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [type] - The file type the export file (CSV is currently the only option).
  @GET('/v1/data/export/budgets')
  Future<String> exportBudgets({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') ExportFileFilter? type,
  });

  /// Export category data from Firefly III.
  ///
  /// This endpoint allows you to export your categories from Firefly III into a file. Currently supports CSV exports only.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [type] - The file type the export file (CSV is currently the only option).
  @GET('/v1/data/export/categories')
  Future<String> exportCategories({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') ExportFileFilter? type,
  });

  /// Export piggy banks from Firefly III.
  ///
  /// This endpoint allows you to export your piggy banks from Firefly III into a file. Currently supports CSV exports only.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [type] - The file type the export file (CSV is currently the only option).
  @GET('/v1/data/export/piggy-banks')
  Future<String> exportPiggies({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') ExportFileFilter? type,
  });

  /// Export recurring transaction data from Firefly III.
  ///
  /// This endpoint allows you to export your recurring transactions from Firefly III into a file. Currently supports CSV exports only.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [type] - The file type the export file (CSV is currently the only option).
  @GET('/v1/data/export/recurring')
  Future<String> exportRecurring({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') ExportFileFilter? type,
  });

  /// Export rule groups and rule data from Firefly III.
  ///
  /// This endpoint allows you to export your rules and rule groups from Firefly III into a file. Currently supports CSV exports only.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [type] - The file type the export file (CSV is currently the only option).
  @GET('/v1/data/export/rules')
  Future<String> exportRules({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') ExportFileFilter? type,
  });

  /// Export tag data from Firefly III.
  ///
  /// This endpoint allows you to export your tags from Firefly III into a file. Currently supports CSV exports only.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [type] - The file type the export file (CSV is currently the only option).
  @GET('/v1/data/export/tags')
  Future<String> exportTags({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('type') ExportFileFilter? type,
  });

  /// Export transaction data from Firefly III.
  ///
  /// This endpoint allows you to export transactions from Firefly III into a file. Currently supports CSV exports only.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  ///
  /// [start] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [end] - A date formatted YYYY-MM-DD.
  ///
  ///
  /// [accounts] - Limit the export of transactions to these accounts only. Only asset accounts will be accepted. Other types will be silently dropped.
  ///
  ///
  /// [type] - The file type the export file (CSV is currently the only option).
  @GET('/v1/data/export/transactions')
  Future<String> exportTransactions({
    @Query('start') required DateTime start,
    @Query('end') required DateTime end,
    @Header('X-Trace-Id') String? xTraceId,
    @Query('accounts') String? accounts,
    @Query('type') ExportFileFilter? type,
  });

  /// Endpoint to purge user data.
  ///
  /// A call to this endpoint purges all previously deleted data. Use it with care and always with user permission.
  /// The demo user is incapable of using this endpoint.
  ///
  /// [xTraceId] - Unique identifier associated with this request.
  @DELETE('/v1/data/purge')
  Future<void> purgeData({
    @Header('X-Trace-Id') String? xTraceId,
  });
}
