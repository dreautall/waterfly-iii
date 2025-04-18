import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/layout.dart';
import 'package:waterflyiii/pages/transaction.dart';

class NewTransactionFab extends StatelessWidget {
  const NewTransactionFab({super.key, required this.context, this.accountId});

  final BuildContext context;
  final String? accountId;

  @override
  Widget build(BuildContext context) {
    if (context.watch<LayoutProvider>().currentSize >= ScreenSize.expanded) {
      return FloatingActionButton(
        onPressed:
            () => showDialog(
              context: context,
              builder:
                  (BuildContext context) => AlertDialog(
                    title: Text(S.of(context).transactionTitleAdd),
                    content: Container(
                      constraints: BoxConstraints(
                        minWidth: 280,
                        maxWidth: MediaQuery.of(context).size.width * 0.5,
                      ),
                      width: double.maxFinite,
                      child: TransactionPage(accountId: accountId),
                    ),
                  ),
            ),
        tooltip: S.of(context).formButtonTransactionAdd,
        elevation: 0,
        child: const Icon(Icons.add),
      );
    } else {
      return OpenContainer(
        openBuilder:
            (BuildContext context, Function closedContainer) =>
                TransactionPage(accountId: accountId),
        openColor: Theme.of(context).cardColor,
        closedColor: Theme.of(context).colorScheme.primaryContainer,
        closedShape:
            Theme.of(context).floatingActionButtonTheme.shape ??
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
        closedElevation:
            Theme.of(context).floatingActionButtonTheme.elevation ?? 6,
        closedBuilder: (BuildContext context, Function openContainer) {
          return FloatingActionButton(
            onPressed: () => openContainer(),
            tooltip: S.of(context).formButtonTransactionAdd,
            child: const Icon(Icons.add),
          );
        },
        onClosed: (bool? refresh) {
          if (refresh ?? false == true) {
            if (context.mounted) {
              context.read<FireflyService>().transStock!.clear();
            }
          }
        },
      );
    }
  }
}
