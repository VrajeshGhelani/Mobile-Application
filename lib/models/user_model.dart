class UserModel {
  final String id;
  final String email;
  final String name;
  final String careerDomain;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.careerDomain = 'Software Development',
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? careerDomain,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      careerDomain: careerDomain ?? this.careerDomain,
    );
  }
}
