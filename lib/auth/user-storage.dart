class UserStorage {
  /// Token stocké en mémoire
  String? token;

  // Instance statique de la classe MySingleton
  static final UserStorage _instance = UserStorage._internal();

  // Constructeur privé pour empêcher la création d'instances à l'extérieur de la classe
  UserStorage._internal();

  // Méthode statique qui renvoie l'instance unique de MySingleton
  factory UserStorage() {
    return _instance;
  }

  /// Savoir si je connecté(e) dans le front
  bool isLogged() {
    return token != null;
  }

  /// Mettre le contexte de connexion
  void refreshToken(String newToken) {
    token = newToken;
  }
}
