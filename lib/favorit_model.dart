class FootballFields {
  static final List<String> values = [id, title, teambadge];

  // table name
  static const favorite_team = 'favorite';

  // column
  static final String id = 'id';
  static final String title = 'title';
  static final String teambadge = 'teambadge';

}

// column model
class Like_Model {
  final int? id;
  final String? title;
  final String? teambadge;

  Like_Model(
      {this.id,
        required this.title,
        required this.teambadge});

  factory Like_Model.fromMap(Map<String, dynamic> json) {
    return Like_Model(
      id: json['id'] as int?,
      title: json['title'] as String?,
      teambadge: json['teambadge'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
    FootballFields.id: id,
    FootballFields.title: title,
    FootballFields.teambadge: teambadge,
  };
}