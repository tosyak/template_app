class Info {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  Info({required this.count, required this.pages, this.next, this.prev});
}

class GraphQLInfo {
  final int count;
  final int pages;
  final int? next;
  final int? prev;

  GraphQLInfo({required this.count, required this.pages, this.next, this.prev});
}
