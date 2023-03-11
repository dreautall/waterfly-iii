import 'firefly_iii.models.swagger.dart';
import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:chopper/chopper.dart' as chopper;
import 'firefly_iii.enums.swagger.dart' as enums;
export 'firefly_iii.enums.swagger.dart';
export 'firefly_iii.models.swagger.dart';

part 'firefly_iii.swagger.chopper.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class FireflyIii extends ChopperService {
  static FireflyIii create({
    ChopperClient? client,
    Authenticator? authenticator,
    Uri? baseUrl,
    Iterable<dynamic>? interceptors,
  }) {
    if (client != null) {
      return _$FireflyIii(client);
    }

    final newClient = ChopperClient(
      services: [_$FireflyIii()],
      converter: $JsonSerializableConverter(),
      interceptors: interceptors ?? [],
      authenticator: authenticator,
      /*baseUrl: YOUR_BASE_URL*/
      baseUrl: baseUrl,
    );
    return _$FireflyIii(newClient);
  }

  ///Returns all rule groups of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteRuleGroupArray>>
      apiV1AutocompleteRuleGroupsGet({
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        AutocompleteRuleGroup, () => AutocompleteRuleGroup.fromJsonFactory);

    return _apiV1AutocompleteRuleGroupsGet(query: query, limit: limit);
  }

  ///Returns all rule groups of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/api/v1/autocomplete/rule-groups')
  Future<chopper.Response<AutocompleteRuleGroupArray>>
      _apiV1AutocompleteRuleGroupsGet({
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all categories of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteCategoryArray>>
      apiV1AutocompleteCategoriesGet({
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        AutocompleteCategory, () => AutocompleteCategory.fromJsonFactory);

    return _apiV1AutocompleteCategoriesGet(query: query, limit: limit);
  }

  ///Returns all categories of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/api/v1/autocomplete/categories')
  Future<chopper.Response<AutocompleteCategoryArray>>
      _apiV1AutocompleteCategoriesGet({
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all transaction types returned in a basic auto-complete array. English only.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteTransactionTypeArray>>
      apiV1AutocompleteTransactionTypesGet({
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(AutocompleteTransactionType,
        () => AutocompleteTransactionType.fromJsonFactory);

    return _apiV1AutocompleteTransactionTypesGet(query: query, limit: limit);
  }

  ///Returns all transaction types returned in a basic auto-complete array. English only.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/api/v1/autocomplete/transaction-types')
  Future<chopper.Response<AutocompleteTransactionTypeArray>>
      _apiV1AutocompleteTransactionTypesGet({
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all object groups of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteObjectGroupArray>>
      apiV1AutocompleteObjectGroupsGet({
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        AutocompleteObjectGroup, () => AutocompleteObjectGroup.fromJsonFactory);

    return _apiV1AutocompleteObjectGroupsGet(query: query, limit: limit);
  }

  ///Returns all object groups of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/api/v1/autocomplete/object-groups')
  Future<chopper.Response<AutocompleteObjectGroupArray>>
      _apiV1AutocompleteObjectGroupsGet({
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all rules of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteRuleArray>> apiV1AutocompleteRulesGet({
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        AutocompleteRule, () => AutocompleteRule.fromJsonFactory);

    return _apiV1AutocompleteRulesGet(query: query, limit: limit);
  }

  ///Returns all rules of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/api/v1/autocomplete/rules')
  Future<chopper.Response<AutocompleteRuleArray>> _apiV1AutocompleteRulesGet({
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all transaction descriptions of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteTransactionArray>>
      apiV1AutocompleteTransactionsGet({
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        AutocompleteTransaction, () => AutocompleteTransaction.fromJsonFactory);

    return _apiV1AutocompleteTransactionsGet(query: query, limit: limit);
  }

  ///Returns all transaction descriptions of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/api/v1/autocomplete/transactions')
  Future<chopper.Response<AutocompleteTransactionArray>>
      _apiV1AutocompleteTransactionsGet({
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all transactions, complemented with their ID, of the user returned in a basic auto-complete array. This endpoint is DEPRECATED and I suggest you DO NOT use it.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteTransactionIDArray>>
      apiV1AutocompleteTransactionsWithIdGet({
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(AutocompleteTransactionID,
        () => AutocompleteTransactionID.fromJsonFactory);

    return _apiV1AutocompleteTransactionsWithIdGet(query: query, limit: limit);
  }

  ///Returns all transactions, complemented with their ID, of the user returned in a basic auto-complete array. This endpoint is DEPRECATED and I suggest you DO NOT use it.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/api/v1/autocomplete/transactions-with-id')
  Future<chopper.Response<AutocompleteTransactionIDArray>>
      _apiV1AutocompleteTransactionsWithIdGet({
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all budgets of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned
  Future<chopper.Response<AutocompleteBudgetArray>>
      apiV1AutocompleteBudgetsGet({
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        AutocompleteBudget, () => AutocompleteBudget.fromJsonFactory);

    return _apiV1AutocompleteBudgetsGet(query: query, limit: limit);
  }

  ///Returns all budgets of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned
  @Get(path: '/api/v1/autocomplete/budgets')
  Future<chopper.Response<AutocompleteBudgetArray>>
      _apiV1AutocompleteBudgetsGet({
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all piggy banks of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompletePiggyArray>>
      apiV1AutocompletePiggyBanksGet({
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        AutocompletePiggy, () => AutocompletePiggy.fromJsonFactory);

    return _apiV1AutocompletePiggyBanksGet(query: query, limit: limit);
  }

  ///Returns all piggy banks of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/api/v1/autocomplete/piggy-banks')
  Future<chopper.Response<AutocompletePiggyArray>>
      _apiV1AutocompletePiggyBanksGet({
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all piggy banks of the user returned in a basic auto-complete array complemented with balance information.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompletePiggyBalanceArray>>
      apiV1AutocompletePiggyBanksWithBalanceGet({
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(AutocompletePiggyBalance,
        () => AutocompletePiggyBalance.fromJsonFactory);

    return _apiV1AutocompletePiggyBanksWithBalanceGet(
        query: query, limit: limit);
  }

  ///Returns all piggy banks of the user returned in a basic auto-complete array complemented with balance information.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/api/v1/autocomplete/piggy-banks-with-balance')
  Future<chopper.Response<AutocompletePiggyBalanceArray>>
      _apiV1AutocompletePiggyBanksWithBalanceGet({
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all currencies of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteCurrencyArray>>
      apiV1AutocompleteCurrenciesGet({
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        AutocompleteCurrency, () => AutocompleteCurrency.fromJsonFactory);

    return _apiV1AutocompleteCurrenciesGet(query: query, limit: limit);
  }

  ///Returns all currencies of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/api/v1/autocomplete/currencies')
  Future<chopper.Response<AutocompleteCurrencyArray>>
      _apiV1AutocompleteCurrenciesGet({
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all currencies of the user returned in a basic auto-complete array. This endpoint is DEPRECATED and I suggest you DO NOT use it.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteCurrencyCodeArray>>
      apiV1AutocompleteCurrenciesWithCodeGet({
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(AutocompleteCurrencyCode,
        () => AutocompleteCurrencyCode.fromJsonFactory);

    return _apiV1AutocompleteCurrenciesWithCodeGet(query: query, limit: limit);
  }

  ///Returns all currencies of the user returned in a basic auto-complete array. This endpoint is DEPRECATED and I suggest you DO NOT use it.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/api/v1/autocomplete/currencies-with-code')
  Future<chopper.Response<AutocompleteCurrencyCodeArray>>
      _apiV1AutocompleteCurrenciesWithCodeGet({
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all accounts of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query for accounts.
  ///@param limit The number of items returned.
  ///@param date If the account is an asset account or a liability, the autocomplete will also return the balance of the account on this date.
  ///@param type Optional filter on the account type(s) used in the autocomplete.
  Future<chopper.Response<AutocompleteAccountArray>>
      apiV1AutocompleteAccountsGet({
    String? query,
    int? limit,
    String? date,
    List<enums.AccountTypeFilter>? types,
  }) {
    generatedMapping.putIfAbsent(
        AutocompleteAccount, () => AutocompleteAccount.fromJsonFactory);

    return _apiV1AutocompleteAccountsGet(
        query: query, limit: limit, date: date, types: types);
  }

  ///Returns all accounts of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query for accounts.
  ///@param limit The number of items returned.
  ///@param date If the account is an asset account or a liability, the autocomplete will also return the balance of the account on this date.
  ///@param type Optional filter on the account type(s) used in the autocomplete.
  @Get(path: '/api/v1/autocomplete/accounts')
  Future<chopper.Response<AutocompleteAccountArray>>
      _apiV1AutocompleteAccountsGet({
    @Query('query') String? query,
    @Query('limit') int? limit,
    @Query('date') String? date,
    @Query('types') List<enums.AccountTypeFilter>? types,
  });

  ///Returns all tags of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteTagArray>> apiV1AutocompleteTagsGet({
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        AutocompleteTag, () => AutocompleteTag.fromJsonFactory);

    return _apiV1AutocompleteTagsGet(query: query, limit: limit);
  }

  ///Returns all tags of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/api/v1/autocomplete/tags')
  Future<chopper.Response<AutocompleteTagArray>> _apiV1AutocompleteTagsGet({
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all bills of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query for bills.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteBillArray>> apiV1AutocompleteBillsGet({
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        AutocompleteBill, () => AutocompleteBill.fromJsonFactory);

    return _apiV1AutocompleteBillsGet(query: query, limit: limit);
  }

  ///Returns all bills of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query for bills.
  ///@param limit The number of items returned.
  @Get(path: '/api/v1/autocomplete/bills')
  Future<chopper.Response<AutocompleteBillArray>> _apiV1AutocompleteBillsGet({
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Returns all recurring transactions of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  Future<chopper.Response<AutocompleteRecurrenceArray>>
      apiV1AutocompleteRecurringGet({
    String? query,
    int? limit,
  }) {
    generatedMapping.putIfAbsent(
        AutocompleteRecurrence, () => AutocompleteRecurrence.fromJsonFactory);

    return _apiV1AutocompleteRecurringGet(query: query, limit: limit);
  }

  ///Returns all recurring transactions of the user returned in a basic auto-complete array.
  ///@param query The autocomplete search query.
  ///@param limit The number of items returned.
  @Get(path: '/api/v1/autocomplete/recurring')
  Future<chopper.Response<AutocompleteRecurrenceArray>>
      _apiV1AutocompleteRecurringGet({
    @Query('query') String? query,
    @Query('limit') int? limit,
  });

  ///Dashboard chart with asset account balance information.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<ChartLine>> apiV1ChartAccountOverviewGet({
    required String? start,
    required String? end,
  }) {
    generatedMapping.putIfAbsent(
        ChartDataSet, () => ChartDataSet.fromJsonFactory);

    return _apiV1ChartAccountOverviewGet(start: start, end: end);
  }

  ///Dashboard chart with asset account balance information.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/api/v1/chart/account/overview')
  Future<chopper.Response<ChartLine>> _apiV1ChartAccountOverviewGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
  });

  ///Export account data from Firefly III
  ///@param type The file type the export file (CSV is currently the only option).
  Future<chopper.Response<String>> apiV1DataExportAccountsGet(
      {enums.ExportFileFilter? type}) {
    return _apiV1DataExportAccountsGet(type: type?.value?.toString());
  }

  ///Export account data from Firefly III
  ///@param type The file type the export file (CSV is currently the only option).
  @Get(path: '/api/v1/data/export/accounts')
  Future<chopper.Response<String>> _apiV1DataExportAccountsGet(
      {@Query('type') String? type});

  ///Export bills from Firefly III
  ///@param type The file type the export file (CSV is currently the only option).
  Future<chopper.Response<String>> apiV1DataExportBillsGet(
      {enums.ExportFileFilter? type}) {
    return _apiV1DataExportBillsGet(type: type?.value?.toString());
  }

  ///Export bills from Firefly III
  ///@param type The file type the export file (CSV is currently the only option).
  @Get(path: '/api/v1/data/export/bills')
  Future<chopper.Response<String>> _apiV1DataExportBillsGet(
      {@Query('type') String? type});

  ///Export budgets and budget amount data from Firefly III
  ///@param type The file type the export file (CSV is currently the only option).
  Future<chopper.Response<String>> apiV1DataExportBudgetsGet(
      {enums.ExportFileFilter? type}) {
    return _apiV1DataExportBudgetsGet(type: type?.value?.toString());
  }

  ///Export budgets and budget amount data from Firefly III
  ///@param type The file type the export file (CSV is currently the only option).
  @Get(path: '/api/v1/data/export/budgets')
  Future<chopper.Response<String>> _apiV1DataExportBudgetsGet(
      {@Query('type') String? type});

  ///Export category data from Firefly III
  ///@param type The file type the export file (CSV is currently the only option).
  Future<chopper.Response<String>> apiV1DataExportCategoriesGet(
      {enums.ExportFileFilter? type}) {
    return _apiV1DataExportCategoriesGet(type: type?.value?.toString());
  }

  ///Export category data from Firefly III
  ///@param type The file type the export file (CSV is currently the only option).
  @Get(path: '/api/v1/data/export/categories')
  Future<chopper.Response<String>> _apiV1DataExportCategoriesGet(
      {@Query('type') String? type});

  ///Export piggy banks from Firefly III
  ///@param type The file type the export file (CSV is currently the only option).
  Future<chopper.Response<String>> apiV1DataExportPiggyBanksGet(
      {enums.ExportFileFilter? type}) {
    return _apiV1DataExportPiggyBanksGet(type: type?.value?.toString());
  }

  ///Export piggy banks from Firefly III
  ///@param type The file type the export file (CSV is currently the only option).
  @Get(path: '/api/v1/data/export/piggy-banks')
  Future<chopper.Response<String>> _apiV1DataExportPiggyBanksGet(
      {@Query('type') String? type});

  ///Export recurring transaction data from Firefly III
  ///@param type The file type the export file (CSV is currently the only option).
  Future<chopper.Response<String>> apiV1DataExportRecurringGet(
      {enums.ExportFileFilter? type}) {
    return _apiV1DataExportRecurringGet(type: type?.value?.toString());
  }

  ///Export recurring transaction data from Firefly III
  ///@param type The file type the export file (CSV is currently the only option).
  @Get(path: '/api/v1/data/export/recurring')
  Future<chopper.Response<String>> _apiV1DataExportRecurringGet(
      {@Query('type') String? type});

  ///Export rule groups and rule data from Firefly III
  ///@param type The file type the export file (CSV is currently the only option).
  Future<chopper.Response<String>> apiV1DataExportRulesGet(
      {enums.ExportFileFilter? type}) {
    return _apiV1DataExportRulesGet(type: type?.value?.toString());
  }

  ///Export rule groups and rule data from Firefly III
  ///@param type The file type the export file (CSV is currently the only option).
  @Get(path: '/api/v1/data/export/rules')
  Future<chopper.Response<String>> _apiV1DataExportRulesGet(
      {@Query('type') String? type});

  ///Export tag data from Firefly III
  ///@param type The file type the export file (CSV is currently the only option).
  Future<chopper.Response<String>> apiV1DataExportTagsGet(
      {enums.ExportFileFilter? type}) {
    return _apiV1DataExportTagsGet(type: type?.value?.toString());
  }

  ///Export tag data from Firefly III
  ///@param type The file type the export file (CSV is currently the only option).
  @Get(path: '/api/v1/data/export/tags')
  Future<chopper.Response<String>> _apiV1DataExportTagsGet(
      {@Query('type') String? type});

  ///Export transaction data from Firefly III
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts Limit the export of transactions to these accounts only. Only asset accounts will be accepted. Other types will be silently dropped.
  ///@param type The file type the export file (CSV is currently the only option).
  Future<chopper.Response<String>> apiV1DataExportTransactionsGet({
    required String? start,
    required String? end,
    String? accounts,
    enums.ExportFileFilter? type,
  }) {
    return _apiV1DataExportTransactionsGet(
        start: start,
        end: end,
        accounts: accounts,
        type: type?.value?.toString());
  }

  ///Export transaction data from Firefly III
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts Limit the export of transactions to these accounts only. Only asset accounts will be accepted. Other types will be silently dropped.
  ///@param type The file type the export file (CSV is currently the only option).
  @Get(path: '/api/v1/data/export/transactions')
  Future<chopper.Response<String>> _apiV1DataExportTransactionsGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts') String? accounts,
    @Query('type') String? type,
  });

  ///Endpoint to destroy user data
  ///@param objects The type of data that you wish to destroy. You can only use one at a time.
  Future<chopper.Response> apiV1DataDestroyDelete(
      {required enums.DataDestroyObject? objects}) {
    return _apiV1DataDestroyDelete(objects: objects?.value?.toString());
  }

  ///Endpoint to destroy user data
  ///@param objects The type of data that you wish to destroy. You can only use one at a time.
  @Delete(path: '/api/v1/data/destroy')
  Future<chopper.Response> _apiV1DataDestroyDelete(
      {@Query('objects') required String? objects});

  ///Bulk update transaction properties. For more information, see https://docs.firefly-iii.org/firefly-iii/api/specials
  ///@param query The JSON query.
  Future<chopper.Response> apiV1DataBulkTransactionsPost(
      {required String? query}) {
    return _apiV1DataBulkTransactionsPost(query: query);
  }

  ///Bulk update transaction properties. For more information, see https://docs.firefly-iii.org/firefly-iii/api/specials
  ///@param query The JSON query.
  @Post(
    path: '/api/v1/data/bulk/transactions',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1DataBulkTransactionsPost(
      {@Query('query') required String? query});

  ///Insight into expenses, grouped by bill.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param bills[] The bills to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> apiV1InsightExpenseBillGet({
    required String? start,
    required String? end,
    List<int>? bills,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightGroupEntry, () => InsightGroupEntry.fromJsonFactory);

    return _apiV1InsightExpenseBillGet(
        start: start, end: end, bills: bills, accounts: accounts);
  }

  ///Insight into expenses, grouped by bill.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param bills[] The bills to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/expense/bill')
  Future<chopper.Response<InsightGroup>> _apiV1InsightExpenseBillGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('bills[]') List<int>? bills,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, without bill.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> apiV1InsightExpenseNoBillGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightTotalEntry, () => InsightTotalEntry.fromJsonFactory);

    return _apiV1InsightExpenseNoBillGet(
        start: start, end: end, accounts: accounts);
  }

  ///Insight into expenses, without bill.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/expense/no-bill')
  Future<chopper.Response<InsightTotal>> _apiV1InsightExpenseNoBillGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into total expenses.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> apiV1InsightExpenseTotalGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightTotalEntry, () => InsightTotalEntry.fromJsonFactory);

    return _apiV1InsightExpenseTotalGet(
        start: start, end: end, accounts: accounts);
  }

  ///Insight into total expenses.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/expense/total')
  Future<chopper.Response<InsightTotal>> _apiV1InsightExpenseTotalGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into total income.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> apiV1InsightIncomeTotalGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightTotalEntry, () => InsightTotalEntry.fromJsonFactory);

    return _apiV1InsightIncomeTotalGet(
        start: start, end: end, accounts: accounts);
  }

  ///Insight into total income.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/income/total')
  Future<chopper.Response<InsightTotal>> _apiV1InsightIncomeTotalGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into total transfers.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> apiV1InsightTransferTotalGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightTotalEntry, () => InsightTotalEntry.fromJsonFactory);

    return _apiV1InsightTransferTotalGet(
        start: start, end: end, accounts: accounts);
  }

  ///Insight into total transfers.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/transfer/total')
  Future<chopper.Response<InsightTotal>> _apiV1InsightTransferTotalGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, grouped by category.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param categories[] The categories to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> apiV1InsightExpenseCategoryGet({
    required String? start,
    required String? end,
    List<int>? categories,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightGroupEntry, () => InsightGroupEntry.fromJsonFactory);

    return _apiV1InsightExpenseCategoryGet(
        start: start, end: end, categories: categories, accounts: accounts);
  }

  ///Insight into expenses, grouped by category.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param categories[] The categories to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/expense/category')
  Future<chopper.Response<InsightGroup>> _apiV1InsightExpenseCategoryGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('categories[]') List<int>? categories,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, without category.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> apiV1InsightExpenseNoCategoryGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightTotalEntry, () => InsightTotalEntry.fromJsonFactory);

    return _apiV1InsightExpenseNoCategoryGet(
        start: start, end: end, accounts: accounts);
  }

  ///Insight into expenses, without category.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/expense/no-category')
  Future<chopper.Response<InsightTotal>> _apiV1InsightExpenseNoCategoryGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into income, grouped by category.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param categories[] The categories to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> apiV1InsightIncomeCategoryGet({
    required String? start,
    required String? end,
    List<int>? categories,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightGroupEntry, () => InsightGroupEntry.fromJsonFactory);

    return _apiV1InsightIncomeCategoryGet(
        start: start, end: end, categories: categories, accounts: accounts);
  }

  ///Insight into income, grouped by category.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param categories[] The categories to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/income/category')
  Future<chopper.Response<InsightGroup>> _apiV1InsightIncomeCategoryGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('categories[]') List<int>? categories,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into income, without category.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> apiV1InsightIncomeNoCategoryGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightTotalEntry, () => InsightTotalEntry.fromJsonFactory);

    return _apiV1InsightIncomeNoCategoryGet(
        start: start, end: end, accounts: accounts);
  }

  ///Insight into income, without category.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/income/no-category')
  Future<chopper.Response<InsightTotal>> _apiV1InsightIncomeNoCategoryGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into transfers, grouped by category.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param categories[] The categories to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> apiV1InsightTransferCategoryGet({
    required String? start,
    required String? end,
    List<int>? categories,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightGroupEntry, () => InsightGroupEntry.fromJsonFactory);

    return _apiV1InsightTransferCategoryGet(
        start: start, end: end, categories: categories, accounts: accounts);
  }

  ///Insight into transfers, grouped by category.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param categories[] The categories to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/transfer/category')
  Future<chopper.Response<InsightGroup>> _apiV1InsightTransferCategoryGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('categories[]') List<int>? categories,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into transfers, without category.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> apiV1InsightTransferNoCategoryGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightTotalEntry, () => InsightTotalEntry.fromJsonFactory);

    return _apiV1InsightTransferNoCategoryGet(
        start: start, end: end, accounts: accounts);
  }

  ///Insight into transfers, without category.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/transfer/no-category')
  Future<chopper.Response<InsightTotal>> _apiV1InsightTransferNoCategoryGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, grouped by expense account.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you add the accounts ID's of expense accounts, only those accounts are included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. You can combine both asset / liability and expense account ID's. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> apiV1InsightExpenseExpenseGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightGroupEntry, () => InsightGroupEntry.fromJsonFactory);

    return _apiV1InsightExpenseExpenseGet(
        start: start, end: end, accounts: accounts);
  }

  ///Insight into expenses, grouped by expense account.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you add the accounts ID's of expense accounts, only those accounts are included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. You can combine both asset / liability and expense account ID's. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/expense/expense')
  Future<chopper.Response<InsightGroup>> _apiV1InsightExpenseExpenseGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, grouped by asset account.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> apiV1InsightExpenseAssetGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightGroupEntry, () => InsightGroupEntry.fromJsonFactory);

    return _apiV1InsightExpenseAssetGet(
        start: start, end: end, accounts: accounts);
  }

  ///Insight into expenses, grouped by asset account.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/expense/asset')
  Future<chopper.Response<InsightGroup>> _apiV1InsightExpenseAssetGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into income, grouped by revenue account.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you add the accounts ID's of revenue accounts, only those accounts are included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. You can combine both asset / liability and deposit account ID's. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> apiV1InsightIncomeRevenueGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightGroupEntry, () => InsightGroupEntry.fromJsonFactory);

    return _apiV1InsightIncomeRevenueGet(
        start: start, end: end, accounts: accounts);
  }

  ///Insight into income, grouped by revenue account.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you add the accounts ID's of revenue accounts, only those accounts are included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. You can combine both asset / liability and deposit account ID's. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/income/revenue')
  Future<chopper.Response<InsightGroup>> _apiV1InsightIncomeRevenueGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into income, grouped by asset account.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> apiV1InsightIncomeAssetGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightGroupEntry, () => InsightGroupEntry.fromJsonFactory);

    return _apiV1InsightIncomeAssetGet(
        start: start, end: end, accounts: accounts);
  }

  ///Insight into income, grouped by asset account.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/income/asset')
  Future<chopper.Response<InsightGroup>> _apiV1InsightIncomeAssetGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into transfers, grouped by account.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTransfer>> apiV1InsightTransferAssetGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightTransferEntry, () => InsightTransferEntry.fromJsonFactory);

    return _apiV1InsightTransferAssetGet(
        start: start, end: end, accounts: accounts);
  }

  ///Insight into transfers, grouped by account.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/transfer/asset')
  Future<chopper.Response<InsightTransfer>> _apiV1InsightTransferAssetGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, grouped by budget.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param budgets[] The budgets to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> apiV1InsightExpenseBudgetGet({
    required String? start,
    required String? end,
    List<int>? budgets,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightGroupEntry, () => InsightGroupEntry.fromJsonFactory);

    return _apiV1InsightExpenseBudgetGet(
        start: start, end: end, budgets: budgets, accounts: accounts);
  }

  ///Insight into expenses, grouped by budget.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param budgets[] The budgets to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/expense/budget')
  Future<chopper.Response<InsightGroup>> _apiV1InsightExpenseBudgetGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('budgets[]') List<int>? budgets,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, without budget.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> apiV1InsightExpenseNoBudgetGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightTotalEntry, () => InsightTotalEntry.fromJsonFactory);

    return _apiV1InsightExpenseNoBudgetGet(
        start: start, end: end, accounts: accounts);
  }

  ///Insight into expenses, without budget.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/expense/no-budget')
  Future<chopper.Response<InsightTotal>> _apiV1InsightExpenseNoBudgetGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, grouped by tag.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param tags[] The tags to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> apiV1InsightExpenseTagGet({
    required String? start,
    required String? end,
    List<int>? tags,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightGroupEntry, () => InsightGroupEntry.fromJsonFactory);

    return _apiV1InsightExpenseTagGet(
        start: start, end: end, tags: tags, accounts: accounts);
  }

  ///Insight into expenses, grouped by tag.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param tags[] The tags to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/expense/tag')
  Future<chopper.Response<InsightGroup>> _apiV1InsightExpenseTagGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('tags[]') List<int>? tags,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, without tag.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> apiV1InsightExpenseNoTagGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightTotalEntry, () => InsightTotalEntry.fromJsonFactory);

    return _apiV1InsightExpenseNoTagGet(
        start: start, end: end, accounts: accounts);
  }

  ///Insight into expenses, without tag.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only withdrawals from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/expense/no-tag')
  Future<chopper.Response<InsightTotal>> _apiV1InsightExpenseNoTagGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into income, grouped by tag.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param tags[] The tags to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> apiV1InsightIncomeTagGet({
    required String? start,
    required String? end,
    List<int>? tags,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightGroupEntry, () => InsightGroupEntry.fromJsonFactory);

    return _apiV1InsightIncomeTagGet(
        start: start, end: end, tags: tags, accounts: accounts);
  }

  ///Insight into income, grouped by tag.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param tags[] The tags to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/income/tag')
  Future<chopper.Response<InsightGroup>> _apiV1InsightIncomeTagGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('tags[]') List<int>? tags,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into income, without tag.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> apiV1InsightIncomeNoTagGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightTotalEntry, () => InsightTotalEntry.fromJsonFactory);

    return _apiV1InsightIncomeNoTagGet(
        start: start, end: end, accounts: accounts);
  }

  ///Insight into income, without tag.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only deposits to those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/income/no-tag')
  Future<chopper.Response<InsightTotal>> _apiV1InsightIncomeNoTagGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into transfers, grouped by tag.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param tags[] The tags to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightGroup>> apiV1InsightTransferTagGet({
    required String? start,
    required String? end,
    List<int>? tags,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightGroupEntry, () => InsightGroupEntry.fromJsonFactory);

    return _apiV1InsightTransferTagGet(
        start: start, end: end, tags: tags, accounts: accounts);
  }

  ///Insight into transfers, grouped by tag.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param tags[] The tags to be included in the results.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers between those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/transfer/tag')
  Future<chopper.Response<InsightGroup>> _apiV1InsightTransferTagGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('tags[]') List<int>? tags,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Insight into expenses, without tag.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  Future<chopper.Response<InsightTotal>> apiV1InsightTransferNoTagGet({
    required String? start,
    required String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        InsightTotalEntry, () => InsightTotalEntry.fromJsonFactory);

    return _apiV1InsightTransferNoTagGet(
        start: start, end: end, accounts: accounts);
  }

  ///Insight into expenses, without tag.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param accounts[] The accounts to be included in the results. If you include ID's of asset accounts or liabilities, only transfers from those asset accounts / liabilities will be included. Other account ID's will be ignored.
  @Get(path: '/api/v1/insight/transfer/no-tag')
  Future<chopper.Response<InsightTotal>> _apiV1InsightTransferNoTagGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Returns basic sums of the users data.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param currency_code A currency code like EUR or USD, to filter the result.
  Future<chopper.Response<BasicSummary>> apiV1SummaryBasicGet({
    required String? start,
    required String? end,
    String? currencyCode,
  }) {
    generatedMapping.putIfAbsent(
        BasicSummary, () => BasicSummary.fromJsonFactory);

    return _apiV1SummaryBasicGet(
        start: start, end: end, currencyCode: currencyCode);
  }

  ///Returns basic sums of the users data.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param currency_code A currency code like EUR or USD, to filter the result.
  @Get(path: '/api/v1/summary/basic')
  Future<chopper.Response<BasicSummary>> _apiV1SummaryBasicGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
    @Query('currency_code') String? currencyCode,
  });

  ///List all attachments.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<AttachmentArray>> apiV1AttachmentsGet({int? page}) {
    generatedMapping.putIfAbsent(
        AttachmentArray, () => AttachmentArray.fromJsonFactory);

    return _apiV1AttachmentsGet(page: page);
  }

  ///List all attachments.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/attachments')
  Future<chopper.Response<AttachmentArray>> _apiV1AttachmentsGet(
      {@Query('page') int? page});

  ///Store a new attachment.
  Future<chopper.Response<AttachmentSingle>> apiV1AttachmentsPost(
      {required AttachmentStore? body}) {
    generatedMapping.putIfAbsent(
        AttachmentSingle, () => AttachmentSingle.fromJsonFactory);

    return _apiV1AttachmentsPost(body: body);
  }

  ///Store a new attachment.
  @Post(
    path: '/api/v1/attachments',
    optionalBody: true,
  )
  Future<chopper.Response<AttachmentSingle>> _apiV1AttachmentsPost(
      {@Body() required AttachmentStore? body});

  ///Get a single attachment.
  ///@param id The ID of the attachment.
  Future<chopper.Response<AttachmentSingle>> apiV1AttachmentsIdGet(
      {required String? id}) {
    generatedMapping.putIfAbsent(
        AttachmentSingle, () => AttachmentSingle.fromJsonFactory);

    return _apiV1AttachmentsIdGet(id: id);
  }

  ///Get a single attachment.
  ///@param id The ID of the attachment.
  @Get(path: '/api/v1/attachments/{id}')
  Future<chopper.Response<AttachmentSingle>> _apiV1AttachmentsIdGet(
      {@Path('id') required String? id});

  ///Update existing attachment.
  ///@param id The ID of the attachment.
  Future<chopper.Response<AttachmentSingle>> apiV1AttachmentsIdPut({
    required String? id,
    required AttachmentUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
        AttachmentSingle, () => AttachmentSingle.fromJsonFactory);

    return _apiV1AttachmentsIdPut(id: id, body: body);
  }

  ///Update existing attachment.
  ///@param id The ID of the attachment.
  @Put(
    path: '/api/v1/attachments/{id}',
    optionalBody: true,
  )
  Future<chopper.Response<AttachmentSingle>> _apiV1AttachmentsIdPut({
    @Path('id') required String? id,
    @Body() required AttachmentUpdate? body,
  });

  ///Delete an attachment.
  ///@param id The ID of the single.
  Future<chopper.Response> apiV1AttachmentsIdDelete({required String? id}) {
    return _apiV1AttachmentsIdDelete(id: id);
  }

  ///Delete an attachment.
  ///@param id The ID of the single.
  @Delete(path: '/api/v1/attachments/{id}')
  Future<chopper.Response> _apiV1AttachmentsIdDelete(
      {@Path('id') required String? id});

  ///Download a single attachment.
  ///@param id The ID of the attachment.
  Future<chopper.Response<String>> apiV1AttachmentsIdDownloadGet(
      {required String? id}) {
    return _apiV1AttachmentsIdDownloadGet(id: id);
  }

  ///Download a single attachment.
  ///@param id The ID of the attachment.
  @Get(path: '/api/v1/attachments/{id}/download')
  Future<chopper.Response<String>> _apiV1AttachmentsIdDownloadGet(
      {@Path('id') required String? id});

  ///Upload an attachment.
  ///@param id The ID of the attachment.
  Future<chopper.Response> apiV1AttachmentsIdUploadPost({
    required String? id,
    required Object? body,
  }) {
    return _apiV1AttachmentsIdUploadPost(id: id, body: body);
  }

  ///Upload an attachment.
  ///@param id The ID of the attachment.
  @Post(
    path: '/api/v1/attachments/{id}/upload',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1AttachmentsIdUploadPost({
    @Path('id') required String? id,
    @Body() required Object? body,
  });

  ///Test which transactions would be hit by the rule. No changes will be made.
  ///@param id The ID of the rule.
  ///@param start A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///@param end A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///@param accounts[] Limit the testing of the rule to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  Future<chopper.Response<TransactionArray>> apiV1RulesIdTestGet({
    required String? id,
    String? start,
    String? end,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        TransactionArray, () => TransactionArray.fromJsonFactory);

    return _apiV1RulesIdTestGet(
        id: id, start: start, end: end, accounts: accounts);
  }

  ///Test which transactions would be hit by the rule. No changes will be made.
  ///@param id The ID of the rule.
  ///@param start A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///@param end A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///@param accounts[] Limit the testing of the rule to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  @Get(path: '/api/v1/rules/{id}/test')
  Future<chopper.Response<TransactionArray>> _apiV1RulesIdTestGet({
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Fire the rule on your transactions.
  ///@param id The ID of the rule.
  ///@param start A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. If the start date is not present, it will be set to one year ago. If you use this field, both the start date and the end date must be present.
  ///@param end A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. If the end date is not present, it will be set to today. If you use this field, both the start date and the end date must be present.
  ///@param accounts[] Limit the triggering of the rule to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  Future<chopper.Response> apiV1RulesIdTriggerPost({
    required String? id,
    String? start,
    String? end,
    List<int>? accounts,
  }) {
    return _apiV1RulesIdTriggerPost(
        id: id, start: start, end: end, accounts: accounts);
  }

  ///Fire the rule on your transactions.
  ///@param id The ID of the rule.
  ///@param start A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. If the start date is not present, it will be set to one year ago. If you use this field, both the start date and the end date must be present.
  ///@param end A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. If the end date is not present, it will be set to today. If you use this field, both the start date and the end date must be present.
  ///@param accounts[] Limit the triggering of the rule to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  @Post(
    path: '/api/v1/rules/{id}/trigger',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1RulesIdTriggerPost({
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///List all attachments uploaded to the bill.
  ///@param id The ID of the bill.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<AttachmentArray>> apiV1BillsIdAttachmentsGet({
    required String? id,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        AttachmentArray, () => AttachmentArray.fromJsonFactory);

    return _apiV1BillsIdAttachmentsGet(id: id, page: page);
  }

  ///List all attachments uploaded to the bill.
  ///@param id The ID of the bill.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/bills/{id}/attachments')
  Future<chopper.Response<AttachmentArray>> _apiV1BillsIdAttachmentsGet({
    @Path('id') required String? id,
    @Query('page') int? page,
  });

  ///List all rules associated with the bill.
  ///@param id The ID of the bill.
  Future<chopper.Response<RuleArray>> apiV1BillsIdRulesGet(
      {required String? id}) {
    generatedMapping.putIfAbsent(RuleArray, () => RuleArray.fromJsonFactory);

    return _apiV1BillsIdRulesGet(id: id);
  }

  ///List all rules associated with the bill.
  ///@param id The ID of the bill.
  @Get(path: '/api/v1/bills/{id}/rules')
  Future<chopper.Response<RuleArray>> _apiV1BillsIdRulesGet(
      {@Path('id') required String? id});

  ///List all transactions associated with the  bill.
  ///@param id The ID of the bill.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param type Optional filter on the transaction type(s) returned
  Future<chopper.Response<TransactionArray>> apiV1BillsIdTransactionsGet({
    required String? id,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
        TransactionArray, () => TransactionArray.fromJsonFactory);

    return _apiV1BillsIdTransactionsGet(
        id: id, start: start, end: end, type: type?.value?.toString());
  }

  ///List all transactions associated with the  bill.
  ///@param id The ID of the bill.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param type Optional filter on the transaction type(s) returned
  @Get(path: '/api/v1/bills/{id}/transactions')
  Future<chopper.Response<TransactionArray>> _apiV1BillsIdTransactionsGet({
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///List all bills.
  ///@param page Page number. The default pagination is 50.
  ///@param start A date formatted YYYY-MM-DD. If it is are added to the request, Firefly III will calculate the appropriate payment and paid dates.
  ///@param end A date formatted YYYY-MM-DD. If it is added to the request, Firefly III will calculate the appropriate payment and paid dates.
  Future<chopper.Response<BillArray>> apiV1BillsGet({
    int? page,
    String? start,
    String? end,
  }) {
    generatedMapping.putIfAbsent(BillArray, () => BillArray.fromJsonFactory);

    return _apiV1BillsGet(page: page, start: start, end: end);
  }

  ///List all bills.
  ///@param page Page number. The default pagination is 50.
  ///@param start A date formatted YYYY-MM-DD. If it is are added to the request, Firefly III will calculate the appropriate payment and paid dates.
  ///@param end A date formatted YYYY-MM-DD. If it is added to the request, Firefly III will calculate the appropriate payment and paid dates.
  @Get(path: '/api/v1/bills')
  Future<chopper.Response<BillArray>> _apiV1BillsGet({
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
  });

  ///Store a new bill
  Future<chopper.Response<BillSingle>> apiV1BillsPost(
      {required BillStore? body}) {
    generatedMapping.putIfAbsent(BillSingle, () => BillSingle.fromJsonFactory);

    return _apiV1BillsPost(body: body);
  }

  ///Store a new bill
  @Post(
    path: '/api/v1/bills',
    optionalBody: true,
  )
  Future<chopper.Response<BillSingle>> _apiV1BillsPost(
      {@Body() required BillStore? body});

  ///Get a single bill.
  ///@param id The ID of the bill.
  ///@param start A date formatted YYYY-MM-DD. If it is are added to the request, Firefly III will calculate the appropriate payment and paid dates.
  ///@param end A date formatted YYYY-MM-DD. If it is added to the request, Firefly III will calculate the appropriate payment and paid dates.
  Future<chopper.Response<BillSingle>> apiV1BillsIdGet({
    required String? id,
    String? start,
    String? end,
  }) {
    generatedMapping.putIfAbsent(BillSingle, () => BillSingle.fromJsonFactory);

    return _apiV1BillsIdGet(id: id, start: start, end: end);
  }

  ///Get a single bill.
  ///@param id The ID of the bill.
  ///@param start A date formatted YYYY-MM-DD. If it is are added to the request, Firefly III will calculate the appropriate payment and paid dates.
  ///@param end A date formatted YYYY-MM-DD. If it is added to the request, Firefly III will calculate the appropriate payment and paid dates.
  @Get(path: '/api/v1/bills/{id}')
  Future<chopper.Response<BillSingle>> _apiV1BillsIdGet({
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
  });

  ///Update existing bill.
  ///@param id The ID of the bill.
  Future<chopper.Response<BillSingle>> apiV1BillsIdPut({
    required String? id,
    required BillUpdate? body,
  }) {
    generatedMapping.putIfAbsent(BillSingle, () => BillSingle.fromJsonFactory);

    return _apiV1BillsIdPut(id: id, body: body);
  }

  ///Update existing bill.
  ///@param id The ID of the bill.
  @Put(
    path: '/api/v1/bills/{id}',
    optionalBody: true,
  )
  Future<chopper.Response<BillSingle>> _apiV1BillsIdPut({
    @Path('id') required String? id,
    @Body() required BillUpdate? body,
  });

  ///Delete a bill.
  ///@param id The ID of the bill.
  Future<chopper.Response> apiV1BillsIdDelete({required String? id}) {
    return _apiV1BillsIdDelete(id: id);
  }

  ///Delete a bill.
  ///@param id The ID of the bill.
  @Delete(path: '/api/v1/bills/{id}')
  Future<chopper.Response> _apiV1BillsIdDelete(
      {@Path('id') required String? id});

  ///List all rules.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<RuleArray>> apiV1RulesGet({int? page}) {
    generatedMapping.putIfAbsent(RuleArray, () => RuleArray.fromJsonFactory);

    return _apiV1RulesGet(page: page);
  }

  ///List all rules.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/rules')
  Future<chopper.Response<RuleArray>> _apiV1RulesGet(
      {@Query('page') int? page});

  ///Store a new rule
  Future<chopper.Response<RuleSingle>> apiV1RulesPost(
      {required RuleStore? body}) {
    generatedMapping.putIfAbsent(RuleSingle, () => RuleSingle.fromJsonFactory);

    return _apiV1RulesPost(body: body);
  }

  ///Store a new rule
  @Post(
    path: '/api/v1/rules',
    optionalBody: true,
  )
  Future<chopper.Response<RuleSingle>> _apiV1RulesPost(
      {@Body() required RuleStore? body});

  ///Get a single rule.
  ///@param id The ID of the object.X
  Future<chopper.Response<RuleSingle>> apiV1RulesIdGet({required String? id}) {
    generatedMapping.putIfAbsent(RuleSingle, () => RuleSingle.fromJsonFactory);

    return _apiV1RulesIdGet(id: id);
  }

  ///Get a single rule.
  ///@param id The ID of the object.X
  @Get(path: '/api/v1/rules/{id}')
  Future<chopper.Response<RuleSingle>> _apiV1RulesIdGet(
      {@Path('id') required String? id});

  ///Update existing rule.
  ///@param id The ID of the object.X
  Future<chopper.Response<RuleSingle>> apiV1RulesIdPut({
    required String? id,
    required RuleUpdate? body,
  }) {
    generatedMapping.putIfAbsent(RuleSingle, () => RuleSingle.fromJsonFactory);

    return _apiV1RulesIdPut(id: id, body: body);
  }

  ///Update existing rule.
  ///@param id The ID of the object.X
  @Put(
    path: '/api/v1/rules/{id}',
    optionalBody: true,
  )
  Future<chopper.Response<RuleSingle>> _apiV1RulesIdPut({
    @Path('id') required String? id,
    @Body() required RuleUpdate? body,
  });

  ///Delete an rule.
  ///@param id The ID of the rule.
  Future<chopper.Response> apiV1RulesIdDelete({required String? id}) {
    return _apiV1RulesIdDelete(id: id);
  }

  ///Delete an rule.
  ///@param id The ID of the rule.
  @Delete(path: '/api/v1/rules/{id}')
  Future<chopper.Response> _apiV1RulesIdDelete(
      {@Path('id') required String? id});

  ///List all the user's transactions.
  ///
  ///@param page Page number. The default pagination is 50.
  ///@param start A date formatted YYYY-MM-DD. This is the start date of the selected range (inclusive).
  ///@param end A date formatted YYYY-MM-DD. This is the end date of the selected range (inclusive).
  ///@param type Optional filter on the transaction type(s) returned.
  Future<chopper.Response<TransactionArray>> apiV1TransactionsGet({
    int? page,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
        TransactionArray, () => TransactionArray.fromJsonFactory);

    return _apiV1TransactionsGet(
        page: page, start: start, end: end, type: type?.value?.toString());
  }

  ///List all the user's transactions.
  ///
  ///@param page Page number. The default pagination is 50.
  ///@param start A date formatted YYYY-MM-DD. This is the start date of the selected range (inclusive).
  ///@param end A date formatted YYYY-MM-DD. This is the end date of the selected range (inclusive).
  ///@param type Optional filter on the transaction type(s) returned.
  @Get(path: '/api/v1/transactions')
  Future<chopper.Response<TransactionArray>> _apiV1TransactionsGet({
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///Store a new transaction
  Future<chopper.Response<TransactionSingle>> apiV1TransactionsPost(
      {required TransactionStore? body}) {
    generatedMapping.putIfAbsent(
        TransactionSingle, () => TransactionSingle.fromJsonFactory);

    return _apiV1TransactionsPost(body: body);
  }

  ///Store a new transaction
  @Post(
    path: '/api/v1/transactions',
    optionalBody: true,
  )
  Future<chopper.Response<TransactionSingle>> _apiV1TransactionsPost(
      {@Body() required TransactionStore? body});

  ///Get a single transaction.
  ///@param id The ID of the transaction.
  Future<chopper.Response<TransactionSingle>> apiV1TransactionsIdGet(
      {required String? id}) {
    generatedMapping.putIfAbsent(
        TransactionSingle, () => TransactionSingle.fromJsonFactory);

    return _apiV1TransactionsIdGet(id: id);
  }

  ///Get a single transaction.
  ///@param id The ID of the transaction.
  @Get(path: '/api/v1/transactions/{id}')
  Future<chopper.Response<TransactionSingle>> _apiV1TransactionsIdGet(
      {@Path('id') required String? id});

  ///Update existing transaction. For more information, see https://docs.firefly-iii.org/firefly-iii/api/specials
  ///@param id The ID of the transaction.
  Future<chopper.Response<TransactionSingle>> apiV1TransactionsIdPut({
    required String? id,
    required TransactionUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
        TransactionSingle, () => TransactionSingle.fromJsonFactory);

    return _apiV1TransactionsIdPut(id: id, body: body);
  }

  ///Update existing transaction. For more information, see https://docs.firefly-iii.org/firefly-iii/api/specials
  ///@param id The ID of the transaction.
  @Put(
    path: '/api/v1/transactions/{id}',
    optionalBody: true,
  )
  Future<chopper.Response<TransactionSingle>> _apiV1TransactionsIdPut({
    @Path('id') required String? id,
    @Body() required TransactionUpdate? body,
  });

  ///Delete a transaction.
  ///@param id The ID of the transaction.
  Future<chopper.Response> apiV1TransactionsIdDelete({required String? id}) {
    return _apiV1TransactionsIdDelete(id: id);
  }

  ///Delete a transaction.
  ///@param id The ID of the transaction.
  @Delete(path: '/api/v1/transactions/{id}')
  Future<chopper.Response> _apiV1TransactionsIdDelete(
      {@Path('id') required String? id});

  ///List all oject groups.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<ObjectGroupArray>> apiV1ObjectGroupsGet({int? page}) {
    generatedMapping.putIfAbsent(
        ObjectGroupArray, () => ObjectGroupArray.fromJsonFactory);

    return _apiV1ObjectGroupsGet(page: page);
  }

  ///List all oject groups.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/object_groups')
  Future<chopper.Response<ObjectGroupArray>> _apiV1ObjectGroupsGet(
      {@Query('page') int? page});

  ///Get a single object group.
  ///@param id The ID of the object group.
  Future<chopper.Response<ObjectGroupSingle>> apiV1ObjectGroupsIdGet(
      {required String? id}) {
    generatedMapping.putIfAbsent(
        ObjectGroupSingle, () => ObjectGroupSingle.fromJsonFactory);

    return _apiV1ObjectGroupsIdGet(id: id);
  }

  ///Get a single object group.
  ///@param id The ID of the object group.
  @Get(path: '/api/v1/object_groups/{id}')
  Future<chopper.Response<ObjectGroupSingle>> _apiV1ObjectGroupsIdGet(
      {@Path('id') required String? id});

  ///Update existing object group.
  ///@param id The ID of the object group
  Future<chopper.Response<ObjectGroupSingle>> apiV1ObjectGroupsIdPut({
    required String? id,
    required ObjectGroupUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
        ObjectGroupSingle, () => ObjectGroupSingle.fromJsonFactory);

    return _apiV1ObjectGroupsIdPut(id: id, body: body);
  }

  ///Update existing object group.
  ///@param id The ID of the object group
  @Put(
    path: '/api/v1/object_groups/{id}',
    optionalBody: true,
  )
  Future<chopper.Response<ObjectGroupSingle>> _apiV1ObjectGroupsIdPut({
    @Path('id') required String? id,
    @Body() required ObjectGroupUpdate? body,
  });

  ///Delete a object group.
  ///@param id The ID of the object group.
  Future<chopper.Response> apiV1ObjectGroupsIdDelete({required String? id}) {
    return _apiV1ObjectGroupsIdDelete(id: id);
  }

  ///Delete a object group.
  ///@param id The ID of the object group.
  @Delete(path: '/api/v1/object_groups/{id}')
  Future<chopper.Response> _apiV1ObjectGroupsIdDelete(
      {@Path('id') required String? id});

  ///List all transactions in a category.
  ///@param id The ID of the category.
  ///@param page Page number. The default pagination is per 50.
  ///@param start A date formatted YYYY-MM-DD, to limit the result list.
  ///@param end A date formatted YYYY-MM-DD, to limit the result list.
  ///@param type Optional filter on the transaction type(s) returned
  Future<chopper.Response<TransactionArray>> apiV1CategoriesIdTransactionsGet({
    required String? id,
    int? page,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
        TransactionArray, () => TransactionArray.fromJsonFactory);

    return _apiV1CategoriesIdTransactionsGet(
        id: id,
        page: page,
        start: start,
        end: end,
        type: type?.value?.toString());
  }

  ///List all transactions in a category.
  ///@param id The ID of the category.
  ///@param page Page number. The default pagination is per 50.
  ///@param start A date formatted YYYY-MM-DD, to limit the result list.
  ///@param end A date formatted YYYY-MM-DD, to limit the result list.
  ///@param type Optional filter on the transaction type(s) returned
  @Get(path: '/api/v1/categories/{id}/transactions')
  Future<chopper.Response<TransactionArray>> _apiV1CategoriesIdTransactionsGet({
    @Path('id') required String? id,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///All transactions without a category.
  ///@param limit Limits the number of results on one page.
  ///@param page Page number. The default pagination is 50.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param type Optional filter on the transaction type(s) returned
  Future<chopper.Response<TransactionArray>>
      apiV1CategoriesTransactionsWithoutCategoryGet({
    int? limit,
    int? page,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
        TransactionArray, () => TransactionArray.fromJsonFactory);

    return _apiV1CategoriesTransactionsWithoutCategoryGet(
        limit: limit,
        page: page,
        start: start,
        end: end,
        type: type?.value?.toString());
  }

  ///All transactions without a category.
  ///@param limit Limits the number of results on one page.
  ///@param page Page number. The default pagination is 50.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param type Optional filter on the transaction type(s) returned
  @Get(path: '/api/v1/categories/transactions-without-category')
  Future<chopper.Response<TransactionArray>>
      _apiV1CategoriesTransactionsWithoutCategoryGet({
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///Lists all attachments.
  ///@param id The ID of the category.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<AttachmentArray>> apiV1CategoriesIdAttachmentsGet({
    required String? id,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        AttachmentArray, () => AttachmentArray.fromJsonFactory);

    return _apiV1CategoriesIdAttachmentsGet(id: id, page: page);
  }

  ///Lists all attachments.
  ///@param id The ID of the category.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/categories/{id}/attachments')
  Future<chopper.Response<AttachmentArray>> _apiV1CategoriesIdAttachmentsGet({
    @Path('id') required String? id,
    @Query('page') int? page,
  });

  ///List all recurring transactions.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<RecurrenceArray>> apiV1RecurrencesGet({int? page}) {
    generatedMapping.putIfAbsent(
        RecurrenceArray, () => RecurrenceArray.fromJsonFactory);

    return _apiV1RecurrencesGet(page: page);
  }

  ///List all recurring transactions.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/recurrences')
  Future<chopper.Response<RecurrenceArray>> _apiV1RecurrencesGet(
      {@Query('page') int? page});

  ///Store a new recurring transaction
  Future<chopper.Response<RecurrenceSingle>> apiV1RecurrencesPost(
      {required RecurrenceStore? body}) {
    generatedMapping.putIfAbsent(
        RecurrenceSingle, () => RecurrenceSingle.fromJsonFactory);

    return _apiV1RecurrencesPost(body: body);
  }

  ///Store a new recurring transaction
  @Post(
    path: '/api/v1/recurrences',
    optionalBody: true,
  )
  Future<chopper.Response<RecurrenceSingle>> _apiV1RecurrencesPost(
      {@Body() required RecurrenceStore? body});

  ///Get a single recurring transaction.
  ///@param id The ID of the recurring transaction.
  Future<chopper.Response<RecurrenceSingle>> apiV1RecurrencesIdGet(
      {required String? id}) {
    generatedMapping.putIfAbsent(
        RecurrenceSingle, () => RecurrenceSingle.fromJsonFactory);

    return _apiV1RecurrencesIdGet(id: id);
  }

  ///Get a single recurring transaction.
  ///@param id The ID of the recurring transaction.
  @Get(path: '/api/v1/recurrences/{id}')
  Future<chopper.Response<RecurrenceSingle>> _apiV1RecurrencesIdGet(
      {@Path('id') required String? id});

  ///Update existing recurring transaction.
  ///@param id The ID of the recurring transaction.
  Future<chopper.Response<RecurrenceSingle>> apiV1RecurrencesIdPut({
    required String? id,
    required RecurrenceUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
        RecurrenceSingle, () => RecurrenceSingle.fromJsonFactory);

    return _apiV1RecurrencesIdPut(id: id, body: body);
  }

  ///Update existing recurring transaction.
  ///@param id The ID of the recurring transaction.
  @Put(
    path: '/api/v1/recurrences/{id}',
    optionalBody: true,
  )
  Future<chopper.Response<RecurrenceSingle>> _apiV1RecurrencesIdPut({
    @Path('id') required String? id,
    @Body() required RecurrenceUpdate? body,
  });

  ///Delete a recurring transaction.
  ///@param id The ID of the recurring transaction.
  Future<chopper.Response> apiV1RecurrencesIdDelete({required String? id}) {
    return _apiV1RecurrencesIdDelete(id: id);
  }

  ///Delete a recurring transaction.
  ///@param id The ID of the recurring transaction.
  @Delete(path: '/api/v1/recurrences/{id}')
  Future<chopper.Response> _apiV1RecurrencesIdDelete(
      {@Path('id') required String? id});

  ///Lists all attachments.
  ///@param id The ID of the transaction.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<AttachmentArray>> apiV1TransactionsIdAttachmentsGet({
    required String? id,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        AttachmentArray, () => AttachmentArray.fromJsonFactory);

    return _apiV1TransactionsIdAttachmentsGet(id: id, page: page);
  }

  ///Lists all attachments.
  ///@param id The ID of the transaction.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/transactions/{id}/attachments')
  Future<chopper.Response<AttachmentArray>> _apiV1TransactionsIdAttachmentsGet({
    @Path('id') required String? id,
    @Query('page') int? page,
  });

  ///Lists all piggy bank events.
  ///@param id The ID of the transaction.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<PiggyBankEventArray>>
      apiV1TransactionsIdPiggyBankEventsGet({
    required String? id,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        PiggyBankEventArray, () => PiggyBankEventArray.fromJsonFactory);

    return _apiV1TransactionsIdPiggyBankEventsGet(id: id, page: page);
  }

  ///Lists all piggy bank events.
  ///@param id The ID of the transaction.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/transactions/{id}/piggy_bank_events')
  Future<chopper.Response<PiggyBankEventArray>>
      _apiV1TransactionsIdPiggyBankEventsGet({
    @Path('id') required String? id,
    @Query('page') int? page,
  });

  ///List all transactions created by a recurring transaction.
  ///@param id The ID of the recurring transaction.
  ///@param page Page number. The default pagination is 50.
  ///@param start A date formatted YYYY-MM-DD. Both the start and end date must be present.
  ///@param end A date formatted YYYY-MM-DD. Both the start and end date must be present.
  ///@param type Optional filter on the transaction type(s) returned
  Future<chopper.Response<TransactionArray>> apiV1RecurrencesIdTransactionsGet({
    required String? id,
    int? page,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
        TransactionArray, () => TransactionArray.fromJsonFactory);

    return _apiV1RecurrencesIdTransactionsGet(
        id: id,
        page: page,
        start: start,
        end: end,
        type: type?.value?.toString());
  }

  ///List all transactions created by a recurring transaction.
  ///@param id The ID of the recurring transaction.
  ///@param page Page number. The default pagination is 50.
  ///@param start A date formatted YYYY-MM-DD. Both the start and end date must be present.
  ///@param end A date formatted YYYY-MM-DD. Both the start and end date must be present.
  ///@param type Optional filter on the transaction type(s) returned
  @Get(path: '/api/v1/recurrences/{id}/transactions')
  Future<chopper.Response<TransactionArray>>
      _apiV1RecurrencesIdTransactionsGet({
    @Path('id') required String? id,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///List all piggy banks.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<PiggyBankArray>> apiV1PiggyBanksGet({int? page}) {
    generatedMapping.putIfAbsent(
        PiggyBankArray, () => PiggyBankArray.fromJsonFactory);

    return _apiV1PiggyBanksGet(page: page);
  }

  ///List all piggy banks.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/piggy-banks')
  Future<chopper.Response<PiggyBankArray>> _apiV1PiggyBanksGet(
      {@Query('page') int? page});

  ///Store a new piggy bank
  Future<chopper.Response<PiggyBankSingle>> apiV1PiggyBanksPost(
      {required PiggyBankStore? body}) {
    generatedMapping.putIfAbsent(
        PiggyBankSingle, () => PiggyBankSingle.fromJsonFactory);

    return _apiV1PiggyBanksPost(body: body);
  }

  ///Store a new piggy bank
  @Post(
    path: '/api/v1/piggy-banks',
    optionalBody: true,
  )
  Future<chopper.Response<PiggyBankSingle>> _apiV1PiggyBanksPost(
      {@Body() required PiggyBankStore? body});

  ///Get a single piggy bank.
  ///@param id The ID of the piggy bank.
  Future<chopper.Response<PiggyBankSingle>> apiV1PiggyBanksIdGet(
      {required String? id}) {
    generatedMapping.putIfAbsent(
        PiggyBankSingle, () => PiggyBankSingle.fromJsonFactory);

    return _apiV1PiggyBanksIdGet(id: id);
  }

  ///Get a single piggy bank.
  ///@param id The ID of the piggy bank.
  @Get(path: '/api/v1/piggy-banks/{id}')
  Future<chopper.Response<PiggyBankSingle>> _apiV1PiggyBanksIdGet(
      {@Path('id') required String? id});

  ///Update existing piggy bank.
  ///@param id The ID of the piggy bank
  Future<chopper.Response<PiggyBankSingle>> apiV1PiggyBanksIdPut({
    required String? id,
    required PiggyBankUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
        PiggyBankSingle, () => PiggyBankSingle.fromJsonFactory);

    return _apiV1PiggyBanksIdPut(id: id, body: body);
  }

  ///Update existing piggy bank.
  ///@param id The ID of the piggy bank
  @Put(
    path: '/api/v1/piggy-banks/{id}',
    optionalBody: true,
  )
  Future<chopper.Response<PiggyBankSingle>> _apiV1PiggyBanksIdPut({
    @Path('id') required String? id,
    @Body() required PiggyBankUpdate? body,
  });

  ///Delete a piggy bank.
  ///@param id The ID of the piggy bank.
  Future<chopper.Response> apiV1PiggyBanksIdDelete({required String? id}) {
    return _apiV1PiggyBanksIdDelete(id: id);
  }

  ///Delete a piggy bank.
  ///@param id The ID of the piggy bank.
  @Delete(path: '/api/v1/piggy-banks/{id}')
  Future<chopper.Response> _apiV1PiggyBanksIdDelete(
      {@Path('id') required String? id});

  ///List all currencies.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<CurrencyArray>> apiV1CurrenciesGet({int? page}) {
    generatedMapping.putIfAbsent(
        CurrencyArray, () => CurrencyArray.fromJsonFactory);

    return _apiV1CurrenciesGet(page: page);
  }

  ///List all currencies.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/currencies')
  Future<chopper.Response<CurrencyArray>> _apiV1CurrenciesGet(
      {@Query('page') int? page});

  ///Store a new currency
  Future<chopper.Response<CurrencySingle>> apiV1CurrenciesPost(
      {required CurrencyStore? body}) {
    generatedMapping.putIfAbsent(
        CurrencySingle, () => CurrencySingle.fromJsonFactory);

    return _apiV1CurrenciesPost(body: body);
  }

  ///Store a new currency
  @Post(
    path: '/api/v1/currencies',
    optionalBody: true,
  )
  Future<chopper.Response<CurrencySingle>> _apiV1CurrenciesPost(
      {@Body() required CurrencyStore? body});

  ///Enable a single currency.
  ///@param code The currency code.
  Future<chopper.Response> apiV1CurrenciesCodeEnablePost(
      {required String? code}) {
    return _apiV1CurrenciesCodeEnablePost(code: code);
  }

  ///Enable a single currency.
  ///@param code The currency code.
  @Post(
    path: '/api/v1/currencies/{code}/enable',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1CurrenciesCodeEnablePost(
      {@Path('code') required String? code});

  ///Disable a currency.
  ///@param code The currency code.
  Future<chopper.Response> apiV1CurrenciesCodeDisablePost(
      {required int? code}) {
    return _apiV1CurrenciesCodeDisablePost(code: code);
  }

  ///Disable a currency.
  ///@param code The currency code.
  @Post(
    path: '/api/v1/currencies/{code}/disable',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1CurrenciesCodeDisablePost(
      {@Path('code') required int? code});

  ///Make currency default currency.
  ///@param code The currency code.
  Future<chopper.Response> apiV1CurrenciesCodeDefaultPost(
      {required String? code}) {
    return _apiV1CurrenciesCodeDefaultPost(code: code);
  }

  ///Make currency default currency.
  ///@param code The currency code.
  @Post(
    path: '/api/v1/currencies/{code}/default',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1CurrenciesCodeDefaultPost(
      {@Path('code') required String? code});

  ///Get a single currency.
  ///@param code The currency code.
  Future<chopper.Response<CurrencySingle>> apiV1CurrenciesCodeGet(
      {required String? code}) {
    generatedMapping.putIfAbsent(
        CurrencySingle, () => CurrencySingle.fromJsonFactory);

    return _apiV1CurrenciesCodeGet(code: code);
  }

  ///Get a single currency.
  ///@param code The currency code.
  @Get(path: '/api/v1/currencies/{code}')
  Future<chopper.Response<CurrencySingle>> _apiV1CurrenciesCodeGet(
      {@Path('code') required String? code});

  ///Update existing currency.
  ///@param code The currency code.
  Future<chopper.Response<CurrencySingle>> apiV1CurrenciesCodePut({
    required String? code,
    required CurrencyUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
        CurrencySingle, () => CurrencySingle.fromJsonFactory);

    return _apiV1CurrenciesCodePut(code: code, body: body);
  }

  ///Update existing currency.
  ///@param code The currency code.
  @Put(
    path: '/api/v1/currencies/{code}',
    optionalBody: true,
  )
  Future<chopper.Response<CurrencySingle>> _apiV1CurrenciesCodePut({
    @Path('code') required String? code,
    @Body() required CurrencyUpdate? body,
  });

  ///Delete a currency.
  ///@param code The currency code.
  Future<chopper.Response> apiV1CurrenciesCodeDelete({required String? code}) {
    return _apiV1CurrenciesCodeDelete(code: code);
  }

  ///Delete a currency.
  ///@param code The currency code.
  @Delete(path: '/api/v1/currencies/{code}')
  Future<chopper.Response> _apiV1CurrenciesCodeDelete(
      {@Path('code') required String? code});

  ///Get the user's default currency.
  Future<chopper.Response<CurrencySingle>> apiV1CurrenciesDefaultGet() {
    generatedMapping.putIfAbsent(
        CurrencySingle, () => CurrencySingle.fromJsonFactory);

    return _apiV1CurrenciesDefaultGet();
  }

  ///Get the user's default currency.
  @Get(path: '/api/v1/currencies/default')
  Future<chopper.Response<CurrencySingle>> _apiV1CurrenciesDefaultGet();

  ///List all categories.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<CategoryArray>> apiV1CategoriesGet({int? page}) {
    generatedMapping.putIfAbsent(
        CategoryArray, () => CategoryArray.fromJsonFactory);

    return _apiV1CategoriesGet(page: page);
  }

  ///List all categories.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/categories')
  Future<chopper.Response<CategoryArray>> _apiV1CategoriesGet(
      {@Query('page') int? page});

  ///Store a new category
  Future<chopper.Response<CategorySingle>> apiV1CategoriesPost(
      {required Category? body}) {
    generatedMapping.putIfAbsent(
        CategorySingle, () => CategorySingle.fromJsonFactory);

    return _apiV1CategoriesPost(body: body);
  }

  ///Store a new category
  @Post(
    path: '/api/v1/categories',
    optionalBody: true,
  )
  Future<chopper.Response<CategorySingle>> _apiV1CategoriesPost(
      {@Body() required Category? body});

  ///Get a single category.
  ///@param id The ID of the category.
  ///@param start A date formatted YYYY-MM-DD, to show spent and earned info.
  ///@param end A date formatted YYYY-MM-DD, to show spent and earned info.
  Future<chopper.Response<CategorySingle>> apiV1CategoriesIdGet({
    required String? id,
    String? start,
    String? end,
  }) {
    generatedMapping.putIfAbsent(
        CategorySingle, () => CategorySingle.fromJsonFactory);

    return _apiV1CategoriesIdGet(id: id, start: start, end: end);
  }

  ///Get a single category.
  ///@param id The ID of the category.
  ///@param start A date formatted YYYY-MM-DD, to show spent and earned info.
  ///@param end A date formatted YYYY-MM-DD, to show spent and earned info.
  @Get(path: '/api/v1/categories/{id}')
  Future<chopper.Response<CategorySingle>> _apiV1CategoriesIdGet({
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
  });

  ///Update existing category.
  ///@param id The ID of the category.
  Future<chopper.Response<CategorySingle>> apiV1CategoriesIdPut({
    required String? id,
    required CategoryUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
        CategorySingle, () => CategorySingle.fromJsonFactory);

    return _apiV1CategoriesIdPut(id: id, body: body);
  }

  ///Update existing category.
  ///@param id The ID of the category.
  @Put(
    path: '/api/v1/categories/{id}',
    optionalBody: true,
  )
  Future<chopper.Response<CategorySingle>> _apiV1CategoriesIdPut({
    @Path('id') required String? id,
    @Body() required CategoryUpdate? body,
  });

  ///Delete a category.
  ///@param id The ID of the category.
  Future<chopper.Response> apiV1CategoriesIdDelete({required String? id}) {
    return _apiV1CategoriesIdDelete(id: id);
  }

  ///Delete a category.
  ///@param id The ID of the category.
  @Delete(path: '/api/v1/categories/{id}')
  Future<chopper.Response> _apiV1CategoriesIdDelete(
      {@Path('id') required String? id});

  ///List all tags.
  ///@param page Page number
  Future<chopper.Response<TagArray>> apiV1TagsGet({int? page}) {
    generatedMapping.putIfAbsent(TagArray, () => TagArray.fromJsonFactory);

    return _apiV1TagsGet(page: page);
  }

  ///List all tags.
  ///@param page Page number
  @Get(path: '/api/v1/tags')
  Future<chopper.Response<TagArray>> _apiV1TagsGet({@Query('page') int? page});

  ///Store a new tag
  Future<chopper.Response<TagSingle>> apiV1TagsPost(
      {required TagModelStore? body}) {
    generatedMapping.putIfAbsent(TagSingle, () => TagSingle.fromJsonFactory);

    return _apiV1TagsPost(body: body);
  }

  ///Store a new tag
  @Post(
    path: '/api/v1/tags',
    optionalBody: true,
  )
  Future<chopper.Response<TagSingle>> _apiV1TagsPost(
      {@Body() required TagModelStore? body});

  ///Get a single tag.
  ///@param tag Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your milage may vary.
  ///@param page Page number
  Future<chopper.Response<TagSingle>> apiV1TagsTagGet({
    required String? tag,
    int? page,
  }) {
    generatedMapping.putIfAbsent(TagSingle, () => TagSingle.fromJsonFactory);

    return _apiV1TagsTagGet(tag: tag, page: page);
  }

  ///Get a single tag.
  ///@param tag Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your milage may vary.
  ///@param page Page number
  @Get(path: '/api/v1/tags/{tag}')
  Future<chopper.Response<TagSingle>> _apiV1TagsTagGet({
    @Path('tag') required String? tag,
    @Query('page') int? page,
  });

  ///Update existing tag.
  ///@param tag Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your milage may vary.
  Future<chopper.Response<TagSingle>> apiV1TagsTagPut({
    required String? tag,
    required TagModelUpdate? body,
  }) {
    generatedMapping.putIfAbsent(TagSingle, () => TagSingle.fromJsonFactory);

    return _apiV1TagsTagPut(tag: tag, body: body);
  }

  ///Update existing tag.
  ///@param tag Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your milage may vary.
  @Put(
    path: '/api/v1/tags/{tag}',
    optionalBody: true,
  )
  Future<chopper.Response<TagSingle>> _apiV1TagsTagPut({
    @Path('tag') required String? tag,
    @Body() required TagModelUpdate? body,
  });

  ///Delete an tag.
  ///@param tag Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your milage may vary.
  Future<chopper.Response> apiV1TagsTagDelete({required String? tag}) {
    return _apiV1TagsTagDelete(tag: tag);
  }

  ///Delete an tag.
  ///@param tag Either the tag itself or the tag ID. If you use the tag itself, and it contains international (non-ASCII) characters, your milage may vary.
  @Delete(path: '/api/v1/tags/{tag}')
  Future<chopper.Response> _apiV1TagsTagDelete(
      {@Path('tag') required String? tag});

  ///Lists all the transaction links for an individual journal (individual split).
  ///@param id The ID of the transaction journal / the split.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<TransactionLinkArray>>
      apiV1TransactionJournalsIdLinksGet({
    required String? id,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        TransactionLinkArray, () => TransactionLinkArray.fromJsonFactory);

    return _apiV1TransactionJournalsIdLinksGet(id: id, page: page);
  }

  ///Lists all the transaction links for an individual journal (individual split).
  ///@param id The ID of the transaction journal / the split.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/transaction-journals/{id}/links')
  Future<chopper.Response<TransactionLinkArray>>
      _apiV1TransactionJournalsIdLinksGet({
    @Path('id') required String? id,
    @Query('page') int? page,
  });

  ///Get a single transaction, based on one of the underlying transaction journals (transaction splits).
  ///@param id The ID of the transaction journal (split).
  Future<chopper.Response<TransactionSingle>> apiV1TransactionJournalsIdGet(
      {required String? id}) {
    generatedMapping.putIfAbsent(
        TransactionSingle, () => TransactionSingle.fromJsonFactory);

    return _apiV1TransactionJournalsIdGet(id: id);
  }

  ///Get a single transaction, based on one of the underlying transaction journals (transaction splits).
  ///@param id The ID of the transaction journal (split).
  @Get(path: '/api/v1/transaction-journals/{id}')
  Future<chopper.Response<TransactionSingle>> _apiV1TransactionJournalsIdGet(
      {@Path('id') required String? id});

  ///Delete split from transaction
  ///@param id The ID of the transaction journal (the split) you wish to delete.
  Future<chopper.Response> apiV1TransactionJournalsIdDelete(
      {required String? id}) {
    return _apiV1TransactionJournalsIdDelete(id: id);
  }

  ///Delete split from transaction
  ///@param id The ID of the transaction journal (the split) you wish to delete.
  @Delete(path: '/api/v1/transaction-journals/{id}')
  Future<chopper.Response> _apiV1TransactionJournalsIdDelete(
      {@Path('id') required String? id});

  ///List all accounts.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param date A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  ///@param type Optional filter on the account type(s) returned
  Future<chopper.Response<AccountArray>> apiV1AccountsGet({
    int? page,
    String? date,
    enums.AccountTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
        AccountArray, () => AccountArray.fromJsonFactory);

    return _apiV1AccountsGet(
        page: page, date: date, type: type?.value?.toString());
  }

  ///List all accounts.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param date A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  ///@param type Optional filter on the account type(s) returned
  @Get(path: '/api/v1/accounts')
  Future<chopper.Response<AccountArray>> _apiV1AccountsGet({
    @Query('page') int? page,
    @Query('date') String? date,
    @Query('type') String? type,
  });

  ///Create new account.
  Future<chopper.Response<AccountSingle>> apiV1AccountsPost(
      {required AccountStore? body}) {
    generatedMapping.putIfAbsent(
        AccountSingle, () => AccountSingle.fromJsonFactory);

    return _apiV1AccountsPost(body: body);
  }

  ///Create new account.
  @Post(
    path: '/api/v1/accounts',
    optionalBody: true,
  )
  Future<chopper.Response<AccountSingle>> _apiV1AccountsPost(
      {@Body() required AccountStore? body});

  ///Get single account.
  ///@param id The ID of the account.
  ///@param date A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  Future<chopper.Response<AccountSingle>> apiV1AccountsIdGet({
    required String? id,
    String? date,
  }) {
    generatedMapping.putIfAbsent(
        AccountSingle, () => AccountSingle.fromJsonFactory);

    return _apiV1AccountsIdGet(id: id, date: date);
  }

  ///Get single account.
  ///@param id The ID of the account.
  ///@param date A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  @Get(path: '/api/v1/accounts/{id}')
  Future<chopper.Response<AccountSingle>> _apiV1AccountsIdGet({
    @Path('id') required String? id,
    @Query('date') String? date,
  });

  ///Update existing account.
  ///@param id The ID of the account.
  Future<chopper.Response<AccountSingle>> apiV1AccountsIdPut({
    required String? id,
    required AccountUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
        AccountSingle, () => AccountSingle.fromJsonFactory);

    return _apiV1AccountsIdPut(id: id, body: body);
  }

  ///Update existing account.
  ///@param id The ID of the account.
  @Put(
    path: '/api/v1/accounts/{id}',
    optionalBody: true,
  )
  Future<chopper.Response<AccountSingle>> _apiV1AccountsIdPut({
    @Path('id') required String? id,
    @Body() required AccountUpdate? body,
  });

  ///Permanently delete account.
  ///@param id The ID of the account.
  Future<chopper.Response> apiV1AccountsIdDelete({required String? id}) {
    return _apiV1AccountsIdDelete(id: id);
  }

  ///Permanently delete account.
  ///@param id The ID of the account.
  @Delete(path: '/api/v1/accounts/{id}')
  Future<chopper.Response> _apiV1AccountsIdDelete(
      {@Path('id') required String? id});

  ///List all accounts with this currency.
  ///@param code The currency code.
  ///@param page Page number. The default pagination is 50.
  ///@param date A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  ///@param type Optional filter on the account type(s) returned
  Future<chopper.Response<AccountArray>> apiV1CurrenciesCodeAccountsGet({
    required String? code,
    int? page,
    String? date,
    enums.AccountTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
        AccountArray, () => AccountArray.fromJsonFactory);

    return _apiV1CurrenciesCodeAccountsGet(
        code: code, page: page, date: date, type: type?.value?.toString());
  }

  ///List all accounts with this currency.
  ///@param code The currency code.
  ///@param page Page number. The default pagination is 50.
  ///@param date A date formatted YYYY-MM-DD. When added to the request, Firefly III will show the account's balance on that day.
  ///@param type Optional filter on the account type(s) returned
  @Get(path: '/api/v1/currencies/{code}/accounts')
  Future<chopper.Response<AccountArray>> _apiV1CurrenciesCodeAccountsGet({
    @Path('code') required String? code,
    @Query('page') int? page,
    @Query('date') String? date,
    @Query('type') String? type,
  });

  ///List all available budgets with this currency.
  ///@param code The currency code.
  ///@param page Page number. The default pagination is 50
  Future<chopper.Response<AvailableBudgetArray>>
      apiV1CurrenciesCodeAvailableBudgetsGet({
    required String? code,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        AvailableBudgetArray, () => AvailableBudgetArray.fromJsonFactory);

    return _apiV1CurrenciesCodeAvailableBudgetsGet(code: code, page: page);
  }

  ///List all available budgets with this currency.
  ///@param code The currency code.
  ///@param page Page number. The default pagination is 50
  @Get(path: '/api/v1/currencies/{code}/available_budgets')
  Future<chopper.Response<AvailableBudgetArray>>
      _apiV1CurrenciesCodeAvailableBudgetsGet({
    @Path('code') required String? code,
    @Query('page') int? page,
  });

  ///List all bills with this currency.
  ///@param code The currency code.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<BillArray>> apiV1CurrenciesCodeBillsGet({
    required String? code,
    int? page,
  }) {
    generatedMapping.putIfAbsent(BillArray, () => BillArray.fromJsonFactory);

    return _apiV1CurrenciesCodeBillsGet(code: code, page: page);
  }

  ///List all bills with this currency.
  ///@param code The currency code.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/currencies/{code}/bills')
  Future<chopper.Response<BillArray>> _apiV1CurrenciesCodeBillsGet({
    @Path('code') required String? code,
    @Query('page') int? page,
  });

  ///List all budget limits with this currency
  ///@param code The currency code.
  ///@param page Page number. The default pagination is 50.
  ///@param start Start date for the budget limit list.
  ///@param end End date for the budget limit list.
  Future<chopper.Response<BudgetLimitArray>>
      apiV1CurrenciesCodeBudgetLimitsGet({
    required String? code,
    int? page,
    String? start,
    String? end,
  }) {
    generatedMapping.putIfAbsent(
        BudgetLimitArray, () => BudgetLimitArray.fromJsonFactory);

    return _apiV1CurrenciesCodeBudgetLimitsGet(
        code: code, page: page, start: start, end: end);
  }

  ///List all budget limits with this currency
  ///@param code The currency code.
  ///@param page Page number. The default pagination is 50.
  ///@param start Start date for the budget limit list.
  ///@param end End date for the budget limit list.
  @Get(path: '/api/v1/currencies/{code}/budget_limits')
  Future<chopper.Response<BudgetLimitArray>>
      _apiV1CurrenciesCodeBudgetLimitsGet({
    @Path('code') required String? code,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
  });

  ///List all recurring transactions with this currency.
  ///@param code The currency code.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<RecurrenceArray>> apiV1CurrenciesCodeRecurrencesGet({
    required String? code,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        RecurrenceArray, () => RecurrenceArray.fromJsonFactory);

    return _apiV1CurrenciesCodeRecurrencesGet(code: code, page: page);
  }

  ///List all recurring transactions with this currency.
  ///@param code The currency code.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/currencies/{code}/recurrences')
  Future<chopper.Response<RecurrenceArray>> _apiV1CurrenciesCodeRecurrencesGet({
    @Path('code') required String? code,
    @Query('page') int? page,
  });

  ///List all rules with this currency.
  ///@param code The currency code.
  ///@param page Page number. The default pagination per 50.
  Future<chopper.Response<RuleArray>> apiV1CurrenciesCodeRulesGet({
    required String? code,
    int? page,
  }) {
    generatedMapping.putIfAbsent(RuleArray, () => RuleArray.fromJsonFactory);

    return _apiV1CurrenciesCodeRulesGet(code: code, page: page);
  }

  ///List all rules with this currency.
  ///@param code The currency code.
  ///@param page Page number. The default pagination per 50.
  @Get(path: '/api/v1/currencies/{code}/rules')
  Future<chopper.Response<RuleArray>> _apiV1CurrenciesCodeRulesGet({
    @Path('code') required String? code,
    @Query('page') int? page,
  });

  ///List all transactions with this currency.
  ///@param code The currency code.
  ///@param page Page number. The default pagination is per 50.
  ///@param start A date formatted YYYY-MM-DD, to limit the list of transactions.
  ///@param end A date formatted YYYY-MM-DD, to limit the list of transactions.
  ///@param type Optional filter on the transaction type(s) returned
  Future<chopper.Response<TransactionArray>>
      apiV1CurrenciesCodeTransactionsGet({
    required String? code,
    int? page,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
        TransactionArray, () => TransactionArray.fromJsonFactory);

    return _apiV1CurrenciesCodeTransactionsGet(
        code: code,
        page: page,
        start: start,
        end: end,
        type: type?.value?.toString());
  }

  ///List all transactions with this currency.
  ///@param code The currency code.
  ///@param page Page number. The default pagination is per 50.
  ///@param start A date formatted YYYY-MM-DD, to limit the list of transactions.
  ///@param end A date formatted YYYY-MM-DD, to limit the list of transactions.
  ///@param type Optional filter on the transaction type(s) returned
  @Get(path: '/api/v1/currencies/{code}/transactions')
  Future<chopper.Response<TransactionArray>>
      _apiV1CurrenciesCodeTransactionsGet({
    @Path('code') required String? code,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///Get all limits for a budget.
  ///@param id The ID of the requested budget.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<BudgetLimitArray>> apiV1BudgetsIdLimitsGet({
    required String? id,
    String? start,
    String? end,
  }) {
    generatedMapping.putIfAbsent(
        BudgetLimitArray, () => BudgetLimitArray.fromJsonFactory);

    return _apiV1BudgetsIdLimitsGet(id: id, start: start, end: end);
  }

  ///Get all limits for a budget.
  ///@param id The ID of the requested budget.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/api/v1/budgets/{id}/limits')
  Future<chopper.Response<BudgetLimitArray>> _apiV1BudgetsIdLimitsGet({
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
  });

  ///Store new budget limit.
  ///@param id The ID of the budget.
  Future<chopper.Response<BudgetLimitSingle>> apiV1BudgetsIdLimitsPost({
    required String? id,
    required BudgetLimitStore? body,
  }) {
    generatedMapping.putIfAbsent(
        BudgetLimitSingle, () => BudgetLimitSingle.fromJsonFactory);

    return _apiV1BudgetsIdLimitsPost(id: id, body: body);
  }

  ///Store new budget limit.
  ///@param id The ID of the budget.
  @Post(
    path: '/api/v1/budgets/{id}/limits',
    optionalBody: true,
  )
  Future<chopper.Response<BudgetLimitSingle>> _apiV1BudgetsIdLimitsPost({
    @Path('id') required String? id,
    @Body() required BudgetLimitStore? body,
  });

  ///Get single budget limit.
  ///@param id The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///@param limitId The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  Future<chopper.Response<BudgetLimitSingle>> apiV1BudgetsIdLimitsLimitIdGet({
    required String? id,
    required int? limitId,
  }) {
    generatedMapping.putIfAbsent(
        BudgetLimitSingle, () => BudgetLimitSingle.fromJsonFactory);

    return _apiV1BudgetsIdLimitsLimitIdGet(id: id, limitId: limitId);
  }

  ///Get single budget limit.
  ///@param id The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///@param limitId The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  @Get(path: '/api/v1/budgets/{id}/limits/{limitId}')
  Future<chopper.Response<BudgetLimitSingle>> _apiV1BudgetsIdLimitsLimitIdGet({
    @Path('id') required String? id,
    @Path('limitId') required int? limitId,
  });

  ///Update existing budget limit.
  ///@param id The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///@param limitId The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  Future<chopper.Response<BudgetLimitSingle>> apiV1BudgetsIdLimitsLimitIdPut({
    required String? id,
    required String? limitId,
    required BudgetLimit? body,
  }) {
    generatedMapping.putIfAbsent(
        BudgetLimitSingle, () => BudgetLimitSingle.fromJsonFactory);

    return _apiV1BudgetsIdLimitsLimitIdPut(
        id: id, limitId: limitId, body: body);
  }

  ///Update existing budget limit.
  ///@param id The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///@param limitId The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  @Put(
    path: '/api/v1/budgets/{id}/limits/{limitId}',
    optionalBody: true,
  )
  Future<chopper.Response<BudgetLimitSingle>> _apiV1BudgetsIdLimitsLimitIdPut({
    @Path('id') required String? id,
    @Path('limitId') required String? limitId,
    @Body() required BudgetLimit? body,
  });

  ///Delete a budget limit.
  ///@param id The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///@param limitId The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  Future<chopper.Response> apiV1BudgetsIdLimitsLimitIdDelete({
    required String? id,
    required String? limitId,
  }) {
    return _apiV1BudgetsIdLimitsLimitIdDelete(id: id, limitId: limitId);
  }

  ///Delete a budget limit.
  ///@param id The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///@param limitId The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  @Delete(path: '/api/v1/budgets/{id}/limits/{limitId}')
  Future<chopper.Response> _apiV1BudgetsIdLimitsLimitIdDelete({
    @Path('id') required String? id,
    @Path('limitId') required String? limitId,
  });

  ///Get list of budget limits by date
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<BudgetLimitArray>> apiV1BudgetLimitsGet({
    required String? start,
    required String? end,
  }) {
    generatedMapping.putIfAbsent(
        BudgetLimitArray, () => BudgetLimitArray.fromJsonFactory);

    return _apiV1BudgetLimitsGet(start: start, end: end);
  }

  ///Get list of budget limits by date
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/api/v1/budget-limits')
  Future<chopper.Response<BudgetLimitArray>> _apiV1BudgetLimitsGet({
    @Query('start') required String? start,
    @Query('end') required String? end,
  });

  ///List all budgets.
  ///@param page Page number. The default pagination is 50.
  ///@param start A date formatted YYYY-MM-DD, to get info on how much the user has spent. You must submit both start and end.
  ///@param end A date formatted YYYY-MM-DD, to get info on how much the user has spent. You must submit both start and end.
  Future<chopper.Response<BudgetArray>> apiV1BudgetsGet({
    int? page,
    String? start,
    String? end,
  }) {
    generatedMapping.putIfAbsent(
        BudgetArray, () => BudgetArray.fromJsonFactory);

    return _apiV1BudgetsGet(page: page, start: start, end: end);
  }

  ///List all budgets.
  ///@param page Page number. The default pagination is 50.
  ///@param start A date formatted YYYY-MM-DD, to get info on how much the user has spent. You must submit both start and end.
  ///@param end A date formatted YYYY-MM-DD, to get info on how much the user has spent. You must submit both start and end.
  @Get(path: '/api/v1/budgets')
  Future<chopper.Response<BudgetArray>> _apiV1BudgetsGet({
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
  });

  ///Store a new budget
  Future<chopper.Response<BudgetSingle>> apiV1BudgetsPost(
      {required BudgetStore? body}) {
    generatedMapping.putIfAbsent(
        BudgetSingle, () => BudgetSingle.fromJsonFactory);

    return _apiV1BudgetsPost(body: body);
  }

  ///Store a new budget
  @Post(
    path: '/api/v1/budgets',
    optionalBody: true,
  )
  Future<chopper.Response<BudgetSingle>> _apiV1BudgetsPost(
      {@Body() required BudgetStore? body});

  ///Get a single budget.
  ///@param id The ID of the requested budget.
  ///@param start A date formatted YYYY-MM-DD, to get info on how much the user has spent.
  ///@param end A date formatted YYYY-MM-DD, to get info on how much the user has spent.
  Future<chopper.Response<BudgetSingle>> apiV1BudgetsIdGet({
    required String? id,
    String? start,
    String? end,
  }) {
    generatedMapping.putIfAbsent(
        BudgetSingle, () => BudgetSingle.fromJsonFactory);

    return _apiV1BudgetsIdGet(id: id, start: start, end: end);
  }

  ///Get a single budget.
  ///@param id The ID of the requested budget.
  ///@param start A date formatted YYYY-MM-DD, to get info on how much the user has spent.
  ///@param end A date formatted YYYY-MM-DD, to get info on how much the user has spent.
  @Get(path: '/api/v1/budgets/{id}')
  Future<chopper.Response<BudgetSingle>> _apiV1BudgetsIdGet({
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
  });

  ///Update existing budget.
  ///@param id The ID of the budget.
  Future<chopper.Response<BudgetSingle>> apiV1BudgetsIdPut({
    required String? id,
    required BudgetUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
        BudgetSingle, () => BudgetSingle.fromJsonFactory);

    return _apiV1BudgetsIdPut(id: id, body: body);
  }

  ///Update existing budget.
  ///@param id The ID of the budget.
  @Put(
    path: '/api/v1/budgets/{id}',
    optionalBody: true,
  )
  Future<chopper.Response<BudgetSingle>> _apiV1BudgetsIdPut({
    @Path('id') required String? id,
    @Body() required BudgetUpdate? body,
  });

  ///Delete a budget.
  ///@param id The ID of the budget.
  Future<chopper.Response> apiV1BudgetsIdDelete({required String? id}) {
    return _apiV1BudgetsIdDelete(id: id);
  }

  ///Delete a budget.
  ///@param id The ID of the budget.
  @Delete(path: '/api/v1/budgets/{id}')
  Future<chopper.Response> _apiV1BudgetsIdDelete(
      {@Path('id') required String? id});

  ///List all events linked to a piggy bank.
  ///@param id The ID of the piggy bank
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<PiggyBankEventArray>> apiV1PiggyBanksIdEventsGet({
    required String? id,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        PiggyBankEventArray, () => PiggyBankEventArray.fromJsonFactory);

    return _apiV1PiggyBanksIdEventsGet(id: id, page: page);
  }

  ///List all events linked to a piggy bank.
  ///@param id The ID of the piggy bank
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/piggy-banks/{id}/events')
  Future<chopper.Response<PiggyBankEventArray>> _apiV1PiggyBanksIdEventsGet({
    @Path('id') required String? id,
    @Query('page') int? page,
  });

  ///Lists all attachments.
  ///@param id The ID of the piggy bank.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<AttachmentArray>> apiV1PiggyBanksIdAttachmentsGet({
    required String? id,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        AttachmentArray, () => AttachmentArray.fromJsonFactory);

    return _apiV1PiggyBanksIdAttachmentsGet(id: id, page: page);
  }

  ///Lists all attachments.
  ///@param id The ID of the piggy bank.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/piggy-banks/{id}/attachments')
  Future<chopper.Response<AttachmentArray>> _apiV1PiggyBanksIdAttachmentsGet({
    @Path('id') required String? id,
    @Query('page') int? page,
  });

  ///List rules in this rule group.
  ///@param id The ID of the rule group.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<RuleArray>> apiV1RuleGroupsIdRulesGet({
    required String? id,
    int? page,
  }) {
    generatedMapping.putIfAbsent(RuleArray, () => RuleArray.fromJsonFactory);

    return _apiV1RuleGroupsIdRulesGet(id: id, page: page);
  }

  ///List rules in this rule group.
  ///@param id The ID of the rule group.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/rule_groups/{id}/rules')
  Future<chopper.Response<RuleArray>> _apiV1RuleGroupsIdRulesGet({
    @Path('id') required String? id,
    @Query('page') int? page,
  });

  ///List all rule groups.
  ///@param page Page number. The default pagination is 50
  Future<chopper.Response<RuleGroupArray>> apiV1RuleGroupsGet({int? page}) {
    generatedMapping.putIfAbsent(
        RuleGroupArray, () => RuleGroupArray.fromJsonFactory);

    return _apiV1RuleGroupsGet(page: page);
  }

  ///List all rule groups.
  ///@param page Page number. The default pagination is 50
  @Get(path: '/api/v1/rule_groups')
  Future<chopper.Response<RuleGroupArray>> _apiV1RuleGroupsGet(
      {@Query('page') int? page});

  ///Store a new rule group.
  Future<chopper.Response<RuleGroupSingle>> apiV1RuleGroupsPost(
      {required RuleGroupStore? body}) {
    generatedMapping.putIfAbsent(
        RuleGroupSingle, () => RuleGroupSingle.fromJsonFactory);

    return _apiV1RuleGroupsPost(body: body);
  }

  ///Store a new rule group.
  @Post(
    path: '/api/v1/rule_groups',
    optionalBody: true,
  )
  Future<chopper.Response<RuleGroupSingle>> _apiV1RuleGroupsPost(
      {@Body() required RuleGroupStore? body});

  ///Get a single rule group.
  ///@param id The ID of the rule group.
  Future<chopper.Response<RuleGroupSingle>> apiV1RuleGroupsIdGet(
      {required String? id}) {
    generatedMapping.putIfAbsent(
        RuleGroupSingle, () => RuleGroupSingle.fromJsonFactory);

    return _apiV1RuleGroupsIdGet(id: id);
  }

  ///Get a single rule group.
  ///@param id The ID of the rule group.
  @Get(path: '/api/v1/rule_groups/{id}')
  Future<chopper.Response<RuleGroupSingle>> _apiV1RuleGroupsIdGet(
      {@Path('id') required String? id});

  ///Update existing rule group.
  ///@param id The ID of the rule group.
  Future<chopper.Response<RuleGroupSingle>> apiV1RuleGroupsIdPut({
    required String? id,
    required RuleGroupUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
        RuleGroupSingle, () => RuleGroupSingle.fromJsonFactory);

    return _apiV1RuleGroupsIdPut(id: id, body: body);
  }

  ///Update existing rule group.
  ///@param id The ID of the rule group.
  @Put(
    path: '/api/v1/rule_groups/{id}',
    optionalBody: true,
  )
  Future<chopper.Response<RuleGroupSingle>> _apiV1RuleGroupsIdPut({
    @Path('id') required String? id,
    @Body() required RuleGroupUpdate? body,
  });

  ///Delete a rule group.
  ///@param id The ID of the rule group.
  Future<chopper.Response> apiV1RuleGroupsIdDelete({required String? id}) {
    return _apiV1RuleGroupsIdDelete(id: id);
  }

  ///Delete a rule group.
  ///@param id The ID of the rule group.
  @Delete(path: '/api/v1/rule_groups/{id}')
  Future<chopper.Response> _apiV1RuleGroupsIdDelete(
      {@Path('id') required String? id});

  ///List all transactions under this link type.
  ///@param id The ID of the link type.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param start A date formatted YYYY-MM-DD, to limit the results.
  ///@param end A date formatted YYYY-MM-DD, to limit the results.
  ///@param type Optional filter on the transaction type(s) returned.
  Future<chopper.Response<TransactionArray>> apiV1LinkTypesIdTransactionsGet({
    required String? id,
    int? page,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
        TransactionArray, () => TransactionArray.fromJsonFactory);

    return _apiV1LinkTypesIdTransactionsGet(
        id: id,
        page: page,
        start: start,
        end: end,
        type: type?.value?.toString());
  }

  ///List all transactions under this link type.
  ///@param id The ID of the link type.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param start A date formatted YYYY-MM-DD, to limit the results.
  ///@param end A date formatted YYYY-MM-DD, to limit the results.
  ///@param type Optional filter on the transaction type(s) returned.
  @Get(path: '/api/v1/link_types/{id}/transactions')
  Future<chopper.Response<TransactionArray>> _apiV1LinkTypesIdTransactionsGet({
    @Path('id') required String? id,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///List all available budget amounts.
  ///@param page Page number. The default pagination is 50.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  Future<chopper.Response<AvailableBudgetArray>> apiV1AvailableBudgetsGet({
    int? page,
    String? start,
    String? end,
  }) {
    generatedMapping.putIfAbsent(
        AvailableBudgetArray, () => AvailableBudgetArray.fromJsonFactory);

    return _apiV1AvailableBudgetsGet(page: page, start: start, end: end);
  }

  ///List all available budget amounts.
  ///@param page Page number. The default pagination is 50.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  @Get(path: '/api/v1/available_budgets')
  Future<chopper.Response<AvailableBudgetArray>> _apiV1AvailableBudgetsGet({
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
  });

  ///Store a new available budget
  Future<chopper.Response<AvailableBudgetSingle>> apiV1AvailableBudgetsPost(
      {required AvailableBudgetStore? body}) {
    generatedMapping.putIfAbsent(
        AvailableBudgetSingle, () => AvailableBudgetSingle.fromJsonFactory);

    return _apiV1AvailableBudgetsPost(body: body);
  }

  ///Store a new available budget
  @Post(
    path: '/api/v1/available_budgets',
    optionalBody: true,
  )
  Future<chopper.Response<AvailableBudgetSingle>> _apiV1AvailableBudgetsPost(
      {@Body() required AvailableBudgetStore? body});

  ///Get a single available budget.
  ///@param id The ID of the available budget.
  Future<chopper.Response<AvailableBudgetSingle>> apiV1AvailableBudgetsIdGet(
      {required String? id}) {
    generatedMapping.putIfAbsent(
        AvailableBudgetSingle, () => AvailableBudgetSingle.fromJsonFactory);

    return _apiV1AvailableBudgetsIdGet(id: id);
  }

  ///Get a single available budget.
  ///@param id The ID of the available budget.
  @Get(path: '/api/v1/available_budgets/{id}')
  Future<chopper.Response<AvailableBudgetSingle>> _apiV1AvailableBudgetsIdGet(
      {@Path('id') required String? id});

  ///Update existing available budget, to change for example the date range of the amount or the amount itself.
  ///@param id The ID of the object.X
  Future<chopper.Response<AvailableBudgetSingle>> apiV1AvailableBudgetsIdPut({
    required String? id,
    required AvailableBudgetUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
        AvailableBudgetSingle, () => AvailableBudgetSingle.fromJsonFactory);

    return _apiV1AvailableBudgetsIdPut(id: id, body: body);
  }

  ///Update existing available budget, to change for example the date range of the amount or the amount itself.
  ///@param id The ID of the object.X
  @Put(
    path: '/api/v1/available_budgets/{id}',
    optionalBody: true,
  )
  Future<chopper.Response<AvailableBudgetSingle>> _apiV1AvailableBudgetsIdPut({
    @Path('id') required String? id,
    @Body() required AvailableBudgetUpdate? body,
  });

  ///Delete an available budget.
  ///@param id The ID of the available budget.
  Future<chopper.Response> apiV1AvailableBudgetsIdDelete(
      {required String? id}) {
    return _apiV1AvailableBudgetsIdDelete(id: id);
  }

  ///Delete an available budget.
  ///@param id The ID of the available budget.
  @Delete(path: '/api/v1/available_budgets/{id}')
  Future<chopper.Response> _apiV1AvailableBudgetsIdDelete(
      {@Path('id') required String? id});

  ///List all transactions by a budget limit ID.
  ///@param id The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///@param limitId The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  ///@param page Page number. The default pagination is 50.
  ///@param type Optional filter on the transaction type(s) returned
  Future<chopper.Response<TransactionArray>>
      apiV1BudgetsIdLimitsLimitIdTransactionsGet({
    required String? id,
    required String? limitId,
    int? page,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
        TransactionArray, () => TransactionArray.fromJsonFactory);

    return _apiV1BudgetsIdLimitsLimitIdTransactionsGet(
        id: id, limitId: limitId, page: page, type: type?.value?.toString());
  }

  ///List all transactions by a budget limit ID.
  ///@param id The ID of the budget. The budget limit MUST be associated to the budget ID.
  ///@param limitId The ID of the budget limit. The budget limit MUST be associated to the budget ID.
  ///@param page Page number. The default pagination is 50.
  ///@param type Optional filter on the transaction type(s) returned
  @Get(path: '/api/v1/budgets/{id}/limits/{limitId}/transactions')
  Future<chopper.Response<TransactionArray>>
      _apiV1BudgetsIdLimitsLimitIdTransactionsGet({
    @Path('id') required String? id,
    @Path('limitId') required String? limitId,
    @Query('page') int? page,
    @Query('type') String? type,
  });

  ///Lists all attachments.
  ///@param tag Either the tag itself or the tag ID.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<AttachmentArray>> apiV1TagsTagAttachmentsGet({
    required String? tag,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        AttachmentArray, () => AttachmentArray.fromJsonFactory);

    return _apiV1TagsTagAttachmentsGet(tag: tag, page: page);
  }

  ///Lists all attachments.
  ///@param tag Either the tag itself or the tag ID.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/tags/{tag}/attachments')
  Future<chopper.Response<AttachmentArray>> _apiV1TagsTagAttachmentsGet({
    @Path('tag') required String? tag,
    @Query('page') int? page,
  });

  ///List all transactions with this tag.
  ///@param tag Either the tag itself or the tag ID.
  ///@param page Page number. The default pagination is 50.
  ///@param start A date formatted YYYY-MM-DD. This is the start date of the selected range (inclusive).
  ///@param end A date formatted YYYY-MM-DD. This is the end date of the selected range (inclusive).
  ///@param type Optional filter on the transaction type(s) returned.
  Future<chopper.Response<TransactionArray>> apiV1TagsTagTransactionsGet({
    required String? tag,
    int? page,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
        TransactionArray, () => TransactionArray.fromJsonFactory);

    return _apiV1TagsTagTransactionsGet(
        tag: tag,
        page: page,
        start: start,
        end: end,
        type: type?.value?.toString());
  }

  ///List all transactions with this tag.
  ///@param tag Either the tag itself or the tag ID.
  ///@param page Page number. The default pagination is 50.
  ///@param start A date formatted YYYY-MM-DD. This is the start date of the selected range (inclusive).
  ///@param end A date formatted YYYY-MM-DD. This is the end date of the selected range (inclusive).
  ///@param type Optional filter on the transaction type(s) returned.
  @Get(path: '/api/v1/tags/{tag}/transactions')
  Future<chopper.Response<TransactionArray>> _apiV1TagsTagTransactionsGet({
    @Path('tag') required String? tag,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///All transactions to a budget.
  ///@param id The ID of the budget.
  ///@param limit Limits the number of results on one page.
  ///@param page Page number. The default pagination is 50.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param type Optional filter on the transaction type(s) returned
  Future<chopper.Response<TransactionArray>> apiV1BudgetsIdTransactionsGet({
    required String? id,
    int? limit,
    int? page,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
        TransactionArray, () => TransactionArray.fromJsonFactory);

    return _apiV1BudgetsIdTransactionsGet(
        id: id,
        limit: limit,
        page: page,
        start: start,
        end: end,
        type: type?.value?.toString());
  }

  ///All transactions to a budget.
  ///@param id The ID of the budget.
  ///@param limit Limits the number of results on one page.
  ///@param page Page number. The default pagination is 50.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param type Optional filter on the transaction type(s) returned
  @Get(path: '/api/v1/budgets/{id}/transactions')
  Future<chopper.Response<TransactionArray>> _apiV1BudgetsIdTransactionsGet({
    @Path('id') required String? id,
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///All transactions without a budget.
  ///@param limit Limits the number of results on one page.
  ///@param page Page number. The default pagination is 50.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param type Optional filter on the transaction type(s) returned
  Future<chopper.Response<TransactionArray>>
      apiV1BudgetsTransactionsWithoutBudgetGet({
    int? limit,
    int? page,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
        TransactionArray, () => TransactionArray.fromJsonFactory);

    return _apiV1BudgetsTransactionsWithoutBudgetGet(
        limit: limit,
        page: page,
        start: start,
        end: end,
        type: type?.value?.toString());
  }

  ///All transactions without a budget.
  ///@param limit Limits the number of results on one page.
  ///@param page Page number. The default pagination is 50.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param type Optional filter on the transaction type(s) returned
  @Get(path: '/api/v1/budgets/transactions-without-budget')
  Future<chopper.Response<TransactionArray>>
      _apiV1BudgetsTransactionsWithoutBudgetGet({
    @Query('limit') int? limit,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///Lists all attachments of a budget.
  ///@param id The ID of the budget.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<AttachmentArray>> apiV1BudgetsIdAttachmentsGet({
    required String? id,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        AttachmentArray, () => AttachmentArray.fromJsonFactory);

    return _apiV1BudgetsIdAttachmentsGet(id: id, page: page);
  }

  ///Lists all attachments of a budget.
  ///@param id The ID of the budget.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/budgets/{id}/attachments')
  Future<chopper.Response<AttachmentArray>> _apiV1BudgetsIdAttachmentsGet({
    @Path('id') required String? id,
    @Query('page') int? page,
  });

  ///List all piggy banks related to the object group.
  ///@param id The ID of the account.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<PiggyBankArray>> apiV1ObjectGroupsIdPiggyBanksGet({
    required String? id,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        PiggyBankArray, () => PiggyBankArray.fromJsonFactory);

    return _apiV1ObjectGroupsIdPiggyBanksGet(id: id, page: page);
  }

  ///List all piggy banks related to the object group.
  ///@param id The ID of the account.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/api/v1/object_groups/{id}/piggy_banks')
  Future<chopper.Response<PiggyBankArray>> _apiV1ObjectGroupsIdPiggyBanksGet({
    @Path('id') required String? id,
    @Query('page') int? page,
  });

  ///List all bills with this object group.
  ///@param id The ID of the account.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<BillArray>> apiV1ObjectGroupsIdBillsGet({
    required String? id,
    int? page,
  }) {
    generatedMapping.putIfAbsent(BillArray, () => BillArray.fromJsonFactory);

    return _apiV1ObjectGroupsIdBillsGet(id: id, page: page);
  }

  ///List all bills with this object group.
  ///@param id The ID of the account.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/api/v1/object_groups/{id}/bills')
  Future<chopper.Response<BillArray>> _apiV1ObjectGroupsIdBillsGet({
    @Path('id') required String? id,
    @Query('page') int? page,
  });

  ///List all transaction links.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<TransactionLinkArray>> apiV1TransactionLinksGet(
      {int? page}) {
    generatedMapping.putIfAbsent(
        TransactionLinkArray, () => TransactionLinkArray.fromJsonFactory);

    return _apiV1TransactionLinksGet(page: page);
  }

  ///List all transaction links.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/api/v1/transaction_links')
  Future<chopper.Response<TransactionLinkArray>> _apiV1TransactionLinksGet(
      {@Query('page') int? page});

  ///Create a new link between transactions
  Future<chopper.Response<TransactionLinkSingle>> apiV1TransactionLinksPost(
      {required TransactionLinkStore? body}) {
    generatedMapping.putIfAbsent(
        TransactionLinkSingle, () => TransactionLinkSingle.fromJsonFactory);

    return _apiV1TransactionLinksPost(body: body);
  }

  ///Create a new link between transactions
  @Post(
    path: '/api/v1/transaction_links',
    optionalBody: true,
  )
  Future<chopper.Response<TransactionLinkSingle>> _apiV1TransactionLinksPost(
      {@Body() required TransactionLinkStore? body});

  ///Get a single link.
  ///@param id The ID of the transaction link.
  Future<chopper.Response<TransactionLinkSingle>> apiV1TransactionLinksIdGet(
      {required String? id}) {
    generatedMapping.putIfAbsent(
        TransactionLinkSingle, () => TransactionLinkSingle.fromJsonFactory);

    return _apiV1TransactionLinksIdGet(id: id);
  }

  ///Get a single link.
  ///@param id The ID of the transaction link.
  @Get(path: '/api/v1/transaction_links/{id}')
  Future<chopper.Response<TransactionLinkSingle>> _apiV1TransactionLinksIdGet(
      {@Path('id') required String? id});

  ///Permanently delete link between transactions.
  ///@param id The ID of the transaction link.
  Future<chopper.Response> apiV1TransactionLinksIdDelete(
      {required String? id}) {
    return _apiV1TransactionLinksIdDelete(id: id);
  }

  ///Permanently delete link between transactions.
  ///@param id The ID of the transaction link.
  @Delete(path: '/api/v1/transaction_links/{id}')
  Future<chopper.Response> _apiV1TransactionLinksIdDelete(
      {@Path('id') required String? id});

  ///Update an existing link between transactions.
  ///@param id The ID of the transaction link.
  Future<chopper.Response<TransactionLinkSingle>> apiV1TransactionLinksIdPut({
    required String? id,
    required TransactionLinkUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
        TransactionLinkSingle, () => TransactionLinkSingle.fromJsonFactory);

    return _apiV1TransactionLinksIdPut(id: id, body: body);
  }

  ///Update an existing link between transactions.
  ///@param id The ID of the transaction link.
  @Put(
    path: '/api/v1/transaction_links/{id}',
    optionalBody: true,
  )
  Future<chopper.Response<TransactionLinkSingle>> _apiV1TransactionLinksIdPut({
    @Path('id') required String? id,
    @Body() required TransactionLinkUpdate? body,
  });

  ///List all types of links.
  ///@param page Page number. The default pagination is 50 items.
  Future<chopper.Response<LinkTypeArray>> apiV1LinkTypesGet({int? page}) {
    generatedMapping.putIfAbsent(
        LinkTypeArray, () => LinkTypeArray.fromJsonFactory);

    return _apiV1LinkTypesGet(page: page);
  }

  ///List all types of links.
  ///@param page Page number. The default pagination is 50 items.
  @Get(path: '/api/v1/link_types')
  Future<chopper.Response<LinkTypeArray>> _apiV1LinkTypesGet(
      {@Query('page') int? page});

  ///Create a new link type
  Future<chopper.Response<LinkTypeSingle>> apiV1LinkTypesPost(
      {required LinkType? body}) {
    generatedMapping.putIfAbsent(
        LinkTypeSingle, () => LinkTypeSingle.fromJsonFactory);

    return _apiV1LinkTypesPost(body: body);
  }

  ///Create a new link type
  @Post(
    path: '/api/v1/link_types',
    optionalBody: true,
  )
  Future<chopper.Response<LinkTypeSingle>> _apiV1LinkTypesPost(
      {@Body() required LinkType? body});

  ///Get single a link type.
  ///@param id The ID of the link type.
  Future<chopper.Response<LinkTypeSingle>> apiV1LinkTypesIdGet(
      {required String? id}) {
    generatedMapping.putIfAbsent(
        LinkTypeSingle, () => LinkTypeSingle.fromJsonFactory);

    return _apiV1LinkTypesIdGet(id: id);
  }

  ///Get single a link type.
  ///@param id The ID of the link type.
  @Get(path: '/api/v1/link_types/{id}')
  Future<chopper.Response<LinkTypeSingle>> _apiV1LinkTypesIdGet(
      {@Path('id') required String? id});

  ///Update existing link type.
  ///@param id The ID of the link type.
  Future<chopper.Response<LinkTypeSingle>> apiV1LinkTypesIdPut({
    required String? id,
    required LinkTypeUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
        LinkTypeSingle, () => LinkTypeSingle.fromJsonFactory);

    return _apiV1LinkTypesIdPut(id: id, body: body);
  }

  ///Update existing link type.
  ///@param id The ID of the link type.
  @Put(
    path: '/api/v1/link_types/{id}',
    optionalBody: true,
  )
  Future<chopper.Response<LinkTypeSingle>> _apiV1LinkTypesIdPut({
    @Path('id') required String? id,
    @Body() required LinkTypeUpdate? body,
  });

  ///Permanently delete link type.
  ///@param id The ID of the link type.
  Future<chopper.Response> apiV1LinkTypesIdDelete({required String? id}) {
    return _apiV1LinkTypesIdDelete(id: id);
  }

  ///Permanently delete link type.
  ///@param id The ID of the link type.
  @Delete(path: '/api/v1/link_types/{id}')
  Future<chopper.Response> _apiV1LinkTypesIdDelete(
      {@Path('id') required String? id});

  ///Test which transactions would be hit by the rule group. No changes will be made.
  ///@param id The ID of the rule group.
  ///@param page Page number. The default pagination is 50 items.
  ///@param start A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///@param end A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///@param search_limit Maximum number of transactions Firefly III will try. Don't set this too high, or it will take Firefly III very long to run the test. I suggest a max of 200.
  ///@param triggered_limit Maximum number of transactions the rule group can actually trigger on, before Firefly III stops. I would suggest setting this to 10 or 15. Don't go above the user's page size, because browsing to page 2 or 3 of a test result would fire the test again, making any navigation efforts very slow.
  ///@param accounts[] Limit the testing of the rule group to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  Future<chopper.Response<TransactionArray>> apiV1RuleGroupsIdTestGet({
    required String? id,
    int? page,
    String? start,
    String? end,
    int? searchLimit,
    int? triggeredLimit,
    List<int>? accounts,
  }) {
    generatedMapping.putIfAbsent(
        TransactionArray, () => TransactionArray.fromJsonFactory);

    return _apiV1RuleGroupsIdTestGet(
        id: id,
        page: page,
        start: start,
        end: end,
        searchLimit: searchLimit,
        triggeredLimit: triggeredLimit,
        accounts: accounts);
  }

  ///Test which transactions would be hit by the rule group. No changes will be made.
  ///@param id The ID of the rule group.
  ///@param page Page number. The default pagination is 50 items.
  ///@param start A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///@param end A date formatted YYYY-MM-DD, to limit the transactions the test will be applied to. Both the start date and the end date must be present.
  ///@param search_limit Maximum number of transactions Firefly III will try. Don't set this too high, or it will take Firefly III very long to run the test. I suggest a max of 200.
  ///@param triggered_limit Maximum number of transactions the rule group can actually trigger on, before Firefly III stops. I would suggest setting this to 10 or 15. Don't go above the user's page size, because browsing to page 2 or 3 of a test result would fire the test again, making any navigation efforts very slow.
  ///@param accounts[] Limit the testing of the rule group to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  @Get(path: '/api/v1/rule_groups/{id}/test')
  Future<chopper.Response<TransactionArray>> _apiV1RuleGroupsIdTestGet({
    @Path('id') required String? id,
    @Query('page') int? page,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('search_limit') int? searchLimit,
    @Query('triggered_limit') int? triggeredLimit,
    @Query('accounts[]') List<int>? accounts,
  });

  ///Fire the rule group on your transactions.
  ///@param id The ID of the rule group.
  ///@param start A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. Both the start date and the end date must be present.
  ///@param end A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. Both the start date and the end date must be present.
  ///@param accounts[] Limit the triggering of the rule group to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  Future<chopper.Response> apiV1RuleGroupsIdTriggerPost({
    required String? id,
    String? start,
    String? end,
    List<int>? accounts,
  }) {
    return _apiV1RuleGroupsIdTriggerPost(
        id: id, start: start, end: end, accounts: accounts);
  }

  ///Fire the rule group on your transactions.
  ///@param id The ID of the rule group.
  ///@param start A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. Both the start date and the end date must be present.
  ///@param end A date formatted YYYY-MM-DD, to limit the transactions the actions will be applied to. Both the start date and the end date must be present.
  ///@param accounts[] Limit the triggering of the rule group to these asset accounts or liabilities. Only asset accounts and liabilities will be accepted. Other types will be silently dropped.
  @Post(
    path: '/api/v1/rule_groups/{id}/trigger',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1RuleGroupsIdTriggerPost({
    @Path('id') required String? id,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('accounts[]') List<int>? accounts,
  });

  ///List all transactions related to the account.
  ///@param id The ID of the account.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param limit Limits the number of results on one page.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param type Optional filter on the transaction type(s) returned.
  Future<chopper.Response<TransactionArray>> apiV1AccountsIdTransactionsGet({
    required String? id,
    int? page,
    int? limit,
    String? start,
    String? end,
    enums.TransactionTypeFilter? type,
  }) {
    generatedMapping.putIfAbsent(
        TransactionArray, () => TransactionArray.fromJsonFactory);

    return _apiV1AccountsIdTransactionsGet(
        id: id,
        page: page,
        limit: limit,
        start: start,
        end: end,
        type: type?.value?.toString());
  }

  ///List all transactions related to the account.
  ///@param id The ID of the account.
  ///@param page Page number. The default pagination is per 50 items.
  ///@param limit Limits the number of results on one page.
  ///@param start A date formatted YYYY-MM-DD.
  ///@param end A date formatted YYYY-MM-DD.
  ///@param type Optional filter on the transaction type(s) returned.
  @Get(path: '/api/v1/accounts/{id}/transactions')
  Future<chopper.Response<TransactionArray>> _apiV1AccountsIdTransactionsGet({
    @Path('id') required String? id,
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('type') String? type,
  });

  ///Lists all attachments.
  ///@param id The ID of the account.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<AttachmentArray>> apiV1AccountsIdAttachmentsGet({
    required String? id,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        AttachmentArray, () => AttachmentArray.fromJsonFactory);

    return _apiV1AccountsIdAttachmentsGet(id: id, page: page);
  }

  ///Lists all attachments.
  ///@param id The ID of the account.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/accounts/{id}/attachments')
  Future<chopper.Response<AttachmentArray>> _apiV1AccountsIdAttachmentsGet({
    @Path('id') required String? id,
    @Query('page') int? page,
  });

  ///List all piggy banks related to the account.
  ///@param id The ID of the account.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<PiggyBankArray>> apiV1AccountsIdPiggyBanksGet({
    required String? id,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        PiggyBankArray, () => PiggyBankArray.fromJsonFactory);

    return _apiV1AccountsIdPiggyBanksGet(id: id, page: page);
  }

  ///List all piggy banks related to the account.
  ///@param id The ID of the account.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/api/v1/accounts/{id}/piggy_banks')
  Future<chopper.Response<PiggyBankArray>> _apiV1AccountsIdPiggyBanksGet({
    @Path('id') required String? id,
    @Query('page') int? page,
  });

  ///Search for accounts
  ///@param page Page number. The default pagination is 50
  ///@param query The query you wish to search for.
  ///@param type The type of accounts you wish to limit the search to.
  ///@param field The account field(s) you want to search in.
  Future<chopper.Response<AccountArray>> apiV1SearchAccountsGet({
    int? page,
    required String? query,
    enums.AccountTypeFilter? type,
    required enums.AccountSearchFieldFilter? field,
  }) {
    generatedMapping.putIfAbsent(
        AccountArray, () => AccountArray.fromJsonFactory);

    return _apiV1SearchAccountsGet(
        page: page,
        query: query,
        type: type?.value?.toString(),
        field: field?.value?.toString());
  }

  ///Search for accounts
  ///@param page Page number. The default pagination is 50
  ///@param query The query you wish to search for.
  ///@param type The type of accounts you wish to limit the search to.
  ///@param field The account field(s) you want to search in.
  @Get(path: '/api/v1/search/accounts')
  Future<chopper.Response<AccountArray>> _apiV1SearchAccountsGet({
    @Query('page') int? page,
    @Query('query') required String? query,
    @Query('type') String? type,
    @Query('field') required String? field,
  });

  ///Search for transactions
  ///@param query The query you wish to search for.
  ///@param page Page number. The default pagination is 50
  Future<chopper.Response<TransactionArray>> apiV1SearchTransactionsGet({
    required String? query,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        TransactionArray, () => TransactionArray.fromJsonFactory);

    return _apiV1SearchTransactionsGet(query: query, page: page);
  }

  ///Search for transactions
  ///@param query The query you wish to search for.
  ///@param page Page number. The default pagination is 50
  @Get(path: '/api/v1/search/transactions')
  Future<chopper.Response<TransactionArray>> _apiV1SearchTransactionsGet({
    @Query('query') required String? query,
    @Query('page') int? page,
  });

  ///Cron job endpoint
  ///@param cliToken The CLI token of any user in Firefly III, required to run the cron job.
  ///@param date A date formatted YYYY-MM-DD. This can be used to make the cron job pretend it's running on another day.
  ///@param force Forces the cron job to fire, regardless of whether it has fired before. This may result in double transactions or weird budgets, so be careful.
  Future<chopper.Response<CronResult>> apiV1CronCliTokenGet({
    required String? cliToken,
    String? date,
    bool? force,
  }) {
    generatedMapping.putIfAbsent(CronResult, () => CronResult.fromJsonFactory);

    return _apiV1CronCliTokenGet(cliToken: cliToken, date: date, force: force);
  }

  ///Cron job endpoint
  ///@param cliToken The CLI token of any user in Firefly III, required to run the cron job.
  ///@param date A date formatted YYYY-MM-DD. This can be used to make the cron job pretend it's running on another day.
  ///@param force Forces the cron job to fire, regardless of whether it has fired before. This may result in double transactions or weird budgets, so be careful.
  @Get(path: '/api/v1/cron/{cliToken}')
  Future<chopper.Response<CronResult>> _apiV1CronCliTokenGet({
    @Path('cliToken') required String? cliToken,
    @Query('date') String? date,
    @Query('force') bool? force,
  });

  ///Get Firefly III system configuration values.
  Future<chopper.Response<ConfigurationArray>> apiV1ConfigurationGet() {
    generatedMapping.putIfAbsent(
        Configuration, () => Configuration.fromJsonFactory);

    return _apiV1ConfigurationGet();
  }

  ///Get Firefly III system configuration values.
  @Get(path: '/api/v1/configuration')
  Future<chopper.Response<ConfigurationArray>> _apiV1ConfigurationGet();

  ///Get a single Firefly III system configuration value
  ///@param name The name of the configuration value you want to know.
  Future<chopper.Response<ConfigurationSingle>> apiV1ConfigurationNameGet(
      {required enums.ConfigValueFilter? name}) {
    generatedMapping.putIfAbsent(
        ConfigurationSingle, () => ConfigurationSingle.fromJsonFactory);

    return _apiV1ConfigurationNameGet(name: name?.value?.toString());
  }

  ///Get a single Firefly III system configuration value
  ///@param name The name of the configuration value you want to know.
  @Get(path: '/api/v1/configuration/{name}')
  Future<chopper.Response<ConfigurationSingle>> _apiV1ConfigurationNameGet(
      {@Path('name') required String? name});

  ///Update configuration value
  ///@param name The name of the configuration value you want to update.
  Future<chopper.Response<ConfigurationSingle>> apiV1ConfigurationNamePut({
    required enums.ConfigValueUpdateFilter? name,
    required ConfigurationUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
        ConfigurationSingle, () => ConfigurationSingle.fromJsonFactory);

    return _apiV1ConfigurationNamePut(
        name: name?.value?.toString(), body: body);
  }

  ///Update configuration value
  ///@param name The name of the configuration value you want to update.
  @Put(
    path: '/api/v1/configuration/{name}',
    optionalBody: true,
  )
  Future<chopper.Response<ConfigurationSingle>> _apiV1ConfigurationNamePut({
    @Path('name') required String? name,
    @Body() required ConfigurationUpdate? body,
  });

  ///List all users.
  ///@param page The page number, if necessary. The default pagination is 50, so 50 users per page.
  Future<chopper.Response<UserArray>> apiV1UsersGet({int? page}) {
    generatedMapping.putIfAbsent(UserArray, () => UserArray.fromJsonFactory);

    return _apiV1UsersGet(page: page);
  }

  ///List all users.
  ///@param page The page number, if necessary. The default pagination is 50, so 50 users per page.
  @Get(path: '/api/v1/users')
  Future<chopper.Response<UserArray>> _apiV1UsersGet(
      {@Query('page') int? page});

  ///Store a new user
  Future<chopper.Response<UserSingle>> apiV1UsersPost({required User? body}) {
    generatedMapping.putIfAbsent(UserSingle, () => UserSingle.fromJsonFactory);

    return _apiV1UsersPost(body: body);
  }

  ///Store a new user
  @Post(
    path: '/api/v1/users',
    optionalBody: true,
  )
  Future<chopper.Response<UserSingle>> _apiV1UsersPost(
      {@Body() required User? body});

  ///Get a single user.
  ///@param id The user ID.
  Future<chopper.Response<UserSingle>> apiV1UsersIdGet({required String? id}) {
    generatedMapping.putIfAbsent(UserSingle, () => UserSingle.fromJsonFactory);

    return _apiV1UsersIdGet(id: id);
  }

  ///Get a single user.
  ///@param id The user ID.
  @Get(path: '/api/v1/users/{id}')
  Future<chopper.Response<UserSingle>> _apiV1UsersIdGet(
      {@Path('id') required String? id});

  ///Update an existing user's information.
  ///@param id The user ID.
  Future<chopper.Response<UserSingle>> apiV1UsersIdPut({
    required String? id,
    required User? body,
  }) {
    generatedMapping.putIfAbsent(UserSingle, () => UserSingle.fromJsonFactory);

    return _apiV1UsersIdPut(id: id, body: body);
  }

  ///Update an existing user's information.
  ///@param id The user ID.
  @Put(
    path: '/api/v1/users/{id}',
    optionalBody: true,
  )
  Future<chopper.Response<UserSingle>> _apiV1UsersIdPut({
    @Path('id') required String? id,
    @Body() required User? body,
  });

  ///Delete a user.
  ///@param id The user ID.
  Future<chopper.Response> apiV1UsersIdDelete({required String? id}) {
    return _apiV1UsersIdDelete(id: id);
  }

  ///Delete a user.
  ///@param id The user ID.
  @Delete(path: '/api/v1/users/{id}')
  Future<chopper.Response> _apiV1UsersIdDelete(
      {@Path('id') required String? id});

  ///System information end point.
  Future<chopper.Response<SystemInfo>> apiV1AboutGet() {
    generatedMapping.putIfAbsent(SystemInfo, () => SystemInfo.fromJsonFactory);

    return _apiV1AboutGet();
  }

  ///System information end point.
  @Get(path: '/api/v1/about')
  Future<chopper.Response<SystemInfo>> _apiV1AboutGet();

  ///Currently authenticated user endpoint.
  Future<chopper.Response<UserSingle>> apiV1AboutUserGet() {
    generatedMapping.putIfAbsent(UserSingle, () => UserSingle.fromJsonFactory);

    return _apiV1AboutUserGet();
  }

  ///Currently authenticated user endpoint.
  @Get(path: '/api/v1/about/user')
  Future<chopper.Response<UserSingle>> _apiV1AboutUserGet();

  ///List all webhooks.
  ///@param page The page number, if necessary. The default pagination is 50, so 50 webhooks per page.
  Future<chopper.Response<WebhookArray>> apiV1WebhooksGet({int? page}) {
    generatedMapping.putIfAbsent(
        WebhookArray, () => WebhookArray.fromJsonFactory);

    return _apiV1WebhooksGet(page: page);
  }

  ///List all webhooks.
  ///@param page The page number, if necessary. The default pagination is 50, so 50 webhooks per page.
  @Get(path: '/api/v1/webhooks')
  Future<chopper.Response<WebhookArray>> _apiV1WebhooksGet(
      {@Query('page') int? page});

  ///Store a new webhook
  Future<chopper.Response<WebhookSingle>> apiV1WebhooksPost(
      {required WebhookStore? body}) {
    generatedMapping.putIfAbsent(
        WebhookSingle, () => WebhookSingle.fromJsonFactory);

    return _apiV1WebhooksPost(body: body);
  }

  ///Store a new webhook
  @Post(
    path: '/api/v1/webhooks',
    optionalBody: true,
  )
  Future<chopper.Response<WebhookSingle>> _apiV1WebhooksPost(
      {@Body() required WebhookStore? body});

  ///Get a single webhook.
  ///@param id The webhook ID.
  Future<chopper.Response<WebhookSingle>> apiV1WebhooksIdGet(
      {required String? id}) {
    generatedMapping.putIfAbsent(
        WebhookSingle, () => WebhookSingle.fromJsonFactory);

    return _apiV1WebhooksIdGet(id: id);
  }

  ///Get a single webhook.
  ///@param id The webhook ID.
  @Get(path: '/api/v1/webhooks/{id}')
  Future<chopper.Response<WebhookSingle>> _apiV1WebhooksIdGet(
      {@Path('id') required String? id});

  ///Update existing webhook.
  ///@param id The webhook ID.
  Future<chopper.Response<WebhookSingle>> apiV1WebhooksIdPut({
    required String? id,
    required WebhookUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
        WebhookSingle, () => WebhookSingle.fromJsonFactory);

    return _apiV1WebhooksIdPut(id: id, body: body);
  }

  ///Update existing webhook.
  ///@param id The webhook ID.
  @Put(
    path: '/api/v1/webhooks/{id}',
    optionalBody: true,
  )
  Future<chopper.Response<WebhookSingle>> _apiV1WebhooksIdPut({
    @Path('id') required String? id,
    @Body() required WebhookUpdate? body,
  });

  ///Delete a webhook.
  ///@param id The webhook ID.
  Future<chopper.Response> apiV1WebhooksIdDelete({required String? id}) {
    return _apiV1WebhooksIdDelete(id: id);
  }

  ///Delete a webhook.
  ///@param id The webhook ID.
  @Delete(path: '/api/v1/webhooks/{id}')
  Future<chopper.Response> _apiV1WebhooksIdDelete(
      {@Path('id') required String? id});

  ///Submit messages for a webhook.
  ///@param id The webhook ID.
  Future<chopper.Response> apiV1WebhooksIdSubmitPost({required String? id}) {
    return _apiV1WebhooksIdSubmitPost(id: id);
  }

  ///Submit messages for a webhook.
  ///@param id The webhook ID.
  @Post(
    path: '/api/v1/webhooks/{id}/submit',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1WebhooksIdSubmitPost(
      {@Path('id') required String? id});

  ///Get all the messages of a single webhook.
  ///@param id The webhook ID.
  Future<chopper.Response<WebhookMessageArray>> apiV1WebhooksIdMessagesGet(
      {required String? id}) {
    generatedMapping.putIfAbsent(
        WebhookMessageArray, () => WebhookMessageArray.fromJsonFactory);

    return _apiV1WebhooksIdMessagesGet(id: id);
  }

  ///Get all the messages of a single webhook.
  ///@param id The webhook ID.
  @Get(path: '/api/v1/webhooks/{id}/messages')
  Future<chopper.Response<WebhookMessageArray>> _apiV1WebhooksIdMessagesGet(
      {@Path('id') required String? id});

  ///Get a single message from a webhook.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  Future<chopper.Response<WebhookMessageSingle>>
      apiV1WebhooksIdMessagesMessageIdGet({
    required String? id,
    required int? messageId,
  }) {
    generatedMapping.putIfAbsent(
        WebhookMessageSingle, () => WebhookMessageSingle.fromJsonFactory);

    return _apiV1WebhooksIdMessagesMessageIdGet(id: id, messageId: messageId);
  }

  ///Get a single message from a webhook.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  @Get(path: '/api/v1/webhooks/{id}/messages/{messageId}')
  Future<chopper.Response<WebhookMessageSingle>>
      _apiV1WebhooksIdMessagesMessageIdGet({
    @Path('id') required String? id,
    @Path('messageId') required int? messageId,
  });

  ///Delete a webhook message.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  Future<chopper.Response> apiV1WebhooksIdMessagesMessageIdDelete({
    required String? id,
    required int? messageId,
  }) {
    return _apiV1WebhooksIdMessagesMessageIdDelete(
        id: id, messageId: messageId);
  }

  ///Delete a webhook message.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  @Delete(path: '/api/v1/webhooks/{id}/messages/{messageId}')
  Future<chopper.Response> _apiV1WebhooksIdMessagesMessageIdDelete({
    @Path('id') required String? id,
    @Path('messageId') required int? messageId,
  });

  ///Get all the failed attempts of a single webhook message.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  ///@param page Page number. The default pagination is per 50 items.
  Future<chopper.Response<WebhookAttemptArray>>
      apiV1WebhooksIdMessagesMessageIdAttemptsGet({
    required String? id,
    required int? messageId,
    int? page,
  }) {
    generatedMapping.putIfAbsent(
        WebhookAttemptArray, () => WebhookAttemptArray.fromJsonFactory);

    return _apiV1WebhooksIdMessagesMessageIdAttemptsGet(
        id: id, messageId: messageId, page: page);
  }

  ///Get all the failed attempts of a single webhook message.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  ///@param page Page number. The default pagination is per 50 items.
  @Get(path: '/api/v1/webhooks/{id}/messages/{messageId}/attempts')
  Future<chopper.Response<WebhookAttemptArray>>
      _apiV1WebhooksIdMessagesMessageIdAttemptsGet({
    @Path('id') required String? id,
    @Path('messageId') required int? messageId,
    @Query('page') int? page,
  });

  ///Get a single failed attempt from a single webhook message.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  ///@param attemptId The webhook attempt ID.
  Future<chopper.Response<WebhookAttemptSingle>>
      apiV1WebhooksIdMessagesMessageIdAttemptsAttemptIdGet({
    required String? id,
    required int? messageId,
    required int? attemptId,
  }) {
    generatedMapping.putIfAbsent(
        WebhookAttemptSingle, () => WebhookAttemptSingle.fromJsonFactory);

    return _apiV1WebhooksIdMessagesMessageIdAttemptsAttemptIdGet(
        id: id, messageId: messageId, attemptId: attemptId);
  }

  ///Get a single failed attempt from a single webhook message.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  ///@param attemptId The webhook attempt ID.
  @Get(path: '/api/v1/webhooks/{id}/messages/{messageId}/attempts/{attemptId}')
  Future<chopper.Response<WebhookAttemptSingle>>
      _apiV1WebhooksIdMessagesMessageIdAttemptsAttemptIdGet({
    @Path('id') required String? id,
    @Path('messageId') required int? messageId,
    @Path('attemptId') required int? attemptId,
  });

  ///Delete a webhook attempt.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  ///@param attemptId The webhook message attempt ID.
  Future<chopper.Response>
      apiV1WebhooksIdMessagesMessageIdAttemptsAttemptIdDelete({
    required String? id,
    required int? messageId,
    required int? attemptId,
  }) {
    return _apiV1WebhooksIdMessagesMessageIdAttemptsAttemptIdDelete(
        id: id, messageId: messageId, attemptId: attemptId);
  }

  ///Delete a webhook attempt.
  ///@param id The webhook ID.
  ///@param messageId The webhook message ID.
  ///@param attemptId The webhook message attempt ID.
  @Delete(
      path: '/api/v1/webhooks/{id}/messages/{messageId}/attempts/{attemptId}')
  Future<chopper.Response>
      _apiV1WebhooksIdMessagesMessageIdAttemptsAttemptIdDelete({
    @Path('id') required String? id,
    @Path('messageId') required int? messageId,
    @Path('attemptId') required int? attemptId,
  });

  ///List all users preferences.
  ///@param page Page number. The default pagination is 50.
  Future<chopper.Response<PreferenceArray>> apiV1PreferencesGet({int? page}) {
    generatedMapping.putIfAbsent(
        PreferenceArray, () => PreferenceArray.fromJsonFactory);

    return _apiV1PreferencesGet(page: page);
  }

  ///List all users preferences.
  ///@param page Page number. The default pagination is 50.
  @Get(path: '/api/v1/preferences')
  Future<chopper.Response<PreferenceArray>> _apiV1PreferencesGet(
      {@Query('page') int? page});

  ///Store a new preference for this user.
  Future<chopper.Response<PreferenceSingle>> apiV1PreferencesPost(
      {required Preference? body}) {
    generatedMapping.putIfAbsent(
        PreferenceSingle, () => PreferenceSingle.fromJsonFactory);

    return _apiV1PreferencesPost(body: body);
  }

  ///Store a new preference for this user.
  @Post(
    path: '/api/v1/preferences',
    optionalBody: true,
  )
  Future<chopper.Response<PreferenceSingle>> _apiV1PreferencesPost(
      {@Body() required Preference? body});

  ///Return a single preference.
  ///@param name The name of the preference.
  Future<chopper.Response<PreferenceSingle>> apiV1PreferencesNameGet(
      {required String? name}) {
    generatedMapping.putIfAbsent(
        PreferenceSingle, () => PreferenceSingle.fromJsonFactory);

    return _apiV1PreferencesNameGet(name: name);
  }

  ///Return a single preference.
  ///@param name The name of the preference.
  @Get(path: '/api/v1/preferences/{name}')
  Future<chopper.Response<PreferenceSingle>> _apiV1PreferencesNameGet(
      {@Path('name') required String? name});

  ///Update preference
  ///@param name The name of the preference. Will always overwrite. Will be created if it does not exist.
  Future<chopper.Response<PreferenceSingle>> apiV1PreferencesNamePut({
    required String? name,
    required PreferenceUpdate? body,
  }) {
    generatedMapping.putIfAbsent(
        PreferenceSingle, () => PreferenceSingle.fromJsonFactory);

    return _apiV1PreferencesNamePut(name: name, body: body);
  }

  ///Update preference
  ///@param name The name of the preference. Will always overwrite. Will be created if it does not exist.
  @Put(
    path: '/api/v1/preferences/{name}',
    optionalBody: true,
  )
  Future<chopper.Response<PreferenceSingle>> _apiV1PreferencesNamePut({
    @Path('name') required String? name,
    @Body() required PreferenceUpdate? body,
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

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);
