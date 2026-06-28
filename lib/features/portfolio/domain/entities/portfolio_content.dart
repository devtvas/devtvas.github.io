import 'package:equatable/equatable.dart';
import 'contact_link.dart';
import 'experience.dart';
import 'project.dart';

/// Agrega todo o conteúdo editável do portfólio em uma única entidade.
/// Isso facilita buscar/cachear "tudo de uma vez" como um documento só.
class PortfolioContent extends Equatable {
  final bool status;
  final String name;
  final String role;
  final String location;
  final String summary;
  final List<String> skills;
  final List<Experience> experiences;
  final List<Project> projects;
  final List<ContactLink> contacts;

  const PortfolioContent({
    required this.status,
    required this.name,
    required this.role,
    required this.location,
    required this.summary,
    required this.skills,
    required this.experiences,
    required this.projects,
    required this.contacts,
  });

  factory PortfolioContent.fromJson(Map<String, dynamic> json) {
    return PortfolioContent(
      status: json['status'] as bool,
      name: json['name'] as String,
      role: json['role'] as String,
      location: json['location'] as String,
      summary: json['summary'] as String,
      skills: [], // deixe vazio por enquanto
      // skills: List<String>.from(json['skills'] as List),
      experiences: (json['experiences'] as List)
          .map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList(),
      projects: (json['projects'] as List)
          .map((p) => Project.fromJson(p as Map<String, dynamic>))
          .toList(),
      contacts: (json['contacts'] as List)
          .map((c) => ContactLink.fromJson(c as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'name': name,
      'role': role,
      'location': location,
      'summary': summary,
      'skills': skills,
      'experiences': experiences.map((e) => e.toJson()).toList(),
      'projects': projects.map((p) => p.toJson()).toList(),
      'contacts': contacts.map((c) => c.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        status,
        name,
        role,
        location,
        summary,
        skills,
        experiences,
        projects,
        contacts
      ];
}
