class Skill {
  final String name;
  final String description;
  final String level; // Beginner, Intermediate, Advanced
  final String duration; // e.g. "3–4 weeks"
  final String? icon; // Emoji or Icon name

  Skill({
    required this.name,
    required this.description,
    required this.level,
    required this.duration,
    this.icon,
  });
}
