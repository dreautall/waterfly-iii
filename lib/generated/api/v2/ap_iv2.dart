// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';

import 'autocomplete/autocomplete_client.dart';
import 'charts/charts_client.dart';
import 'accounts/accounts_client.dart';
import 'budgets/budgets_client.dart';
import 'currencies/currencies_client.dart';
import 'piggy_banks/piggy_banks_client.dart';
import 'preferences/preferences_client.dart';
import 'bills/bills_client.dart';
import 'transactionssum/transactionssum_client.dart';
import 'transactions/transactions_client.dart';
import 'networth/networth_client.dart';
import 'summary/summary_client.dart';

/// Firefly III API v2.0.12 `v2.0.12`.
///
/// This is the documentation of the Firefly III API. You can find accompanying documentation on the website of Firefly III itself (see below). Please report any bugs or issues. You may use the "Authorize" button to try the API below. This file was last generated on 2024-01-03T07:10:56+00:00.
///
/// Please keep in mind that the demo site does not accept requests from curl, colly, wget, etc. You must use a browser or a tool like Postman to make requests. Too many script kiddies out there, sorry about that.
///
class APIv2 {
  APIv2(
    Dio dio, {
    String? baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String? _baseUrl;

  AutocompleteClient? _autocomplete;
  ChartsClient? _charts;
  AccountsClient? _accounts;
  BudgetsClient? _budgets;
  CurrenciesClient? _currencies;
  PiggyBanksClient? _piggyBanks;
  PreferencesClient? _preferences;
  BillsClient? _bills;
  TransactionssumClient? _transactionssum;
  TransactionsClient? _transactions;
  NetworthClient? _networth;
  SummaryClient? _summary;

  AutocompleteClient get autocomplete => _autocomplete ??= AutocompleteClient(_dio, baseUrl: _baseUrl);

  ChartsClient get charts => _charts ??= ChartsClient(_dio, baseUrl: _baseUrl);

  AccountsClient get accounts => _accounts ??= AccountsClient(_dio, baseUrl: _baseUrl);

  BudgetsClient get budgets => _budgets ??= BudgetsClient(_dio, baseUrl: _baseUrl);

  CurrenciesClient get currencies => _currencies ??= CurrenciesClient(_dio, baseUrl: _baseUrl);

  PiggyBanksClient get piggyBanks => _piggyBanks ??= PiggyBanksClient(_dio, baseUrl: _baseUrl);

  PreferencesClient get preferences => _preferences ??= PreferencesClient(_dio, baseUrl: _baseUrl);

  BillsClient get bills => _bills ??= BillsClient(_dio, baseUrl: _baseUrl);

  TransactionssumClient get transactionssum => _transactionssum ??= TransactionssumClient(_dio, baseUrl: _baseUrl);

  TransactionsClient get transactions => _transactions ??= TransactionsClient(_dio, baseUrl: _baseUrl);

  NetworthClient get networth => _networth ??= NetworthClient(_dio, baseUrl: _baseUrl);

  SummaryClient get summary => _summary ??= SummaryClient(_dio, baseUrl: _baseUrl);
}
