import 'dart:async';

import 'package:waterflyiii/notifications/domain/transactions/firefly_resource_reference.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';

abstract interface class FireflyResourceLabelGateway {
  Future<String> loadLabel(FireflyResourceKind kind, String id);
}

class FireflyResourceLabelResolver {
  FireflyResourceLabelResolver(this._gateway);

  final FireflyResourceLabelGateway _gateway;
  final Map<FireflyResourceReference, Future<String>> _labels =
      <FireflyResourceReference, Future<String>>{};
  final StreamController<void> _invalidations =
      StreamController<void>.broadcast();
  int _generation = 0;

  Stream<void> get invalidations => _invalidations.stream;

  Future<String> resolve(FireflyResourceKind kind, String id) {
    final FireflyResourceReference reference = FireflyResourceReference(
      kind: kind,
      id: id,
    );
    return _labels.putIfAbsent(reference, () => _load(reference, _generation));
  }

  Future<String> _load(
    FireflyResourceReference reference,
    int generation,
  ) async {
    try {
      return await _gateway.loadLabel(reference.kind, reference.id);
    } catch (_) {
      if (generation == _generation) {
        final Object? ignored = _labels.remove(reference);
        assert(ignored != null);
      }
      rethrow;
    }
  }

  void invalidate() {
    _generation += 1;
    _labels.clear();
    _invalidations.add(null);
  }

  Future<void> close() => _invalidations.close();
}
