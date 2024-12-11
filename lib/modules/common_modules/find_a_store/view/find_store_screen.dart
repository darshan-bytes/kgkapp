import 'package:kgk/kgk.dart';

class FindStoreScreen extends StatelessWidget {
  const FindStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).findStoreStyle;
    final bloc = BlocProvider.of<FindStoreBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.findStore.tr,
      ),
      body: SmartSingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          children: [
            SmartText(
              APPStrings.enterAnAddressOrZipCodeToFindARetailerNearYou.tr,
              style: style.storeMessageStyle,
            ),
            SizedBox(
              height: 16.h,
            ),
            SmartTextField(
              controller: bloc.addressSearchController,
              labelText: APPStrings.enterAddressOrPincode.tr,
              labelStyle: style.enterAddressStyle,
              focusNode: bloc.searchFocusNode,
              onFieldSubmitted: (value) {
                bloc.add(FindRetailStoreEvent(context: context));
              },
              suffixIcon: SmartImage(
                path: AppImages.icSearchThin,
                padding: EdgeInsets.all(14.w),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            GestureDetector(
              onTap: () {
                bloc.add(FindRetailStoreEvent(context: context, useCurrentLocation: true));
              },
              child: Row(
                children: [
                  SmartImage(
                    path: AppImages.icFindStorePin,
                    color: style.primaryColor,
                    height: 24.w,
                    width: 24.w,
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  SmartText(
                    APPStrings.useCurrentLocation.tr,
                    style: style.useCurrentLocationStyle,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),

            /// When api is ready to use this code will be used
            BlocBuilder<FindStoreBloc, FindStoreState>(
              buildWhen: (previous, current) => current is FindStoreAddressLoadedState,
              builder: (context, state) {
                return bloc.myCameraPosition != null
                    ? SizedBox(
                        height: 452.h,
                        child: GoogleMap(
                          mapType: MapType.hybrid,
                          initialCameraPosition: bloc.myCameraPosition!,
                          onMapCreated: (GoogleMapController controller) {
                            bloc.mapController.complete(controller);
                          },
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          markers: bloc.markers,
                          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                            Factory<EagerGestureRecognizer>(
                              () => EagerGestureRecognizer(),
                            ),
                            Factory<PanGestureRecognizer>(
                              () => PanGestureRecognizer(),
                            ),
                          },
                        ),
                      )
                    : SizedBox.shrink();
              },
            ),
            SizedBox(
              height: 24.h,
            ),
            BlocBuilder<FindStoreBloc, FindStoreState>(
              buildWhen: (previous, current) => current is FindStoreAddressLoadedState,
              builder: (context, state) {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bloc.addressList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return BlocBuilder<FindStoreBloc, FindStoreState>(
                        buildWhen: (previous, current) =>
                            current is FindStoreShowFullAddressState && (current.oldIndex == index || current.index == index),
                        builder: (context, state) {
                          return Column(
                            children: [
                              SmartExpansionTile(
                                key: bloc.addressList[index].addressDetailsKey,
                                onExpansionChanged: (value) {
                                  bloc.add(FindStoreShowFullAddressEvent(context: context, index: index, isExpanded: value));
                                },
                                trailing: bloc.addressList[index].isExpanded
                                    ? null
                                    : SmartImage(
                                        path: AppImages.icPlus,
                                        color: style.primaryColor,
                                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                                      ),
                                trailingCollapsedIconVisible: false,
                                backgroundColor: style.addressBgColor,
                                title: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SmartText(bloc.addressList[index].storeName, style: style.addressTitleStyle),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      SmartText(APPStrings.fromYourLocationX.tr.interpolate([bloc.addressList[index].storeDistance]),
                                          style: style.addressStyle),
                                    ],
                                  ),
                                ),
                                children: [
                                  Container(
                                    color: style.addressBgColor,
                                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                                    child: Column(
                                      children: [
                                        const Divider(),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        SmartText(bloc.addressList[index].storeAddress, style: style.addressStyle),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        SmartButton(
                                            onTap: () {
                                              bloc.add(GetDirectionEvent(
                                                  latitude: bloc.addressList[index].latitude.toDouble ?? 0.0,
                                                  longitude: bloc.addressList[index].longitude.toDouble ?? 0.0));
                                            },
                                            title: APPStrings.getDirections.tr),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              )
                            ],
                          );
                        },
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
