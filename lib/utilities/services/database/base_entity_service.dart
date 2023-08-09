import 'package:budget_maker_app/utilities/entities/base_entity.dart';
import 'package:budget_maker_app/utilities/services/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';

/// Service de base pour les entités
abstract class BaseEntityService<T extends BaseEntity> {
  /// Nom de la table
  final String table;

  /// Fonction pour convertir une map en entité
  final T Function(Map<String, dynamic> data) fromMap;

  /// Constructeur
  BaseEntityService({
    required this.table,
    required this.fromMap,
  });

  /// Id de l'utilisateur courant
  String get userId {
    return AuthService.getCurrentUser()!.uid;
  }

  /// Référence à la table
  DatabaseReference get _ref =>
      FirebaseDatabase.instance.ref().child('users').child(userId).child(table);

  /// Retourne toutes les entités
  Future<List<T>> getAll() async {
    // Récupère les données
    DataSnapshot snapshot = (await _ref.once()).snapshot;

    // Convertit les données en map
    Map<dynamic, dynamic>? rawData = snapshot.value as Map<dynamic, dynamic>?;

    // Si pas de données, retourne une liste vide
    if (rawData == null) return [];

    var data = <Map<String, dynamic>>[];

    // Convertit les données en liste de maps
    rawData.forEach((key, value) {
      var map = Map<String, dynamic>.from(value.map((key, value) {
        return MapEntry(key.toString(), value);
      }));
      map['id'] = key.toString();
      data.add(map);
    });

    List<T> entities = [];

    // Convertit les maps en entités
    for (var date in data) {
      entities.add(fromMap(date));
    }

    // Trie les entités
    entities.sort((a, b) => a.compareTo(b));

    return entities;
  }

  /// Retourne une entité par son id
  Future<T?> getById(String id) async {
    // Récupère les données
    DataSnapshot snapshot = (await _ref.child(id).once()).snapshot;

    // Convertit les données en map
    Map<String, dynamic>? data = snapshot.value as Map<String, dynamic>?;

    // Si pas de données, retourne null
    if (data == null) return null;

    data['id'] = id;

    // Convertit la map en entité et la retourne
    return fromMap(data);
  }

  /// Crée une entité
  Future<T> create(T entity) async {
    // Crée une nouvelle référence
    var newDataRef = _ref.push();

    // Ajoute l'entité à la base de données
    await newDataRef.set(entity.toMap(withId: false));

    // Récupère les données
    DataSnapshot snapshot = (await newDataRef.once()).snapshot;

    // Convertit les données en map
    Map<String, dynamic> data = snapshot.value as Map<String, dynamic>;

    data['id'] = newDataRef.key;

    // Convertit la map en entité et la retourne
    return fromMap(data);
  }

  /// Met à jour une entité
  Future<T> update(String id, T entity) async {
    // Met à jour l'entité dans la base de données
    await _ref.child(id).update(entity.toMap(withId: false));

    return entity;
  }

  /// Supprime une entité
  Future<void> delete(String id) async {
    await _ref.child(id).remove();
  }
}
