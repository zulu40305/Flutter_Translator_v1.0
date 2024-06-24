class FlashCardFrame {
  FlashCardFrame({
    required this.id,
    required this.word,
    required this.meaning,
    this.synonym,
    this.antonym,
  });
  final String id;
  final String word;
  final String meaning;
  final String? synonym;
  final String? antonym;
}