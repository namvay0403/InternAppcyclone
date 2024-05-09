import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intern_appcyclone/utilities/const/app_assets.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';

import '../../../../practice/week02/localization/bloc/localization_bloc/localization_bloc.dart';
import '../../../../practice/week02/localization/model/model.dart';
import '../../../../utilities/const/colors.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return LanguageDialog();
            });
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.changeLanguage,
                textAlign: TextAlign.center,
                style: AppStyle.normal.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.language,
                textAlign: TextAlign.center,
                style: AppStyle.heading.copyWith(
                  color: AppColor.primaryColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageDialog extends StatelessWidget {
  LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var groupValue = context.read<LocalizationBloc>().state.locale.languageCode;
    List<String> flats = [AppAssets.ukFlat, AppAssets.vnFlat];
    return BlocConsumer<LocalizationBloc, LocalizationState>(
      listener: (context, state) {
        groupValue = state.locale.languageCode;
      },
      builder: (context, state) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.language),
          content: SizedBox(
            height: 200,
            width: 400,
            child: ListView.builder(
              itemCount: languageModel.length,
              itemBuilder: (context, index) {
                var item = languageModel[index];
                return RadioListTile(
                  value: item.languageCode,
                  secondary: Image.asset(
                    flats[index],
                    width: 30,
                    height: 30,
                  ),
                  groupValue: groupValue,
                  title: Text(item.language),
                  subtitle: Text(item.subLanguage),
                  onChanged: (value) {
                    BlocProvider.of<LocalizationBloc>(context)
                        .add(LoadLocalization(Locale(item.languageCode)));
                    Navigator.pop(context, value);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
