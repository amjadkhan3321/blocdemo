//Quote class
// Class representing a quote with various properties
class Quote {
  final String id;
  final String content;
  final String author;
  final List<String> tags;
  final String authorSlug;
  final int length;
  final String dateAdded;
  final String dateModified;

  // Constructor for creating a Quote instance with required data
  Quote({
    required this.id,
    required this.content,
    required this.author,
    required this.tags,
    required this.authorSlug,
    required this.length,
    required this.dateAdded,
    required this.dateModified,
  });

  // Factory method for creating a Quote instance from a JSON map
  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      // Using null-aware operators to handle potential null values in the JSON
      id: json['_id'] ?? "",
      content: json['content'],
      author: json['author'],
      tags: List<String>.from(json['tags']),
      authorSlug: json['authorSlug'],
      length: json['length'],
      dateAdded: json['dateAdded'],
      dateModified: json['dateModified'],
    );
  }
}
