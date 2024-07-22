import 'dart:math' as math;

import 'package:kgk/kgk.dart';

part 'orion_event.dart';

part 'orion_state.dart';

class OrionBloc extends Bloc<OrionEvent, OrionState> {
  List<ProductCustomizationOptionValues> diamondShapeList = [];
  ProductCustomizationOptionValues? selectedDiamondShape;
  ScrollController diamondShapeListController = ScrollController();

  /// Defines the minimum and maximum values for the price range slider.
  ///
  /// This constant is used to set the initial and maximum selectable range for the price slider in the UI.
  /// The `SfRangeValues` object holds two values:
  /// - start: The minimum value of the range, set to 500.
  /// - end: The maximum value of the range, set to 10000.
  /// These values represent the allowable price range for diamond selection.
  SfRangeValues minMaxValues = const SfRangeValues(500.00, 10000.00);

  /// Represents the selected range values for the price filter.
  ///
  /// This `SfRangeValues` instance holds the initial minimum and maximum values
  /// for the price range slider used in the UI. It is set with a start value of 500
  /// and an end value of 10000, defining the default price range for filtering.
  SfRangeValues values = const SfRangeValues(500.00, 10000.00);
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();

  /// Chart Data
  List<ChartDataModel> chartData = [];
  int? pointIndex;
  ChartSeriesController? chartSeriesController;
  Offset pinPosition = const Offset(100, 100); // Initial position of the pin
  List<Offset> dotPositions = [];
  double xAxisWidth = -10.0.w;
  double yAxisWidth = -10.0.w;

  List<CutModel> cutModelList = [];
  List<ClarityModel> clarityModelList = [];
  List<ColorModel> colorModelList = [];

  ClarityModel selectedClarityModel = ClarityModel(id: 1, name: 'IF', description: 'Internally Flawless');
  ColorModel selectedColorModel = ColorModel(id: 1, name: 'D', description: 'Colorless');
  CutModel selectedCutModel = CutModel(id: 1, name: 'Excellent', description: 'Very sparkly');

  double currentPrice = 0.0;
  double currentCarat = 0.0;

  final GlobalKey chartKey = GlobalKey();

  OrionBloc() : super(const OrionInitial()) {
    on<OrionInitialEvent>(_onOrionInitialEvent);
    on<OrionPriceRangeChangedEvent>(_onOrionPriceRangeChangedEvent);
    on<OrionDiamondShapeChangedEvent>(_onOrionDiamondShapeChangedEvent);
    on<OrionDiamondPropertiesChangedEvent>(_onOrionDiamondPropertiesChangedEvent);
    on<OrionPriceRangeEditEvent>(_onOrionPriceRangeEditEvent);
    on<OrionDiamondCalculateDotPositionsEvent>(_onOrionDiamondCalculateDotPositionsEvent);
    on<OrionDiamondChangePointIndexEvent>(_onOrionDiamondChangePointIndexEvent);
    on<OrionDiamondChartTouchInteractionUpEvent>(_onOrionDiamondChartTouchInteractionUpEvent);
    on<OrionDiamondChartTouchInteractionDownEvent>(_onOrionDiamondChartTouchInteractionDownEvent);
    on<OrionDiamondChartTouchInteractionMoveEvent>(_onOrionDiamondChartTouchInteractionMoveEvent);
    on<OrionDiamondUpdatePinPositionEvent>(_onOrionDiamondUpdatePinPositionEvent);
    on<OrionDiamondSnapNearestPoint>(_onOrionDiamondSnapNearestPoint);
  }

  ///Event Handlers
  void _onOrionInitialEvent(OrionInitialEvent event, Emitter<OrionState> emit) {
    minPriceController.text = '\$ ${values.start.toStringAsFixed(2)}';
    maxPriceController.text = '\$ ${values.end.toStringAsFixed(2)}';
    _initDiamondShapeList();
    _initModelsData();
    emit(const OrionLoadedState());
  }

  void _initModelsData() {
    clarityModelList = [
      ClarityModel(id: 1, name: 'IF', description: 'Internally Flawless'),
      ClarityModel(id: 2, name: 'VVS1', description: 'Very Very Slightly Included 1'),
      ClarityModel(id: 3, name: 'VVS2', description: 'Very Very Slightly Included 2'),
      ClarityModel(id: 4, name: 'VS1', description: 'Very Slightly Included 1'),
      ClarityModel(id: 5, name: 'VS2', description: 'Very Slightly Included 2'),
      ClarityModel(id: 6, name: 'SI1', description: 'Slightly Included 1'),
      ClarityModel(id: 7, name: 'SI2', description: 'Slightly Included 2'),
      ClarityModel(id: 8, name: 'I1', description: 'Included 1'),
      ClarityModel(id: 9, name: 'I2', description: 'Included 2'),
      ClarityModel(id: 10, name: 'I3', description: 'Included 3'),
    ];

    colorModelList = [
      ColorModel(id: 1, name: 'D', description: 'Colorless'),
      ColorModel(id: 2, name: 'E', description: 'Colorless'),
      ColorModel(id: 3, name: 'F', description: 'Colorless'),
      ColorModel(id: 4, name: 'G', description: 'Near Colorless'),
      ColorModel(id: 5, name: 'H', description: 'Near Colorless'),
      ColorModel(id: 6, name: 'I', description: 'Near Colorless'),
      ColorModel(id: 7, name: 'J', description: 'Near Colorless'),
      ColorModel(id: 8, name: 'K', description: 'Faint Yellow'),
      ColorModel(id: 9, name: 'L', description: 'Faint Yellow'),
      ColorModel(id: 10, name: 'M', description: 'Faint Yellow'),
    ];

    cutModelList = [
      CutModel(id: 1, name: 'Excellent', description: 'Very sparkly'),
      CutModel(id: 2, name: 'Very Good', description: 'Very Good'),
      CutModel(id: 3, name: 'Good', description: 'Good'),
      CutModel(id: 4, name: 'Fair', description: 'Fair'),
      CutModel(id: 5, name: 'Poor', description: 'Poor'),
    ];

    chartData = _generateChartData();
  }

  List<ChartDataModel> _generateChartData() {
    final random = math.Random();
    return List.generate(50, (index) {
      return ChartDataModel(
          random.nextDouble() * 40, // x value between 0 and 40
          random.nextDouble() * 100, // y value
          cutModel: cutModelList.randomValue,
          clarityModel: clarityModelList.randomValue,
          colorModel: colorModelList.randomValue);
    });
  }

  void _onOrionPriceRangeChangedEvent(OrionPriceRangeChangedEvent event, Emitter<OrionState> emit) {
    emit(const OrionReloadedState());
    values = event.values;
    minPriceController.text = '\$ ${values.start.toStringAsFixed(2)}';
    maxPriceController.text = '\$ ${values.end.toStringAsFixed(2)}';
    emit(const OrionPriceRangeChangedState());
  }

  void _onOrionDiamondShapeChangedEvent(OrionDiamondShapeChangedEvent event, Emitter<OrionState> emit) {
    emit(const OrionReloadedState());
    int oldIndex = selectedDiamondShape == null ? -1 : diamondShapeList.indexOf(selectedDiamondShape!);
    selectedDiamondShape = diamondShapeList[event.index];

    emit(OrionDiamondShapeChangedState(oldIndex, event.index));
  }

  void _onOrionDiamondPropertiesChangedEvent(OrionDiamondPropertiesChangedEvent event, Emitter<OrionState> emit) {
    emit(const OrionReloadedState());
    switch (event.diamondPropertiesIndex) {
      case 0:
        selectedCutModel = cutModelList[event.propertiesIndex];
        break;
      case 1:
        selectedColorModel = colorModelList[event.propertiesIndex];
        break;
      case 2:
        selectedClarityModel = clarityModelList[event.propertiesIndex];
        break;
    }
    emit(OrionDiamondCutChangedState(event.diamondPropertiesIndex, event.propertiesIndex));
  }

  void _onOrionPriceRangeEditEvent(OrionPriceRangeEditEvent event, Emitter<OrionState> emit) {
    if (event.isMin) {
      handleMinPriceChange();
    } else {
      handleMaxPriceChange();
    }
  }

  ///Helper Methods
  void _initDiamondShapeList() {
    diamondShapeList = [
      ProductCustomizationOptionValues(
          id: '1', value: 'Round', image: 'https://i.ibb.co/8g83JhC/Mask-group.png', availableProductCount: Random().nextInt(100)),
      ProductCustomizationOptionValues(
          id: '2', value: 'Oval', image: 'https://i.ibb.co/KrzYdKc/Mask-group-1.png', availableProductCount: Random().nextInt(100)),
      ProductCustomizationOptionValues(
          id: '3', value: 'Cushion', image: 'https://i.ibb.co/85Xqqqc/Mask-group-2.png', availableProductCount: Random().nextInt(100)),
      ProductCustomizationOptionValues(
          id: '4', value: 'Pear', image: 'https://i.ibb.co/6RGVXbh/Mask-group-3.png', availableProductCount: Random().nextInt(100)),
      ProductCustomizationOptionValues(
          id: '5', value: 'Princess', image: 'https://i.ibb.co/ykmsZS2/Princess.png', availableProductCount: Random().nextInt(100)),
    ];
    selectedDiamondShape = diamondShapeList.first;
  }

  /// Handles the change in the minimum price value from the text field.
  ///
  /// This method is triggered when there is a change in the text field for the minimum price.
  /// It parses the text field value to a double and validates it against the predefined minimum and maximum values.
  /// If the new minimum value is within the valid range and not greater than the current maximum value,
  /// it updates the price range and triggers a [OrionPriceRangeChangedEvent].
  /// If the new minimum value is greater than the current maximum value, it adjusts the maximum value to match the minimum,
  /// ensuring the range is valid. If the parsed value is not within the valid range, it resets the text field
  /// to the current minimum value of the price range.
  ///
  /// The method uses [minPriceController] to read and update the text field value,
  /// [minMaxValues] to check against the valid range, and [values] to update the current price range.
  void handleMinPriceChange() {
    double min = double.tryParse(minPriceController.text) ?? 0; // Attempt to parse the minimum price from the text field.
    if (min >= minMaxValues.start && min <= minMaxValues.end) {
      // Check if the parsed value is within the valid range.
      SfRangeValues values = SfRangeValues(min, this.values.end); // Create a new range with the updated minimum value.
      if (min >= this.values.end) {
        // Adjust the maximum value if the new minimum is greater than the current maximum.
        values = SfRangeValues(min, min);
      }
      add(OrionPriceRangeChangedEvent(values, isFromTextField: true, isMin: true)); // Trigger an event to update the price range.
    } else {
      minPriceController.text = '\$ ${values.start.toStringAsFixed(2)}'; // Reset the text field if the value is out of range.
    }
  }

  /// Handles the change in the maximum price value from the text field.
  ///
  /// This method is invoked when there is a change in the text field for the maximum price.
  /// It attempts to parse the text field value to a double and validates it against the predefined
  /// minimum and maximum values defined in [minMaxValues]. If the parsed value is within the valid range,
  /// it updates the price range slider's maximum value accordingly. If the new maximum value is less than
  /// or equal to the current minimum value, it adjusts the minimum value to match the new maximum,
  /// ensuring the range is valid. If the parsed value is not within the valid range, it resets the text field
  /// to the current maximum value of the price range.
  ///
  /// The method uses [maxPriceController] to read and update the text field value,
  /// [minMaxValues] to check against the valid range, and [values] to update the current price range.
  void handleMaxPriceChange() {
    double max = double.tryParse(maxPriceController.text) ?? 0; // Attempt to parse the maximum price from the text field.
    if (max >= minMaxValues.start && max <= minMaxValues.end) {
      // Check if the parsed value is within the valid range.
      SfRangeValues values = SfRangeValues(this.values.start, max); // Create a new range with the updated maximum value.
      if (max <= this.values.start) {
        // Adjust the minimum value if the new maximum is less than or equal to the current minimum.
        values = SfRangeValues(max, max);
      }
      add(OrionPriceRangeChangedEvent(values, isFromTextField: true, isMin: false)); // Trigger an event to update the price range.
    } else {
      maxPriceController.text = '\$ ${values.end.toStringAsFixed(2)}'; // Reset the text field if the value is out of range.
    }
  }

  /// Handles the drag update event for the pin.
  Future<void> updatePinPosition(DragUpdateDetails details) async {
    Offset newPosition = pinPosition + details.delta;

    // Get the chart's render box
    final RenderBox? renderBox = chartKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final Size size = renderBox.size;

      // Constrain the pin position within the chart area
      newPosition = Offset(
        newPosition.dx.clamp(0, size.width),
        newPosition.dy.clamp(0, size.height - 44.w),
      );
    }

    // Calculate the current price based on the pin position
    if (chartSeriesController != null) {
      CartesianChartPoint<dynamic> chartPoint = chartSeriesController!.pixelToPoint(Offset(pinPosition.dx + yAxisWidth, pinPosition.dy));
      currentPrice = chartPoint.y!.toDouble();

      // Directly use the x value as the carat value
      currentCarat = chartPoint.x.toDouble();

      // Ensure carat is not negative and round to two decimal places
      currentCarat = math.max(0, (currentCarat * 100).round() / 100);
    }

    pinPosition = newPosition;
    ChartDataModel? currentData = getCurrentChartData();
    if (currentData != null) {
      showSelectedData(currentData);
    }
  }

  /// get the current chart data based on the pin position
  ChartDataModel? getCurrentChartData() {
    if (dotPositions.isEmpty) return null;

    int nearestIndex = -1;
    double minDistance = double.infinity;
    for (int i = 0; i < dotPositions.length; i++) {
      double distance = _calculateDistance(dotPositions[i], pinPosition);
      if (distance < minDistance) {
        minDistance = distance;
        nearestIndex = i;
      }
    }

    return nearestIndex >= 0 ? chartData[nearestIndex] : null;
  }

  /// Show the selected data based on the current chart data
  void showSelectedData(ChartDataModel data) {
    selectedCutModel = data.cutModel;
    selectedClarityModel = data.clarityModel;
    selectedColorModel = data.colorModel;
  }

  /// Snap the pin to the nearest point on the chart
  void snapPinToNearestPoint() {
    if (dotPositions.isNotEmpty) {
      pinPosition = findNearestOffset(dotPositions, pinPosition);
      if (chartSeriesController != null) {
        CartesianChartPoint<dynamic> chartPoint = chartSeriesController!.pixelToPoint(Offset(pinPosition.dx + yAxisWidth, pinPosition.dy));
        currentPrice = chartPoint.y!.toDouble();

        // Directly use the x value as the carat value
        currentCarat = chartPoint.x.toDouble();

        // Ensure carat is not negative and round to two decimal places
        currentCarat = math.max(0, (currentCarat * 100).round() / 100);
      }
    }
  }

  /// Find the nearest offset from a list of offsets to a target offset
  Offset findNearestOffset(List<Offset> offsetList, Offset targetOffset) {
    double minDistance = double.infinity;
    Offset nearestOffset = Offset.zero;

    for (Offset offset in offsetList) {
      double distance = _calculateDistance(offset, targetOffset);
      if (distance < minDistance) {
        minDistance = distance;
        nearestOffset = offset;
      }
    }

    return nearestOffset;
  }

  /// Calculate the distance between two offsets
  double _calculateDistance(Offset offset1, Offset offset2) {
    double deltaX = offset1.dx - offset2.dx;
    double deltaY = offset1.dy - offset2.dy;
    return sqrt(deltaX * deltaX + deltaY * deltaY);
  }

  /// Calculate the positions of the dots on the chart
  void calculateDotPositions() {
    if (chartSeriesController != null) {
      dotPositions = chartData.map((point) {
        return chartSeriesController!.pointToPixel(CartesianChartPoint<num>(x: point.x, y: point.y ?? 0));
      }).toList();

      pinPosition = dotPositions.first;
    }
  }

  void _onOrionDiamondCalculateDotPositionsEvent(OrionDiamondCalculateDotPositionsEvent event, Emitter<OrionState> emit) {
    emit(const OrionReloadedState());
    calculateDotPositions();
    emit(const OrionDiamondMovedState());
  }

  void _onOrionDiamondChangePointIndexEvent(OrionDiamondChangePointIndexEvent event, Emitter<OrionState> emit) {
    emit(const OrionReloadedState());
    pointIndex = event.index;
    emit(const OrionDiamondMovedState());
  }

  void _onOrionDiamondChartTouchInteractionUpEvent(OrionDiamondChartTouchInteractionUpEvent event, Emitter<OrionState> emit) {
    emit(const OrionReloadedState());

    pinPosition = event.tapArgs.position;
    snapPinToNearestPoint();

    ChartDataModel? currentData = getCurrentChartData();
    if (currentData != null) {
      showSelectedData(currentData);
    }

    if (pointIndex != null && chartSeriesController != null) {
      CartesianChartPoint<dynamic> dragPoint = chartSeriesController!.pixelToPoint(event.tapArgs.position);

      chartData[pointIndex!] = ChartDataModel(dragPoint.x, dragPoint.y as double?,
          cutModel: selectedCutModel, clarityModel: selectedClarityModel, colorModel: selectedColorModel);
    }
    emit(const OrionDiamondMovedState());
  }

  void _onOrionDiamondChartTouchInteractionDownEvent(OrionDiamondChartTouchInteractionDownEvent event, Emitter<OrionState> emit) {
    emit(const OrionReloadedState());

    pinPosition = event.tapArgs.position;
    snapPinToNearestPoint();

    ChartDataModel? currentData = getCurrentChartData();
    if (currentData != null) {
      showSelectedData(currentData);
    }

    if (pointIndex != null && chartSeriesController != null) {
      CartesianChartPoint<dynamic> dragPoint = chartSeriesController!.pixelToPoint(event.tapArgs.position);

      chartData[pointIndex!] = ChartDataModel(dragPoint.x, dragPoint.y as double?,
          cutModel: selectedCutModel, clarityModel: selectedClarityModel, colorModel: selectedColorModel);
    }
    emit(const OrionDiamondMovedState());
  }

  void _onOrionDiamondChartTouchInteractionMoveEvent(OrionDiamondChartTouchInteractionMoveEvent event, Emitter<OrionState> emit) {
    emit(const OrionReloadedState());
    pinPosition = event.tapArgs.position;
    emit(const OrionDiamondMovedState());
  }

  void _onOrionDiamondUpdatePinPositionEvent(OrionDiamondUpdatePinPositionEvent event, Emitter<OrionState> emit) async {
    emit(const OrionReloadedState());
    await updatePinPosition(event.dragUpdateDetails);
    emit(const OrionDiamondMovedState());
  }

  void _onOrionDiamondSnapNearestPoint(OrionDiamondSnapNearestPoint event, Emitter<OrionState> emit) {
    emit(const OrionReloadedState());
    snapPinToNearestPoint();
    emit(const OrionDiamondMovedState());
  }
}
