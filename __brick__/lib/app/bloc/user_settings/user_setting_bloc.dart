import 'dart:convert';
import 'dart:io';

import 'package:{{project_name.snakeCase()}}/generated/l10n.dart';
import 'package:{{project_name.snakeCase()}}/utils/log/log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_setting_state.dart';

const bool kSupportDarkMode = true;

class UserSettingCubit extends Cubit<UserSettingState> with HydratedMixin {
  UserSettingCubit() : super(UserSettingState()) {
    hydrate();
    _observeLocale();
    _observeBrightness();
  }

  Locale get locale {
    if (state.localMode == UserLocaleMode.system) {
      return _systemLocale;
    }
    return UserLocaleMode.values
        .where((mode) => mode == state.localMode)
        .map((mode) => Locale(mode.name))
        .first;
  }

  Brightness get brightness {
    return switch (state.themeMode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => PlatformDispatcher.instance.platformBrightness,
    };
  }

  SystemUiOverlayStyle get systemUiOverlayStyle {
    var style = brightness == Brightness.light
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;
    if (Platform.isAndroid) {
      style = style.copyWith(statusBarColor: Colors.transparent);
    }
    return style;
  }

  void setLocaleMode(UserLocaleMode localeMode) {
    zkLogger.d('setLocaleMode');
    emit(state.copyWith(localMode: localeMode));
  }

  void setThemeMode(ThemeMode theme) {
    switch (theme) {
      case ThemeMode.light:
        emit(state.copyWith(themeMode: theme));
        break;
      case ThemeMode.dark:
        emit(state.copyWith(themeMode: theme));
        break;
      case ThemeMode.system:
        emit(state.copyWith(themeMode: theme));
        _shouldChangePlatformBrightness();
    }
  }

  void setPrimaryColor(Color? color) {
    emit(state.copyWith(primary: () => color));
  }

  void _shouldChangePlatformBrightness() {
    if (state.themeMode != ThemeMode.system) {
      return;
    }

    final brightness = PlatformDispatcher.instance.platformBrightness;
    switch (brightness) {
      case Brightness.light:
        //emit(state.copyWith(colors: ZKColors.light()));
        break;
      case Brightness.dark:
        if (kSupportDarkMode) {
          //emit(state.copyWith(colors: ZKColors.dark()));
        }
        break;
    }
  }

  void _observeLocale() {
    if (state.localMode == UserLocaleMode.system) {
      setLocaleMode(UserLocaleMode.system);
    }
    PlatformDispatcher.instance.onLocaleChanged = () {
      if (state.localMode != UserLocaleMode.system) return;
      setLocaleMode(UserLocaleMode.system);
    };
  }

  void _observeBrightness() {
    PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
      WidgetsBinding.instance.handlePlatformBrightnessChanged();
      _shouldChangePlatformBrightness();
    };
    _shouldChangePlatformBrightness();
  }

  Locale get _systemLocale {
    final locales = PlatformDispatcher.instance.locales;
    for (var locale in locales
        .where((locale) => L10N.delegate.supportedLocales.contains(locale))) {
      return locale;
    }
    for (var locale in locales.where((locale) => L10N.delegate.supportedLocales
        .map((e) => e.languageCode)
        .contains(locale.languageCode))) {
      return locale;
    }
    return const Locale('en');
  }

  @override
  UserSettingState? fromJson(Map<String, dynamic> json) {
    return UserSettingState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(UserSettingState state) {
    return state.toMap();
  }
}
