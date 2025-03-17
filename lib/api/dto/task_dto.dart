class TaskDto {
  final String name;
  final String date;
  final String status;

  TaskDto({required this.name, required this.date,required this.status});

  factory TaskDto.fromJson(Map<String, dynamic> json) {
    return TaskDto(
      name: json['name'],
      date: json['date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'start_date': date,
      'status': status,
    };
  }
}