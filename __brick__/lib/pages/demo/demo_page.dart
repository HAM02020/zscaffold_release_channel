import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:{{project_name.snakeCase()}}/app/application.dart';
import 'package:{{project_name.snakeCase()}}/app/bloc/user_settings/user_setting_bloc.dart';
import 'package:{{project_name.snakeCase()}}/app/route/routes.dart';
import 'package:{{project_name.snakeCase()}}/generated/l10n.dart';
import 'package:{{project_name.snakeCase()}}/pages/demo/bloc/counter_bloc.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildRouter(context),
            _buildCounter(context),
            const SizedBox(
              height: 50,
            ),
            _buildLanguageModeWidget(context),
            _buildThemeModeWidget(context),
            _buildPrimaryColorWidget(context),
          ],
        );
      },
    );
  }

  Widget _buildRouter(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: "toSecondPage",
      onPressed: () => Application.router.navigateTo(context, Routes.second),
      label: Text(L10N.of(context).toSecondPage),
    );
  }

  Widget _buildCounter(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                L10N.of(context).countTimes,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${BlocProvider.of<CounterBloc>(context).state.count}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              heroTag: "a",
              onPressed: () => GetIt.I.get<CounterBloc>().add(CounterMinus()),
              tooltip: 'Decrement',
              child: const FaIcon(FontAwesomeIcons.minus),
            ),
            const SizedBox(
              width: 50,
            ),
            FloatingActionButton(
              heroTag: "b",
              onPressed: () =>
                  //BlocProvider.of<CounterBloc>(context).add(CounterAdd()),
                  GetIt.instance.get<CounterBloc>().add(CounterAdd()),
              tooltip: 'Increment',
              child: const FaIcon(FontAwesomeIcons.plus),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLanguageModeWidget(BuildContext context) {
    final userSettingCubit =
        BlocProvider.of<UserSettingCubit>(context, listen: true);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(FontAwesomeIcons.language),
            const SizedBox(
              width: 10,
            ),
            Text(L10N.of(context).changeLocale)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(L10N.of(context).Chinese),
                Radio(
                  value: UserLocaleMode.zh,
                  groupValue: userSettingCubit.state.localMode,
                  onChanged: (value) => userSettingCubit.setLocaleMode(value!),
                )
              ],
            ),
            Row(
              children: [
                Text(L10N.of(context).English),
                Radio(
                  value: UserLocaleMode.en,
                  groupValue: userSettingCubit.state.localMode,
                  onChanged: (value) => userSettingCubit.setLocaleMode(value!),
                )
              ],
            ),
            Row(
              children: [
                Text(L10N.of(context).system),
                Radio(
                  value: UserLocaleMode.system,
                  groupValue: userSettingCubit.state.localMode,
                  onChanged: (value) => userSettingCubit.setLocaleMode(value!),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _buildThemeModeWidget(BuildContext context) {
    final userSettingCubit =
        BlocProvider.of<UserSettingCubit>(context, listen: true);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(FontAwesomeIcons.moon),
            const SizedBox(
              width: 10,
            ),
            Text(L10N.of(context).changeThemeMode),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(L10N.of(context).lightMode),
                Radio(
                  value: ThemeMode.light,
                  groupValue: userSettingCubit.state.themeMode,
                  onChanged: (value) => userSettingCubit.setThemeMode(value!),
                ),
              ],
            ),
            Row(
              children: [
                Text(L10N.of(context).darkMode),
                Radio(
                  value: ThemeMode.dark,
                  groupValue: userSettingCubit.state.themeMode,
                  onChanged: (value) {
                    userSettingCubit.setThemeMode(value!);
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text(L10N.of(context).system),
                Radio(
                  value: ThemeMode.system,
                  groupValue: userSettingCubit.state.themeMode,
                  onChanged: (value) => userSettingCubit.setThemeMode(value!),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _buildPrimaryColorWidget(BuildContext context) {
    final userSettingCubit =
        BlocProvider.of<UserSettingCubit>(context, listen: true);
    return SizedBox(
      width: 300,
      child: Wrap(
        children: [
          ...List<Color>.generate(
              24,
              (index) => Color.fromARGB(
                  Random().nextInt(255),
                  Random().nextInt(255),
                  Random().nextInt(255),
                  Random().nextInt(255))).map((color) => Container(
                margin: const EdgeInsets.all(2),
                width: 20,
                height: 20,
                child: Ink(
                  child: InkWell(
                    onTap: () => userSettingCubit.setPrimaryColor(color),
                    child: ColoredBox(color: color),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
