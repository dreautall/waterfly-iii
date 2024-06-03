// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';

import 'autocomplete/autocomplete_client.dart';
import 'charts/charts_client.dart';
import 'data/data_client.dart';
import 'insight/insight_client.dart';
import 'accounts/accounts_client.dart';
import 'attachments/attachments_client.dart';
import 'available_budgets/available_budgets_client.dart';
import 'bills/bills_client.dart';
import 'budgets/budgets_client.dart';
import 'categories/categories_client.dart';
import 'links/links_client.dart';
import 'object_groups/object_groups_client.dart';
import 'piggy_banks/piggy_banks_client.dart';
import 'recurrences/recurrences_client.dart';
import 'rule_groups/rule_groups_client.dart';
import 'rules/rules_client.dart';
import 'tags/tags_client.dart';
import 'currencies/currencies_client.dart';
import 'transactions/transactions_client.dart';
import 'search/search_client.dart';
import 'summary/summary_client.dart';
import 'about/about_client.dart';
import 'configuration/configuration_client.dart';
import 'users/users_client.dart';
import 'preferences/preferences_client.dart';
import 'webhooks/webhooks_client.dart';

/// Firefly III API v2.1.0 `v2.1.0`.
///
/// This is the documentation of the Firefly III API. You can find accompanying documentation on the website of Firefly III itself (see below). Please report any bugs or issues. You may use the "Authorize" button to try the API below. This file was last generated on 2024-05-19T04:33:01+00:00.
///
/// Please keep in mind that the demo site does not accept requests from curl, colly, wget, etc. You must use a browser or a tool like Postman to make requests. Too many script kiddies out there, sorry about that.
///
class APIv1 {
  APIv1(
    Dio dio, {
    String? baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String? _baseUrl;

  AutocompleteClient? _autocomplete;
  ChartsClient? _charts;
  DataClient? _data;
  InsightClient? _insight;
  AccountsClient? _accounts;
  AttachmentsClient? _attachments;
  AvailableBudgetsClient? _availableBudgets;
  BillsClient? _bills;
  BudgetsClient? _budgets;
  CategoriesClient? _categories;
  LinksClient? _links;
  ObjectGroupsClient? _objectGroups;
  PiggyBanksClient? _piggyBanks;
  RecurrencesClient? _recurrences;
  RuleGroupsClient? _ruleGroups;
  RulesClient? _rules;
  TagsClient? _tags;
  CurrenciesClient? _currencies;
  TransactionsClient? _transactions;
  SearchClient? _search;
  SummaryClient? _summary;
  AboutClient? _about;
  ConfigurationClient? _configuration;
  UsersClient? _users;
  PreferencesClient? _preferences;
  WebhooksClient? _webhooks;

  AutocompleteClient get autocomplete =>
      _autocomplete ??= AutocompleteClient(_dio, baseUrl: _baseUrl);

  ChartsClient get charts => _charts ??= ChartsClient(_dio, baseUrl: _baseUrl);

  DataClient get data => _data ??= DataClient(_dio, baseUrl: _baseUrl);

  InsightClient get insight =>
      _insight ??= InsightClient(_dio, baseUrl: _baseUrl);

  AccountsClient get accounts =>
      _accounts ??= AccountsClient(_dio, baseUrl: _baseUrl);

  AttachmentsClient get attachments =>
      _attachments ??= AttachmentsClient(_dio, baseUrl: _baseUrl);

  AvailableBudgetsClient get availableBudgets =>
      _availableBudgets ??= AvailableBudgetsClient(_dio, baseUrl: _baseUrl);

  BillsClient get bills => _bills ??= BillsClient(_dio, baseUrl: _baseUrl);

  BudgetsClient get budgets =>
      _budgets ??= BudgetsClient(_dio, baseUrl: _baseUrl);

  CategoriesClient get categories =>
      _categories ??= CategoriesClient(_dio, baseUrl: _baseUrl);

  LinksClient get links => _links ??= LinksClient(_dio, baseUrl: _baseUrl);

  ObjectGroupsClient get objectGroups =>
      _objectGroups ??= ObjectGroupsClient(_dio, baseUrl: _baseUrl);

  PiggyBanksClient get piggyBanks =>
      _piggyBanks ??= PiggyBanksClient(_dio, baseUrl: _baseUrl);

  RecurrencesClient get recurrences =>
      _recurrences ??= RecurrencesClient(_dio, baseUrl: _baseUrl);

  RuleGroupsClient get ruleGroups =>
      _ruleGroups ??= RuleGroupsClient(_dio, baseUrl: _baseUrl);

  RulesClient get rules => _rules ??= RulesClient(_dio, baseUrl: _baseUrl);

  TagsClient get tags => _tags ??= TagsClient(_dio, baseUrl: _baseUrl);

  CurrenciesClient get currencies =>
      _currencies ??= CurrenciesClient(_dio, baseUrl: _baseUrl);

  TransactionsClient get transactions =>
      _transactions ??= TransactionsClient(_dio, baseUrl: _baseUrl);

  SearchClient get search => _search ??= SearchClient(_dio, baseUrl: _baseUrl);

  SummaryClient get summary =>
      _summary ??= SummaryClient(_dio, baseUrl: _baseUrl);

  AboutClient get about => _about ??= AboutClient(_dio, baseUrl: _baseUrl);

  ConfigurationClient get configuration =>
      _configuration ??= ConfigurationClient(_dio, baseUrl: _baseUrl);

  UsersClient get users => _users ??= UsersClient(_dio, baseUrl: _baseUrl);

  PreferencesClient get preferences =>
      _preferences ??= PreferencesClient(_dio, baseUrl: _baseUrl);

  WebhooksClient get webhooks =>
      _webhooks ??= WebhooksClient(_dio, baseUrl: _baseUrl);
}
