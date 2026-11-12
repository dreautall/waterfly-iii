import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_resource_label_resolver.dart';
import 'package:waterflyiii/notifications/domain/transactions/firefly_resource_reference.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';

class FireflyResourceLabel extends StatelessWidget {
  const FireflyResourceLabel({
    super.key,
    required this.kind,
    required this.id,
    this.textAlign,
    this.style,
  });

  final FireflyResourceKind kind;
  final String id;
  final TextAlign? textAlign;
  final TextStyle? style;

  factory FireflyResourceLabel.reference(
    FireflyResourceReference reference, {
    Key? key,
    TextAlign? textAlign,
    TextStyle? style,
  }) => FireflyResourceLabel(
    key: key,
    kind: reference.kind,
    id: reference.id,
    textAlign: textAlign,
    style: style,
  );

  @override
  Widget build(BuildContext context) {
    final FireflyResourceLabelResolver? resolver = context
        .read<FireflyResourceLabelResolver?>();
    if (resolver == null) {
      return Text(
        '${_kindLabel(kind)} $id',
        textAlign: textAlign,
        style: style,
      );
    }
    return StreamBuilder<void>(
      stream: resolver.invalidations,
      builder: (BuildContext context, AsyncSnapshot<void> _) =>
          FutureBuilder<String>(
            future: resolver.resolve(kind, id),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
                Text(
                  snapshot.hasData
                      ? snapshot.data!
                      : snapshot.hasError
                      ? '${_kindLabel(kind)} $id unavailable'
                      : '${_kindLabel(kind)} $id',
                  textAlign: textAlign,
                  style: style,
                ),
          ),
    );
  }

  String _kindLabel(FireflyResourceKind kind) => switch (kind) {
    FireflyResourceKind.account => 'Account',
    FireflyResourceKind.category => 'Category',
    FireflyResourceKind.tag => 'Tag',
    FireflyResourceKind.subscription => 'Subscription',
    FireflyResourceKind.currency => 'Currency',
    FireflyResourceKind.piggyBank => 'Piggy bank',
  };
}
