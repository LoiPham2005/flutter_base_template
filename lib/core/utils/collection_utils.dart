// ════════════════════════════════════════════════════════════════
// 📁 lib/core/utils/collection_utils.dart
// ════════════════════════════════════════════════════════════════
class CollectionUtils {
  CollectionUtils._();

  /// Check if list is null or empty
  static bool isNullOrEmpty<T>(List<T>? list) {
    return list == null || list.isEmpty;
  }

  /// Safely get item at index (returns null if out of bounds)
  static T? getAt<T>(List<T>? list, int index) {
    if (list == null || index < 0 || index >= list.length) return null;
    return list[index];
  }

  /// Chunk list into smaller lists of specified size
  static List<List<T>> chunk<T>(List<T> list, int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < list.length; i += size) {
      chunks.add(
        list.sublist(i, i + size > list.length ? list.length : i + size),
      );
    }
    return chunks;
  }

  /// Remove duplicates from list
  static List<T> unique<T>(List<T> list) {
    return list.toSet().toList();
  }

  /// Shuffle list randomly
  static List<T> shuffle<T>(List<T> list) {
    final shuffled = List<T>.from(list);
    shuffled.shuffle();
    return shuffled;
  }

  /// Group list by key
  static Map<K, List<V>> groupBy<K, V>(
    List<V> list,
    K Function(V) keyFunction,
  ) {
    final map = <K, List<V>>{};
    for (final item in list) {
      final key = keyFunction(item);
      map.putIfAbsent(key, () => []).add(item);
    }
    return map;
  }

  /// Find first element matching condition
  static T? firstWhere<T>(
    List<T> list,
    bool Function(T) test, {
    T? Function()? orElse,
  }) {
    try {
      return list.firstWhere(test);
    } catch (e) {
      return orElse?.call();
    }
  }

  /// Partition list into two lists based on condition
  static (List<T>, List<T>) partition<T>(List<T> list, bool Function(T) test) {
    final matched = <T>[];
    final unmatched = <T>[];
    for (final item in list) {
      if (test(item)) {
        matched.add(item);
      } else {
        unmatched.add(item);
      }
    }
    return (matched, unmatched);
  }

  /// Safely get max value from list
  static T? max<T extends Comparable>(List<T>? list) {
    if (isNullOrEmpty(list)) return null;
    return list!.reduce((a, b) => a.compareTo(b) > 0 ? a : b);
  }

  /// Safely get min value from list
  static T? min<T extends Comparable>(List<T>? list) {
    if (isNullOrEmpty(list)) return null;
    return list!.reduce((a, b) => a.compareTo(b) < 0 ? a : b);
  }

  // Thêm method hữu ích:
  static List<T> flatten<T>(List<List<T>> lists) {
    return lists.expand((list) => list).toList();
  }

  static Map<K, V> mapFromLists<K, V>(List<K> keys, List<V> values) {
    return Map.fromIterables(keys, values);
  }
}
