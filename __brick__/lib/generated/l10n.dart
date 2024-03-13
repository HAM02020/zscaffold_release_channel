// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class L10N {
  L10N();

  static L10N? _current;

  static L10N get current {
    assert(_current != null,
        'No instance of L10N was loaded. Try to initialize the L10N delegate before accessing L10N.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<L10N> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = L10N();
      L10N._current = instance;

      return instance;
    });
  }

  static L10N of(BuildContext context) {
    final instance = L10N.maybeOf(context);
    assert(instance != null,
        'No instance of L10N present in the widget tree. Did you add L10N.delegate in localizationsDelegates?');
    return instance!;
  }

  static L10N? maybeOf(BuildContext context) {
    return Localizations.of<L10N>(context, L10N);
  }

  /// `helloWorld`
  String get helloworld {
    return Intl.message(
      'helloWorld',
      name: 'helloworld',
      desc: '',
      args: [],
    );
  }

  /// `to second page`
  String get toSecondPage {
    return Intl.message(
      'to second page',
      name: 'toSecondPage',
      desc: '',
      args: [],
    );
  }

  /// `this is the second Page`
  String get secondPage {
    return Intl.message(
      'this is the second Page',
      name: 'secondPage',
      desc: '',
      args: [],
    );
  }

  /// `current total count is:`
  String get countTimes {
    return Intl.message(
      'current total count is:',
      name: 'countTimes',
      desc: '',
      args: [],
    );
  }

  /// `demo`
  String get demo {
    return Intl.message(
      'demo',
      name: 'demo',
      desc: '',
      args: [],
    );
  }

  /// `server`
  String get server {
    return Intl.message(
      'server',
      name: 'server',
      desc: '',
      args: [],
    );
  }

  /// `blog`
  String get blog {
    return Intl.message(
      'blog',
      name: 'blog',
      desc: '',
      args: [],
    );
  }

  /// `listTile`
  String get listTile {
    return Intl.message(
      'listTile',
      name: 'listTile',
      desc: '',
      args: [],
    );
  }

  /// `Chinese`
  String get Chinese {
    return Intl.message(
      'Chinese',
      name: 'Chinese',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message(
      'English',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `lightMode`
  String get lightMode {
    return Intl.message(
      'lightMode',
      name: 'lightMode',
      desc: '',
      args: [],
    );
  }

  /// `darkMode`
  String get darkMode {
    return Intl.message(
      'darkMode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `changeLocale`
  String get changeLocale {
    return Intl.message(
      'changeLocale',
      name: 'changeLocale',
      desc: '',
      args: [],
    );
  }

  /// `changeThemeMode`
  String get changeThemeMode {
    return Intl.message(
      'changeThemeMode',
      name: 'changeThemeMode',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<L10N> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<L10N> load(Locale locale) => L10N.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
