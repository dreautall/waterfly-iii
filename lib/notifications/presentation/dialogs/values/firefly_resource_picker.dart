import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/firefly_resource_value_source.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_card_theme.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';
import 'package:waterflyiii/widgets/autocompletetext.dart';

class FireflyResourcePicker extends StatefulWidget {
  const FireflyResourcePicker({
    super.key,
    required this.resourceKind,
    required this.onSelected,
  });

  final FireflyResourceKind resourceKind;
  final ValueChanged<FireflyResourceValueSource> onSelected;

  @override
  State<FireflyResourcePicker> createState() => _FireflyResourcePickerState();
}

class _FireflyResourcePickerState extends State<FireflyResourcePicker> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<Iterable<_FireflyResourceOption>> _options(String query) async {
    final FireflyIii api = context.read<FireflyService>().api;
    switch (widget.resourceKind) {
      case FireflyResourceKind.account:
        final AutocompleteAccountArray items =
            (await api.v1AutocompleteAccountsGet(query: query)).body!;
        return items.map(
          (AutocompleteAccount item) =>
              _FireflyResourceOption(id: item.id, name: item.name),
        );
      case FireflyResourceKind.category:
        final AutocompleteCategoryArray items =
            (await api.v1AutocompleteCategoriesGet(query: query)).body!;
        return items.map(
          (AutocompleteCategory item) =>
              _FireflyResourceOption(id: item.id, name: item.name),
        );
      case FireflyResourceKind.tag:
        final AutocompleteTagArray items = (await api.v1AutocompleteTagsGet(
          query: query,
        )).body!;
        return items.map(
          (AutocompleteTag item) =>
              _FireflyResourceOption(id: item.id, name: item.tag),
        );
      case FireflyResourceKind.subscription:
        final AutocompleteBillArray items =
            (await api.v1AutocompleteSubscriptionsGet(query: query)).body!;
        return items.map(
          (AutocompleteBill item) =>
              _FireflyResourceOption(id: item.id, name: item.name),
        );
      case FireflyResourceKind.currency:
        final AutocompleteCurrencyArray items =
            (await api.v1AutocompleteCurrenciesGet(query: query)).body!;
        return items.map(
          (AutocompleteCurrency item) =>
              _FireflyResourceOption(id: item.id, name: item.name),
        );
      case FireflyResourceKind.piggyBank:
        final AutocompletePiggyArray items =
            (await api.v1AutocompletePiggyBanksGet(query: query)).body!;
        return items.map(
          (AutocompletePiggy item) =>
              _FireflyResourceOption(id: item.id, name: item.name),
        );
    }
  }

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    elevation: 0,
    color:
        notificationDialogSurfaceColor(context) ??
        Theme.of(context).colorScheme.surfaceContainerLow,
    shape: notificationControlShape(context),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: AutoCompleteText<_FireflyResourceOption>(
        textController: _controller,
        focusNode: _focusNode,
        labelText: S.of(context).notificationsActionSearchFirefly,
        optionsViewOffset: Offset.zero,
        displayStringForOption: (_FireflyResourceOption option) => option.name,
        optionsBuilder: (TextEditingValue value) => _options(value.text),
        onSelected: (_FireflyResourceOption option) => widget.onSelected(
          FireflyResourceValueSource(
            resourceKind: widget.resourceKind,
            resourceId: option.id,
          ),
        ),
      ),
    ),
  );
}

class _FireflyResourceOption {
  const _FireflyResourceOption({required this.id, required this.name});

  final String id;
  final String name;
}
