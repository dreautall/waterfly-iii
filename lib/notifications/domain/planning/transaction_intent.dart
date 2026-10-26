import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';

class TransactionIntent {
  const TransactionIntent({required this.mode, required this.patch});

  final TransactionCreationMode mode;
  final TransactionPatch patch;

  factory TransactionIntent.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> patch = json['patch'] as Map<String, dynamic>;
    return TransactionIntent(
      mode: TransactionCreationMode.values.byName(json['mode'] as String),
      patch: TransactionPatch.fromJson(patch),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'mode': mode.name,
    'patch': patch.toJson(),
  };
}
