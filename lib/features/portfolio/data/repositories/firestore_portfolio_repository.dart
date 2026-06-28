import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/portfolio_content.dart';
import '../../domain/repositories/portfolio_repository.dart';

/// Busca o conteúdo do portfólio em um único documento no Firestore.
///
/// Estrutura esperada no Firestore:
///   coleção: "portfolio"
///   documento: "content"
///   campos: name, role, location, summary, skills (array),
///            experiences (array de maps), projects (array de maps),
///            contacts (array de maps)
class FirestorePortfolioRepository implements PortfolioRepository {
  final FirebaseFirestore _firestore;

  FirestorePortfolioRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  static const _collection = 'portfolio';
  static const _documentId = 'content';

  @override
  Future<PortfolioContent> getPortfolioContent() async {
    final snapshot =
        await _firestore.collection(_collection).doc(_documentId).get();

    if (!snapshot.exists || snapshot.data() == null) {
      throw Exception(
        'Documento "$_documentId" não encontrado na coleção "$_collection".',
      );
    }

    final rawData = snapshot.data()!;
    final contentData = _unwrapContent(rawData);
    final normalizedData = _normalizeFirestoreData(contentData);

    return PortfolioContent.fromJson(normalizedData);
  }

  Map<String, dynamic> _unwrapContent(Map<String, dynamic> rawData) {
    final content = rawData['content'];
    if (content is Map<String, dynamic>) return content;
    if (content is Map) return Map<String, dynamic>.from(content);
    return rawData;
  }

  Map<String, dynamic> _normalizeFirestoreData(Map<String, dynamic> data) {
    return {
      ...data,
      'skills': _normalizeStringList(data['skills']),
      'experiences': _normalizeListOfMaps(data['experiences']),
      'projects': _normalizeListOfMaps(data['projects']),
      'contacts': _normalizeListOfMaps(data['contacts']),
    };
  }

  List<String> _normalizeStringList(dynamic value) {
    if (value is List) {
      return value.whereType<String>().toList();
    }
    if (value is String) {
      return [value];
    }
    return [];
  }

  List<Map<String, dynamic>> _normalizeListOfMaps(dynamic value) {
    if (value is List) {
      return value
          .where((item) => item is Map)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    }
    if (value is Map) {
      return [Map<String, dynamic>.from(value)];
    }
    return [];
  }
}
