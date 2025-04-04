import 'package:kgk/kgk.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).contactUsStyle;
    final bloc = BlocProvider.of<ContactUsBloc>(context);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        bloc.clearData();
      },
      child: Scaffold(
        appBar: SmartAppBar(
          title: APPStrings.contactUs.tr,
          onBack: () {
            bloc.clearData();
            context.pop();
          },
        ),
        body: BlocBuilder<ContactUsBloc, ContactUsState>(
          buildWhen: (previous, current) => current is ContactUsChangeInquiryTypeState,
          builder: (context, state) {
            return bloc.isLoading
                ? SmartCircularProgressIndicator()
                : SmartSingleChildScrollView(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w, vertical: 18.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SmartText(bloc.title, style: style.headerTitleStyle),
                        SizedBox(height: 8.h),
                        SmartText(bloc.description, style: style.messageStyle),
                        SizedBox(height: 18.h),
                        SmartImage(path: bloc.imageUrl, height: 356.h),
                        SizedBox(height: 20.h),
                        _buildFullNameField(bloc),
                        SizedBox(height: 14.h),
                        _buildEmailField(bloc),
                        SizedBox(height: 14.h),
                        _buildContactNumberField(bloc, context, style),
                        SizedBox(height: 14.h),
                        _buildInquiryTypeDropdown(bloc),
                        // Right now hide this section ones confirmation comes from client totally remove this
                        // _buildProductDropdown(bloc),
                        SizedBox(height: 14.h),
                        _buildCommentField(bloc),
                        SizedBox(height: 22.h),
                        SmartButton(
                          onTap: () {
                            bloc.add(ContactUsSubmitEvent(context: context));
                          },
                          title: APPStrings.submit.tr,
                        ),
                        SizedBox(height: 18.h),
                        _buildStillNeedSection(bloc, style),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget _buildContactNumberField(ContactUsBloc contactUsBloc, BuildContext context, ContactUsStyle style) {
    final CountryPickerStyle countryPickerStyle = AppTheme.of(context).countryPickerStyle;
    return BlocBuilder<ContactUsBloc, ContactUsState>(
      buildWhen: (previous, current) => current is ContactUsAddRemoveContactState,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<ContactUsBloc, ContactUsState>(
              buildWhen: (previous, current) =>
                  current is ContactUsFieldValidationState && current.fieldType == FieldTypeValidationEnum.contactNumber,
              builder: (context, state) {
                return SmartTextField(
                  labelText: APPStrings.contactNumber.tr,
                  hintText: APPStrings.hintContactNumber.tr,
                  controller: contactUsBloc.contactNumberController,
                  focusNode: contactUsBloc.contactNumberFocusNode,
                  keyboardType: TextInputType.phone,
                  textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
                  onValueChanges: (value) {},
                  prefixIcon: BlocBuilder<ContactUsBloc, ContactUsState>(
                    buildWhen: (previous, current) => current is ContactUsChangeCountryCodeState,
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          Utils.showCountryPickerModel(
                            context: context,
                            countryPickerStyle: countryPickerStyle,
                            showPhoneCode: true,
                            onSelect: (Country country) {
                              contactUsBloc.add(ContactUsChangeCountryCodeEvent(country: country));
                            },
                          );
                        },
                        child: SizedBox(
                          width: 95.w,
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            padding: EdgeInsetsDirectional.all(12.w),
                            margin: EdgeInsetsDirectional.only(end: 12.w),
                            decoration: BoxDecoration(
                              border: BorderDirectional(
                                end: BorderSide(
                                  color: AppTheme.of(context).textFieldStyle.enabledTextFieldBorderColor,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SmartText(
                                  '+${contactUsBloc.selectedCountry.phoneCode}',
                                  style: AppTheme.of(context).textFieldStyle.textStyle,
                                ),
                                SizedBox(width: 4.w),
                                const SmartImage(path: AppImages.icArrowDropDown),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            BlocBuilder<ContactUsBloc, ContactUsState>(
              buildWhen: (previous, current) => current is ContactUsPhoneNumberValidationState,
              builder: (context, state) {
                if (state is ContactUsPhoneNumberValidationState && state.isError) {
                  return SmartText(
                    state.errorMessage ?? APPStrings.phoneNumberAlreadyUsed.tr,
                    color: style.errorTextColor,
                    optionalPadding: EdgeInsetsDirectional.only(top: 6.h),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildFullNameField(ContactUsBloc contactUsBloc) {
    return SmartTextField(
      labelText: APPStrings.fullName.tr,
      hintText: APPStrings.fullName.tr,
      controller: contactUsBloc.fullNameController,
      focusNode: contactUsBloc.fullNameFocusNode,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildEmailField(ContactUsBloc contactUsBloc) {
    return SmartTextField(
      labelText: APPStrings.email.tr,
      hintText: APPStrings.email.tr,
      controller: contactUsBloc.emailController,
      focusNode: contactUsBloc.emailFocusNode,
      nextFocus: contactUsBloc.commentFocusNode,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
    );
  }

  Widget _buildCommentField(ContactUsBloc contactUsBloc) {
    return SmartTextField(
      labelText: APPStrings.comment.tr,
      hintText: APPStrings.comment.tr,
      controller: contactUsBloc.commentController,
      focusNode: contactUsBloc.commentFocusNode,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      maxLines: 3,
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildStillNeedSection(ContactUsBloc bloc, ContactUsStyle style) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SmartText(bloc.stillNeedHelp, style: style.subHeaderTitleStyle),
        SizedBox(height: 24.h),
        _buildStillNeedHelpList(bloc.support, style),
      ],
    );
  }

  Widget _buildStillNeedHelpList(List<ContactUsSupport> supportList, ContactUsStyle style) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: supportList.length,
      itemBuilder: (context, index) {
        return _buildStillNeedHelpItems(
          style,
          supportList[index].title ?? '',
          supportList[index].description?.replaceAll('\n', '') ?? '',
          supportList[index].action ?? '',
          onTap: () {
            if (supportList[index].action?.contains(',') ?? false) {
              showListOfNumbers(context, supportList[index].action ?? '', supportList[index].url ?? '');
              return;
            }
            Utils.handleContactAction(context, supportList[index].action ?? '', supportList[index].url ?? '');
          },
        );
      },
    );
  }

  void showListOfNumbers(BuildContext context, String value, String url) {
    final currentContext = context.mounted ? context : getNavigatorKeyContext;
    final options = value.split(',').map((e) => e.trim()).toList();

    if (options.length > 1) {
      Utils.showSmartModalBottomSheet(
        context: currentContext,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
        ),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: SmartText(
                  APPStrings.selectContact.tr,
                  style: AppTheme.of(context).faqStyle.titleStyle,
                ),
              ),
              SizedBox(height: 16.h),
              ListView.separated(
                shrinkWrap: true,
                itemCount: options.length,
                separatorBuilder: (_, __) => Divider(height: 1),
                itemBuilder: (context, index) {
                  final option = options[index];
                  return ListTile(
                    title: Text(option),
                    onTap: () {
                      context.pop();
                      Utils.handleContactAction(currentContext, option, url);
                    },
                  );
                },
              ),
              SizedBox(height: 24.h),
            ],
          );
        },
      );
    } else {
      Utils.handleContactAction(currentContext, value.trim(), url);
    }
  }

  Widget _buildStillNeedHelpItems(ContactUsStyle style, String title, String desc, String value, {VoidCallback? onTap}) {
    return Column(
      children: [
        SmartText(title, style: style.subMessageStyle),
        SizedBox(height: 16.h),
        SmartText(desc, style: style.subMessageDescriptionStyle),
        SizedBox(height: 8.h),
        SmartText(value, style: style.contactDetailsStyle, onTap: onTap),
        SizedBox(height: 24.h),
        const Divider(),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildProductDropdown(ContactUsBloc bloc) {
    return BlocBuilder<ContactUsBloc, ContactUsState>(
      buildWhen: (previous, current) => current is ContactUsChangeSelectProductState,
      builder: (context, state) {
        return SmartDropDown<ProductModel>(
          selectedItem: bloc.selectedProduct,
          items: bloc.productList.map((e) => SmartDropDownItem<ProductModel>(value: e, title: e.name)).toList(),
          hintText: APPStrings.selectProduct.tr,
          labelText: APPStrings.selectProduct.tr,
          onChanged: (newValue) {
            if (newValue == null) return;
            bloc.add(ContactUsChangeSelectProductEvent(productModel: newValue));
          },
        );
      },
    );
  }

  Widget _buildInquiryTypeDropdown(ContactUsBloc bloc) {
    return BlocBuilder<ContactUsBloc, ContactUsState>(
      buildWhen: (previous, current) => current is ContactUsChangeInquiryTypeState,
      builder: (context, state) {
        return SmartDropDown<InquiryTypeModel>(
          selectedItem: bloc.selectedInquiryType,
          items: bloc.inquiryTypeList.map((e) => SmartDropDownItem<InquiryTypeModel>(value: e, title: e.name)).toList(),
          hintText: APPStrings.inquiryType.tr,
          labelText: APPStrings.inquiryType.tr,
          onChanged: (newValue) {
            if (newValue == null) return;
            bloc.add(ContactUsChangeInquiryTypeEvent(inquiryTypeModel: newValue));
          },
        );
      },
    );
  }
}
