import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/practice/week02/localization/bloc/localization_bloc/localization_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intern_appcyclone/practice/week02/localization/model/model.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var groupValue = context.read<LocalizationBloc>().state.locale.languageCode;
    return BlocConsumer<LocalizationBloc, LocalizationState>(
      listener: (context, state) {
        groupValue = state.locale.languageCode;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.language),
          ),
          body: ListView.builder(
            itemCount: languageModel.length,
            itemBuilder: (context, index) {
              var item = languageModel[index];
              return RadioListTile(
                value: item.languageCode,
                groupValue: groupValue,
                title: Text(item.language),
                subtitle: Text(item.subLanguage),
                onChanged: (value) {
                  print(value);
                  BlocProvider.of<LocalizationBloc>(context)
                      .add(LoadLocalization(Locale(item.languageCode)));
                },
              );
            },
          ),
        );
      },
    );
  }
}
