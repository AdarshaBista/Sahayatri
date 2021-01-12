import 'package:sahayatri/core/models/language.dart';

class Languages {
  static const defaultSource = english;
  static const defaultTarget = Language(code: 'ne', title: 'Nepali', ttsCode: 'ne-NP');
  static const english = Language(code: 'en', title: 'English', ttsCode: 'en-US');

  static const List<Language> all = [
    Language(ttsCode: 'sq', code: 'sq', title: 'Albanian'),
    Language(ttsCode: 'ar', code: 'ar', title: 'Arabic'),
    Language(ttsCode: '', code: 'hy', title: 'Armenian'),
    Language(ttsCode: '', code: 'az', title: 'Azerbaijani'),
    Language(ttsCode: '', code: 'eu', title: 'Basque'),
    Language(ttsCode: '', code: 'be', title: 'Belarusian'),
    Language(ttsCode: 'bn-IN', code: 'bn', title: 'Bengali'),
    Language(ttsCode: 'bs', code: 'bs', title: 'Bosnian'),
    Language(ttsCode: '', code: 'bg', title: 'Bulgarian'),
    Language(ttsCode: 'ca', code: 'ca', title: 'Catalan'),
    Language(ttsCode: 'zh-TW', code: 'zh-tw', title: 'Chinese'),
    Language(ttsCode: 'hr', code: 'hr', title: 'Croatian'),
    Language(ttsCode: 'cs-CZ', code: 'cs', title: 'Czech'),
    Language(ttsCode: 'da-DK', code: 'da', title: 'Danish'),
    Language(ttsCode: 'nl-NL', code: 'nl', title: 'Dutch'),
    Language(ttsCode: 'en-US', code: 'en', title: 'English'),
    Language(ttsCode: 'et-EE', code: 'et', title: 'Estonian'),
    Language(ttsCode: 'fil-PH', code: 'tl', title: 'Filipino'),
    Language(ttsCode: 'fi-FI', code: 'fi', title: 'Finnish'),
    Language(ttsCode: 'fr-FR', code: 'fr', title: 'French'),
    Language(ttsCode: 'de-DE', code: 'de', title: 'German'),
    Language(ttsCode: 'el-GR', code: 'el', title: 'Greek'),
    Language(ttsCode: 'gu-IN', code: 'gu', title: 'Gujarati'),
    Language(ttsCode: '', code: 'haw', title: 'Hawaiian'),
    Language(ttsCode: '', code: 'iw', title: 'Hebrew'),
    Language(ttsCode: 'hi-IN', code: 'hi', title: 'Hindi'),
    Language(ttsCode: 'hu-HU', code: 'hu', title: 'Hungarian'),
    Language(ttsCode: '', code: 'is', title: 'Icelandic'),
    Language(ttsCode: '', code: 'id', title: 'Indonesian'),
    Language(ttsCode: '', code: 'ga', title: 'Irish'),
    Language(ttsCode: 'it-IT', code: 'it', title: 'Italian'),
    Language(ttsCode: 'ja-JP', code: 'ja', title: 'Japanese'),
    Language(ttsCode: '', code: 'jw', title: 'Javanese'),
    Language(ttsCode: 'kn-IN', code: 'kn', title: 'Kannada'),
    Language(ttsCode: 'km-KH', code: 'km', title: 'Khmer'),
    Language(ttsCode: 'ko-KR', code: 'ko', title: 'Korean'),
    Language(ttsCode: 'ku', code: 'ku', title: 'Kurdish (Kurmanji)'),
    Language(ttsCode: '', code: 'lo', title: 'Lao'),
    Language(ttsCode: 'la', code: 'la', title: 'Latin'),
    Language(ttsCode: '', code: 'lv', title: 'Latvian'),
    Language(ttsCode: '', code: 'lt', title: 'Lithuanian'),
    Language(ttsCode: '', code: 'lb', title: 'Luxembourgish'),
    Language(ttsCode: '', code: 'mk', title: 'Macedonian'),
    Language(ttsCode: 'ml-IN', code: 'ml', title: 'Malayalam'),
    Language(ttsCode: '', code: 'mt', title: 'Maltese'),
    Language(ttsCode: 'mr-IN', code: 'mr', title: 'Marathi'),
    Language(ttsCode: '', code: 'mn', title: 'Mongolian'),
    Language(ttsCode: '', code: 'my', title: 'Myanmar (Burmese)'),
    Language(ttsCode: 'ne-NP', code: 'ne', title: 'Nepali'),
    Language(ttsCode: '', code: 'no', title: 'Norwegian'),
    Language(ttsCode: '', code: 'fa', title: 'Persian'),
    Language(ttsCode: 'pl-PL', code: 'pl', title: 'Polish'),
    Language(ttsCode: 'pt-PT', code: 'pt', title: 'Portuguese'),
    Language(ttsCode: '', code: 'pa', title: 'Punjabi'),
    Language(ttsCode: 'ro-RO', code: 'ro', title: 'Romanian'),
    Language(ttsCode: 'ru-RU', code: 'ru', title: 'Russian'),
    Language(ttsCode: '', code: 'sm', title: 'Samoan'),
    Language(ttsCode: '', code: 'gd', title: 'Scots Gaelic'),
    Language(ttsCode: 'sr', code: 'sr', title: 'Serbian'),
    Language(ttsCode: 'si-LK', code: 'si', title: 'Sinhala'),
    Language(ttsCode: 'sk-SK', code: 'sk', title: 'Slovak'),
    Language(ttsCode: '', code: 'sl', title: 'Slovenian'),
    Language(ttsCode: '', code: 'so', title: 'Somali'),
    Language(ttsCode: 'es-ES', code: 'es', title: 'Spanish'),
    Language(ttsCode: 'su-ID', code: 'su', title: 'Sundanese'),
    Language(ttsCode: 'sw', code: 'sw', title: 'Swahili'),
    Language(ttsCode: 'sv-SE', code: 'sv', title: 'Swedish'),
    Language(ttsCode: 'ta-IN', code: 'ta', title: 'Tamil'),
    Language(ttsCode: 'te-IN', code: 'te', title: 'Telugu'),
    Language(ttsCode: 'th-TH', code: 'th', title: 'Thai'),
    Language(ttsCode: 'tr-TR', code: 'tr', title: 'Turkish'),
    Language(ttsCode: 'uk-UA', code: 'uk', title: 'Ukrainian'),
    Language(ttsCode: 'ur-PK', code: 'ur', title: 'Urdu'),
    Language(ttsCode: '', code: 'uz', title: 'Uzbek'),
    Language(ttsCode: 'vi-VN', code: 'vi', title: 'Vietnamese'),
    Language(ttsCode: 'cy', code: 'cy', title: 'Welsh'),
  ];
}
