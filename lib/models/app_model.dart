class AppSetting {
  final String aboutText;
  final String github;
  final String gitlab;
  final String linkedin;
  final String hackerrank;

  const AppSetting({
    required this.aboutText,
    required this.github,
    required this.gitlab,
    required this.linkedin,
    required this.hackerrank,
  });

  factory AppSetting.fromJson(Map<String, dynamic> json) {
    return AppSetting(
      aboutText: json['aboutText'] ?? '',
      github: json['github'] ?? '',
      gitlab: json['gitlab'] ?? '',
      linkedin: json['linkedin'] ?? '',
      hackerrank: json['hackerrank'] ?? '',
    );
  }
}
