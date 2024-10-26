class DocumentModel {
  final String name;
  final String fileName;
  final String originalUrl;
  final String extension;
  final int size;
  final DateTime createdAt;

  DocumentModel({
    required this.name,
    required this.fileName,
    required this.originalUrl,
    required this.extension,
    required this.size,
    required this.createdAt,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      name: json['name'],
      fileName: json['file_name'],
      originalUrl: json['original_url'],
      extension: json['extension'],
      size: json['size'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'file_name': fileName,
      'original_url': originalUrl,
      'extension': extension,
      'size': size,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
