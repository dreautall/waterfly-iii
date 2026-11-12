import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/widgets/firefly_transaction_title_autocomplete.dart';

class TransactionTitle extends StatelessWidget {
  const TransactionTitle({
    super.key,
    required this.textController,
    required this.focusNode,
    required this.savingInProgress,
  });

  final TextEditingController textController;
  final FocusNode focusNode;
  final bool savingInProgress;

  @override
  Widget build(BuildContext context) => Expanded(
    child: FireflyTransactionTitleAutocomplete(
      disabled: savingInProgress,
      labelText: S.of(context).transactionFormLabelTitle,
      labelIcon: Icons.receipt_long,
      textController: textController,
      focusNode: focusNode,
    ),
  );
}
