/// Entité de base pour les entités de l'application
abstract class BaseEntity implements Comparable<BaseEntity> {
  /// Convertis l'entité en Map
  Map<String, dynamic> toMap({bool withId = true});
}
