import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/timezonehandler.dart';

class BillList extends StatelessWidget {
  const BillList({super.key, required this.snapshot});

  final AsyncSnapshot<List<BillRead>> snapshot;

  @override
  Widget build(BuildContext context) {
    final TimeZoneHandler tzHandler = context.read<FireflyService>().tzHandler;

    return SizedBox(
      child: Padding(
        padding: const .fromLTRB(12, 0, 12, 12),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final List<Widget> widgets = <Widget>[];
            snapshot.data!.sort((BillRead a, BillRead b) {
              final int dateCompare =
                  (a.attributes.nextExpectedMatch ?? tzHandler.sNow())
                      .compareTo(
                        b.attributes.nextExpectedMatch ?? tzHandler.sNow(),
                      );
              if (dateCompare != 0) {
                return dateCompare;
              }
              final int orderCompare = (a.attributes.order ?? 0).compareTo(
                b.attributes.order ?? 0,
              );
              if (orderCompare != 0) {
                return orderCompare;
              }
              return a.attributes.avgAmount().compareTo(
                b.attributes.avgAmount(),
              );
            });

            DateTime lastDate =
                (snapshot.data!.first.attributes.nextExpectedMatch ??
                        tzHandler.sNow())
                    .subtract(const Duration(days: 1));
            for (BillRead bill in snapshot.data!) {
              final DateTime nextMatch =
                  bill.attributes.nextExpectedMatch != null
                  ? tzHandler
                        .sTime(bill.attributes.nextExpectedMatch!)
                        .toLocal()
                  : tzHandler.sNow();
              final CurrencyRead currency = CurrencyRead(
                id: bill.attributes.currencyId ?? "0",
                type: "currencies",
                attributes: CurrencyProperties(
                  code: bill.attributes.currencyCode ?? "",
                  name: "",
                  symbol: bill.attributes.currencySymbol ?? "",
                  decimalPlaces: bill.attributes.currencyDecimalPlaces,
                ),
              );

              if (nextMatch != lastDate) {
                if (widgets.isNotEmpty) {
                  widgets.add(const SizedBox(height: 8));
                }
                widgets.add(
                  Text(
                    DateFormat.yMd().format(nextMatch),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                );
                lastDate = nextMatch;
              }
              widgets.add(
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: <Widget>[
                    RichText(
                      maxLines: 1,
                      overflow: .ellipsis,
                      text: TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: bill.attributes.name!.length > 30
                                ? bill.attributes.name!.replaceRange(
                                    30,
                                    bill.attributes.name!.length,
                                    "…",
                                  )
                                : bill.attributes.name,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          TextSpan(
                            text: S
                                .of(context)
                                .homeMainBillsInterval(
                                  bill.attributes.repeatFreq!.value ?? "",
                                ),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      currency.fmt(bill.attributes.avgAmount()),
                      style: const TextStyle(
                        color: Color(0xFFFF4F4B),
                        fontWeight: .bold,
                        fontFeatures: <FontFeature>[.tabularFigures()],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Column(crossAxisAlignment: .start, children: widgets);
          },
        ),
      ),
    );
  }
}
