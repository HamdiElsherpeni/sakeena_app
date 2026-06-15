class HealthCategory {
  final String id;
  final String title;
  final String icon;
  final String color;

  const HealthCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
  });
}

class HealthArticle {
  final String id;
  final String categoryId;
  final String title;
  final String summary;
  final String content;
  final String readTime;

  const HealthArticle({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.summary,
    required this.content,
    required this.readTime,
  });
}

class HealthTip {
  final String title;
  final String body;
  final String icon;

  const HealthTip({
    required this.title,
    required this.body,
    required this.icon,
  });
}