import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart' show Response, HttpMethod;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/transaction/tags.dart';
import 'package:waterflyiii/timezonehandler.dart';

final Logger log = Logger("Pages.Transaction.State");

class TransactionState extends ChangeNotifier {
  TransactionTypeProperty type = .swaggerGeneratedUnknown;
  String? ownAccountID;
  final TextEditingController groupTitleTC = TextEditingController();
  final FocusNode groupTitleFN = FocusNode();
  final TextEditingController totalAmountTC = TextEditingController();
  final FocusNode totalAmountFN = FocusNode();
  late tz.TZDateTime _date;
  final TextEditingController dateTC = TextEditingController();
  final TextEditingController timeTC = TextEditingController();
  CurrencyRead localCurrency;
  bool reconciled = false;
  bool initiallyReconciled = false;
  final List<TransactionSplitState> splits = <TransactionSplitState>[];
  List<AttachmentRead>? _attachments = <AttachmentRead>[];
  AccountTypeProperty sourceAccountType = .swaggerGeneratedUnknown;
  AccountTypeProperty destinationAccountType = .swaggerGeneratedUnknown;
  final List<String> _deletedSplitIDs = <String>[];
  final TransactionRead? originalTX;

  bool get split => splits.length > 1;

  double get totalAmount => splits.fold(
    0,
    (double sum, TransactionSplitState s) => sum + s.localAmount,
  );

  tz.TZDateTime get date => _date;

  set date(tz.TZDateTime date) {
    log.finest(() => "[TS] set date");
    // same as date.copyWith(second: 0, millisecond: 0, microsecond: 0)
    _date = tz.TZDateTime(
      date.location,
      date.year,
      date.month,
      date.day,
      date.hour,
      date.minute,
    );
    dateTC.text = DateFormat.yMMMd().format(_date);
    timeTC.text = DateFormat.Hm().format(_date);
    //notifyListeners();
  }

  List<AttachmentRead>? get attachments => _attachments;

  bool get hasAttachments => attachments?.isNotEmpty ?? false;

  set attachments(List<AttachmentRead>? attachments) {
    log.finest(() => "[TS] set attachments");
    _attachments = attachments;
    notifyListeners();
  }

  bool get hasCommonSourceAccount {
    if (!split) {
      return true;
    }
    return splits.every(
      (TransactionSplitState s) =>
          s.sourceAccountTC.text == splits.first.sourceAccountTC.text,
    );
  }

  bool get showSplitSourceAccounts =>
      type == .deposit && !hasCommonSourceAccount;

  bool get hasCommonDestinationAccount {
    if (!split) {
      return true;
    }
    return splits.every(
      (TransactionSplitState s) =>
          s.destinationAccountTC.text == splits.first.destinationAccountTC.text,
    );
  }

  bool get showSplitDestinationAccounts =>
      type == .withdrawal && !hasCommonDestinationAccount;

  TransactionState(this.localCurrency, {this.originalTX});

  void notify() => notifyListeners();

  void updateAmount() {
    if (!split) {
      return;
    }
    totalAmountTC.text = totalAmount.toStringAsFixed(
      localCurrency.attributes.decimalPlaces ?? 2,
    );
  }

  void addAttachment(AttachmentRead attachment) {
    log.finest(() => "[TS] addAttachment()");
    _attachments ??= <AttachmentRead>[];
    _attachments!.add(attachment);
    notifyListeners();
  }

  void splitAdd() {
    log.fine(() => "[TS] splitAdd()");
    final bool initialCommonSource = hasCommonSourceAccount;
    final bool initialCommonDestination = hasCommonDestinationAccount;
    splits.add(TransactionSplitState(this));

    if (initialCommonSource) {
      splits.last.sourceAccountTC.text = splits.first.sourceAccountTC.text;
    }
    if (initialCommonDestination) {
      splits.last.destinationAccountTC.text =
          splits.first.destinationAccountTC.text;
    }

    // As firefly doesn't allow editing accounts or sums when reconciled,
    // deactivate reconciled.
    reconciled = false;

    notifyListeners();
  }

  bool splitRemove(int i) {
    log.fine(() => "[TS] splitRemove($i)");
    if (splits.length == 1) {
      log.severe(("trying to remove last split!"));
      return false;
    }
    if (splits[i].journalID != null) {
      _deletedSplitIDs.add(splits[i].journalID!);
    }
    splits[i].dispose();
    splits.removeAt(i);

    // As firefly doesn't allow editing accounts or sums when reconciled,
    // deactivate reconciled.
    reconciled = false;
    // Recalculate total amount
    totalAmountTC.text = totalAmount.toStringAsFixed(
      localCurrency.attributes.decimalPlaces ?? 2,
    );

    notifyListeners();
    return true;
  }

  void setSourceAccount(String s) {
    log.finest(() => "[TS] setSourceAccount($s)");

    for (final TransactionSplitState split in splits) {
      split.sourceAccountTC.text = s;
    }
    if (sourceAccountType.isAsset) {
      ownAccountID = null;
    }
    sourceAccountType = .swaggerGeneratedUnknown;

    _checkTXType();
  }

  void selectSourceAccount(AutocompleteAccount option) {
    log.finest(() => "[TS] selectSourceAccount(${option.name})");

    for (final TransactionSplitState split in splits) {
      split.sourceAccountTC.text = option.name;
    }
    sourceAccountType = AccountTypeProperty.values.firstWhere(
      (AccountTypeProperty e) => e.value == option.type,
      orElse: () => .swaggerGeneratedUnknown,
    );
    log.finer(
      () =>
          "selected source account ${option.name}, type ${sourceAccountType.toString()} (${option.type})",
    );
    if (sourceAccountType.isAsset) {
      ownAccountID = option.id;
    }

    _checkTXType();
  }

  void setDestinationAccount(String s) {
    log.finest(() => "[TS] setDestinationAccount($s)");

    for (final TransactionSplitState split in splits) {
      split.destinationAccountTC.text = s;
    }
    if (destinationAccountType.isAsset) {
      ownAccountID = null;
    }
    destinationAccountType = .swaggerGeneratedUnknown;

    _checkTXType();
  }

  void selectDestinationAccount(AutocompleteAccount option) {
    log.finest(() => "[TS] selectDestinationAccount(${option.name})");

    for (final TransactionSplitState split in splits) {
      split.destinationAccountTC.text = option.name;
    }
    destinationAccountType = AccountTypeProperty.values.firstWhere(
      (AccountTypeProperty e) => e.value == option.type,
      orElse: () => .swaggerGeneratedUnknown,
    );
    log.finer(
      () =>
          "selected destination account ${option.name}, type ${destinationAccountType.toString()} (${option.type})",
    );
    if (destinationAccountType.isAsset) {
      ownAccountID = option.id;
    }

    _checkTXType();
  }

  TransactionTypeProperty computeTransactionType() {
    log.finest(() => "[TS] computeTransactionType()");

    TransactionTypeProperty txType = accountsToTransaction(
      sourceAccountType,
      destinationAccountType,
    );

    /* WATERFLY CUSTOM - NOT FIREFLY BEHAVIOR!
     * To ease UX, two assumptions:
     * 1. If only source is entered & it's an asset account, it'll be a
     *    withdrawal
     * 2. If only destination is entered & it's an asset account, it'll be a
     *    deposit
     *
     * As _ownAccountId will be set for both of these scenarios, the other one
     * would potentially be created by FF3 when saving. The actual webinterface
     * only does this when saving (but also throws an error when no ownAccount
     * is explicitly selected from the dropdown! Just typing the name [just as
     * in this app] will throw an error!).
     */
    if (txType == .swaggerGeneratedUnknown &&
        sourceAccountType == .assetAccount &&
        destinationAccountType == .swaggerGeneratedUnknown) {
      txType = .withdrawal;
    } else if (txType == .swaggerGeneratedUnknown &&
        sourceAccountType == .swaggerGeneratedUnknown &&
        destinationAccountType == .assetAccount) {
      txType = .deposit;
    }

    return txType;
  }

  void _checkTXType() {
    log.finest(() => "[TS] checkTXType()");

    final TransactionTypeProperty newType = computeTransactionType();

    if (type != newType) {
      type = newType;

      // Withdrawal: splits have common source account
      // Deposit: splits have common destination account
      // Transfer: splits have common accounts for both
      if (type == .withdrawal || type == .transfer) {
        for (final TransactionSplitState s in splits) {
          s.sourceAccountTC.text = splits.first.sourceAccountTC.text;
        }
      }
      if (type == .deposit || type == .transfer) {
        for (final TransactionSplitState s in splits) {
          s.destinationAccountTC.text = splits.first.destinationAccountTC.text;
        }
      }

      log.finest(() => "[TS] checkTXType(): notify due to new $type");
      notifyListeners();
    }
  }

  TransactionSplitUpdate _filterSameFields(TransactionSplitUpdate txU) {
    /* https://github.com/firefly-iii/firefly-iii/blob/main/app/Validation/GroupValidation.php#L105
     $forbidden = ['amount', 'foreign_amount', 'currency_code', 'currency_id', 'foreign_currency_code', 'foreign_currency_id',
       'source_id', 'source_name', 'source_number', 'source_iban',
       'destination_id', 'destination_name', 'destination_number', 'destination_iban',
     ];
       */
    // if no originalTX exists or the journal is new --> nothing to filter
    if (originalTX == null || (txU.transactionJournalId?.isEmpty ?? true)) {
      return txU;
    }
    final TransactionSplit? tx = originalTX!.attributes.transactions
        .firstWhereOrNull(
          (TransactionSplit s) =>
              s.transactionJournalId == txU.transactionJournalId,
        );
    // if no previous transaction with the journalID is found --> nothing to filter
    if (tx == null) {
      return txU;
    }
    return txU.copyWith(
      amount: tx.amount == txU.amount ? null : txU.amount,
      foreignAmount: tx.foreignAmount == txU.foreignAmount
          ? null
          : txU.foreignAmount,
      foreignCurrencyId: tx.foreignCurrencyId == txU.foreignCurrencyId
          ? null
          : txU.foreignCurrencyId,
      sourceName: tx.sourceName == txU.sourceName ? null : txU.sourceName,
      destinationName: tx.destinationName == txU.destinationName
          ? null
          : txU.destinationName,
    );
  }

  Future<TransactionRead> save(FireflyIii api, AuthUser user) async {
    log.info("[TS] save()");
    late Response<TransactionSingle> resp;
    if (originalTX == null) {
      // new TX
      resp = await api.v1TransactionsPost(body: _toStore());
    } else {
      // updated TX
      final List<Future<Response<dynamic>>> futures = _deletedSplitIDs
          .where((String id) => id.isNotEmpty)
          .map((String id) {
            log.fine(() => "[TS] save(): deleting split $id");
            return api.v1TransactionJournalsIdDelete(id: id);
          })
          .toList();
      if (futures.isNotEmpty) {
        await Future.wait(futures);
      }
      resp = await api.v1TransactionsIdPut(
        id: originalTX!.id,
        body: _toUpdate(),
      );
    }

    // Check if insert/update was successful
    if (!resp.isSuccessful || resp.body == null) {
      String? error;
      try {
        final ValidationErrorResponse valError = .fromJson(
          json.decode(resp.error.toString()),
        );
        error = valError.message;
      } catch (_) {}
      log.severe("[TS] save(): failed ($error)");
      throw Exception(error);
    }

    // for new TX: save transactions
    if ((_attachments?.isNotEmpty ?? false) && originalTX == null) {
      log.fine(
        () => "[TS] save(): uploading ${_attachments!.length} attachments",
      );
      final TransactionSplit? tx = resp.body?.data.attributes.transactions
          .firstWhereOrNull(
            (TransactionSplit e) => e.transactionJournalId != null,
          );
      if (tx != null) {
        final String txId = tx.transactionJournalId!;
        log.finest(() => "[TS] save(): uploading to txId $txId");
        for (AttachmentRead attachment in _attachments!) {
          log.finest(
            () =>
                "[TS] save(): uploading attachment ${attachment.id}: ${attachment.attributes.filename}",
          );
          final Response<AttachmentSingle> respAttachment = await api
              .v1AttachmentsPost(
                body: AttachmentStore(
                  filename: attachment.attributes.filename!,
                  attachableType: .transactionjournal,
                  attachableId: txId,
                ),
              );
          if (!respAttachment.isSuccessful || respAttachment.body == null) {
            log.warning(() => "[TS] save(): error uploading attachment");
            continue;
          }
          final AttachmentRead newAttachment = respAttachment.body!.data;
          log.finest(() => "[TS] save(): attachment id is ${newAttachment.id}");

          final File file = File(attachment.attributes.uploadUrl!);

          final http.StreamedRequest request = http.StreamedRequest(
            HttpMethod.Post,
            Uri.parse(newAttachment.attributes.uploadUrl!),
          );
          request.headers.addAll(user.headers());
          request.headers[HttpHeaders.contentTypeHeader] =
              ContentType.binary.mimeType;
          request.contentLength = await file.length();
          log.fine(() => "[TS] save(): Starting Upload ${newAttachment.id}");

          file.openRead().listen(
            (List<int> data) {
              log.finest(() => "[TS] save(): sent ${data.length} bytes");
              request.sink.add(data);
            },
            onDone: () {
              request.sink.close();
            },
          );

          await httpClient.send(request);

          log.fine(() => "[TS] save(): done uploading attachment");
        }
      }
    }

    return resp.body!.data;
  }

  TransactionStore _toStore() => TransactionStore(
    groupTitle: split ? groupTitleTC.text : null,
    transactions: <TransactionSplitStore>[
      ...splits.map((TransactionSplitState s) => s.toStore()),
    ],
    applyRules: true,
    fireWebhooks: true,
    errorIfDuplicateHash: true,
  );

  TransactionUpdate _toUpdate() => TransactionUpdate(
    groupTitle: split ? groupTitleTC.text : null,
    transactions: <TransactionSplitUpdate>[
      ...splits.map(
        (TransactionSplitState s) => _filterSameFields(s.toUpdate()),
      ),
    ],
  );

  @override
  void dispose() {
    log.fine(() => "[TS] dispose");

    for (final TransactionSplitState s in splits) {
      s.dispose();
    }
    groupTitleTC.dispose();
    groupTitleFN.dispose();
    totalAmountTC.dispose();
    totalAmountFN.dispose();
    dateTC.dispose();
    timeTC.dispose();

    super.dispose();
  }

  static TransactionState fromExisting(
    TransactionRead transaction,
    TimeZoneHandler tzHandler,
  ) {
    final List<TransactionSplit> transactions =
        transaction.attributes.transactions;

    // Common values
    final TransactionState tx = TransactionState(
      CurrencyRead(
        type: "currencies",
        id: transactions.first.currencyId!,
        attributes: CurrencyProperties(
          code: transactions.first.currencyCode!,
          name: transactions.first.currencyName!,
          symbol: transactions.first.currencySymbol!,
          decimalPlaces: transactions.first.currencyDecimalPlaces,
        ),
      ),
      originalTX: transaction,
    );
    tx.type = transactions.first.type;

    /// title
    if (transaction.attributes.groupTitle?.isNotEmpty ?? false) {
      tx.groupTitleTC.text = transaction.attributes.groupTitle!;
    }

    /// own account
    switch (tx.type) {
      case .withdrawal:
      case .transfer:
        tx.ownAccountID = transactions.first.sourceId;
        break;
      case .deposit:
      case .openingBalance:
      case .reconciliation:
        tx.ownAccountID = transactions.first.destinationId;
        break;
      default:
    }

    /// date
    tx.date = tzHandler.sTime(transactions.first.date).toLocal();

    // Reconciled
    tx.reconciled = transactions.first.reconciled ?? false;
    if (tx.reconciled) {
      tx.initiallyReconciled = true;
    }

    bool hasAttachments = false;

    for (TransactionSplit trans in transactions) {
      final TransactionSplitState newSplit = TransactionSplitState(tx);

      // Always in card view
      /// Category
      newSplit.categoryTC.text = trans.categoryName ?? "";

      //// Budget
      newSplit.budgetTC.text = trans.budgetName ?? "";

      /// Tags
      newSplit.tags = Tags(trans.tags ?? <String>[]);

      /// Notes
      newSplit.noteTC.text = trans.notes ?? "";

      /// Bill
      if ((trans.billId?.isNotEmpty ?? false) && trans.billId != "0") {
        newSplit.bill = BillRead(
          type: "bill",
          id: trans.billId ?? "",
          attributes: BillProperties(
            name: trans.billName ?? "",
            amountMin: "",
            amountMax: "",
            date: DateTime.now(),
            repeatFreq: .swaggerGeneratedUnknown,
          ),
        );
      }

      // Individual for split transactions
      /// Title
      newSplit.titleTC.text = trans.description;

      /// local amount
      newSplit.localAmount = double.tryParse(trans.amount) ?? 0.0;
      newSplit.localAmountUpdateText();

      /// source account
      newSplit.sourceAccountTC.text = trans.sourceName ?? "";
      tx.sourceAccountType = trans.sourceType!;

      /// target account
      newSplit.destinationAccountTC.text = trans.destinationName ?? "";
      tx.destinationAccountType = trans.destinationType!;

      /// foreign currency
      //// foreign currency
      if (trans.foreignCurrencyCode?.isNotEmpty ?? false) {
        newSplit.foreignCurrency = CurrencyRead(
          type: "currencies",
          id: trans.foreignCurrencyId!,
          attributes: CurrencyProperties(
            code: trans.foreignCurrencyCode!,
            name: "", // empty
            symbol: trans.foreignCurrencySymbol!,
            decimalPlaces: trans.foreignCurrencyDecimalPlaces,
          ),
        );
      }
      //// foreign amount
      newSplit.foreignAmount = double.tryParse(trans.foreignAmount ?? '') ?? 0;
      if (newSplit.foreignAmount != 0) {
        newSplit.foreignAmountUpdateText();
      }

      /// Journal ID
      newSplit.journalID = trans.transactionJournalId;

      /// attachments
      hasAttachments = hasAttachments || (trans.hasAttachments ?? false);

      tx.splits.add(newSplit);
    }

    if (hasAttachments) {
      // If any split had an attachment, there are some. Set to "null" to
      // trigger a separate API call to fetch the list!
      tx.attachments = null;
    }

    return tx;
  }
}

class TransactionSplitState {
  final TransactionState parent;

  // Always in card view
  final TextEditingController categoryTC = TextEditingController();
  final FocusNode categoryFN = FocusNode();
  final TextEditingController budgetTC = TextEditingController();
  final FocusNode budgetFN = FocusNode();
  Tags tags = Tags();
  final TextEditingController tagsTC = TextEditingController();
  final TextEditingController noteTC = TextEditingController();
  BillRead? bill;
  PiggyBankRead? piggy;

  // Individual for split transactions
  final TextEditingController titleTC = TextEditingController();
  final FocusNode titleFN = FocusNode();
  final TextEditingController sourceAccountTC = TextEditingController();
  final FocusNode sourceAccountFN = FocusNode();
  final TextEditingController destinationAccountTC = TextEditingController();
  final FocusNode destinationAccountFN = FocusNode();
  double _localAmount = 0.0;
  final TextEditingController localAmountTC = TextEditingController();
  final FocusNode localAmountFN = FocusNode();
  double _foreignAmount = 0.0;
  final TextEditingController foreignAmountTC = TextEditingController();
  final FocusNode foreignAmountFN = FocusNode();
  CurrencyRead? foreignCurrency;
  String? journalID;

  CurrencyRead get localCurrency => parent.localCurrency;

  double get localAmount => _localAmount;

  set localAmount(double amount) {
    log.fine(() => "[TSS] set localAmount($amount)");
    _localAmount = amount;
    // To update the global amount for splits
    parent.updateAmount();
  }

  double get foreignAmount => _foreignAmount;

  set foreignAmount(double amount) {
    log.fine(() => "[TSS] set foreignAmount($amount)");
    _foreignAmount = amount;
  }

  TransactionSplitState(this.parent) {
    sourceAccountFN.addListener(() {
      if (!sourceAccountFN.hasFocus && parent.hasCommonSourceAccount) {
        parent.notify();
      }
    });
    destinationAccountFN.addListener(() {
      if (!destinationAccountFN.hasFocus &&
          parent.hasCommonDestinationAccount) {
        parent.notify();
      }
    });
  }

  void localAmountUpdateText() {
    log.finest(() => "[TSS] localAmountUpdateText()");
    localAmountTC.text = _localAmount.toStringAsFixed(
      localCurrency.attributes.decimalPlaces ?? 2,
    );
  }

  void foreignAmountUpdateText() {
    log.finest(() => "[TSS] localAmountUpdateText()");
    foreignAmountTC.text = _foreignAmount.toStringAsFixed(
      foreignCurrency?.attributes.decimalPlaces ?? 2,
    );
  }

  TransactionSplitStore toStore() => TransactionSplitStore(
    type: parent.type,
    date: parent.date,
    amount: localAmount.toString(),
    description: titleTC.text,
    billId: bill?.id ?? "0",
    piggyBankId: (piggy?.id != null) ? int.parse(piggy!.id) : null,
    budgetName: parent.type == .withdrawal ? budgetTC.text : "",
    categoryName: categoryTC.text,
    destinationName: destinationAccountTC.text,
    // :HAX: Since nulled fields are not submitted, we set
    // the value to 0 so the foreign currency is gone...
    foreignAmount: foreignCurrency != null ? foreignAmountTC.text : "0",
    foreignCurrencyId: foreignCurrency?.id,
    notes: noteTC.text,
    // order: :TODO:
    sourceName: sourceAccountTC.text,
    tags: tags.tags,
    reconciled: parent.reconciled,
  );

  TransactionSplitUpdate toUpdate() => TransactionSplitUpdate(
    type: parent.type,
    date: parent.date,
    amount: localAmount.toString(),
    description: titleTC.text,
    billId: bill?.id ?? "0",
    budgetName: parent.type == .withdrawal ? budgetTC.text : "",
    categoryName: categoryTC.text,
    destinationName: destinationAccountTC.text,
    // :HAX: Since nulled fields are not submitted, we set
    // the value to 0 so the foreign currency is gone...
    foreignAmount: foreignCurrency != null ? foreignAmountTC.text : "0",
    foreignCurrencyId: foreignCurrency?.id,
    notes: noteTC.text,
    // order: :TODO:
    sourceName: sourceAccountTC.text,
    tags: tags.tags,
    reconciled: parent.reconciled,
  );

  void dispose() {
    log.fine(() => "[TSS] dispose()");

    categoryTC.dispose();
    categoryFN.dispose();
    budgetTC.dispose();
    budgetFN.dispose();
    tagsTC.dispose();
    noteTC.dispose();
    titleTC.dispose();
    titleFN.dispose();
    sourceAccountTC.dispose();
    sourceAccountFN.dispose();
    destinationAccountTC.dispose();
    destinationAccountFN.dispose();
    localAmountTC.dispose();
    localAmountFN.dispose();
    foreignAmountTC.dispose();
    foreignAmountFN.dispose();
  }
}
