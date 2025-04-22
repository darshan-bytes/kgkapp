import 'package:kgk/kgk.dart';

part 'pdd_preview_event.dart';

part 'pdd_preview_state.dart';

class PddPreviewBloc extends Bloc<PddPreviewEvent, PddPreviewState> {
  String presentationId = '';

  //For WebView
  late WebViewController webViewController;

  //For Version History
  List<PddVersionHistoryModel> versionHistoryList = [];

  //For Selected Version
  PddVersionHistoryModel? selectedversion;
  Presentation? presentation;

  String htmlData = '';

  Map<String, String> imageMap = {};

  PddPreviewBloc() : super(InitialPddPreviewState()) {
    on<InitialPddPreviewEvent>(_onInitialPddListingEvent);
    on<VersionHistoryChangeEvent>(_onVersionHistoryChangeEvent);
    on<NavigateToPddVersionHistoryEvent>(_onNavigateToPddVersionHistoryEvent);
  }

  void getRouteData(BuildContext context) async {
    Map<RoutesData, dynamic>? data = context.routesData;
    if (data != null) {
      presentationId = data[RoutesData.presentationId] ?? '';
    }
  }

  Future<void> _onInitialPddListingEvent(InitialPddPreviewEvent event, Emitter<PddPreviewState> emit) async {
    emit(PddPreviewReloadState());
    getRouteData(event.context);
    await _onCmsWebViewInitialEvent(event.context);
    versionHistoryList =
        List.generate(
          10,
          (index) => PddVersionHistoryModel(
            historyDateTime: DateFormat(DateFormatter.dateFormatDDMMMYYYY).format(DateTime.now().subtract(Duration(days: index + 1))),
          ),
        ).toList();
    selectedversion = versionHistoryList.first;
    emit(PddPreviewLoadedState());
  }

  Future<void> _onCmsWebViewInitialEvent(BuildContext context) async {
    webViewController = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);
    await getPresentationPreviewDataAPI(context, presentationId);
    if (presentation?.data != null) {
      await loadJsonData(presentation!.data!);
    }
  }

  void _onVersionHistoryChangeEvent(VersionHistoryChangeEvent event, Emitter<PddPreviewState> emit) {
    emit(PddPreviewReloadState());
    selectedversion = event.pddVersionHistoryModel;
    emit(PddPreviewChangePreviewTypeState());
  }

  void _onNavigateToPddVersionHistoryEvent(NavigateToPddVersionHistoryEvent event, Emitter<PddPreviewState> emit) {
    event.context.pushNamed(AppRoutes.presentationPreviewHistory);
  }

  Future<void> getPresentationPreviewDataAPI(BuildContext context, String presentationId) async {
    try {
      final response = await AppRepository(context).presentationDetailsById(id: presentationId);
      response?.fold(
        (l) {
          Utils.showMessage(l.message);
        },
        (r) {
          presentation = r;
        },
      );
    } catch (e) {
      Utils.showMessage(e.toString());
    }
  }

  /// Loads JSON data and generates HTML content to be displayed in a WebView.
  ///
  /// This method processes the provided JSON data to extract styles, assets, and pages.
  /// It generates CSS styles, substitutes image sources using a lookup map, and builds
  /// an HTML structure from the JSON data. The resulting HTML is then loaded into the
  /// WebViewController.
  ///
  /// The JSON data is expected to have the following structure:
  /// - `styles`: A list of style definitions, each containing selectors and style rules.
  /// - `assets`: A list of assets, where images are identified by their type and name.
  /// - `pages`: A list of pages, each containing frames and components.
  ///
  /// The method performs the following steps:
  /// 1. Creates a lookup map (`imageMap`) for substituting image sources.
  /// 2. Generates CSS styles from the `styles` section of the JSON.
  /// 3. Builds the HTML body by recursively processing the components in the first frame of the first page.
  /// 4. Combines the CSS and HTML body into a complete HTML document.
  /// 5. Loads the generated HTML into the WebViewController.
  ///
  /// @param jsonData A `Map<String, dynamic>` containing the JSON data to be processed.
  Future<void> loadJsonData(Map<String, dynamic> jsonData) async {
    // Extract styles, assets, and pages from the JSON data.
    final styles = jsonData['styles'] as List<dynamic>;
    final assets = jsonData['assets'] as List<dynamic>;
    final pages = jsonData['pages'] as List<dynamic>;

    // Create a lookup map for substituting image sources.
    imageMap = {
      for (var asset in assets)
        if (asset['type'] == 'image') asset['name']: asset['src'],
    };

    // Generate CSS styles from the styles section of the JSON.
    final css = styles
        .map((style) {
          final selectors = style['selectors'] as List<dynamic>;
          final styleMap = style['style'] as Map<String, dynamic>;
          final selectorNames = selectors
              .map((s) {
                if (s is Map) {
                  return ".${s['name']?.toString()}";
                } else if (s is List) {
                  return s.firstOrNull;
                } else {
                  return s.toString();
                }
              })
              .join(', ');
          final styleRules = styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');
          return '$selectorNames { $styleRules }';
        })
        .join('\n');

    // Extract the first frame's component from the first page.
    final frameComponent = pages[0]['frames'][0]['component'];
    // Build the HTML body by processing the component recursively.
    final htmlBody = buildHtmlFromComponent(frameComponent);

    // Combine the CSS and HTML body into a complete HTML document.
    final html = '''
    <!DOCTYPE html>
    <html>
    <head>
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <style>
        $css
      </style>
    </head>
    <body>
      $htmlBody
    </body>
    </html>
    ''';

    // Store the generated HTML in the `htmlData` variable.
    htmlData = html;
    // Load the generated HTML into the WebViewController.
    await webViewController.loadHtmlString(htmlData);
  }

  /// Builds an HTML string representation of a component and its children.
  ///
  /// This method recursively processes a component represented as a `Map<String, dynamic>`,
  /// generating an HTML string. It handles attributes, classes, styles, and nested components.
  /// Additionally, it replaces image sources using a lookup map (`imageMap`) if the component
  /// is of type "image".
  ///
  /// The method performs the following steps:
  /// 1. Determines the HTML tag to use based on the `tagName` or `type` of the component.
  /// 2. Extracts attributes, classes, and styles from the component.
  /// 3. Replaces the `src` attribute for image components using the `imageMap`.
  /// 4. Recursively processes child components to build their HTML representation.
  /// 5. Combines all the information into a complete HTML string.
  ///
  /// @param component A `Map<String, dynamic>` representing the component to process.
  ///   - `tagName`: The HTML tag name to use (default is `div`).
  ///   - `type`: The type of the component (e.g., "image").
  ///   - `attributes`: A map of HTML attributes for the component.
  ///   - `classes`: A list of class names for the component.
  ///   - `style`: A map of CSS styles for the component.
  ///   - `components`: A list of child components.
  ///   - `content`: The inner content of the component (used if no children are present).
  /// @return A `String` containing the generated HTML for the component and its children.
  String buildHtmlFromComponent(Map<String, dynamic> component) {
    // Determine the HTML tag to use, defaulting to 'div'.
    String tag = component['tagName'] ?? 'div';
    if (component['type'] == "image") {
      tag = 'img';
    }

    // Extract attributes from the component.
    final attributes = Map<String, dynamic>.from(component['attributes'] ?? {});

    // Extract and join class names.
    final classes = (component['classes'] as List<dynamic>? ?? [])
        .map((cls) {
          if (cls is Map) {
            return cls['name']?.toString() ?? '';
          } else if (cls is List) {
            return cls.firstOrNull;
          } else {
            return cls.toString();
          }
        })
        .join(' ');

    // Extract and format styles.
    final style = component['style'] ?? {};
    final styleString = style.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    // Extract child components.
    final components = component['components'] as List<dynamic>?;

    // Handle image source replacement using the imageMap.
    if (tag == 'img' && attributes.containsKey('src')) {
      final String originalSrc = attributes['src'];
      if (imageMap.containsKey(originalSrc)) {
        attributes['src'] = imageMap[originalSrc];
      }
    }

    // Recursively process child components or use the content if no children are present.
    final childrenHtml =
        components != null
            ? components.map((child) => buildHtmlFromComponent(child as Map<String, dynamic>)).join('')
            : (component['content'] ?? '');

    // Format attributes into a string.
    final attrString = attributes.entries.map((e) => '${e.key}="${e.value}"').join(' ');

    // Return the complete HTML string for the component.
    return '<$tag class="$classes" style="$styleString" $attrString>$childrenHtml</$tag>';
  }
}
