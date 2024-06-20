import 'package:kgk/kgk.dart';

class AuctionScreen extends StatelessWidget {
  const AuctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuctionBloc bloc = BlocProvider.of<AuctionBloc>(context);
    final AuctionScreenStyle style = AppTheme.of(context).auctionScreenStyle;
    return Scaffold(
      appBar: SmartAppBar(
        title: '1.01 Carat Round Diamond',
        onFavorite: () {
          context.pushNamed(AppRoutes.wishListPage);
        },
      ),
      body: ListView(
        controller: bloc.listScrollController,
        shrinkWrap: true,
        children: [
          _buildImageSlider(bloc),
          SizedBox(height: 39.h),
          _productDetail(context, bloc, style),
        ],
      ),
      floatingActionButton: _buildCompareButton(bloc, style),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _buildBottomNavigationBar(bloc, context, style),
      ),
    );
  }

  Widget _buildImageSlider(AuctionBloc bloc) {
    return BlocBuilder<AuctionBloc, AuctionState>(
      buildWhen: (_, current) => current is AuctionDiamondImagePageChangeState,
      builder: (context, state) {
        final ImageCarouselStyle imageCarouselStyle = AppTheme.of(context).imageCarouselStyle;
        return Column(
          children: [
            CarouselSlider(
              items: bloc.imgList.map((e) {
                return SmartImage(path: e);
              }).toList(),
              carouselController: bloc.controller,
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1.5,
                aspectRatio: 1,
                onPageChanged: (index, reason) {
                  bloc.add(AuctionDiamondImagePageChangeEvent(index: index));
                },
              ),
            ),
            SizedBox(height: 16.h),
            _buildImageIndicator(bloc, imageCarouselStyle),
          ],
        );
      },
    );
  }

  Widget _buildImageIndicator(AuctionBloc bloc, ImageCarouselStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: bloc.imgList.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => bloc.controller.animateToPage(entry.key),
          child: Container(
            width: 8.0.w,
            height: 8.0.w,
            margin: EdgeInsets.only(right: 6.0.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bloc.current == entry.key ? style.selectedDotColor : style.dotColor,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _productDetail(BuildContext context, AuctionBloc bloc, AuctionScreenStyle style) {
    final DiamondDetailScreenStyle diamondDetailScreenStyle = AppTheme.of(context).diamondDetailScreenStyle;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductHeader(diamondDetailScreenStyle),
          SizedBox(height: 8.h),
          _buildRatingSection(diamondDetailScreenStyle, style),
          SizedBox(height: 16.h),
          _compareWidget(bloc),
          SizedBox(height: 24.h),
          _priceSection(style),
          SizedBox(height: 12.h),
          _auctionRecentBidSection(bloc, style),
          SizedBox(height: 24.h),
          _orderSampleSection(diamondDetailScreenStyle),
          SizedBox(height: 24.h),
          _additionalInfo(diamondDetailScreenStyle),
          SizedBox(height: 24.h),
          const InquiryWidget(
            email: 'enquiry.diaind@kgkmail.com',
            phone: '+91 - 1234567830',
          ),
          SizedBox(height: 32.h),
          _buildYouMayAlsoLikeSection(bloc, context),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildProductHeader(DiamondDetailScreenStyle style) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmartText(
                'SKU 14178065',
                style: style.skuStyle,
              ),
              SizedBox(height: 8.h),
              SmartText(
                '1.01 Carat Round Diamond',
                style: style.diamondNameStyle,
              ),
            ],
          ),
        ),
        SizedBox(width: 17.w),
        SelectionButton(
          padding: EdgeInsets.all(12.w),
          isSelected: false,
          onTap: () {},
          image: AppImages.icHeart,
        ),
        SizedBox(width: 10.w),
        SelectionButton(
          padding: EdgeInsets.all(12.w),
          isSelected: false,
          onTap: () {},
          image: AppImages.icShare,
        ),
      ],
    );
  }

  Widget _buildRatingSection(DiamondDetailScreenStyle diamondDetailScreenStyle, AuctionScreenStyle style) {
    return Row(
      children: [
        SmartRatingBar(
          itemCount: 5,
          onRatingUpdate: (double value) {},
          initialRating: 4,
          allowHalfRating: false,
          itemSize: 16.sp,
          itemPadding: EdgeInsets.only(right: 2.w, left: 2.w),
        ),
        SizedBox(width: 8.w),
        SmartText(
          APPStrings.reviewsX.tr.interpolate([120]),
          style: diamondDetailScreenStyle.reviewStyle,
        ),
      ],
    );
  }

  Widget _compareWidget(AuctionBloc bloc) {
    return BlocBuilder<AuctionBloc, AuctionState>(
      buildWhen: (previous, current) => current is AuctionProductCompareToggleState,
      builder: (context, state) {
        return SmartCheckbox(
          value: bloc.isCompare,
          onChanged: (value) {
            bloc.add(const AuctionProductCompareToggleEvent());
          },
          label: APPStrings.compareProduct.tr,
        );
      },
    );
  }

  Widget _priceSection(AuctionScreenStyle style) {
    return Row(
      children: [
        SmartText(APPStrings.startingBidPrice.tr, style: style.bidPriceLableStyle),
        SizedBox(width: 8.w),
        Expanded(
          child: SmartText(
            "\$1200.00",
            style: style.bidPriceStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _auctionRecentBidSection(AuctionBloc bloc, AuctionScreenStyle style) {
    return BlocBuilder<AuctionBloc, AuctionState>(
      buildWhen: (previous, current) => current is AuctionTimerUpdateState || current is AuctionTimerCompletedState,
      builder: (context, state) {
        String timerText = state is AuctionTimerUpdateState ? bloc.formatDuration(state.duration) : "Loading...";
        if (state is AuctionTimerCompletedState) {
          timerText = "Auction has ended";
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              key: bloc.targetKey,
              decoration: BoxDecoration(
                color: style.recentBidBackgroundColor,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: style.borderColor),
              ),
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SmartText(
                        APPStrings.auctionEndIn.tr,
                        style: style.auctionTimerStyle,
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: SmartText(
                          timerText,
                          style: style.recentBidStyle,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                  const Divider(),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmartText(APPStrings.recentBid.tr, style: style.recentBidStyle),
                        SizedBox(width: 8.w),
                        if (bloc.recentBidList.isNotEmpty && bloc.recentBidList.length > 4)
                          InkWell(
                            onTap: () async {
                              await Utils.showSmartModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                useSafeArea: true,
                                builder: (context) => const AllBidsBottomSheet(),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmartText(
                                  APPStrings.viewAll.tr,
                                  style: style.auctionTimerStyle,
                                ),
                                SizedBox(width: 8.w),
                                Container(
                                  height: 24.w,
                                  width: 24.w,
                                  alignment: Alignment.center,
                                  child: const SmartImage(
                                    path: AppImages.icArrowRight,
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ListView.separated(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return _buildResetBidsItem(
                            isMyBid: bloc.isMyBidPlaced && index == 2 ? true : false,
                            labelText: bloc.recentBidList[index]['date_time'],
                            value: bloc.recentBidList[index]['price'],
                            style: style);
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 16.h),
                      itemCount: bloc.recentBidList.length > 5 ? 5 : bloc.recentBidList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics()),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            bloc.isMyBidPlaced
                ? Row(
                    children: [
                      const SmartImage(path: AppImages.icSuccessPlaceBid),
                      SizedBox(width: 8.w),
                      SmartRichText(spans: [
                        SmartTextSpan(text: APPStrings.yourBidOf.tr, style: style.auctionTimerStyle),
                        SmartTextSpan(text: "\$8500.00", style: style.recentBidValueStyle),
                        SmartTextSpan(text: APPStrings.hasBeenPlaced.tr, style: style.auctionTimerStyle),
                      ]),
                    ],
                  )
                : SmartText(
                    APPStrings.enterBidAmountHigherThanX.tr.interpolate(["\$9000.00"]),
                    style: style.auctionTimerStyle,
                  ),
          ],
        );
      },
    );
  }

  Widget _orderSampleSection(DiamondDetailScreenStyle style) {
    return Row(
      children: [
        SmartText(
          APPStrings.wantToSeeProductPhysically.tr,
          style: style.seeProductStyle,
        ),
        SizedBox(width: 8.w),
        SmartText(
          APPStrings.orderSample.tr,
          style: style.orderSampleStyle,
        ),
      ],
    );
  }

  Widget _additionalInfo(DiamondDetailScreenStyle style) {
    return Column(
      children: [
        Row(
          children: [
            SmartImage(
              path: AppImages.icDiamond,
              height: 24.w,
              width: 24.w,
            ),
            SizedBox(width: 16.w),
            SmartText(
              APPStrings.diamondPurityYouCanTrust.tr,
              style: style.diamondPurityStyle,
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            const SmartImage(path: AppImages.icTruck),
            SizedBox(width: 16.w),
            SmartText(
              APPStrings.shippingAcrossAllCountries.tr,
              style: style.shippingStyle,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildYouMayAlsoLikeSection(AuctionBloc bloc, BuildContext context) {
    final MyBagScreenStyle myBagScreenStyle = AppTheme.of(context).myBagScreenStyle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(
          APPStrings.youMayAlsoLike.tr,
          style: myBagScreenStyle.productsTitleStyle,
        ),
        SizedBox(height: 16.h),
        SmartSingleChildScrollView(
          child: Scrollbar(
            controller: bloc.scrollController,
            thumbVisibility: true,
            child: SmartSingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: bloc.scrollController,
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 12,
                runSpacing: 12.2,
                children: bloc.youMayAlisLikeProductList.map((product) {
                  return ProductGridItem(
                    margin: EdgeInsets.only(bottom: 17.h),
                    onEyeTap: () {},
                    onFavTap: () {},
                    productDetails: product,
                    isStoneWithPrice: true,
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResetBidsItem({required String labelText, required String value, required AuctionScreenStyle style, bool isMyBid = false}) {
    return Row(
      children: [
        const SmartImage(path: AppImages.icCalendar),
        SizedBox(width: 8.w),
        Expanded(
            flex: 1,
            child: Row(
              children: [
                SmartText(
                  labelText,
                  style: style.auctionTimerStyle,
                ),
                SizedBox(width: 5.w),
                if (isMyBid)
                  Container(
                      decoration: BoxDecoration(color: style.myBidBackgroundColor, borderRadius: BorderRadius.circular(23.r)),
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      child: SmartText(
                        APPStrings.myBid.tr,
                        style: style.myBidTextStyle,
                      ))
              ],
            )),
        SizedBox(width: 8.w),
        SmartText(
          value,
          style: style.recentBidValueStyle,
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(AuctionBloc bloc, BuildContext context, AuctionScreenStyle style) {
    return BlocBuilder<AuctionBloc, AuctionState>(
      buildWhen: (previous, current) => current is AuctionPlaceBidState,
      builder: (context, state) {
        if (state is AuctionPlaceBidState) {
          return const SizedBox();
        } else {
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: style.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: style.boxShadowColor.withOpacity(0.17),
                  spreadRadius: 0.r,
                  blurRadius: 16.r,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SmartText(
                    APPStrings.enterBidAmountHigherThanX.tr.interpolate(["\$9000.00"]),
                    style: style.auctionTimerStyle,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48.w,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: '',
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                                  borderSide: BorderSide(color: style.textFieldBorderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                                  borderSide: BorderSide(color: style.textFieldBorderColor),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: style.textFieldBorderColor),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r))),
                                // contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.6.w),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                                  borderSide: BorderSide(color: style.textFieldBorderColor),
                                )),
                            controller: bloc.bidAmountController,
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.words,
                            onTapOutside: (event) => FocusScope.of(context).unfocus(),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      SmartButton(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
                        width: 134.w,
                        onTap: () {
                          if (bloc.bidAmountController.text.isNotNullNorEmpty) {
                            bloc.add(const AuctionPlaceBidEvent());
                          }
                        },
                        title: APPStrings.placeBid.tr,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildCompareButton(AuctionBloc auctionBloc, AuctionScreenStyle style) {
    return BlocBuilder<AuctionBloc, AuctionState>(
      buildWhen: (previous, current) => current is AuctionProductCompareToggleState,
      builder: (context, state) {
        return auctionBloc.isCompare
            ? ElevatedButton(
                onPressed: () {
                  context.pushNamed(AppRoutes.compareProductPage);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: style.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SmartText(APPStrings.compare.tr, style: AppTheme.of(context).primaryButtonStyle.titleStyle),
                    SizedBox(width: 16.w),
                    Container(
                      height: 24.w,
                      width: 24.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: style.compareCountBGColor,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: SmartText('3', style: AppTheme.of(context).primaryButtonStyle.titleStyle),
                    )
                  ],
                ),
              )
            : const SizedBox();
      },
    );
  }
}
