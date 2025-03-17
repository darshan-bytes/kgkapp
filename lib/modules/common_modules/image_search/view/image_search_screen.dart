import 'package:kgk/kgk.dart';

class ImageSearchScreen extends StatelessWidget {
  const ImageSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageSearchStyle style = AppTheme.of(context).imageSearchStyle;
    final ImageSearchBloc bloc = BlocProvider.of<ImageSearchBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(),
      body: SizedBox(
        height: context.height,
        width: context.width,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70.h,
                  ),
                  SmartImage(
                    path: AppImages.icSearchImgThumbnail,
                    height: 300.w,
                    width: 300.w,
                  ),
                  SmartText("Search with your photos", style: style.titleStyle),
                  SizedBox(height: 8.h),
                  SmartText("Upload/Capture a photo to search for similar images", style: style.subTitleStyle),
                  SizedBox(height: 24.h),
                  BlocBuilder<ImageSearchBloc, ImageSearchState>(
                    buildWhen: (_, current) => current is ImageSelectionToggleState,
                    builder: (context, state) {
                      return SmartButton(
                        onTap: () {},
                        title: bloc.isCameraSelected ? "Captured image" : "Upload a photo",
                        height: 48.h,
                        titleStyle: style.buttonTextStyle,
                        margin: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                      );
                    },
                  ),
                ],
              ),
            ),
            SafeArea(
              child: BlocBuilder<ImageSearchBloc, ImageSearchState>(
                buildWhen: (_, current) => current is ImageSelectionToggleState,
                builder: (context, state) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          bloc.add(const ImageSelectionToggleEvent(isCameraSelected: true));
                        },
                        child: Container(
                          padding: EdgeInsetsDirectional.symmetric(vertical: 8.w),
                          decoration: bloc.isCameraSelected
                              ? BoxDecoration(
                                  color: Colors.transparent,
                                  border: BorderDirectional(
                                    top: BorderSide(
                                      color: style.selectedColor,
                                      width: 6.0.w,
                                    ),
                                  ),
                                )
                              : const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                size: 24.w,
                                color: bloc.isCameraSelected ? style.selectedColor : style.unSelectedColor,
                              ),
                              SmartText(
                                "Camera",
                                style: bloc.isCameraSelected ? style.selectedItemStyle : style.unSelectedItemStyle,
                              ),
                            ],
                          ),
                        ),
                      )),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          bloc.add(const ImageSelectionToggleEvent(isCameraSelected: false));
                        },
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          decoration: bloc.isCameraSelected
                              ? const BoxDecoration(
                                  color: Colors.transparent,
                                )
                              : BoxDecoration(
                                  color: Colors.transparent,
                                  border: BorderDirectional(
                                    top: BorderSide(
                                      color: style.selectedColor,
                                      width: 6.0.w,
                                    ),
                                  ),
                                ),
                          padding: EdgeInsetsDirectional.symmetric(vertical: 8.w),
                          child: Column(
                            children: [
                              Icon(
                                Icons.image_outlined,
                                size: 24.w,
                                color: bloc.isCameraSelected ? style.unSelectedColor : style.selectedColor,
                              ),
                              SmartText(
                                "Gallery",
                                style: bloc.isCameraSelected ? style.unSelectedItemStyle : style.selectedItemStyle,
                              ),
                            ],
                          ),
                        ),
                      )),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
