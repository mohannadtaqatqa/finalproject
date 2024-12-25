class Comment {
  final int id;
  final String author;
  final String body;
  final String datePosted;

  Comment({required this.id, required this.author, required this.body, required this.datePosted});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      author: json['author'],
      body: json['body'],
      datePosted: json['date_posted'],
    );
  }
}
