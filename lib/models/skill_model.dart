class Skill {
  final String name;
  final String description;
  final double level;
  final String imageURL;

  const Skill({
    required this.name,
    required this.description,
    required this.level,
    required this.imageURL,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'] ?? "No name provided",
      description: json['description'] ?? "No description provided",
      level: json['level'] ?? 0.8,
      imageURL: json['imageURL'] ?? "No imageURL provided",
    );
  }
}
