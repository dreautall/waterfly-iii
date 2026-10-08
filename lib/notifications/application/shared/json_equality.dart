import 'package:collection/collection.dart';

const DeepCollectionEquality _jsonEquality = DeepCollectionEquality();

bool jsonStructuresEqual(Object? left, Object? right) =>
    _jsonEquality.equals(left, right);
