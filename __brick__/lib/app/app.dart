import 'package:{{project_name.snakeCase()}}/app/bloc/user_settings/user_setting_bloc.dart';
import 'package:{{project_name.snakeCase()}}/app/route/routes.dart';
import 'package:{{project_name.snakeCase()}}/app/theme/color_schemes.g.dart';
import 'package:{{project_name.snakeCase()}}/app/theme/theme.dart';
import 'package:{{project_name.snakeCase()}}/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get_it/get_it.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context,_) {
        return BlocProvider(
          create: (_) => GetIt.I.get<UserSettingCubit>(),
          child: const AppView(),
        );
      }
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSettingCubit, UserSettingState>(
      builder: (context, state) {
        return MaterialApp(
          
          theme: AppTheme().theme(),
          darkTheme: AppTheme().theme(isdark: true),
          themeMode: state.themeMode,
          onGenerateRoute: Routes.router.generator,
          initialRoute: '/',
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            S.delegate,
          ],
          
          supportedLocales: S.delegate.supportedLocales,
          locale: context.watch<UserSettingCubit>().state.locale,
          localeResolutionCallback:
              context.read<UserSettingCubit>().handleLocaleResolutionCallback,
          navigatorObservers: [FlutterSmartDialog.observer],
          builder: FlutterSmartDialog.init(),

        );
        
      },
    );
  }
}
