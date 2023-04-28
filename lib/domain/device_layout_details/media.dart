class Media {
  int? id;
  String? title;
  String? type;
  String? file;
  dynamic thumbnail;

  Media({this.id, this.title, this.type, this.file, this.thumbnail});

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json['id'] as int?,
        title: json['title'] as String?,
        type: json['type'] as String?,
        file: json['file'] as String?,
        thumbnail: json['thumbnail'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'type': type,
        'file': file,
        'thumbnail': thumbnail,
      };
}
