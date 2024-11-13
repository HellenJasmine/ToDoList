// ignore_for_file: public_member_api_docs, sort_constructors_first


enum Category{
  trabalho('Trabalho'),
  pessoal('Pessoal'),
  estudos('Estudos');


  const Category(this.string);
  final String string;
}


class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final Category category;
  bool isCompleted;
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
    this.isCompleted = false,
  });

  @override
  String toString() {
    return 'Task(id: $id, title: $title, description: $description, dueDate: $dueDate, category: $category, isCompleted: $isCompleted)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'category': category.index,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> data) {
    return Task(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      dueDate: DateTime.fromMillisecondsSinceEpoch(data['dueDate'] ?? 0),
      category: Category.values[data['category'] ?? 0],
      isCompleted: data['isCompleted'] ?? false,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Task.fromJson(String source) => Task.fromMap(json.decode(source) as Map<String, dynamic>);
}
