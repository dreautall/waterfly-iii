import 'package:flutter/material.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';

class DeletionConfirmDialog extends StatelessWidget {
  const DeletionConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      icon: const Icon(Icons.delete),
      title: Text(S.of(context).transactionTitleDelete),
      clipBehavior: Clip.hardEdge,
      actions: <Widget>[
        TextButton(
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
          child: Text(MaterialLocalizations.of(context).deleteButtonTooltip),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
      content: Text(S.of(context).transactionDeleteConfirm),
    );
  }
}
