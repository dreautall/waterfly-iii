// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'firefly_iii_v2.models.swagger.dart';
import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
import 'firefly_iii_v2.enums.swagger.dart' as enums;
export 'firefly_iii_v2.enums.swagger.dart';
export 'firefly_iii_v2.models.swagger.dart';

part 'firefly_iii_v2.swagger.chopper.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class FireflyIiiV2 extends ChopperService {
  static FireflyIiiV2 create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    Iterable<dynamic>? interceptors,
  }) {
    if (client != null) {
      return _$FireflyIiiV2(client);
    }

    final newClient = ChopperClient(
        services: [_$FireflyIiiV2()],
        converter: converter ?? $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        client: httpClient,
        authenticator: authenticator,
        errorConverter: errorConverter,
        baseUrl: baseUrl ?? Uri.parse('http://'));
    return _$FireflyIiiV2(newClient);
  }

  ///Dashboard chart with asset account balance information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<ChartLineV2>> v2ChartAccountDashboardGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    generatedMapping.putIfAbsent(
        ChartDataSetV2, () => ChartDataSetV2.fromJsonFactory);

    return _v2ChartAccountDashboardGet(
        xTraceId: xTraceId?.toString(), start: start, end: end);
  }

  ///Dashboard chart with asset account balance information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/v2/chart/account/dashboard')
  Future<chopper.Response<ChartLineV2>> _v2ChartAccountDashboardGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
  });

  ///A chart that contains spent/earned amounts
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] An array of accounts that should be included. Example: accounts[]=1&accounts[]=2
  ///@param period The period by which the results must be grouped.
  Future<chopper.Response<ChartLineV2>> v2ChartBalanceBalanceGet({
    String? xTraceId,
    required String? start,
    required String? end,
    required List<int>? accounts,
    required enums.PeriodProperty? period,
  }) {
    generatedMapping.putIfAbsent(
        ChartDataSetV2, () => ChartDataSetV2.fromJsonFactory);

    return _v2ChartBalanceBalanceGet(
        xTraceId: xTraceId?.toString(),
        start: start,
        end: end,
        accounts: accounts,
        period: period?.value?.toString());
  }

  ///A chart that contains spent/earned amounts
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] An array of accounts that should be included. Example: accounts[]=1&accounts[]=2
  ///@param period The period by which the results must be grouped.
  @Get(path: '/v2/chart/balance/balance')
  Future<chopper.Response<ChartLineV2>> _v2ChartBalanceBalanceGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') required List<int>? accounts,
    @Query('period') required String? period,
  });

  ///List all transactions related to the account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param id The ID of the account.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param type Optional filter on the transaction type(s) returned.
  Future<chopper.Response<TransactionArray>> v2AccountsIdTransactionsGet({
    String? xTraceId,
    int? page,
    int? limit,
    required String? id,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
        TransactionArray, () => TransactionArray.fromJsonFactory);

    return _v2AccountsIdTransactionsGet(
        xTraceId: xTraceId?.toString(),
        page: page,
        limit: limit,
        id: id,
        start: start,
        end: end,
        type: type?.value?.toString());
  }

  ///List all transactions related to the account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param id The ID of the account.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param type Optional filter on the transaction type(s) returned.
  @Get(path: '/v2/accounts/{id}/transactions')
  Future<chopper.Response<TransactionArray>> _v2AccountsIdTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///Returns the sum of the bills already paid in the period indicated.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<TransactionSumArray>> v2BillsSumPaidGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    generatedMapping.putIfAbsent(
        TransactionSum, () => TransactionSum.fromJsonFactory);

    return _v2BillsSumPaidGet(
        xTraceId: xTraceId?.toString(), start: start, end: end);
  }

  ///Returns the sum of the bills already paid in the period indicated.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/v2/bills/sum/paid')
  Future<chopper.Response<TransactionSumArray>> _v2BillsSumPaidGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
  });

  ///Returns the sum of the bills not yet paid in the period indicated.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<TransactionSumArray>> v2BillsSumUnpaidGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    generatedMapping.putIfAbsent(
        TransactionSum, () => TransactionSum.fromJsonFactory);

    return _v2BillsSumUnpaidGet(
        xTraceId: xTraceId?.toString(), start: start, end: end);
  }

  ///Returns the sum of the bills not yet paid in the period indicated.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/v2/bills/sum/unpaid')
  Future<chopper.Response<TransactionSumArray>> _v2BillsSumUnpaidGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
  });

  ///List all budgets.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<BudgetV2Array>> v2BudgetsGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        BudgetV2Array, () => BudgetV2Array.fromJsonFactory);

    return _v2BudgetsGet(
        xTraceId: xTraceId?.toString(), limit: limit, page: page);
  }

  ///List all budgets.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v2/budgets')
  Future<chopper.Response<BudgetV2Array>> _v2BudgetsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///Get all limits for a budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param id The ID of the requested budget.
  Future<chopper.Response<BudgetLimitV2Array>> v2BudgetsIdLimitsGet({
    String? xTraceId,
    required String? start,
    required String? end,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
        BudgetLimitV2Array, () => BudgetLimitV2Array.fromJsonFactory);

    return _v2BudgetsIdLimitsGet(
        xTraceId: xTraceId?.toString(), start: start, end: end, id: id);
  }

  ///Get all limits for a budget.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param id The ID of the requested budget.
  @Get(path: '/v2/budgets/{id}/limits')
  Future<chopper.Response<BudgetLimitV2Array>> _v2BudgetsIdLimitsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Path('id') required String? id,
  });

  ///Returns the budgeted amount for the given budget in the given period.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param id The ID of the budget.
  Future<chopper.Response<TransactionSumArray>> v2BudgetsIdBudgetedGet({
    String? xTraceId,
    required String? start,
    required String? end,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
        TransactionSum, () => TransactionSum.fromJsonFactory);

    return _v2BudgetsIdBudgetedGet(
        xTraceId: xTraceId?.toString(), start: start, end: end, id: id);
  }

  ///Returns the budgeted amount for the given budget in the given period.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param id The ID of the budget.
  @Get(path: '/v2/budgets/{id}/budgeted')
  Future<chopper.Response<TransactionSumArray>> _v2BudgetsIdBudgetedGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Path('id') required String? id,
  });

  ///Returns the spent amount for the given budget in the given period.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param id The ID of the budget.
  Future<chopper.Response<TransactionSumArray>> v2BudgetsIdSpentGet({
    String? xTraceId,
    required String? start,
    required String? end,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
        TransactionSum, () => TransactionSum.fromJsonFactory);

    return _v2BudgetsIdSpentGet(
        xTraceId: xTraceId?.toString(), start: start, end: end, id: id);
  }

  ///Returns the spent amount for the given budget in the given period.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param id The ID of the budget.
  @Get(path: '/v2/budgets/{id}/spent')
  Future<chopper.Response<TransactionSumArray>> _v2BudgetsIdSpentGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Path('id') required String? id,
  });

  ///Returns the budgeted amount for all budgets in the given period.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param id The ID of the budget.
  Future<chopper.Response<TransactionSumArray>> v2BudgetsSumBudgetedGet({
    String? xTraceId,
    required String? start,
    required String? end,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
        TransactionSum, () => TransactionSum.fromJsonFactory);

    return _v2BudgetsSumBudgetedGet(
        xTraceId: xTraceId?.toString(), start: start, end: end, id: id);
  }

  ///Returns the budgeted amount for all budgets in the given period.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param id The ID of the budget.
  @Get(path: '/v2/budgets/sum/budgeted')
  Future<chopper.Response<TransactionSumArray>> _v2BudgetsSumBudgetedGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Path('id') required String? id,
  });

  ///Returns the spent amount for all budgets in the given period.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param id The ID of the budget.
  Future<chopper.Response<TransactionSumArray>> v2BudgetsSumSpentGet({
    String? xTraceId,
    required String? start,
    required String? end,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
        TransactionSum, () => TransactionSum.fromJsonFactory);

    return _v2BudgetsSumSpentGet(
        xTraceId: xTraceId?.toString(), start: start, end: end, id: id);
  }

  ///Returns the spent amount for all budgets in the given period.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param id The ID of the budget.
  @Get(path: '/v2/budgets/sum/spent')
  Future<chopper.Response<TransactionSumArray>> _v2BudgetsSumSpentGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Path('id') required String? id,
  });

  ///Return a single preference.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param name The name of the preference.
  Future<chopper.Response<PreferenceSingle>> v2PreferencesNameGet({
    String? xTraceId,
    required String? name,
  }) {
    generatedMapping.putIfAbsent(
        PreferenceSingle, () => PreferenceSingle.fromJsonFactory);

    return _v2PreferencesNameGet(xTraceId: xTraceId?.toString(), name: name);
  }

  ///Return a single preference.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param name The name of the preference.
  @Get(path: '/v2/preferences/{name}')
  Future<chopper.Response<PreferenceSingle>> _v2PreferencesNameGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Path('name') required String? name,
  });

  ///Shows the net worth
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param date A date formatted YYYY-MM-DD.
  Future<chopper.Response<TransactionSumArray>> v2NetWorthGet({
    String? xTraceId,
    required String? date,
  }) {
    generatedMapping.putIfAbsent(
        TransactionSum, () => TransactionSum.fromJsonFactory);

    return _v2NetWorthGet(xTraceId: xTraceId?.toString(), date: date);
  }

  ///Shows the net worth
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param date A date formatted YYYY-MM-DD.
  @Get(path: '/v2/net-worth')
  Future<chopper.Response<TransactionSumArray>> _v2NetWorthGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('date') required String? date,
  });
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
          body: DateTime.parse((response.body as String).replaceAll('"', ''))
              as ResultType);
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);
