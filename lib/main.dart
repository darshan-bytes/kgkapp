import 'package:kgk/kgk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager().init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
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
                title: 'KGK Mobile app',
                navigatorKey: NavigatorKey.navigatorKey,
                supportedLocales: const [
                  Locale(APPStrings.languageEn, ''), // English
                  Locale(APPStrings.languageKo, '')
                ],
                theme: appBloc.themeData,
                locale: appBloc.locale,
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
  }
}
