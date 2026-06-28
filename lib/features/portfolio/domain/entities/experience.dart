import 'package:equatable/equatable.dart';

class Experience extends Equatable {
  final String company;
  final String role;
  final String period;
  final List<String> highlights;
  final String stack;

  const Experience({
    required this.company,
    required this.role,
    required this.period,
    required this.highlights,
    required this.stack,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    // normaliza highlights para List<String>
    final rawHighlights = json['highlights'];
    final List<String> highlights = rawHighlights is List
        ? rawHighlights
            .where((item) => item != null)
            .map((item) => item.toString())
            .where((s) => s.isNotEmpty)
            .toList()
        : rawHighlights is String
            ? (rawHighlights.isNotEmpty ? [rawHighlights] : <String>[])
            : <String>[];

    // normaliza stack para String (aceita String ou List)
    final rawStack = json['stack'];
    final String stack = rawStack is List
        ? rawStack
            .where((item) => item != null)
            .map((item) => item.toString())
            .where((s) => s.isNotEmpty)
            .join(', ')
        : (rawStack ?? '').toString();

    return Experience(
      company: (json['company'] ?? '').toString(),
      role: (json['role'] ?? '').toString(),
      period: (json['period'] ?? '').toString(),
      highlights: highlights,
      stack: stack,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'role': role,
      'period': period,
      'highlights': highlights,
      'stack': stack,
    };
  }

  @override
  List<Object?> get props => [company, role, period, highlights, stack];
}
