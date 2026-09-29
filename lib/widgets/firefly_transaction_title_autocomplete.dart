import 'dart:async';

import 'package:async/async.dart';
import 'package:chopper/chopper.dart';
import 'package:logging/logging.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/widgets/autocompletetext.dart';

typedef TransactionTitleSuggestionLoader =
    Future<List<String>> Function(String query);

class FireflyTransactionTitleAutocomplete extends StatefulWidget {
  const FireflyTransactionTitleAutocomplete({
    super.key,
    required this.textController,
    required this.focusNode,
    required this.labelText,
    this.fieldKey,
    this.labelIcon,
    this.disabled = false,
    this.errorText,
    this.errorIconOnly = false,
    this.onChanged,
    this.suggestionLoader,
  });

  final TextEditingController textController;
  final FocusNode focusNode;
  final String labelText;
  final Key? fieldKey;
  final IconData? labelIcon;
  final bool disabled;
  final String? errorText;
  final bool errorIconOnly;
  final ValueChanged<String>? onChanged;
  final TransactionTitleSuggestionLoader? suggestionLoader;

  @override
  State<FireflyTransactionTitleAutocomplete> createState() =>
      _FireflyTransactionTitleAutocompleteState();
}

class _FireflyTransactionTitleAutocompleteState
    extends State<FireflyTransactionTitleAutocomplete> {
  static final Logger _log = Logger('Widgets.FireflyTransactionTitle');
  CancelableOperation<List<String>>? _fetchOperation;

  @override
  void dispose() {
    unawaited(_fetchOperation?.cancel());
    super.dispose();
  }

  Future<Iterable<String>> _options(TextEditingValue value) async {
    try {
      unawaited(_fetchOperation?.cancel());
      _fetchOperation = CancelableOperation<List<String>>.fromFuture(
        _load(value.text),
      );
      return await _fetchOperation!.valueOrCancellation() ?? <String>[];
    } catch (error, stackTrace) {
      _log.severe(
        'Error while fetching transaction title autocomplete from API.',
        error,
        stackTrace,
      );
      return const <String>[];
    }
  }

  Future<List<String>> _load(String query) async {
    if (widget.suggestionLoader
        case final TransactionTitleSuggestionLoader loader) {
      return loader(query);
    }
    final FireflyIii api = context.read<FireflyService>().api;
    final Response<AutocompleteTransactionArray> response = await api
        .v1AutocompleteTransactionsGet(query: query);
    apiThrowErrorIfEmpty(response, mounted ? context : null);
    return response.body!
        .map((AutocompleteTransaction transaction) => transaction.name)
        .toList();
  }

  @override
  Widget build(BuildContext context) => AutoCompleteText<String>(
    fieldKey: widget.fieldKey,
    disabled: widget.disabled,
    labelText: widget.labelText,
    labelIcon: widget.labelIcon,
    textController: widget.textController,
    focusNode: widget.focusNode,
    errorText: widget.errorText,
    errorIconOnly: widget.errorIconOnly,
    optionsBuilder: _options,
    onChanged: widget.onChanged,
    onSelected: widget.onChanged,
  );
}
