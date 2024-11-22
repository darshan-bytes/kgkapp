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
          providers: BlocGenerator.generateBlocList(context),
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
                  supportedLocales: appBloc.supportedLocales,
                  theme: appBloc.themeData,
                  locale: appBloc.locale,
                  builder: (context, widget) {
                    return buildMaterialBuilder(appBloc, widget, appState);
                  },
                  navigatorObservers: [MyNavigatorObserver()],
                  localizationsDelegates: appBloc.localizationsDelegates,
                ),
              );
            },
          ),
        );
      },
    );
  }

  /// Create main app view builder
  AnnotatedRegion<SystemUiOverlayStyle> buildMaterialBuilder(AppBloc appBloc, Widget? widget, AppState appState) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          buildAppRootsWidgets(appBloc, widget),
          buildDateBannerTag(),
          if (appState is ConnectivityState && !appState.isConnected)
            NoInternetScreen(
              theme: appBloc.themeData ?? appBloc.appThemes.light(),
            )
        ],
      ),
    );
  }

  /// Build date banner tag on top right corner
  Align buildDateBannerTag() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: const EdgeInsets.only(top: 55, right: 50),
        child: const Banner(
          message: "22-Nov-24",
          location: BannerLocation.bottomStart,
        ),
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
                  color: Colors.grey.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
