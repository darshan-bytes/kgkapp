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
        body: SmartSingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SmartText(APPStrings.getInTouchWithUs.tr, style: style.headerTitleStyle),
              SizedBox(height: 8.h),
              SmartText(APPStrings.dropUsANote.tr, style: style.messageStyle),
              SizedBox(height: 18.h),
              SmartImage(path: "https://i.ibb.co/mbJ92Mj/image-383.png", height: 356.h),
              SizedBox(height: 20.h),
              _buildFullNameField(bloc),
              SizedBox(height: 14.h),
              _buildEmailField(bloc),
              SizedBox(height: 14.h),
              _buildInquiryTypeDropdown(bloc),
              // Right now hide this section ones confirmation comes from client totally remove this
              // SizedBox(height: 14.h),
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
              _buildStillNeedSection(style),
            ],
          ),
        ),
      ),
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

  Widget _buildStillNeedSection(ContactUsStyle style) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SmartText(APPStrings.stillNeedHelp.tr, style: style.subHeaderTitleStyle),
        SizedBox(height: 24.h),
        _buildStillNeedHelpItems(
          style,
          APPStrings.byPhone.tr,
          "Monday – Friday 9 AM – 5 PM",
          "+91 98765 43210",
        ),
        _buildStillNeedHelpItems(
          style,
          APPStrings.byEmail.tr,
          APPStrings.questionOrQueriesGetInTouch.tr,
          "support@kgk.com",
        ),
        _buildStillNeedHelpItems(
          style,
          APPStrings.findAStore.tr,
          APPStrings.findYourNearestXStore.tr.interpolate(['KGK']),
          APPStrings.storeDirectory.tr,
          onTap: () {
            //TODO: Navigate to Store Directory
          },
        ),
      ],
    );
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
