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
  SfRangeValues minMaxValues = const SfRangeValues(500, 10000);

  /// Represents the selected range values for the price filter.
  ///
  /// This `SfRangeValues` instance holds the initial minimum and maximum values
  /// for the price range slider used in the UI. It is set with a start value of 500
  /// and an end value of 10000, defining the default price range for filtering.
  SfRangeValues values = const SfRangeValues(500, 10000);
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();

  List<OrionDiamondPropertiesDataModel> diamondPropertiesList = [];
  List<ScrollController> diamondPropertiesListController = [];

  OrionBloc() : super(const OrionInitial()) {
    on<OrionInitialEvent>(_onOrionInitialEvent);
    on<OrionPriceRangeChangedEvent>(_onOrionPriceRangeChangedEvent);
    on<OrionDiamondShapeChangedEvent>(_onOrionDiamondShapeChangedEvent);
    on<OrionDiamondPropertiesChangedEvent>(_onOrionDiamondPropertiesChangedEvent);
    on<OrionPriceRangeEditEvent>(_onOrionPriceRangeEditEvent);
  }

  ///Event Handlers
  void _onOrionInitialEvent(OrionInitialEvent event, Emitter<OrionState> emit) {
    minPriceController.text = '\$ ${values.start.toStringAsFixed(0)}';
    maxPriceController.text = '\$ ${values.end.toStringAsFixed(0)}';
    _initDiamondShapeList();
    _initDiamondPropertiesList();
    emit(const OrionLoadedState());
  }

  void _onOrionPriceRangeChangedEvent(OrionPriceRangeChangedEvent event, Emitter<OrionState> emit) {
    emit(const OrionReloadedState());
    values = event.values;
    minPriceController.text = '\$ ${values.start.toStringAsFixed(0)}';
    maxPriceController.text = '\$ ${values.end.toStringAsFixed(0)}';
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

    diamondPropertiesList[event.diamondPropertiesIndex].selectedProperties =
        diamondPropertiesList[event.diamondPropertiesIndex].propertiesList?[event.propertiesIndex];
    emit(OrionDiamondPropertiesChangedState(event.diamondPropertiesIndex, event.propertiesIndex));
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

  void _initDiamondPropertiesList() {
    diamondPropertiesList = [
      OrionDiamondPropertiesDataModel(
        id: 1,
        title: 'Cut',
        propertiesList: [
          OrionPropertiesDetails(id: 1, title: 'Excellent', subTitle: 'Very sparkly'),
          OrionPropertiesDetails(id: 2, title: 'Very Good', subTitle: 'Very sparkly Good'),
          OrionPropertiesDetails(id: 3, title: 'Good', subTitle: 'Sparkly Good'),
          OrionPropertiesDetails(id: 4, title: 'Fair', subTitle: 'Very sparkly Fair'),
          OrionPropertiesDetails(id: 5, title: 'Poor', subTitle: 'Sparkly Poor'),
          OrionPropertiesDetails(id: 6, title: 'Low', subTitle: 'Low Quality'),
        ],
      ),
      OrionDiamondPropertiesDataModel(
        id: 2,
        title: 'Color',
        propertiesList: [
          OrionPropertiesDetails(id: 1, title: 'D', subTitle: 'Colorless'),
          OrionPropertiesDetails(id: 2, title: 'E', subTitle: 'Colorless'),
          OrionPropertiesDetails(id: 3, title: 'F', subTitle: 'Colorless'),
          OrionPropertiesDetails(id: 4, title: 'G', subTitle: 'Colorless'),
          OrionPropertiesDetails(id: 5, title: 'H', subTitle: 'Colorless'),
          OrionPropertiesDetails(id: 6, title: 'I', subTitle: 'Colorless'),
          OrionPropertiesDetails(id: 7, title: 'J', subTitle: 'Colorless'),
          OrionPropertiesDetails(id: 8, title: 'K', subTitle: 'Colorless'),
          OrionPropertiesDetails(id: 9, title: 'L', subTitle: 'Colorless'),
          OrionPropertiesDetails(id: 10, title: 'M', subTitle: 'Colorless'),
        ],
      ),
      OrionDiamondPropertiesDataModel(
        id: 3,
        title: 'Clarity',
        propertiesList: [
          OrionPropertiesDetails(id: 1, title: 'IF', subTitle: 'Very slightly included'),
          OrionPropertiesDetails(id: 2, title: 'VVS1', subTitle: 'Very slightly included'),
          OrionPropertiesDetails(id: 3, title: 'VVS2', subTitle: 'Very slightly included'),
          OrionPropertiesDetails(id: 4, title: 'VS1', subTitle: 'Very slightly included'),
          OrionPropertiesDetails(id: 5, title: 'VS2', subTitle: 'Very slightly included'),
          OrionPropertiesDetails(id: 6, title: 'SI1', subTitle: 'Slightly included'),
          OrionPropertiesDetails(id: 7, title: 'SI2', subTitle: 'Slightly included'),
          OrionPropertiesDetails(id: 8, title: 'I1', subTitle: 'Included'),
          OrionPropertiesDetails(id: 9, title: 'I2', subTitle: 'Included'),
          OrionPropertiesDetails(id: 10, title: 'I3', subTitle: 'Included'),
        ],
      ),
    ];

    for (OrionDiamondPropertiesDataModel element in diamondPropertiesList) {
      element.selectedProperties = element.propertiesList?.first;
    }

    diamondPropertiesListController = List.generate(diamondPropertiesList.length, (index) => ScrollController());
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
      minPriceController.text = '\$ ${values.start.toStringAsFixed(0)}'; // Reset the text field if the value is out of range.
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
      maxPriceController.text = '\$ ${values.end.toStringAsFixed(0)}'; // Reset the text field if the value is out of range.
    }
  }
}
