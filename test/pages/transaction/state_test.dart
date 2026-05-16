import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:intl/intl.dart' as intl;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/transaction/state.dart';

import '../../fakes/authuser.dart';
import '../../fakes/timezonehandler.dart';

void main() {
  tz.initializeTimeZones();
  final tz.Location location = tz.UTC;

  group('TransactionState', () {
    late CurrencyRead usdCurrency;

    setUpAll(() {
      usdCurrency = const CurrencyRead(
        type: "currencies",
        id: "1",
        attributes: CurrencyProperties(
          code: "USD",
          name: "US Dollar",
          symbol: r"$",
          decimalPlaces: 2,
        ),
      );
    });

    test('Initial state', () {
      final TransactionState state = TransactionState(usdCurrency);
      expect(state.splits.length, 0);
      expect(state.totalAmount, 0.0);
      expect(state.newTX, true);
    });

    test('Date and Time controllers update', () {
      final TransactionState state = TransactionState(usdCurrency);
      final tz.TZDateTime now = tz.TZDateTime.now(location);
      state.date = now;

      expect(state.dateTC.text, intl.DateFormat.yMMMd().format(now));
      expect(state.timeTC.text, intl.DateFormat.Hm().format(now));
      expect(state.date.second, 0);
      expect(state.date.microsecond, 0);
      expect(state.date.millisecond, 0);
    });

    test('Add and remove splits', () {
      final TransactionState state = TransactionState(usdCurrency);
      state.splitAdd();
      expect(state.splits.length, 1);
      expect(state.split, false);

      state.splitAdd();
      expect(state.splits.length, 2);
      expect(state.split, true);

      state.splits[0].localAmount = 10.0;
      state.splits[1].localAmount = 20.0;
      expect(state.totalAmount, 30.0);
      expect(state.totalAmountTC.text, "30.00");

      state.splitRemove(0);
      expect(state.splits.length, 1);
      expect(state.totalAmount, 20.0);
      expect(state.totalAmountTC.text, "20.00");
      expect(state.split, false);
    });

    group('Compute Transaction Type', () {
      late TransactionState state;
      setUp(() {
        state = TransactionState(usdCurrency);
      });

      test('Withdrawal', () {
        state.sourceAccountType = AccountTypeProperty.assetAccount;
        state.destinationAccountType = AccountTypeProperty.expenseAccount;

        expect(
          state.computeTransactionType(),
          TransactionTypeProperty.withdrawal,
        );
      });

      test('Deposit', () {
        state.sourceAccountType = AccountTypeProperty.revenueAccount;
        state.destinationAccountType = AccountTypeProperty.assetAccount;

        expect(state.computeTransactionType(), TransactionTypeProperty.deposit);
      });

      test('Transfer', () {
        state.sourceAccountType = AccountTypeProperty.assetAccount;
        state.destinationAccountType = AccountTypeProperty.assetAccount;

        expect(
          state.computeTransactionType(),
          TransactionTypeProperty.transfer,
        );
      });

      test('Waterfly custom UX assumptions', () {
        // Only source asset account -> Withdrawal
        state.sourceAccountType = AccountTypeProperty.assetAccount;
        state.destinationAccountType =
            AccountTypeProperty.swaggerGeneratedUnknown;
        expect(
          state.computeTransactionType(),
          TransactionTypeProperty.withdrawal,
        );

        // Only destination asset account -> Deposit
        state.sourceAccountType = AccountTypeProperty.swaggerGeneratedUnknown;
        state.destinationAccountType = AccountTypeProperty.assetAccount;
        expect(state.computeTransactionType(), TransactionTypeProperty.deposit);
      });
    });

    test('selectSourceAccount updates type and splits', () {
      final TransactionState state = TransactionState(usdCurrency);
      state.splitAdd();
      state.splits[0].sourceAccountTC.text = "Old Source";

      final AutocompleteAccount option = const AutocompleteAccount(
        id: "123",
        name: "New Asset Account",
        nameWithBalance: "New Asset Account (\$100.00)",
        type: "Asset account",
        currencyId: "1",
        currencyName: "US Dollar",
        currencyCode: "USD",
        currencySymbol: r"$",
        currencyDecimalPlaces: 2,
      );

      state.selectSourceAccount(option);

      expect(state.sourceAccountType, AccountTypeProperty.assetAccount);
      expect(state.ownAccountID, "123");
      expect(state.splits[0].sourceAccountTC.text, "New Asset Account");
    });

    test('fromExisting creates correct state', () {
      final TransactionRead transaction = TransactionRead(
        type: "transactions",
        id: "1",
        links: const ObjectLink(),
        attributes: Transaction(
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          groupTitle: "Test Group",
          transactions: <TransactionSplit>[
            TransactionSplit(
              date: DateTime.now(),
              amount: "100.0",
              description: "Split 1",
              type: TransactionTypeProperty.withdrawal,
              sourceId: "1",
              sourceName: "Source Account",
              sourceType: AccountTypeProperty.assetAccount,
              destinationId: "2",
              destinationName: "Dest Account",
              destinationType: AccountTypeProperty.expenseAccount,
              currencyId: "1",
              currencyCode: "USD",
              currencyName: "US Dollar",
              currencySymbol: r"$",
              currencyDecimalPlaces: 2,
            ),
          ],
        ),
      );

      final TransactionState state = TransactionState.fromExisting(
        transaction,
        FakeTimeZoneHandler(),
      );

      expect(state.groupTitleTC.text, "Test Group");
      expect(state.splits.length, 1);
      expect(state.splits[0].titleTC.text, "Split 1");
      expect(state.splits[0].localAmount, 100.0);
      expect(state.totalAmount, 100.0);
      expect(state.type, TransactionTypeProperty.withdrawal);
      expect(state.ownAccountID, "1");
    });

    test('toUpdate filters unchanged fields', () {
      final TransactionRead transaction = TransactionRead(
        type: "transactions",
        id: "1",
        links: const ObjectLink(),
        attributes: Transaction(
          groupTitle: "Test Group",
          transactions: <TransactionSplit>[
            TransactionSplit(
              transactionJournalId: "1",
              date: DateTime.now(),
              amount: "100.5",
              description: "Split 1",
              type: TransactionTypeProperty.withdrawal,
              sourceId: "1",
              sourceName: "Source Account",
              sourceType: AccountTypeProperty.assetAccount,
              destinationId: "2",
              destinationName: "Dest Account",
              destinationType: AccountTypeProperty.expenseAccount,
              currencyId: "1",
              currencyCode: "USD",
              currencyName: "US Dollar",
              currencySymbol: r"$",
              currencyDecimalPlaces: 2,
            ),
          ],
        ),
      );

      final TransactionState state = TransactionState.fromExisting(
        transaction,
        FakeTimeZoneHandler(),
      );

      // Change only the description
      state.splits[0].titleTC.text = "New Description";

      final TransactionUpdate update = state.toUpdate();
      final TransactionSplitUpdate splitUpdate = update.transactions!.first;

      expect(splitUpdate.description, "New Description");
      expect(splitUpdate.amount, null);
      expect(splitUpdate.sourceName, null);
    });

    test('save calls delete for removed splits', () async {
      final TransactionRead transaction = TransactionRead(
        type: "transactions",
        id: "1",
        links: const ObjectLink(self: "url"),
        attributes: Transaction(
          transactions: <TransactionSplit>[
            TransactionSplit(
              transactionJournalId: "1",
              date: DateTime.now(),
              amount: "50.0",
              description: "Split 1",
              type: TransactionTypeProperty.withdrawal,
              sourceType: AccountTypeProperty.assetAccount,
              destinationType: AccountTypeProperty.expenseAccount,
              currencyId: "1",
              currencyCode: "USD",
              currencyName: "US Dollar",
              currencySymbol: r"$",
            ),
            TransactionSplit(
              transactionJournalId: "2",
              date: DateTime.now(),
              amount: "50.0",
              description: "Split 2",
              type: TransactionTypeProperty.withdrawal,
              sourceType: AccountTypeProperty.assetAccount,
              destinationType: AccountTypeProperty.expenseAccount,
              currencyId: "1",
              currencyCode: "USD",
              currencyName: "US Dollar",
              currencySymbol: r"$",
            ),
          ],
        ),
      );

      final TransactionState state = TransactionState.fromExisting(
        transaction,
        FakeTimeZoneHandler(),
      );
      state.splitRemove(1); // removes 2nd split

      bool deleteCalled = false;
      final MockClient mockHttpClient = MockClient((
        http.Request request,
      ) async {
        if (request.method == 'DELETE' && request.url.path.contains('2')) {
          deleteCalled = true;
          return http.Response('', 204);
        }
        if (request.method == 'PUT') {
          return http.Response(
            json.encode(<String, Map<String, dynamic>>{
              "data": transaction.toJson(),
            }),
            200,
          );
        }
        return http.Response('Not Found', 404);
      });

      final ChopperClient chopperClient = ChopperClient(
        client: mockHttpClient,
        services: <ChopperService>[FireflyIii.create()],
        converter: $JsonSerializableConverter(),
      );
      final FireflyIii api = chopperClient.getService<FireflyIii>();

      await state.save(api, FakeAuthUser());

      expect(deleteCalled, true);
    });
  });

  group('TransactionSplitState', () {
    late TransactionState parent;
    late CurrencyRead usdCurrency;

    setUpAll(() {
      usdCurrency = const CurrencyRead(
        type: "currencies",
        id: "1",
        attributes: CurrencyProperties(
          code: "USD",
          name: "US Dollar",
          symbol: r"$",
          decimalPlaces: 2,
        ),
      );
      parent = TransactionState(usdCurrency);
    });

    test('localAmountUpdateText formats correctly', () {
      final TransactionSplitState split = TransactionSplitState(parent);
      split.localAmount = 123.456;
      split.localAmountUpdateText();

      expect(split.localAmountTC.text, "123.46");
    });

    test('toStore creates correct TransactionSplitStore', () {
      parent.date = tz.TZDateTime.now(tz.UTC);
      parent.type = TransactionTypeProperty.withdrawal;

      final TransactionSplitState split = TransactionSplitState(parent);
      split.titleTC.text = "Test Title";
      split.localAmount = 50.0;
      split.sourceAccountTC.text = "Source";
      split.destinationAccountTC.text = "Dest";
      split.categoryTC.text = "Category";

      final TransactionSplitStore store = split.toStore();

      expect(store.description, "Test Title");
      expect(store.amount, "50.0");
      expect(store.sourceName, "Source");
      expect(store.destinationName, "Dest");
      expect(store.categoryName, "Category");
      expect(store.type, TransactionTypeProperty.withdrawal);
    });

    test('toStore handles bill and piggy bank', () {
      parent.date = tz.TZDateTime.now(tz.UTC);
      final TransactionSplitState split = TransactionSplitState(parent);
      split.bill = BillRead(
        type: "bills",
        id: "42",
        attributes: BillProperties(
          name: "Test Bill",
          amountMin: "10",
          amountMax: "20",
          date: DateTime.now(),
          repeatFreq: BillRepeatFrequency.monthly,
        ),
      );
      split.piggy = const PiggyBankRead(
        type: "piggy_banks",
        id: "123",
        links: ObjectLink(),
        attributes: PiggyBankProperties(name: "Test Piggy"),
      );

      final TransactionSplitStore store = split.toStore();
      expect(store.billId, "42");
      expect(store.piggyBankId, 123);
    });
  });
}
