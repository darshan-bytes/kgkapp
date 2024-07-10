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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ScreenUtilInit(
      designSize: AppConst.designSize,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: BlocGenerator.generateBlocList(),
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, appState) {
              AppBloc appBloc = BlocProvider.of<AppBloc>(context);
              return MediaQuery.withNoTextScaling(
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  onGenerateRoute: AppRoutes.generateRoute,
                  initialRoute: AppRoutes.initialRoute,
                  title: APPStrings.appName,
                  navigatorKey: NavigatorKey.navigatorKey,
                  supportedLocales: const [
                    Locale(APPStrings.languageEn, ''), // English
                    Locale(APPStrings.languageKo, '')
                  ],
                  theme: appBloc.themeData,
                  locale: appBloc.locale,
                  builder: (context, widget) {
                    return AnnotatedRegion<SystemUiOverlayStyle>(
                      value: SystemUiOverlayStyle.light,
                      child: Stack(
                        children: [
                          if (widget != null) widget,
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: const EdgeInsets.only(top: 55, right: 50),
                              child: const Banner(
                                message: "8-Jul-24",
                                location: BannerLocation.bottomStart,
                              ),
                            ),
                          ),
                          if (appState is ConnectivityState && !appState.isConnected)
                            NoInternetScreen(
                              theme: appBloc.themeData ?? appBloc.appThemes.light(),
                            )
                        ],
                      ),
                    );
                  },
                  navigatorObservers: [MyNavigatorObserver()],
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    AppLocalizations.delegate,
                    CountryLocalizations.delegate,
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
