import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/application/rules/notification_condition_tree.dart';
import 'package:waterflyiii/notifications/domain/conditions/all_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/any_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/not_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/notification_condition.dart';
import 'package:waterflyiii/notifications/domain/conditions/value_exists_condition.dart';
import 'package:waterflyiii/notifications/domain/value_sources/literal_value_source.dart';

void main() {
  const NotificationConditionTree tree = NotificationConditionTree();
  const ValueExistsCondition first = ValueExistsCondition(
    LiteralValueSource('first'),
  );
  const ValueExistsCondition second = ValueExistsCondition(
    LiteralValueSource('second'),
  );

  group('normalization', () {
    test('flattens matching nested groups', () {
      final List<NotificationCondition> normalized = tree
          .normalizeGroupChildren(
            const AllCondition(<NotificationCondition>[]),
            const <NotificationCondition>[
              AllCondition(<NotificationCondition>[first]),
              AnyCondition(<NotificationCondition>[second]),
            ],
          );

      expect(normalized, <Object>[same(first), isA<AnyCondition>()]);
    });

    test('collapses double negation but preserves a single negation', () {
      expect(tree.normalize(const NotCondition(first)), isA<NotCondition>());
      expect(
        tree.normalize(const NotCondition(NotCondition(first))),
        same(first),
      );
    });

    test('reports when insertion will flatten a group', () {
      expect(
        tree.willFlattenGroupChildren(
          const AnyCondition(<NotificationCondition>[]),
          const <NotificationCondition>[
            AnyCondition(<NotificationCondition>[first]),
          ],
        ),
        isTrue,
      );
      expect(
        tree.willFlattenGroupChildren(
          const AnyCondition(<NotificationCondition>[]),
          const <NotificationCondition>[
            AllCondition(<NotificationCondition>[first]),
          ],
        ),
        isFalse,
      );
    });
  });

  test('clone creates an independent recursive tree', () {
    const AllCondition original = AllCondition(<NotificationCondition>[
      NotCondition(first),
    ]);

    final AllCondition cloned = tree.clone(original) as AllCondition;

    expect(cloned, isNot(same(original)));
    expect(cloned.conditions.single, isNot(same(original.conditions.single)));
    expect(
      (cloned.conditions.single as NotCondition).condition,
      isNot(same(first)),
    );
    expect(cloned.toJson(), original.toJson());
  });

  group('relationships and paste targets', () {
    test('distinguishes descendants from direct children', () {
      const NotCondition nested = NotCondition(first);
      const AllCondition root = AllCondition(<NotificationCondition>[nested]);

      expect(tree.contains(root, first), isTrue);
      expect(tree.isDirectChild(root, nested), isTrue);
      expect(tree.isDirectChild(root, first), isFalse);
      expect(tree.contains(first, root), isFalse);
    });

    test('rejects self, descendants, and unchanged parent', () {
      const AllCondition nested = AllCondition(<NotificationCondition>[first]);
      const AnyCondition root = AnyCondition(<NotificationCondition>[nested]);
      const List<NotificationCondition> roots = <NotificationCondition>[root];

      expect(
        tree.canPaste(
          roots: roots,
          source: nested,
          removal: nested,
          target: nested,
        ),
        isFalse,
      );
      expect(
        tree.canPaste(
          roots: roots,
          source: nested,
          removal: nested,
          target: first,
        ),
        isFalse,
      );
      expect(
        tree.canPaste(
          roots: roots,
          source: nested,
          removal: nested,
          target: root,
        ),
        isFalse,
      );
      expect(
        tree.canPaste(
          roots: roots,
          source: nested,
          removal: nested,
          target: null,
        ),
        isTrue,
      );
    });

    test('root node can move only when another destination exists', () {
      const AllCondition root = AllCondition(<NotificationCondition>[first]);

      expect(
        tree.hasMoveTarget(
          roots: const <NotificationCondition>[root],
          source: root,
          removal: root,
        ),
        isFalse,
      );
      expect(
        tree.hasMoveTarget(
          roots: const <NotificationCondition>[
            root,
            AnyCondition(<NotificationCondition>[second]),
          ],
          source: root,
          removal: root,
        ),
        isTrue,
      );
    });
  });

  group('move', () {
    test('removes a nested source and inserts its clone at root', () {
      const AllCondition root = AllCondition(<NotificationCondition>[
        first,
        second,
      ]);
      final NotificationCondition pasted = tree.clone(first);

      final NotificationConditionTreeMoveResult result = tree.move(
        roots: const <NotificationCondition>[root],
        removal: first,
        target: null,
        pasted: pasted,
      );

      final AllCondition updated = result.conditions.first as AllCondition;
      expect(updated.conditions, <NotificationCondition>[second]);
      expect(result.conditions.last, same(pasted));
      expect(result.replacements[root], same(updated));
    });

    test('inserts into a target and normalizes matching groups', () {
      const AllCondition source = AllCondition(<NotificationCondition>[first]);
      const AllCondition target = AllCondition(<NotificationCondition>[second]);
      const AnyCondition root = AnyCondition(<NotificationCondition>[
        source,
        target,
      ]);
      final NotificationCondition pasted = tree.clone(source);

      final NotificationConditionTreeMoveResult result = tree.move(
        roots: const <NotificationCondition>[root],
        removal: source,
        target: target,
        pasted: pasted,
      );

      final AnyCondition updatedRoot = result.conditions.single as AnyCondition;
      final AllCondition updatedTarget =
          updatedRoot.conditions.single as AllCondition;
      expect(updatedTarget.conditions.length, 2);
      expect(updatedTarget.conditions.first, same(second));
      expect(updatedTarget.conditions.last.toJson(), first.toJson());
      expect(result.replacements[target], same(updatedTarget));
    });

    test('removes an empty negation wrapper with its moved child', () {
      const NotCondition wrapper = NotCondition(first);
      final NotificationCondition pasted = tree.clone(first);

      final NotificationConditionTreeMoveResult result = tree.move(
        roots: const <NotificationCondition>[wrapper, second],
        removal: first,
        target: null,
        pasted: pasted,
      );

      expect(result.conditions, <NotificationCondition>[second, pasted]);
      expect(result.removedContainers, <NotificationCondition>{wrapper});
    });
  });
}
