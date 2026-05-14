import 'dart:async';

import 'package:async/async.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/widgets/autocompletetext.dart';

bool _savingInProgress = false; // :TODO:

class TransactionTitle extends StatelessWidget {
  const TransactionTitle({
    super.key,
    required this.textController,
    required this.focusNode,
  });

  final TextEditingController textController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final Logger log = Logger("Pages.Transaction.Title");

    CancelableOperation<Response<AutocompleteTransactionArray>>? fetchOp;

    log.finest(() => "build()");
    return Expanded(
      child: AutoCompleteText<String>(
        disabled: _savingInProgress,
        labelText: S.of(context).transactionFormLabelTitle,
        labelIcon: Icons.receipt_long,
        textController: textController,
        focusNode: focusNode,
        optionsBuilder: (TextEditingValue textEditingValue) async {
          try {
            unawaited(fetchOp?.cancel());

            final FireflyIii api = context.read<FireflyService>().api;
            fetchOp =
                CancelableOperation<
                  Response<AutocompleteTransactionArray>
                >.fromFuture(
                  api.v1AutocompleteTransactionsGet(
                    query: textEditingValue.text,
                  ),
                );
            final Response<AutocompleteTransactionArray>? response =
                await fetchOp?.valueOrCancellation();
            if (response == null) {
              // Cancelled
              return const Iterable<String>.empty();
            }
            apiThrowErrorIfEmpty(response, context.mounted ? context : null);

            return response.body!.map((AutocompleteTransaction e) => e.name);
          } catch (e, stackTrace) {
            log.severe(
              "Error while fetching autocomplete from API",
              e,
              stackTrace,
            );
            return const Iterable<String>.empty();
          }
        },
      ),
    );
  }
}
