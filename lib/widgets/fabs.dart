import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:waterflyiii/pages/transaction.dart';

class NewTransactionFab extends StatelessWidget {
  const NewTransactionFab({
    super.key,
    required this.context,
    this.accountId,
  });

  final BuildContext context;
  final String? accountId;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openBuilder: (BuildContext context, Function closedContainer) {
        return TransactionPage(accountId: accountId);
      },
      openColor: Theme.of(context).cardColor,
      closedColor: Theme.of(context).colorScheme.primaryContainer,
      closedShape: Theme.of(context).floatingActionButtonTheme.shape ??
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
      closedElevation:
          Theme.of(context).floatingActionButtonTheme.elevation ?? 6,
      closedBuilder: (BuildContext context, Function openContainer) {
        return FloatingActionButton(
          onPressed: () => openContainer(),
          tooltip: S.of(context).formButtonTransactionAdd,
          child: const Icon(Icons.add),
        );
      },
    );
  }
}
