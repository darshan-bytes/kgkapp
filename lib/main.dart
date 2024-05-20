import 'package:kgk/kgk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager().init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static ValueNotifier<Locale> notifier = ValueNotifier<Locale>(const Locale(APPStrings.languageEn));

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    String lang = StorageManager().getLocale() ?? APPStrings.languageEn;
    MyApp.notifier.value = Locale(lang);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: MyApp.notifier,
      builder: (context, value, child) {
        return MultiBlocProvider(
          providers: BlocGenerator.generateBlocList(),
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, appState) {
              AppBloc appBloc = BlocProvider.of<AppBloc>(context);
              return MaterialApp(
                home: Stack(children: [
                  MaterialApp(
                    onGenerateRoute: AppRoutes.generateRoute,
                    initialRoute: AppRoutes.initialRoute,
                    title: 'Bloc Base',
                    navigatorKey: NavigatorKey.navigatorKey,
                    supportedLocales: const [
                      Locale(APPStrings.languageEn, ''), // English
                      Locale(APPStrings.languageKo, '')
                    ],
                    theme: appBloc.themeData,
                    locale: MyApp.notifier.value,
                    localizationsDelegates: const [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      AppLocalizations.delegate
                    ],
                  ),
                  if (appState is ConnectivityState && !appState.isConnected)
                    NoInternetScreen(
                      theme: appBloc.themeData ?? appBloc.appThemes.light(),
                    )
                ]),
              );
            },
          ),
        );
      },
    );
  }
}
