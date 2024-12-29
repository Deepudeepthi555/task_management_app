class Task {
  final int id;
  final String title;
  final String description;
  final String category;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    required this.category,
    this.isCompleted = false,
  });

  //These to store data in shared prefernece as json

  // Convert Task to JSON 

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'isCompleted': isCompleted,
    };
  }

  // Create Task from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      category: json['category'],
      isCompleted: json['isCompleted'],
    );
  }
}
