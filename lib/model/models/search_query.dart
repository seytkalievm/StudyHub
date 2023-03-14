class Filter {
  final String? semester;
  final int? folderId;

  Filter({this.semester, this.folderId});

  Map<String, Object?> toJson() {
    if (semester != null && folderId != null) {
      return {
        "semester": semester,
        "folder_id": folderId,
      };
    } else if (folderId != null) {
      return {
        "folder_id": folderId,
      };
    } else if (semester != null) {
      return {
        "semester": semester,
      };
    } else {
      return {};
    }
  }
}

class SearchQuery {
  final String query;
  final Filter? filter;

  SearchQuery({required this.query, this.filter});

  Map<String, Object?> toJson() {
    return filter != null
        ? {"query": query, "filter": filter!.toJson()}
        : {"query": query};
  }
}
