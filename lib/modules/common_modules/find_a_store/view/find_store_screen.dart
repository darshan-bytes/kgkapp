import 'package:kgk/kgk.dart';

class FindStoreScreen extends StatelessWidget {
  const FindStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).findStoreStyle;
    final bloc = BlocProvider.of<FindStoreBloc>(context);
    final textFieldStyle = AppTheme.of(context).textFieldStyle;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SmartAppBar(title: APPStrings.findStore.tr),
      body: BlocBuilder<FindStoreBloc, FindStoreState>(
        buildWhen: (previous, current) => current is FindStorePaginationInitializedState,
        builder: (context, state) {
          if (state is! FindStorePaginationInitializedState) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmartText(APPStrings.enterAddressOrPincode.tr, style: style.enterAddressStyle),
                SizedBox(height: 12.h),
                SizedBox(
                  height: 48.w,
                  child: GooglePlaceAutoCompleteTextField(
                    textEditingController: bloc.addressSearchController,
                    textStyle: style.enterAddressStyle,
                    googleAPIKey: AppConst.googleMapsKey,
                    boxDecoration: BoxDecoration(border: null),
                    inputDecoration: InputDecoration(
                      contentPadding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w),
                      suffixIcon: SmartImage(path: AppImages.icSearchThin, padding: EdgeInsetsDirectional.all(14.w)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.r)),
                        borderSide: BorderSide(color: textFieldStyle.enabledTextFieldBorderColor),
                      ),
                    ),
                    debounceTime: 800,
                    // default 600 ms,
                    isLatLngRequired: true,
                    focusNode: bloc.searchFocusNode,
                    // if you required coordinates from place detail
                    getPlaceDetailWithLatLng: (Prediction prediction) {
                      // this method will return latlng with place detail
                      bloc.add(
                        SortAddressByLatLongEvent(
                          context: context,
                          latitude: prediction.lat.toDouble ?? 0.0,
                          longitude: prediction.lng.toDouble ?? 0.0,
                        ),
                      );
                    },
                    // this callback is called when isLatLngRequired is true
                    itemClick: (Prediction prediction) {
                      FocusScope.of(context).unfocus();
                      bloc.addressSearchController.text = prediction.description ?? '';
                      bloc.addressSearchController.selection = TextSelection.fromPosition(
                        TextPosition(offset: prediction.description!.length),
                      );
                    },
                    // if we want to make custom list item builder
                    itemBuilder: (context, index, Prediction prediction) {
                      return Container(
                        padding: EdgeInsets.all(10.w),
                        child: Row(
                          children: [Icon(Icons.location_on), SizedBox(width: 7), Expanded(child: Text(prediction.description ?? ""))],
                        ),
                      );
                    },
                    // if you want to add seperator between list items
                    seperatedBuilder: Divider(),
                    // want to show close icon
                    isCrossBtnShown: false,
                    // place type
                    placeType: PlaceType.geocode,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    bloc.add(SortAddressByLatLongEvent(context: context, latitude: 0.0, longitude: 0.0, isCurrentLocation: true));
                  },
                  child: Container(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 12.w),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        SmartImage(path: AppImages.icFindStorePin, color: style.primaryColor, height: 24.w, width: 24.w),
                        SizedBox(width: 6.w),
                        SmartText(APPStrings.useCurrentLocation.tr, style: style.useCurrentLocationStyle),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                BlocBuilder<FindStoreBloc, FindStoreState>(
                  buildWhen: (previous, current) => current is FindStoreChangeTypeState,
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: SelectionButton(
                            isSelected: bloc.isInitialToggle,
                            title: bloc.tabOneTitle,
                            borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(4.r), bottomEnd: Radius.circular(4.r)),
                            onTap: () {
                              bloc.add(FindStoreChangeTypeEvent(isInitialToggle: true));
                            },
                          ),
                        ),
                        Expanded(
                          child: SelectionButton(
                            isSelected: !bloc.isInitialToggle,
                            title: bloc.tabTwoTitle,
                            borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(4.r), bottomEnd: Radius.circular(4.r)),
                            onTap: () {
                              bloc.add(FindStoreChangeTypeEvent(isInitialToggle: false));
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 12.h),

                /// When api is ready to use this code will be used
                Expanded(
                  child: BlocBuilder<FindStoreBloc, FindStoreState>(
                    buildWhen: (previous, current) => current is FindStoreAddressLoadedState || current is FindStoreChangeTypeState,
                    builder: (context, state) {
                      /// Changed to IndexedStack to show map and list view to fix the map re-rendering issue. Ref: https://stackoverflow.com/questions/53793869/flutter-googlemaps-reloads-everytime-i-change-page-in-tabnavigator
                      return IndexedStack(
                        index: !bloc.isInitialToggle ? 0 : 1,
                        children: [
                          SizedBox(
                            height: 452.h,
                            child: GoogleMap(
                              key: bloc.mapKey,
                              mapType: MapType.normal,
                              initialCameraPosition: bloc.myCameraPosition ?? CameraPosition(target: LatLng(0.0, 0.0)),
                              onMapCreated: (GoogleMapController controller) {
                                bloc.mapController.complete(controller);
                              },
                              myLocationEnabled: true,
                              markers: bloc.markers,
                              onTap: (position) {
                                if (bloc.searchFocusNode.hasFocus) {
                                  bloc.searchFocusNode.unfocus();
                                }
                              },
                              onCameraMove: (cameraPosition) {
                                if (bloc.searchFocusNode.hasFocus) {
                                  bloc.searchFocusNode.unfocus();
                                }
                              },
                              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                                Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()),
                                Factory<PanGestureRecognizer>(() => PanGestureRecognizer()),
                              },
                            ),
                          ),
                          BlocBuilder<FindStoreBloc, FindStoreState>(
                            builder: (context, state) {
                              return ListView.builder(
                                itemCount: bloc.addressList.length,
                                controller: bloc.paginationScrollController.controller,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return BlocBuilder<FindStoreBloc, FindStoreState>(
                                    builder: (context, state) {
                                      return Column(
                                        children: [
                                          SmartExpansionTile(
                                            key: bloc.addressList[index].addressDetailsKey,
                                            initiallyExpanded: true,
                                            trailing: null,
                                            trailingCollapsedIconVisible: false,
                                            backgroundColor: style.addressBgColor,
                                            title: Padding(
                                              padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 10.h),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        SmartText(bloc.addressList[index].storeName, style: style.addressTitleStyle),
                                                        SizedBox(height: 6.h),
                                                        SmartText(
                                                          APPStrings.fromYourLocationX.tr.interpolate([
                                                            bloc.addressList[index].storeDistance,
                                                          ]),
                                                          style: style.addressStyle,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      bloc.add(
                                                        GetDirectionEvent(
                                                          latitude: bloc.addressList[index].latitude.toDouble ?? 0.0,
                                                          longitude: bloc.addressList[index].longitude.toDouble ?? 0.0,
                                                        ),
                                                      );
                                                    },
                                                    icon: Icon(Icons.directions, color: style.primaryColor),
                                                    color: style.primaryColor,
                                                    tooltip: APPStrings.getDirections.tr,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            children: [
                                              Container(
                                                color: style.addressBgColor,
                                                padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Divider(),
                                                    SizedBox(height: 10.h),
                                                    SmartText(
                                                      bloc.addressList[index].storeAddress,
                                                      style: style.addressStyle,
                                                      textAlign: TextAlign.start,
                                                    ),
                                                    SizedBox(height: 16.h),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20.h),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
