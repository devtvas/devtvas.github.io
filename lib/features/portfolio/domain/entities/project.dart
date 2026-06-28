import 'package:equatable/equatable.dart';

/// Entidade pura — não conhece Flutter, BLoC, nem Firebase (D do SOLID).
/// Representa apenas o conceito de "projeto" no domínio do portfólio.
class Project extends Equatable {
  final String title;
  final String description;
  final List<String> stack;

  const Project({
    required this.title,
    required this.description,
    required this.stack,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    final rawStack = json['stack'];

    return Project(
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      stack: rawStack is List
          ? rawStack
              .map((item) => item?.toString() ?? '')
              .where((item) => item.isNotEmpty)
              .toList()
          : <String>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'stack': stack,
    };
  }

  @override
  List<Object?> get props => [title, description, stack];
}
