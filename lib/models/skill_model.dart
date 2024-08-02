class Skill {
  final String name;
  final String description;
  final String imageURL;

  const Skill({
    required this.name,
    required this.description,
    required this.imageURL,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'] ?? "No name provided",
      description: json['description'] ?? "No description provided",
      imageURL: json['imageURL'] ?? "No imageURL provided",
    );
  }
}
