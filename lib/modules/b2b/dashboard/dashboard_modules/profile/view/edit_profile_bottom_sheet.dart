import 'package:kgk/kgk.dart';

class EditProfileBottomSheet extends StatelessWidget {
  const EditProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileScreenStyle style = AppTheme.of(context).profilePageScreenStyle;
    final ProfileBloc bloc = BlocProvider.of<ProfileBloc>(context);

    return SmartSingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 17.5.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: style.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.r),
            topRight: Radius.circular(6.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAppBar(style, context),
            SizedBox(height: 24.h),
            _buildProfileImageSection(style, context),
            SizedBox(height: 24.h),
            ...generateProfileForm(bloc),
            SizedBox(height: 24.h),
            _buildSaveButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(ProfileScreenStyle style, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmartText(
          APPStrings.editProfile.tr,
          style: style.bottomTitleStyle,
        ),
        SmartImage(
          path: AppImages.icCross,
          height: 24.w,
          width: 24.w,
          color: style.primaryColor,
          onTap: () {
            context.pop();
          },
        ),
      ],
    );
  }

  Widget _buildProfileImageSection(ProfileScreenStyle style, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 3.5.w, bottom: 1.5.h),
              child: SmartImage(
                path: 'https://i.ibb.co/GWFG9GF/Frame-1410088735.png',
                height: 73.w,
                width: 73.w,
                fit: BoxFit.cover,
                imageBorderRadius: BorderRadius.circular(50.r),
                onTap: () {
                  _showImagePickDialog(context);
                },
              ),
            ),
            SmartImage(
              path: AppImages.icEditImage,
              height: 32.w,
              width: 32.w,
              onTap: () {
                _showImagePickDialog(context);
              },
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> generateProfileForm(ProfileBloc profileBloc) {
    return <Widget>[
      _buildFirstNameField(profileBloc),
      SizedBox(height: 24.h),
      _buildLastNameField(profileBloc),
      SizedBox(height: 24.h),
      _buildEmailField(profileBloc),
      SizedBox(height: 24.h),
      _buildContactNumberField(profileBloc),
    ];
  }

  Widget _buildFirstNameField(ProfileBloc profileBloc) {
    return SmartTextField(
      labelText: APPStrings.firstName.tr,
      hintText: APPStrings.firstName.tr,
      controller: profileBloc.firstNameController,
      focusNode: profileBloc.firstNameFocusNode,
      nextFocus: profileBloc.lastNameFocusNode,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildLastNameField(ProfileBloc profileBloc) {
    return SmartTextField(
      labelText: APPStrings.lastName.tr,
      hintText: APPStrings.lastName.tr,
      controller: profileBloc.lastNameController,
      focusNode: profileBloc.lastNameFocusNode,
      nextFocus: profileBloc.emailFocusNode,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildEmailField(ProfileBloc profileBloc) {
    return SmartTextField(
      labelText: APPStrings.email.tr,
      hintText: APPStrings.email.tr,
      controller: profileBloc.emailController,
      focusNode: profileBloc.emailFocusNode,
      nextFocus: profileBloc.contactNumberFocusNode,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildContactNumberField(ProfileBloc profileBloc) {
    return SmartTextField(
      labelText: APPStrings.contactNumber.tr,
      hintText: APPStrings.contactNumber.tr,
      controller: profileBloc.contactNumberController,
      focusNode: profileBloc.contactNumberFocusNode,
      keyboardType: TextInputType.phone,
      textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return SmartButton(
      title: APPStrings.save.tr,
      onTap: () {},
    );
  }

  Future<void> _showImagePickDialog(BuildContext context) async {
    await Utils.showSmartModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return ImagePickDialogSheet(
          onTapSource: (ImageSource imageSource) {},
        );
      },
    ).then(
      (value) {},
    );
  }
}
