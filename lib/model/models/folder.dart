class Folder {
  final int id;
  final String name;

  Folder({required this.id, required this.name});

  static Folder fromJson(Map<String, Object?> json) {
    return Folder(
      id: json["folder_id"] as int,
      name: json["folder_name"] as String,
    );
  }

  @override
  String toString() {
    return "$id: $name";
  }

  @override
  int get hashCode => Object.hash(id, name);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is Folder && other.id == id;
  }
}
