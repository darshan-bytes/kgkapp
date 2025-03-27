import 'package:kgk/kgk.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).preferencesStyle;
    final bloc = BlocProvider.of<PreferencesBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.preferences.tr,
      ),
      body: BlocBuilder<PreferencesBloc, PreferencesState>(
        buildWhen: (previous, current) => current is PreferencesLoadingState || current is PreferencesDataFetchedState,
        builder: (context, state) {
          return SafeArea(
            child: state is PreferencesLoadingState
                ? const SmartCircularProgressIndicator()
                : Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmartText(
                          APPStrings.country.tr,
                          style: style.titleStyle,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        BlocBuilder<PreferencesBloc, PreferencesState>(
                          buildWhen: (previous, current) => current is PreferencesChangeCountryState,
                          builder: (context, state) {
                            return SmartDropDown<CountryModel>(
                              selectedItem: bloc.selectedCountry,
                              items: bloc.countryList.map((e) => SmartDropDownItem<CountryModel>(value: e, title: e.name)).toList(),
                              hintText: APPStrings.country.tr,
                              onChanged: (newValue) {
                                if (newValue == null) return;
                                bloc.add(PreferencesChangeCountryEvent(newValue));
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SmartText(
                          APPStrings.language.tr,
                          style: style.titleStyle,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        BlocBuilder<PreferencesBloc, PreferencesState>(
                          buildWhen: (previous, current) => current is PreferencesChangeLanguageState,
                          builder: (context, state) {
                            return SmartDropDown<LanguageDatum>(
                              selectedItem: bloc.selectedLanguage,
                              items: bloc.languageList.map((e) => SmartDropDownItem<LanguageDatum>(value: e, title: e.name ?? '')).toList(),
                              hintText: APPStrings.language.tr,
                              onChanged: (newValue) {
                                if (newValue == null) return;
                                bloc.add(PreferencesChangeLanguageEvent(newValue));
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SmartText(
                          APPStrings.currency.tr,
                          style: style.titleStyle,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        BlocBuilder<PreferencesBloc, PreferencesState>(
                          buildWhen: (previous, current) => current is PreferencesChangeCurrencyState,
                          builder: (context, state) {
                            return SmartDropDown<CurrencyListModel>(
                              selectedItem: bloc.selectedCurrency,
                              items: bloc.currencyList
                                  .map((e) => SmartDropDownItem<CurrencyListModel>(value: e, title: "${e.name} (${e.symbol})"))
                                  .toList(),
                              hintText: APPStrings.currency.tr,
                              onChanged: (newValue) {
                                if (newValue == null) return;
                                bloc.add(PreferencesChangeCurrencyEvent(newValue));
                              },
                            );
                          },
                        ),
                        const Spacer(),
                        SmartButton(
                          title: APPStrings.save.tr,
                          onTap: () {
                            bloc.add(PreferencesSaveEvent(context));
                          },
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
