// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class AppLocalizations {
//   final Locale locale;
//   late Map<String, String> _localizedStrings;

//   AppLocalizations(this.locale);

//   static AppLocalizations of(BuildContext context) {
//     return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
//   }

//   Future<bool> load() async {
//     final jsonString =
//         await rootBundle.loadString('lib/core/l10n/translations/${locale.languageCode}.json');
//     final Map<String, dynamic> jsonMap = json.decode(jsonString);

//     _localizedStrings =
//         jsonMap.map((key, value) => MapEntry(key, value.toString()));

//     return true;
//   }

//   String translate(String key) {
//     return _localizedStrings[key] ?? key;
//   }

//   // Delegate
//   static const LocalizationsDelegate<AppLocalizations> delegate =
//       _AppLocalizationsDelegate();
// }

// class _AppLocalizationsDelegate
//     extends LocalizationsDelegate<AppLocalizations> {
//   const _AppLocalizationsDelegate();

//   @override
//   bool isSupported(Locale locale) =>
//       ['en', 'vi', 'ja'].contains(locale.languageCode);

//   @override
//   Future<AppLocalizations> load(Locale locale) async {
//     final localizations = AppLocalizations(locale);
//     await localizations.load();
//     return localizations;
//   }

//   @override
//   bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
//       false;
// }
