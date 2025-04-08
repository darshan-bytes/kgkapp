import 'dart:math' as math;

import 'package:kgk/kgk.dart';

part 'orion_event.dart';

part 'orion_state.dart';

class OrionBloc extends Bloc<OrionEvent, OrionState> {
  bool isInitialized = false;
  List<ProductCustomizationOptionValues> diamondShapeList = [];
  ProductCustomizationOptionValues? selectedDiamondShape;
  ScrollController diamondShapeListController = ScrollController();
  double maximumXAxis = 0.0;

  String getCurrencySymbol = "";

  /// Defines the minimum and maximum values for the price range slider.
  ///
  /// This constant is used to set the initial and maximum selectable range for the price slider in the UI.
  /// The `SfRangeValues` object holds two values:
  /// - start: The minimum value of the range, set to 0.
  /// - end: The maximum value of the range, set to 10000.
  /// These values represent the allowable price range for diamond selection.
  SfRangeValues minMaxValues = const SfRangeValues(0.00, 1000000.00);

  /// Represents the selected range values for the price filter.
  ///
  /// This `SfRangeValues` instance holds the initial minimum and maximum values
  /// for the price range slider used in the UI. It is set with a start value of 500
  /// and an end value of 10000, defining the default price range for filtering.
  SfRangeValues values = const SfRangeValues(0.00, 1000000.00);
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

  // List<CutModel> cutModelList = [];
  // List<ClarityModel> clarityModelList = [];
  // List<ColorModel> colorModelList = [];

  ClarityModel selectedClarityModel = ClarityModel(id: 1, name: 'IF', description: 'Internally Flawless');
  ColorModel selectedColorModel = ColorModel(id: 1, name: 'D', description: 'Colorless');
  CutModel selectedCutModel = CutModel(id: 1, name: 'Excellent', description: 'Very sparkly');

  double currentPrice = 0.0;
  double currentCarat = 0.0;

  GlobalKey chartKey = GlobalKey();

  // For List OF Diamond
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  /// The total number of filtered records
  int? totalFilteredRecords;

  /// Controller for managing pagination
  int? totalNumberOfPages;

  /// Determines if the view is in grid or list mode
  bool isGrid = true;

  /// This model is used to transfer data between the BLoC and the screen for displaying the product list in the UI
  List<ProductDetailsModel> productList = [];

  /// This variable is used to check whether the toggle is Precious tab or Semi Precious tab
  bool isInitialToggle = true;

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
    on<OrionPriceRangeReleaseEvent>(_onOrionPriceRangeReleaseEvent);
    on<OrionChangeListingTypeEvent>(_onOrionChangeListingTypeEvent);
    on<OrionListLoadMoreEvent>(_onOrionListLoadMoreEvent);
    on<OrionDiamondOnPointTapEvent>(_onOrionDiamondOnPointTapEvent);
  }

  /// Handler for load more
  Future<void> _onOrionListLoadMoreEvent(OrionListLoadMoreEvent event, Emitter<OrionState> emit) async {
    await _handleLoadMore(event.context, emit, event.currentPage);
  }

  /// Handle load more
  Future<void> _handleLoadMore(BuildContext context, Emitter<OrionState> emit, int currentPage) async {
    if (currentPage <= totalNumberOfPages!) {
      emit(OrionListLoadingMoreState());
      await fetchDiamondList(context, emit, isLoadMore: false);
      emit(OrionListLoadedMoreState(currentPage));
    }
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  /// Handler for changing the listing type
  Future<void> _onOrionChangeListingTypeEvent(OrionChangeListingTypeEvent event, Emitter<OrionState> emit) async {
    _changeListingViewType(emit);
  }

  /// Change listing view type
  void _changeListingViewType(Emitter<OrionState> emit) {
    emit(OrionReloadedState());
    isGrid = !isGrid;
    emit(OrionChangeListingTypeState());
  }

  ///Event Handlers
  Future<void> _onOrionInitialEvent(OrionInitialEvent event, Emitter<OrionState> emit) async {
    getCurrencySymbol = "".setCurrency;
    minPriceController.text = '${values.start.toStringAsFixed(2)}'.setCurrency;
    maxPriceController.text = '${values.end.toStringAsFixed(2)}'.setCurrency;
    if (isInitialized) return;
    isInitialized = true;
    _initializePagination(event.context);
    if (diamondShapeList.isEmpty) {
      await fetchUniqueShapes(event.context, emit);
    }
    if (selectedDiamondShape != null && selectedDiamondShape!.shapeCode.isNotNullNorEmpty) {
      final Map<String, String> body = {
        ApiKey.shape: selectedDiamondShape!.shapeCode ?? '',
        ApiKey.min: minPriceController.text.replaceAll(getCurrencySymbol, ''),
        ApiKey.max: maxPriceController.text.replaceAll(getCurrencySymbol, ''),
        ApiKey.limit: AppConst.pageLimit10000.toString()
      };
      await fetchOrionList(event.context, emit, body, isLoadMore: false);
    }
    emit(const OrionLoadedState());
  }

  Future<void> _generateProductList(BuildContext context, Emitter<OrionState> emit, Map<String, String>? query) async {
    /// Clear product list before fetching new data
    productList.clear();

    await fetchDiamondList(context, emit, query: query);

    emit(const OrionProductLoadedState());
  }

  Future<void> fetchDiamondList(BuildContext context, Emitter<OrionState> emit,
      {bool isLoadMore = false, Map<String, String>? query}) async {
    Either<ErrorResponse, DiamondListingModel>? response;
    query ??= {};
    response = await AppRepository(context).fetchDiamondList(
      page: AppConst.page1.toString(),
      limit: AppConst.pageLimit50.toString(),
      isLoadMore: isLoadMore,
      query: query,
    );

    await _handleDiamondListResponse(emit: emit, response: response);
  }

  /// Handle diamond list response
  Future<void> _handleDiamondListResponse(
      {required Either<ErrorResponse, DiamondListingModel>? response, required Emitter<OrionState> emit}) async {
    response?.fold((error) {
      Utils.showMessage(error.message);
    }, (success) {
      totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
      final diamondList = success.data;

      /// Show the total number of records in the UI side
      totalFilteredRecords = success.filteredRecords;
      productList.addAll(
        diamondList.map((diamond) => _convertDiamondDataModelToProductDetailsModel(diamond: diamond)).toList(),
      );

      /// Here sometime the pagination is not completed and called multiple times so we have managed it
      if (paginationScrollController.isPageLoaded.isCompleted) {
        paginationScrollController.isPageLoaded = Completer<bool>();
      }
      paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
      emit(const OrionDiamondListLoadedState());
    });
  }

  /// Helper Function: Convert Gemstone Data to ProductDetailsModel
  ProductDetailsModel _convertDiamondDataModelToProductDetailsModel({required DiamondDataModel diamond}) {
    return ProductDetailsModel(
      suid: diamond.suid,
      productId: diamond.id,
      imageUrl: diamond.image.isNotNullNorEmpty ? diamond.image.first.url : null,
      name: diamond.rmDescription ?? "",
      ctsOrGms: diamond.ctsOrGms,
      rappaportPrice: diamond.rappaportPrice,
      priceCts: diamond.priceCts,
      originalPrice: diamond.finalPrice?.toString().setCurrency,
      offerPrice: diamond.finalPrice?.toString().setCurrency,
      finalPrice: diamond.discountPrice?.toString().setCurrency,
      lotCode: diamond.lotCode,
      productSku: diamond.lotCode,
      shape: diamond.shape,
      fluorescence: diamond.fluorescence,
      labs: diamond.labs,
      lsp: diamond.lsp,
      color: diamond.color,
      clarity: diamond.clarity,
      cut: diamond.cut,
      certificateFile: diamond.certificateFile,
      openDnaUrl: diamond.openDnaUrl,
      commodity: Commodity.diamond,
      company: diamond.id,
      isFavourite: diamond.isFavorite,
      wishlistId: diamond.wishlistID,
      title: diamond.lotCode ?? "",
      subTitle: diamond.rmDescription ?? "",
      isForAuction: diamond.isAuction,
    );
  }

  /// Initialize pagination
  _initializePagination(BuildContext context) {
    paginationScrollController.init(
      isSecondaryView: true,
      loadAction: (int currentPage) async {
        add(OrionListLoadMoreEvent(context, currentPage));
      },
    );
  }

  Future<void> fetchUniqueShapes(context, Emitter<OrionState> emit) async {
    Either<ErrorResponse, List<OrionShapeModel>>? response = await AppRepository(context).fetchUniqueShapes();
    response?.fold((l) {
      Utils.showMessage(l.message);
    }, (r) async {
      List<OrionShapeModel> shapeList = r;
      for (int i = 0; i < shapeList.length; i++) {
        ProductCustomizationOptionValues value = ProductCustomizationOptionValues(
            id: i.toString(),
            value: shapeList[i].shape.isNotNullNorEmpty ? shapeList[i].shape : '-',
            shapeCode: shapeList[i].shapeCode.isNotNullNorEmpty ? shapeList[i].shapeCode : '',
            image: shapeList[i].imgPath?.setMediaUrl,
            availableProductCount: shapeList[i].count != null ? shapeList[i].count!.toInt() : 0);
        diamondShapeList.add(value);
      }
      if (diamondShapeList.isNotEmpty) selectedDiamondShape = diamondShapeList.first;
    });
  }

  Future<void> fetchOrionList(context, Emitter<OrionState> emit, Map<String, String> body, {bool isLoadMore = true}) async {
    final response = await AppRepository(context).fetchOrionList(isLoadMore, body: body);

    return response?.fold((error) => Utils.showMessage(error.message), (PaginationData<OrionDataModel> success) async {
      /// Clear previous data
      clearData();
      final list = success.dataList ?? [];
      if (list.isEmpty) return;

      final validItems = list.where((item) => item.discountPrice != null);

      final validItemList = validItems.toList();
      for (final item in validItemList) {
        // Parse size and update maximumXAxis
        // final size = double.parse(item.ctsOrGms!.replaceAll(',', ''));
        final size = item.ctsOrGms ?? 0.0;
        maximumXAxis = size > maximumXAxis ? size : maximumXAxis;
        //
        // // Check and update ClarityModel
        // var clarityModel = clarityModelList.firstWhere(
        //   (model) => model.name.trim().toLowerCase() == item.clarity?.trim().toLowerCase(),
        //   orElse: () {
        //     final newClarityModel = ClarityModel(
        //       id: validItemList.indexOf(item),
        //       name: item.clarity ?? '',
        //       description: 'Very slightly included',
        //     );
        //     clarityModelList.add(newClarityModel);
        //     return newClarityModel;
        //   },
        // );
        //
        // // Check and update ColorModel
        // var colorModel = colorModelList.firstWhere(
        //   (model) => model.name.trim().toLowerCase() == item.color?.trim().toLowerCase(),
        //   orElse: () {
        //     final newColorModel = ColorModel(
        //       id: validItemList.indexOf(item),
        //       name: item.color ?? '',
        //       description: 'Colorless',
        //     );
        //     colorModelList.add(newColorModel);
        //     return newColorModel;
        //   },
        // );
        //
        // // Check and update CutModel
        // var cutModel = cutModelList.firstWhere(
        //   (model) => model.name.trim().toLowerCase() == item.cut?.trim().toLowerCase(),
        //   orElse: () {
        //     final newCutModel = CutModel(
        //       id: validItemList.indexOf(item),
        //       name: item.cut ?? '',
        //       description: 'Very sparkly',
        //     );
        //     cutModelList.add(newCutModel);
        //     return newCutModel;
        //   },
        // );

        // Add the data to chartData
        chartData.add(ChartDataModel(
          size,
          double.parse(item.discountPrice!.replaceAll(',', '')),
          orionDataModel: item,
          // cutModel: cutModel,
          // clarityModel: clarityModel,
          // colorModel: colorModel,
        ));
      }

      // Adjust maximum X axis after processing all items
      if (list.isNotEmpty) {
        maximumXAxis += 1.0;
      }
    });
  }

  // clear data
  void clearData() {
    // clarityModelList.clear();
    // colorModelList.clear();
    // cutModelList.clear();
    chartData.clear();
    maximumXAxis = 0.0;
    productList.clear();
    chartKey = GlobalKey();
  }

  Future<void> _onOrionPriceRangeChangedEvent(OrionPriceRangeChangedEvent event, Emitter<OrionState> emit) async {
    emit(const OrionReloadedState());
    values = event.values;
    minPriceController.text = '${values.start.toStringAsFixed(2)}'.setCurrency;
    maxPriceController.text = '${values.end.toStringAsFixed(2)}'.setCurrency;
    emit(const OrionPriceRangeChangedState());
  }

  //_onOrionPriceRangeReleaseEvent
  Future<void> _onOrionPriceRangeReleaseEvent(OrionPriceRangeReleaseEvent event, Emitter<OrionState> emit) async {
    emit(const OrionReloadedState());
    clearData();
    if (selectedDiamondShape != null && selectedDiamondShape!.shapeCode.isNotNullNorEmpty) {
      final Map<String, String> body = {
        ApiKey.shape: selectedDiamondShape!.shapeCode ?? '',
        ApiKey.min: minPriceController.text.replaceAll(getCurrencySymbol, ''),
        ApiKey.max: maxPriceController.text.replaceAll(getCurrencySymbol, ''),
        ApiKey.limit: AppConst.pageLimit10000.toString(),
      };
      await fetchOrionList(event.context, emit, body);
      add(OrionDiamondCalculateDotPositionsEvent(context: event.context));
      emit(const OrionLoadedState());
    }
  }

  Future<void> _onOrionDiamondShapeChangedEvent(OrionDiamondShapeChangedEvent event, Emitter<OrionState> emit) async {
    emit(const OrionReloadedState());
    int oldIndex = selectedDiamondShape == null ? -1 : diamondShapeList.indexOf(selectedDiamondShape!);
    selectedDiamondShape = diamondShapeList[event.index];
    if (selectedDiamondShape != null && selectedDiamondShape != null && selectedDiamondShape!.shapeCode.isNotNullNorEmpty) {
      final Map<String, String> body = {
        ApiKey.shape: selectedDiamondShape!.shapeCode ?? '',
        ApiKey.min: minPriceController.text.replaceAll(getCurrencySymbol, ''),
        ApiKey.max: maxPriceController.text.replaceAll(getCurrencySymbol, ''),
        ApiKey.limit: AppConst.pageLimit10000.toString()
      };
      await fetchOrionList(event.context, emit, body);
      add(OrionDiamondCalculateDotPositionsEvent(context: event.context));
      emit(const OrionLoadedState());
    }
    emit(OrionDiamondShapeChangedState(oldIndex, event.index));
  }

  Future<void> _onOrionDiamondPropertiesChangedEvent(OrionDiamondPropertiesChangedEvent event, Emitter<OrionState> emit) async {
    emit(const OrionReloadedState());
    switch (event.diamondPropertiesIndex) {
      // case 0:
      //   selectedCutModel = cutModelList[event.propertiesIndex];
      //   break;
      // case 1:
      //   selectedColorModel = colorModelList[event.propertiesIndex];
      //   break;
      // case 2:
      //   selectedClarityModel = clarityModelList[event.propertiesIndex];
      //   break;
    }

    emit(OrionDiamondCutChangedState(event.diamondPropertiesIndex, event.propertiesIndex));
  }

  void _onOrionPriceRangeEditEvent(OrionPriceRangeEditEvent event, Emitter<OrionState> emit) {
    if (event.isMin) {
      handleMinPriceChange(event.context);
    } else {
      handleMaxPriceChange(event.context);
    }
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
  void handleMinPriceChange(BuildContext context) {
    double min = double.tryParse(minPriceController.text) ?? 0; // Attempt to parse the minimum price from the text field.
    if (min >= minMaxValues.start && min <= minMaxValues.end) {
      // Check if the parsed value is within the valid range.
      SfRangeValues values = SfRangeValues(min, this.values.end); // Create a new range with the updated minimum value.
      if (min >= this.values.end) {
        // Adjust the maximum value if the new minimum is greater than the current maximum.
        values = SfRangeValues(min, min);
      }
      add(OrionPriceRangeChangedEvent(values, context, isFromTextField: true, isMin: true)); // Trigger an event to update the price range.
    } else {
      minPriceController.text = '${values.start.toStringAsFixed(2)}'.setCurrency; // Reset the text field if the value is out of range.
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
  void handleMaxPriceChange(BuildContext context) {
    double max = double.tryParse(maxPriceController.text) ?? 0; // Attempt to parse the maximum price from the text field.
    if (max >= minMaxValues.start && max <= minMaxValues.end) {
      // Check if the parsed value is within the valid range.
      SfRangeValues values = SfRangeValues(this.values.start, max); // Create a new range with the updated maximum value.
      if (max <= this.values.start) {
        // Adjust the minimum value if the new maximum is less than or equal to the current minimum.
        values = SfRangeValues(max, max);
      }
      add(OrionPriceRangeChangedEvent(values, context, isFromTextField: true, isMin: false)); // Trigger an event to update the price range.
    } else {
      maxPriceController.text = '${values.end.toStringAsFixed(2)}'.setCurrency; // Reset the text field if the value is out of range.
    }
  }

  /// Handles the drag update event for the pin.
  Future<void> updatePinPosition(BuildContext context, DragUpdateDetails details) async {
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
      await showSelectedData(context, currentData);
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
  Future<void> showSelectedData(BuildContext context, ChartDataModel data) async {
    // await _getOrionDetails(context);
    // selectedCutModel = data.cutModel;
    // selectedClarityModel = data.clarityModel;
    // selectedColorModel = data.colorModel;
  }

  /// Snap the pin to the nearest point on the chart
  Future<void> snapPinToNearestPoint(BuildContext context, Emitter<OrionState> emit) async {
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
    currentCarat = chartData[pointIndex ?? 0].x;

    context.setAppLoading(true);
    await _getOrionDetails(context, pointIndex);
    Map<String, String> query = {
      ApiKey.cut: selectedCutModel.name,
      ApiKey.color: selectedColorModel.name,
      ApiKey.clarity: selectedClarityModel.name,
      ApiKey.shapeCode: selectedDiamondShape!.shapeCode ?? '',
    };
    await _generateProductList(context, emit, query);
    context.setAppLoading(false);
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
  Future<void> calculateDotPositions(BuildContext context, Emitter<OrionState> emit) async {
    dotPositions.clear();
    if (chartSeriesController != null) {
      dotPositions = chartData.map((point) {
        return chartSeriesController!.pointToPixel(CartesianChartPoint<num>(x: point.x, y: point.y ?? 0));
      }).toList();

      if (chartData.isNotEmpty) {
        currentPrice = chartData[pointIndex ?? 0].y ?? 0;

        // Directly use the x value as the carat value
        currentCarat = chartData[pointIndex ?? 0].x;
      }

      context.setAppLoading(true);
      Map<String, String> query = {
        ApiKey.cut: selectedCutModel.name,
        ApiKey.color: selectedColorModel.name,
        ApiKey.clarity: selectedClarityModel.name,
        ApiKey.shapeCode: selectedDiamondShape!.shapeCode ?? '',
      };
      await _generateProductList(context, emit, query);
      context.setAppLoading(false);
      if (dotPositions.isEmpty) return;
      pinPosition = dotPositions.first;
      // Todo ::
    }
  }

  /// _getOrionDetails
  Future<void> _getOrionDetails(BuildContext context, int? myIndex) async {
    Either<ErrorResponse, CommonResponse<OrionDetailModel>>? response = await AppRepository(context).fetchOrionDetails(
        discountPrice: chartData[myIndex ?? 0].orionDataModel?.rate.toString() ?? "0.0",
        caratWeight: chartData[myIndex ?? 0].orionDataModel?.ctsOrGms.toString() ?? "0.0");
    response?.fold((l) {
      Utils.showMessage(l.message);
    }, (r) async {
      // Handle the response

      selectedCutModel = CutModel(
        id: 0,
        name: r.responseData.first.cuts.first.toString(),
        description: 'Very sparkly',
      );
      selectedColorModel = ColorModel(
        id: 0,
        name: r.responseData.first.colors.first.toString(),
        description: 'Colorless',
      );
      selectedClarityModel = ClarityModel(
        id: 0,
        name: r.responseData.first.clarity.first.toString(),
        description: 'Very slightly included',
      );
    });
  }

  Future<void> _onOrionDiamondCalculateDotPositionsEvent(OrionDiamondCalculateDotPositionsEvent event, Emitter<OrionState> emit) async {
    emit(const OrionReloadedState());
    await calculateDotPositions(event.context, emit);
    emit(const OrionDiamondMovedState());
  }

  Future<void> _onOrionDiamondChangePointIndexEvent(OrionDiamondChangePointIndexEvent event, Emitter<OrionState> emit) async {
    emit(const OrionReloadedState());
    pointIndex = event.index;
    await _getOrionDetails(event.context, event.index);
    emit(const OrionDiamondMovedState());
  }

  Future<void> _onOrionDiamondChartTouchInteractionUpEvent(OrionDiamondChartTouchInteractionUpEvent event, Emitter<OrionState> emit) async {
    emit(const OrionReloadedState());
    event.context.setAppLoading(true);
    pinPosition = event.tapArgs.position;
    await snapPinToNearestPoint(event.context, emit);

    ChartDataModel? currentData = getCurrentChartData();
    if (currentData != null) {
      await showSelectedData(event.context, currentData);
    }

    if (pointIndex != null && chartSeriesController != null) {
      CartesianChartPoint<dynamic> dragPoint = chartSeriesController!.pixelToPoint(event.tapArgs.position);

      chartData[pointIndex!] = ChartDataModel(dragPoint.x, dragPoint.y as double?,
          cutModel: selectedCutModel, clarityModel: selectedClarityModel, colorModel: selectedColorModel);
    }

    // Todo : Add logic to update the chart
    Map<String, String> query = {
      ApiKey.cut: selectedCutModel.name,
      ApiKey.color: selectedColorModel.name,
      ApiKey.clarity: selectedClarityModel.name,
      ApiKey.shapeCode: selectedDiamondShape!.shapeCode ?? '',
    };
    await _generateProductList(event.context, emit, query);
    event.context.setAppLoading(false);
    emit(const OrionDiamondMovedState());
  }

  Future<void> _onOrionDiamondChartTouchInteractionDownEvent(
      OrionDiamondChartTouchInteractionDownEvent event, Emitter<OrionState> emit) async {
    emit(const OrionReloadedState());

    pinPosition = event.tapArgs.position;
    await snapPinToNearestPoint(event.context, emit);

    ChartDataModel? currentData = getCurrentChartData();
    if (currentData != null) {
      await showSelectedData(event.context, currentData);
    }

    if (pointIndex != null && chartSeriesController != null) {
      CartesianChartPoint<dynamic> dragPoint = chartSeriesController!.pixelToPoint(event.tapArgs.position);

      chartData[pointIndex!] = ChartDataModel(dragPoint.x, dragPoint.y as double?,
          cutModel: selectedCutModel, clarityModel: selectedClarityModel, colorModel: selectedColorModel);
    }
    //_getOrionDetails(event.context);
    emit(const OrionDiamondMovedState());
  }

  void _onOrionDiamondChartTouchInteractionMoveEvent(OrionDiamondChartTouchInteractionMoveEvent event, Emitter<OrionState> emit) {
    emit(const OrionReloadedState());
    pinPosition = event.tapArgs.position;
    emit(const OrionDiamondMovedState());
  }

  void _onOrionDiamondUpdatePinPositionEvent(OrionDiamondUpdatePinPositionEvent event, Emitter<OrionState> emit) async {
    emit(const OrionReloadedState());
    await updatePinPosition(event.context, event.dragUpdateDetails);
    emit(const OrionDiamondMovedState());
  }

  Future<void> _onOrionDiamondSnapNearestPoint(OrionDiamondSnapNearestPoint event, Emitter<OrionState> emit) async {
    emit(const OrionReloadedState());
    await snapPinToNearestPoint(event.context, emit);
    emit(const OrionDiamondMovedState());
  }

  Future<void> _onOrionDiamondOnPointTapEvent(OrionDiamondOnPointTapEvent event, Emitter<OrionState> emit) async {
    emit(const OrionReloadedState());
    pinPosition = chartSeriesController!.pointToPixel(CartesianChartPoint<num>(
        x: event.pointDetails.dataPoints?[(event.pointDetails.viewportPointIndex ?? 0).toInt()].x,
        y: event.pointDetails.dataPoints?[(event.pointDetails.viewportPointIndex ?? 0).toInt()].y ?? 0));

    snapPinToNearestPoint(event.context, emit);
    await _getOrionDetails(event.context, event.index);
    emit(const OrionDiamondMovedState());
  }
}
