import 'dart:developer' as dev;

import 'package:kgk/kgk.dart';

void logMemoryUsage() {
  dev.log('Memory Usage: ${ProcessInfo.currentRss} bytes');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initializing Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Initializing Hive database
  await StorageManager().init();

  await initLangDetect();

  /// Initializing HttpOverrides
  HttpOverrides.global = MyHttpOverrides();

  /// Initializing Crashlytics
  if (!kDebugMode) {
    await AppCrashlytics.instance.initialize();
  }

  /// Below line is used to log memory usage. Uncomment it when need to log the memory usage
  // Timer.periodic(Duration(seconds: 1), (timer) {
  //logMemoryUsage();
  // });

  /// Initializing app
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
          providers: BlocGenerator.generateBlocList(context),
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, appState) {
              AppBloc appBloc = BlocProvider.of<AppBloc>(context);
              return MediaQuery.withNoTextScaling(
                /// Here we are using ToastificationWrapper to show toast messages and wrapped our MaterialApp
                /// with it to display toast messages without context
                child: ToastificationWrapper(
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    onGenerateRoute: AppRoutes.generateRoute,
                    initialRoute: AppRoutes.initialRoute,
                    title: APPStrings.appName,
                    navigatorKey: NavigatorKey.navigatorKey,
                    supportedLocales: appBloc.supportedLocales,
                    theme: appBloc.themeData,
                    locale: appBloc.locale,
                    builder: (context, widget) {
                      return buildMaterialBuilder(appBloc, widget, appState);
                    },
                    navigatorObservers: [MyNavigatorObserver()],
                    localizationsDelegates: appBloc.localizationsDelegates,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  /// Create  app view builder
  AnnotatedRegion<SystemUiOverlayStyle> buildMaterialBuilder(AppBloc appBloc, Widget? widget, AppState appState) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          buildAppRootsWidgets(appBloc, widget),
          buildDateBannerTag(),
          if (appState is ConnectivityState && !appState.isConnected)
            NoInternetScreen(theme: appBloc.themeData ?? appBloc.appThemes.light()),
        ],
      ),
    );
  }

  /// Build date banner tag on top right corner
  Align buildDateBannerTag() {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: const Banner(
        message: "11 April",
        location: BannerLocation.topEnd,
      ),
    );
  }

  /// Build app roots widgets with loading indicator
  BlocBuilder<AppBloc, AppState> buildAppRootsWidgets(AppBloc appBloc, Widget? widget) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => current is AppLoadingState,
      builder: (context, state) {
        return IgnorePointer(
          ignoring: appBloc.isLoading,
          child: Stack(
            children: [
              widget ?? const Offstage(),
              if (appBloc.isLoading) // Top level loading ( used while api calls)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  color: Colors.grey.withValues(alpha: 0.5),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        );
      },
    );
  }
}
