import 'package:kgk/kgk.dart';
import 'package:kgk/modules/b2b/shipping_address/bloc/shipping_address_state.dart';

import '../bloc/shipping_address_event.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final btnStyle = AppTheme.of(context).primaryButtonStyle;
    final style = AppTheme.of(context).shippingAddressStyle;
    return Scaffold(
      backgroundColor: style.whiteColor,
      appBar: SmartAppBar(title: APPStrings.shippingAddress.tr),
      body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(17.sp),
          child: BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
              builder: (context, state) {
            if (state is InitialState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedState) {
              return Stack(
                children: [
                  ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        final address = state.data[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 7, right: 7),
                          // Set horizontal padding
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      address.isSelected
                                          ? Material(
                                              child: InkWell(
                                                  onTap: () {},
                                                  child: const SmartImage(
                                                      path: AppImages
                                                          .icRadioSelected)),
                                            )
                                          : Material(
                                              child: InkWell(
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            ShippingAddressBloc>()
                                                        .add(
                                                            SelectShippingAddressEvent(
                                                                address.id));
                                                  },
                                                  child: const SmartImage(
                                                      path: AppImages.icRadio)),
                                            ),
                                      const SizedBox(width: 10),
                                      SmartText(
                                        "${address.firstName} ${address.lastName}",
                                        style: style.titleStyle,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SmartImage(
                                          path: AppImages.icEditAddress,
                                          height: 24,
                                          width: 24),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Material(
                                        child: InkWell(
                                          onTap: () {
                                            context.read<ShippingAddressBloc>().add(
                                                ShippingAddressDeleteAddressEvent(
                                                    address));
                                          },
                                          child: const SmartImage(
                                              path: AppImages.icCancel,
                                              height: 24,
                                              width: 24),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.only(left: 35, top: 5),
                                  child: SmartText(
                                    "${address.apartment!} ${address.streetAddress}, ${address.city}, ${address.state} ${address.zipCode}",
                                    style: style.subTitleStyle,
                                  )),
                              const SizedBox(
                                height: 4,
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.only(left: 35, top: 5),
                                  child: SmartText(address.phoneNumber,
                                      style: style.subTitleStyle)),
                              const SizedBox(
                                height: 9,
                              ),
                              if (address.isDefault)
                                Container(
                                    height: 26,
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(left: 30),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              style.defaultBgColor),
                                      onPressed: () {},
                                      child: Text(APPStrings.default_text.tr,
                                          style: style
                                              .defaultTextStyle), //: TextStyle(fontSize: 12),
                                    )),
                              if (index != state.data.length - 1)
                                Divider(
                                    color: style.dividerColor,
                                    thickness: 1,
                                    height: 56),
                            ],
                          ),
                        );
                      }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 90,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                child: SizedBox(
                              height: 48,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      elevation: 0,
                                      backgroundColor: Colors.white),
                                  onPressed: () {},
                                  icon: const SmartImage(
                                      path: AppImages.icPlusBlue,
                                      height: 24,
                                      width: 24),
                                  label: SmartText("Add",
                                      style: style.cancelTextStyle)),
                            )),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: const BorderSide(
                                        color: Colors.blue, width: 1),
                                  ),
                                  minimumSize: const Size(0, 48),
                                  backgroundColor:
                                      btnStyle.activeBackgroundColor),
                              onPressed: () {},
                              child: SmartText(APPStrings.save.tr,
                                  style: style.saveTextStyle),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is NoDataState) {
              return Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.all(12),
                      child: SmartText(
                        state.message,
                        style: style.titleStyle,
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 90,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        elevation: 0,
                                        backgroundColor: Colors.white),
                                    onPressed: () {},
                                    icon: const SmartImage(
                                        path: AppImages.icPlusBlue,
                                        height: 24,
                                        width: 24),
                                    label: SmartText(APPStrings.add.tr,
                                        style: style.cancelTextStyle))),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: const BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                  minimumSize: const Size(0, 48),
                                  elevation: 0,
                                  backgroundColor: Colors.grey),
                              onPressed: () {},
                              child: SmartText(APPStrings.save.tr,
                                  style: style.saveTextStyle),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: SmartText(APPStrings.somethingWrong));
            }
          })),
    );
  }
}
