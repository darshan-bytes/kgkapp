import 'package:kgk/kgk.dart';

class MakeInquiryScreen extends StatelessWidget {
  const MakeInquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MakeInquiryBloc>(context);
    final style = AppTheme.of(context).makeInquiryStyle;
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.makeAnInquiry.tr,
      ),
      backgroundColor: style.whiteColor,
      body: SafeArea(
        child: SmartSingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmartImage(
                path: 'https://i.ibb.co/RPzDQqL/Rectangle-656.png',
                height: 464.h,
                width: context.width,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 14.h),
              _buildFullNameField(bloc),
              SizedBox(height: 14.h),
              _buildEmailField(bloc),
              SizedBox(height: 14.h),
              _buildInquiryTypeDropdown(bloc),
              SizedBox(height: 14.h),
              _buildProductDropdown(bloc),
              SizedBox(height: 14.h),
              _buildCommentField(bloc),
              SizedBox(height: 18.h),
              SmartButton(
                  onTap: () {
                    context.pop();
                  },
                  title: APPStrings.submit.tr)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFullNameField(MakeInquiryBloc signUpBloc) {
    return SmartTextField(
      labelText: APPStrings.fullName.tr,
      hintText: APPStrings.fullName.tr,
      controller: signUpBloc.fullNameController,
      focusNode: signUpBloc.fullNameFocusNode,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildEmailField(MakeInquiryBloc signUpBloc) {
    return SmartTextField(
      labelText: APPStrings.email.tr,
      hintText: APPStrings.email.tr,
      controller: signUpBloc.emailController,
      focusNode: signUpBloc.emailFocusNode,
      nextFocus: signUpBloc.commentFocusNode,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
    );
  }

  Widget _buildCommentField(MakeInquiryBloc signUpBloc) {
    return SmartTextField(
      labelText: APPStrings.comment.tr,
      hintText: APPStrings.comment.tr,
      controller: signUpBloc.commentController,
      focusNode: signUpBloc.commentFocusNode,
      keyboardType: TextInputType.name,
      maxLines: 3,
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildProductDropdown(MakeInquiryBloc bloc) {
    return BlocBuilder<MakeInquiryBloc, MakeInquiryState>(
      buildWhen: (previous, current) => current is ToggleProductState || current is MakeInquiryReloadState,
      builder: (context, state) {
        return SmartDropDown<ProductModel>(
          selectedItem: bloc.selectedProduct,
          items: bloc.productList.map((e) => SmartDropDownItem<ProductModel>(value: e, title: e.name)).toList(),
          hintText: APPStrings.selectProduct.tr,
          labelText: APPStrings.selectProduct.tr,
          onChanged: (newValue) {
            if (newValue == null) return;
            bloc.add(ChangeSelectProductEvent(productModel: newValue));
          },
        );
      },
    );
  }

  Widget _buildInquiryTypeDropdown(MakeInquiryBloc bloc) {
    return BlocBuilder<MakeInquiryBloc, MakeInquiryState>(
      buildWhen: (previous, current) => current is ToggleMakeInquiryState || current is MakeInquiryReloadState,
      builder: (context, state) {
        return SmartDropDown<InquiryTypeModel>(
          selectedItem: bloc.selectedInquiryType,
          items: bloc.inquiryTypeList.map((e) => SmartDropDownItem<InquiryTypeModel>(value: e, title: e.name)).toList(),
          hintText: APPStrings.inquiryType.tr,
          labelText: APPStrings.inquiryType.tr,
          onChanged: (newValue) {
            if (newValue == null) return;
            bloc.add(ChangeInquiryTypeEvent(inquiryTypeModel: newValue));
          },
        );
      },
    );
  }
}
