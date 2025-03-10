class HabitDto {
  final String name;
  final String date;
  final String time;

  HabitDto({required this.name, required this.date,required this.time});

  factory HabitDto.fromJson(Map<String, dynamic> json) {
    return HabitDto(
      name: json['name'],
      date: json['date'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'start_date': date,
      'start_time': time,
    };
  }
}