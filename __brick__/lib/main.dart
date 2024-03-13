import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:{{project_name.snakeCase()}}/app/bloc/app_bloc_oberver.dart';
import 'package:{{project_name.snakeCase()}}/app/bloc/user_settings/user_setting_bloc.dart';
import 'package:{{project_name.snakeCase()}}/app/route/routes.dart';
import 'package:{{project_name.snakeCase()}}/app/theme/theme.dart';
import 'package:{{project_name.snakeCase()}}/generated/l10n.dart';
import 'package:{{project_name.snakeCase()}}/pages/demo/bloc/counter_bloc.dart';
import 'package:{{project_name.snakeCase()}}/utils/log/log.dart';

void main() {
  zkRunZoneGuard(() async {
    await init();
    runApp(const App());
  });
}

Future<void> init() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Future.delayed(const Duration(seconds: 3))
      .then((value) => FlutterNativeSplash.remove());
  await ScreenUtil.ensureScreenSize();
  Routes.configureRouters();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  GetIt.I.registerSingleton<UserSettingCubit>(UserSettingCubit());
  GetIt.I.registerSingleton<CounterBloc>(CounterBloc());
  Bloc.observer = const AppBlocObserver();
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, _) {
      return BlocProvider(
        create: (_) => GetIt.I.get<UserSettingCubit>(),
        child: const AppView(),
      );
    });
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSettingCubit, UserSettingState>(
      builder: (context, state) {
        return MaterialApp(
          theme: AppTheme().theme(primary: state.primary),
          darkTheme: AppTheme().theme(isdark: true,primary: state.primary),
          themeMode: state.themeMode,
          onGenerateRoute: Routes.router.generator,
          initialRoute: '/',
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            L10N.delegate,
          ],
          supportedLocales: L10N.delegate.supportedLocales,
          locale: state.locale,
          navigatorObservers: [FlutterSmartDialog.observer],
          builder: FlutterSmartDialog.init(),
        );
      },
    );
  }
}
