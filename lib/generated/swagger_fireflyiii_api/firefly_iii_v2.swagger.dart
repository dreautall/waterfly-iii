// ignore_for_file: type=lint

import 'dart:async';

import 'package:chopper/chopper.dart' as chopper;
import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;

import 'client_mapping.dart';
import 'firefly_iii_v2.enums.swagger.dart' as enums;
import 'firefly_iii_v2.models.swagger.dart';

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
    List<Interceptor>? interceptors,
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

  ///Returns all accounts of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  ///@param date If the account is an asset account or a liability, the autocomplete will also return the balance of the account on this date.
  ///@param types Optional filter on the account type(s) used in the autocomplete.
  Future<chopper.Response<AutocompleteAccountV2Array>>
      v2AutocompleteAccountsGet({
    String? xTraceId,
    String? query,
    int? limit,
    String? date,
    List<enums.AccountTypeFilter>? types,
  }) {
    generatedMapping.putIfAbsent(
        AutocompleteAccountV2, () => AutocompleteAccountV2.fromJsonFactory);

    return _v2AutocompleteAccountsGet(
        xTraceId: xTraceId?.toString(),
        query: query,
        limit: limit,
        date: date,
        types: accountTypeFilterListToJson(types));
  }

  ///Returns all accounts of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  ///@param date If the account is an asset account or a liability, the autocomplete will also return the balance of the account on this date.
  ///@param types Optional filter on the account type(s) used in the autocomplete.
  @Get(path: '/v2/autocomplete/accounts')
  Future<chopper.Response<AutocompleteAccountV2Array>>
      _v2AutocompleteAccountsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
    @Query('date') String? date,
    @Query('types') List<Object?>? types,
  });

  ///Returns all transactions, complemented with their ID, of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteTDArray>>
      v2AutocompleteTransactionDescriptionsGet({
    String? xTraceId,
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        AutocompleteTD, () => AutocompleteTD.fromJsonFactory);

    return _v2AutocompleteTransactionDescriptionsGet(
        xTraceId: xTraceId?.toString(), query: query, limit: limit);
  }

  ///Returns all transactions, complemented with their ID, of the user returned in a basic auto-complete array.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/v2/autocomplete/transaction-descriptions')
  Future<chopper.Response<AutocompleteTDArray>>
      _v2AutocompleteTransactionDescriptionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Dashboard chart with asset account balance information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param preselected The accounts Firefly III must include in this chart.
  ///@param accounts[] An array of accounts that should be included. Example: accounts[]=1&accounts[]=2
  Future<chopper.Response<ChartLineV2>> v2ChartAccountDashboardGet({
    String? xTraceId,
    required String? start,
    required String? end,
    enums.PreselectedAccountProperty? preselected,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        ChartDataSetV2, () => ChartDataSetV2.fromJsonFactory);

    return _v2ChartAccountDashboardGet(
        xTraceId: xTraceId?.toString(),
        start: start,
        end: end,
        preselected: preselected?.value?.toString(),
        accounts: accounts);
  }

  ///Dashboard chart with asset account balance information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param preselected The accounts Firefly III must include in this chart.
  ///@param accounts[] An array of accounts that should be included. Example: accounts[]=1&accounts[]=2
  @Get(path: '/v2/chart/account/dashboard')
  Future<chopper.Response<ChartLineV2>> _v2ChartAccountDashboardGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('preselected') String? preselected,
    @Query('accounts[]') List<int>? accounts,
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

  ///Dashboard chart with budget information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<ChartLineV2>> v2ChartBudgetDashboardGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    generatedMapping.putIfAbsent(
        ChartDataSetV2, () => ChartDataSetV2.fromJsonFactory);

    return _v2ChartBudgetDashboardGet(
        xTraceId: xTraceId?.toString(), start: start, end: end);
  }

  ///Dashboard chart with budget information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/v2/chart/budget/dashboard')
  Future<chopper.Response<ChartLineV2>> _v2ChartBudgetDashboardGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
  });

  ///Dashboard chart with budget information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<ChartLineV2>> v2ChartCategoryDashboardGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    generatedMapping.putIfAbsent(
        ChartDataSetV2, () => ChartDataSetV2.fromJsonFactory);

    return _v2ChartCategoryDashboardGet(
        xTraceId: xTraceId?.toString(), start: start, end: end);
  }

  ///Dashboard chart with budget information.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/v2/chart/category/dashboard')
  Future<chopper.Response<ChartLineV2>> _v2ChartCategoryDashboardGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
  });

  ///Get single account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param date A date formatted YYYY-MM-DD.
  ///@param id The ID of the account.
  Future<chopper.Response<AccountV2Single>> v2AccountsIdGet({
    String? xTraceId,
    String? date,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
        AccountV2Single, () => AccountV2Single.fromJsonFactory);

    return _v2AccountsIdGet(xTraceId: xTraceId?.toString(), date: date, id: id);
  }

  ///Get single account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param date A date formatted YYYY-MM-DD.
  ///@param id The ID of the account.
  @Get(path: '/v2/accounts/{id}')
  Future<chopper.Response<AccountV2Single>> _v2AccountsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('date') String? date,
    @Path('id') required String? id,
  });

  ///List all transactions related to the account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param start A date formatted YYYY-MM-DD. May be omitted.
  ///@param end A date formatted YYYY-MM-DD. Must be after "start". Can not be the same as "start". May be omitted.
  ///@param id The ID of the account.
  ///@param type Optional filter on the transaction type(s) returned.
  Future<chopper.Response<TransactionV2Array>> v2AccountsIdTransactionsGet({
    String? xTraceId,
    int? page,
    int? limit,
    String? start,
    String? end,
    required String? id,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
        TransactionV2Array, () => TransactionV2Array.fromJsonFactory);

    return _v2AccountsIdTransactionsGet(
        xTraceId: xTraceId?.toString(),
        page: page,
        limit: limit,
        start: start,
        end: end,
        id: id,
        type: type?.value?.toString());
  }

  ///List all transactions related to the account.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param start A date formatted YYYY-MM-DD. May be omitted.
  ///@param end A date formatted YYYY-MM-DD. Must be after "start". Can not be the same as "start". May be omitted.
  ///@param id The ID of the account.
  ///@param type Optional filter on the transaction type(s) returned.
  @Get(path: '/v2/accounts/{id}/transactions')
  Future<chopper.Response<TransactionV2Array>> _v2AccountsIdTransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('start') String? start,
    @Query('end') String? end,
    @Path('id') required String? id,
    @Query('type') String? type,
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
  Future<chopper.Response<TransactionSumArray>> v2BudgetsSumBudgetedGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    generatedMapping.putIfAbsent(
        TransactionSum, () => TransactionSum.fromJsonFactory);

    return _v2BudgetsSumBudgetedGet(
        xTraceId: xTraceId?.toString(), start: start, end: end);
  }

  ///Returns the budgeted amount for all budgets in the given period.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/v2/budgets/sum/budgeted')
  Future<chopper.Response<TransactionSumArray>> _v2BudgetsSumBudgetedGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
  });

  ///Returns the spent amount for all budgets in the given period.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<TransactionSumArray>> v2BudgetsSumSpentGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    generatedMapping.putIfAbsent(
        TransactionSum, () => TransactionSum.fromJsonFactory);

    return _v2BudgetsSumSpentGet(
        xTraceId: xTraceId?.toString(), start: start, end: end);
  }

  ///Returns the spent amount for all budgets in the given period.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/v2/budgets/sum/spent')
  Future<chopper.Response<TransactionSumArray>> _v2BudgetsSumSpentGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
  });

  ///List all currencies.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<CurrencyV2Array>> v2CurrenciesGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        CurrencyV2Array, () => CurrencyV2Array.fromJsonFactory);

    return _v2CurrenciesGet(
        xTraceId: xTraceId?.toString(), limit: limit, page: page);
  }

  ///List all currencies.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v2/currencies')
  Future<chopper.Response<CurrencyV2Array>> _v2CurrenciesGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///List all piggy banks.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<PiggyBankV2Array>> v2PiggyBanksGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        PiggyBankV2Array, () => PiggyBankV2Array.fromJsonFactory);

    return _v2PiggyBanksGet(
        xTraceId: xTraceId?.toString(), limit: limit, page: page);
  }

  ///List all piggy banks.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v2/piggy-banks')
  Future<chopper.Response<PiggyBankV2Array>> _v2PiggyBanksGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
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

  ///List all subscriptions.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<SubscriptionArray>> v2SubscriptionsGet({
    String? xTraceId,
    int? limit,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        SubscriptionArray, () => SubscriptionArray.fromJsonFactory);

    return _v2SubscriptionsGet(
        xTraceId: xTraceId?.toString(), limit: limit, page: page);
  }

  ///List all subscriptions.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/v2/subscriptions')
  Future<chopper.Response<SubscriptionArray>> _v2SubscriptionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
  });

  ///Get single subscription.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD. Must be before "end". Can not be the same as "end". If this is included, "end" must also be included.
  ///@param end A date formatted YYYY-MM-DD. Must be after "start". Can not be the same as "start". If this field is included, "start" must also be included.
  ///@param id The ID of the subscription.
  Future<chopper.Response<SubscriptionSingle>> v2SubscriptionsIdGet({
    String? xTraceId,
    String? start,
    String? end,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
        SubscriptionSingle, () => SubscriptionSingle.fromJsonFactory);

    return _v2SubscriptionsIdGet(
        xTraceId: xTraceId?.toString(), start: start, end: end, id: id);
  }

  ///Get single subscription.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD. Must be before "end". Can not be the same as "end". If this is included, "end" must also be included.
  ///@param end A date formatted YYYY-MM-DD. Must be after "start". Can not be the same as "start". If this field is included, "start" must also be included.
  ///@param id The ID of the subscription.
  @Get(path: '/v2/subscriptions/{id}')
  Future<chopper.Response<SubscriptionSingle>> _v2SubscriptionsIdGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') String? start,
    @Query('end') String? end,
    @Path('id') required String? id,
  });

  ///Returns the sum of the bills already paid in the period indicated.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<TransactionSumArray>> v2SubscriptionsSumPaidGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    generatedMapping.putIfAbsent(
        TransactionSum, () => TransactionSum.fromJsonFactory);

    return _v2SubscriptionsSumPaidGet(
        xTraceId: xTraceId?.toString(), start: start, end: end);
  }

  ///Returns the sum of the bills already paid in the period indicated.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/v2/subscriptions/sum/paid')
  Future<chopper.Response<TransactionSumArray>> _v2SubscriptionsSumPaidGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
  });

  ///Returns the sum of the subscriptions not yet paid in the period indicated.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<TransactionSumArray>> v2SubscriptionsSumUnpaidGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    generatedMapping.putIfAbsent(
        TransactionSum, () => TransactionSum.fromJsonFactory);

    return _v2SubscriptionsSumUnpaidGet(
        xTraceId: xTraceId?.toString(), start: start, end: end);
  }

  ///Returns the sum of the subscriptions not yet paid in the period indicated.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/v2/subscriptions/sum/unpaid')
  Future<chopper.Response<TransactionSumArray>> _v2SubscriptionsSumUnpaidGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
  });

  ///List all transactions.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param start A date formatted YYYY-MM-DD. May be omitted.
  ///@param end A date formatted YYYY-MM-DD. Must be after "start". Can not be the same as "start". May be omitted.
  Future<chopper.Response<TransactionV2Array>> v2TransactionsGet({
    String? xTraceId,
    int? limit,
    int? page,
    String? start,
    String? end,
  }) {
    generatedMapping.putIfAbsent(
        TransactionV2Array, () => TransactionV2Array.fromJsonFactory);

    return _v2TransactionsGet(
        xTraceId: xTraceId?.toString(),
        limit: limit,
        page: page,
        start: start,
        end: end);
  }

  ///List all transactions.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param limit Number of items per page. The default pagination is per 50 items.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param start A date formatted YYYY-MM-DD. May be omitted.
  ///@param end A date formatted YYYY-MM-DD. Must be after "start". Can not be the same as "start". May be omitted.
  @Get(path: '/v2/transactions')
  Future<chopper.Response<TransactionV2Array>> _v2TransactionsGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
  });

  ///Store a new transaction
  ///@param X-Trace-Id Unique identifier associated with this request.
  Future<chopper.Response<TransactionV2Single>> v2TransactionsPost({
    String? xTraceId,
    required TransactionV2Store? body,
  }) {
    generatedMapping.putIfAbsent(
        TransactionV2Single, () => TransactionV2Single.fromJsonFactory);

    return _v2TransactionsPost(xTraceId: xTraceId?.toString(), body: body);
  }

  ///Store a new transaction
  ///@param X-Trace-Id Unique identifier associated with this request.
  @Post(
    path: '/v2/transactions',
    optionalBody: true,
  )
  Future<chopper.Response<TransactionV2Single>> _v2TransactionsPost({
    @Header('X-Trace-Id') String? xTraceId,
    @Body() required TransactionV2Store? body,
  });

  ///Shows the net worth
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param date A date formatted YYYY-MM-DD.
  Future<chopper.Response<NetWorthArray>> v2NetWorthGet({
    String? xTraceId,
    required String? date,
  }) {
    generatedMapping.putIfAbsent(
        NetWorthArray, () => NetWorthArray.fromJsonFactory);

    return _v2NetWorthGet(xTraceId: xTraceId?.toString(), date: date);
  }

  ///Shows the net worth
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param date A date formatted YYYY-MM-DD.
  @Get(path: '/v2/net-worth')
  Future<chopper.Response<NetWorthArray>> _v2NetWorthGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('date') required String? date,
  });

  ///Returns basic sums of the users data.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<BasicSummaryV2>> v2SummaryBasicGet({
    String? xTraceId,
    required String? start,
    required String? end,
  }) {
    generatedMapping.putIfAbsent(
        BasicSummaryV2, () => BasicSummaryV2.fromJsonFactory);

    return _v2SummaryBasicGet(
        xTraceId: xTraceId?.toString(), start: start, end: end);
  }

  ///Returns basic sums of the users data.
  ///@param X-Trace-Id Unique identifier associated with this request.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/v2/summary/basic')
  Future<chopper.Response<BasicSummaryV2>> _v2SummaryBasicGet({
    @Header('X-Trace-Id') String? xTraceId,
    @Query('start') required String? start,
    @Query('end') required String? end,
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
