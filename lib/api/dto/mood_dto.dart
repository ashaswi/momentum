class MoodDto {
  final String feeling;
  final String content;

  MoodDto({required this.feeling, required this.content});

  factory MoodDto.fromJson(Map<String, dynamic> json) {
    return MoodDto(
      feeling: json['feeling'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'feeling': feeling,
      'content': content,
    };
  }
}