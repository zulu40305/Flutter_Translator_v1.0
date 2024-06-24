class NavigatorValue {
  NavigatorValue({
    required this.name,
    required this.value
  });
  String name;
  String value;
}

final List<NavigatorValue> translator_type = [
  NavigatorValue(name: '텍스트 번역', value: 'text'),
  NavigatorValue(name: '이미지 번역', value: 'image'),
  NavigatorValue(name: '대화 번역', value: 'conversation'),
  NavigatorValue(name: '단어 학습', value: 'learning')
];