// lib/pagecustomer/brosur/model/brosur_model.dart
class Brosur {
  final int id;
  final String title;
  final String description;
  final String file;
  final String fileUrl;
  final String downloadUrl;

  Brosur({
    required this.id,
    required this.title,
    required this.description,
    required this.file,
    required this.fileUrl,
    required this.downloadUrl,
  });

  factory Brosur.fromJson(Map<String, dynamic> json) {
    return Brosur(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      file: json['file'],
      fileUrl: json['file_url'],
      downloadUrl: json['download_url'],
    );
  }
}