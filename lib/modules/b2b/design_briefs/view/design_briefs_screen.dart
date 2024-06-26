import 'package:kgk/kgk.dart';

class DesignBriefsScreen extends StatelessWidget {
  const DesignBriefsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DesignBriefsBloc designBriefsBloc = BlocProvider.of<DesignBriefsBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.designBriefs.tr),
      bottomNavigationBar: _buildBottomNavigationBar(designBriefsBloc, context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: BlocBuilder<DesignBriefsBloc, DesignBriefsState>(
            buildWhen: (previous, current) => current is DesignBriefsLoadedState,
            builder: (context, state) {
              if (state is DesignBriefsLoadedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 24.h),
                    SmartTextField(
                      hintText: APPStrings.searchProjects.tr,
                      controller: designBriefsBloc.designBriefsSearchController,
                      suffixIcon: SmartImage(
                        path: AppImages.icSearchThin,
                        padding: EdgeInsets.all(16.w),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Expanded(
                      child: _buildDesignBriefsList(designBriefsBloc),
                    ),
                  ],
                );
              } else {
                return const SmartCircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDesignBriefsList(DesignBriefsBloc designBriefsBloc) {
    if (designBriefsBloc.designBriefsList.isEmpty) {
      return NoDataFoundWidget(text: APPStrings.noDesignBriefsFound.tr);
    }
    return ListView.separated(
      itemCount: designBriefsBloc.designBriefsList.length,
      itemBuilder: (context, index) {
        return B2BListingItem(
          type: B2BListingType.designBriefsType,
          listingItemModel: designBriefsBloc.designBriefsList[index],
          onTapMenuButton: () {},
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
    );
  }

  Widget _buildBottomNavigationBar(DesignBriefsBloc designBriefsBloc, BuildContext context) {
    return SafeArea(
      child: SelectionButton(
        borderRadius: BorderRadius.zero,
        isSelected: false,
        onTap: () {
          Utils.showSmartModalBottomSheet(
            context: context,
            builder: (context) => FilterScreen(
              onApply: () {},
            ),
          );
        },
        image: AppImages.icFilter,
        title: APPStrings.filter.tr,
      ),
    );
  }
}
