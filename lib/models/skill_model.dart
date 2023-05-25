class Skill {
  final String name;
  final String description;
  final String fontAwesomeCode;

  const Skill({
    required this.name,
    required this.description,
    required this.fontAwesomeCode,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'],
      description: json['description'],
      fontAwesomeCode: json['fontAwesomeCode'],
    );
  }
}
