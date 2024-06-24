import 'package:google_ml_kit/google_ml_kit.dart';

class TranslatorValue {
  TranslatorValue({
    required this.name,
    required this.native_name,
    required this.value,
    this.script_value,
    this.iso_language_code,
    required this.language_code,
    required this.isDownloading,
    required this.isDownloaded,
  });
  String name;
  String native_name;
  TranslateLanguage value;
  TextRecognitionScript? script_value;
  String? iso_language_code;
  String language_code;
  bool isDownloading;
  bool isDownloaded;
}

final List<TranslatorValue> languages = [
  TranslatorValue(
    name: '갈리시아어', 
    native_name: 'gálata', 
    value: TranslateLanguage.galician,
    script_value: TextRecognitionScript.latin,
    iso_language_code: null,
    language_code: 'gl',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '그리스어', 
    native_name: 'Ελληνικά', 
    value: TranslateLanguage.greek,
    script_value: null,
    iso_language_code: 'el-GR',
    language_code: 'el',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '네덜란드어', 
    native_name: 'Nederlands', 
    value: TranslateLanguage.dutch,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'nl-NL',
    language_code: 'nl',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '노르웨이어', 
    native_name: 'norsk', 
    value: TranslateLanguage.norwegian,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'nb-NO',
    language_code: 'no',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '덴마크어', 
    native_name: 'dansk', 
    value: TranslateLanguage.danish,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'da-DK',
    language_code: 'da',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '독일어', 
    native_name: 'Deutsch', 
    value: TranslateLanguage.german,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'de-DE',
    language_code: 'de',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '라트비아어', 
    native_name: 'latviski', 
    value: TranslateLanguage.latvian,
    script_value: TextRecognitionScript.latin,
    iso_language_code: null,
    language_code: 'lv',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '러시아어', 
    native_name: 'Русский', 
    value: TranslateLanguage.russian,
    iso_language_code: 'ru-RU',
    script_value: null,
    language_code: 'ru',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '루마니아어', 
    native_name: 'Română', 
    value: TranslateLanguage.romanian,
    script_value: TextRecognitionScript.latin,
    iso_language_code: null,
    language_code: 'ro',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '리투아니아어', 
    native_name: 'lietuvių',
    value: TranslateLanguage.lithuanian,
    script_value: TextRecognitionScript.latin,
    iso_language_code: null,
    language_code: 'lt',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '마라타어', 
    native_name: 'मराठी', 
    value: TranslateLanguage.marathi,
    script_value: TextRecognitionScript.devanagiri,
    iso_language_code: null,
    language_code: 'mr',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '마케도니아어', 
    native_name: 'македонски', 
    value: TranslateLanguage.macedonian,
    script_value: null,
    iso_language_code: null,
    language_code: 'mk',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '말레이어', 
    native_name: 'melayu', 
    value: TranslateLanguage.malay,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'ms-MY',
    language_code: 'ms',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '몰타어', 
    native_name: 'malti', 
    value: TranslateLanguage.maltese,
    script_value: TextRecognitionScript.latin,
    iso_language_code: null,
    language_code: 'mt',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '베트남어', 
    native_name: 'Tiếng Việt', 
    value: TranslateLanguage.vietnamese,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'vi-VN',
    language_code: 'vi',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '벨라루스어', 
    native_name: 'беларускі', 
    value: TranslateLanguage.belarusian,
    script_value: null,
    iso_language_code: null,
    language_code: 'be',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '불가리아어', 
    native_name: 'български', 
    value: TranslateLanguage.bulgarian,
    script_value: null,
    iso_language_code: 'bg-BG',
    language_code: 'bg',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '스와힐리어', 
    native_name: 'kiswahili', 
    value: TranslateLanguage.swahili,
    script_value: TextRecognitionScript.latin,
    iso_language_code: null,
    language_code: 'sw',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '스웨덴어', 
    native_name: 'svenska', 
    value: TranslateLanguage.swedish,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'sv-SE',
    language_code: 'sv',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '스페인어', 
    native_name: 'Español', 
    value: TranslateLanguage.spanish,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'es-MX',
    language_code: 'es',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '슬로바키아어', 
    native_name: 'slovenský', 
    value: TranslateLanguage.slovak,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'sk-SK',
    language_code: 'sk',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '슬로베니아어', 
    native_name: 'Slovenščina', 
    value: TranslateLanguage.slovenian,
    script_value: TextRecognitionScript.latin,
    iso_language_code: null,
    language_code: 'sl',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '아랍어', 
    native_name: 'عربي', 
    value: TranslateLanguage.arabic,
    script_value: null,
    iso_language_code: 'ar-001',
    language_code: 'ar',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '아이슬란드어', 
    native_name: 'íslenskur', 
    value: TranslateLanguage.icelandic,
    script_value: TextRecognitionScript.latin,
    iso_language_code: null,
    language_code: 'is',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '아이티어', 
    native_name: 'Ayisyen', 
    value: TranslateLanguage.haitian,
    script_value: TextRecognitionScript.latin,
    iso_language_code: null,
    language_code: 'ht',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '아일랜드어', 
    native_name: 'Gaeilge', 
    value: TranslateLanguage.irish,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'en-IE',
    language_code: 'ga',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '알바니아어', 
    native_name: 'shqiptare', 
    value: TranslateLanguage.albanian,
    script_value: TextRecognitionScript.latin,
    iso_language_code: null,
    language_code: 'sq',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '에스토니아어', 
    native_name: 'eesti keel', 
    value: TranslateLanguage.estonian,
    script_value: TextRecognitionScript.latin,
    iso_language_code: null,
    language_code: 'et',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '에스페란토어', 
    native_name: 'Esperanto', 
    value: TranslateLanguage.esperanto,
    script_value: TextRecognitionScript.latin,
    iso_language_code: null,
    language_code: 'eo',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '영어', 
    native_name: 'English', 
    value: TranslateLanguage.english,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'en-US',
    language_code: 'en',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '우르두어', 
    native_name: 'اردو', 
    value: TranslateLanguage.urdu,
    script_value: null,
    iso_language_code: null,
    language_code: 'ur',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '우크라이나어', 
    native_name: 'українська', 
    value: TranslateLanguage.ukrainian,
    script_value: null,
    iso_language_code: 'uk-UA',
    language_code: 'uk',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '웨일스어', 
    native_name: 'Cymraeg', 
    value: TranslateLanguage.welsh,
    script_value: TextRecognitionScript.latin,
    iso_language_code: null,
    language_code: 'cy',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '이탈리아어', 
    native_name: 'Italiano', 
    value: TranslateLanguage.italian,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'it-IT',
    language_code: 'it',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '인도네시아어', 
    native_name: 'bahasa Indonesia', 
    value: TranslateLanguage.indonesian,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'id-ID',
    language_code: 'id',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '일본어', 
    native_name: '日本語', 
    value: TranslateLanguage.japanese,
    script_value: TextRecognitionScript.japanese,
    iso_language_code: 'ja-JP',
    language_code: 'jp',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '조지아어', 
    native_name: 'ქართული', 
    value: TranslateLanguage.georgian,
    script_value: null,
    iso_language_code: null,
    language_code: 'ka',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '중국어(간체)', 
    native_name: '中国', 
    value: TranslateLanguage.chinese,
    script_value: TextRecognitionScript.chinese,
    iso_language_code: 'zh-CN',
    language_code: 'zh',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '체코어', 
    native_name: 'čeština', 
    value: TranslateLanguage.czech,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'cs-CZ',
    language_code: 'cs',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '카탈로니아어', 
    native_name: 'català', 
    value: TranslateLanguage.catalan,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'ca-ES',
    language_code: 'ca',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '칸나다어', 
    native_name: 'ಕನ್ನಡ', 
    value: TranslateLanguage.kannada,
    script_value: null,
    iso_language_code: null,
    language_code: 'kn',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '크로아티아어', 
    native_name: 'Hrvatski', 
    value: TranslateLanguage.croatian,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'hr-HR',
    language_code: 'hr',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '타밀어', 
    native_name: 'தமிழ்', 
    value: TranslateLanguage.tamil,
    script_value: null,
    iso_language_code: null,
    language_code: 'ta',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '태국어', 
    native_name: 'แบบไทย', 
    value: TranslateLanguage.thai,
    script_value: null,
    iso_language_code: 'th-TH',
    language_code: 'th',
    isDownloading: false, 
    isDownloaded: false
  ),
  TranslatorValue(
    name: '터키어', 
    native_name: 'Türkçe', 
    value: TranslateLanguage.turkish, 
    script_value: null,
    iso_language_code: 'tr-TR',
    language_code: 'tr',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '텔루구어', 
    native_name: 'తెలుగు', 
    value: TranslateLanguage.telugu,
    script_value: null,
    iso_language_code: null,
    language_code: 'te',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '페르시아어', 
    native_name: 'فارسی', 
    value: TranslateLanguage.persian,
    script_value: null,
    iso_language_code: null,
    language_code: 'fa',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '포르투갈어', 
    native_name: 'Português', 
    value: TranslateLanguage.portuguese,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'pt-PT',
    language_code: 'pt',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '폴란드어', 
    native_name: 'polski', 
    value: TranslateLanguage.polish,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'pl-PL',
    language_code: 'pl',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '프랑스어', 
    native_name: 'Français', 
    value: TranslateLanguage.french,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'fr-FR',
    language_code: 'fr',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '핀란드어', 
    native_name: 'Suomalainen', 
    value: TranslateLanguage.finnish,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'fi-FI',
    language_code: 'fi',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '한국어', 
    native_name: '한국어', 
    value: TranslateLanguage.korean,
    script_value: TextRecognitionScript.korean,
    iso_language_code: 'ko-KR',
    language_code: 'ko',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '헝가리어', 
    native_name: 'Magyar', 
    value: TranslateLanguage.hungarian,
    script_value: TextRecognitionScript.latin,
    iso_language_code: 'hu-HU',
    language_code: 'hu',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '히브리어', 
    native_name: 'עִברִית', 
    value: TranslateLanguage.hebrew,
    script_value: null,
    iso_language_code: 'he-IL',
    language_code: 'he',
    isDownloading: false,
    isDownloaded: false
  ),
  TranslatorValue(
    name: '힌디어', 
    native_name: 'हिंदी', 
    value: TranslateLanguage.hindi,
    script_value: TextRecognitionScript.devanagiri,
    iso_language_code: 'hi-IN',
    language_code: 'hi',
    isDownloading: false,
    isDownloaded: false
  ),
];