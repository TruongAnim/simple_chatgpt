class ListUtils {
  static zip<T>(List<T> list1, List<T> list2) {
    List<T> result = [];
    for (int i = 0; i < list1.length; i++) {
      result.add(list1[i]);
      if (i < list2.length) {
        result.add(list2[i]);
      }
    }
    return result;
  }
}
