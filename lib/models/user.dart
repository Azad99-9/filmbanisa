class UserModel {
  final String id;
  final String email;
  final String? displayName;
  final String? photoURL;
  final DateTime createdAt;
  final int filmCoins;
  final int reviewCoins;

  UserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.photoURL,
    required this.createdAt,
    this.filmCoins = 0,
    this.reviewCoins = 0,
  });

  // Create a UserModel from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      filmCoins: json['filmCoins'] ?? 0,
      reviewCoins: json['reviewCoins'] ?? 0,
    );
  }

  // Convert UserModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'createdAt': createdAt.toIso8601String(),
      'filmCoins': filmCoins,
      'reviewCoins': reviewCoins,
    };
  }

  // Create a copy of UserModel with some updated fields
  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoURL,
    DateTime? createdAt,
    int? filmCoins,
    int? reviewCoins,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      createdAt: createdAt ?? this.createdAt,
      filmCoins: filmCoins ?? this.filmCoins,
      reviewCoins: reviewCoins ?? this.reviewCoins,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, displayName: $displayName)';
  }
}
