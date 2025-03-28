class TaskDto {
  final String name;
  final String date;
  final String status;
  final String description;

  TaskDto({required this.name, required this.date,required this.status,this.description});

  factory TaskDto.fromJson(Map<String, dynamic> json) {
    return TaskDto(
      name: json['name'],
      date: json['date'],
      status: json['status'],
      description: json['description']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'start_date': date,
      'status': status,
      'description': description,
    };
  }
}