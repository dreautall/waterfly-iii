import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_resource_label_resolver.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';

class ApiFireflyResourceLabelGateway implements FireflyResourceLabelGateway {
  const ApiFireflyResourceLabelGateway(this._firefly);

  final FireflyService _firefly;

  @override
  Future<String> loadLabel(FireflyResourceKind kind, String id) async {
    final FireflyIii api = _firefly.api;
    final String? label = switch (kind) {
      FireflyResourceKind.account => (await api.v1AccountsIdGet(
        id: id,
      )).body?.data.attributes.name,
      FireflyResourceKind.category => (await api.v1CategoriesIdGet(
        id: id,
      )).body?.data.attributes.name,
      FireflyResourceKind.subscription => (await api.v1BillsIdGet(
        id: id,
      )).body?.data.attributes.name,
      FireflyResourceKind.piggyBank => (await api.v1PiggyBanksIdGet(
        id: id,
      )).body?.data.attributes.name,
      FireflyResourceKind.tag => await _tagLabel(api, id),
      FireflyResourceKind.currency => await _currencyLabel(api, id),
    };
    if (label == null || label.trim().isEmpty) {
      throw StateError('${kind.name} $id is unavailable.');
    }
    return label;
  }

  Future<String?> _tagLabel(FireflyIii api, String id) async {
    final AutocompleteTagArray? tags = (await api.v1AutocompleteTagsGet(
      query: '',
    )).body;
    for (final AutocompleteTag tag in tags ?? const <AutocompleteTag>[]) {
      if (tag.id == id) return tag.tag;
    }
    return null;
  }

  Future<String?> _currencyLabel(FireflyIii api, String id) async {
    final AutocompleteCurrencyArray? currencies =
        (await api.v1AutocompleteCurrenciesGet(query: '')).body;
    for (final AutocompleteCurrency currency
        in currencies ?? const <AutocompleteCurrency>[]) {
      if (currency.id == id) return currency.name;
    }
    return null;
  }
}
