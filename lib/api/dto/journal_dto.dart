class JournalDto {
  final String title;
  final String content;

  JournalDto({required this.title, required this.content});

  factory JournalDto.fromJson(Map<String, dynamic> json) {
    return JournalDto(
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}