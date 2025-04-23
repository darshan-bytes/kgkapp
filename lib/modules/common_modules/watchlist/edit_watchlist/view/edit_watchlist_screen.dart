import 'package:kgk/kgk.dart';

class EditWatchlistScreen extends StatelessWidget {
  const EditWatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EditWatchlistStyle style = AppTheme.of(context).editWatchlistStyle;
    final EditWatchlistBloc bloc = BlocProvider.of<EditWatchlistBloc>(context);
    return SmartSingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsetsDirectional.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(color: style.backgroundColor, borderRadius: BorderRadius.circular(16.w)),
                padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 20.h),
                child: BlocBuilder<EditWatchlistBloc, EditWatchlistState>(
                  buildWhen: (previous, current) => current is EditWatchlistLoadedState,
                  builder: (context, state) {
                    if (state is EditWatchlistLoadedState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SmartText(bloc.appBarTitle, style: style.titleStyle),
                          SizedBox(height: 4.h),
                          SmartText(APPStrings.watchListDesc.tr, style: style.subTitleStyle),
                          SizedBox(height: 16.h),
                          BlocBuilder<EditWatchlistBloc, EditWatchlistState>(
                            buildWhen: (previous, current) => current is EditWatchlistFieldErrorState,
                            builder: (context, state) {
                              return SmartTextField(
                                errorText: bloc.watchListNameError,
                                labelText: APPStrings.name.tr,
                                hintText: APPStrings.hintWatchlistName.tr,
                                controller: bloc.nameController,
                                textInputAction: TextInputAction.done,
                                textCapitalization: TextCapitalization.words,
                                onValueChanges: (value) {
                                  if (value.isNotNullNorEmpty) {
                                    bloc.watchListNameError = null;
                                    bloc.add(EditWatchlistNameChangedEvent(value));
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(height: 16.h),
                          BlocBuilder<EditWatchlistBloc, EditWatchlistState>(
                            buildWhen:
                                (previous, current) =>
                                    current is EditWatchlistDurationChangedState || current is EditWatchlistFieldErrorState,
                            builder: (context, state) {
                              return SmartDurationPicker(
                                errorText: bloc.watchListDurationError,
                                labelText: APPStrings.duration.tr,
                                initialDuration: bloc.duration,
                                onDurationChanged: (duration) {
                                  bloc.add(EditWatchlistDurationChangedEvent(duration: duration));
                                },
                              );
                            },
                          ),
                          if (bloc.isEdit) ...[
                            SizedBox(height: 16.h),
                            remainingTimeWidgetForEdit(context, style, bloc),
                            /*Container(
                              color: style.durationBackgroundColor,
                              padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w, vertical: 16.h),
                              child: Column(
                                children: [
                                  if (BlocProvider.of<WatchlistBloc>(context)
                                          .watchListingList
                                          .firstWhereOrNull((e) => e.id == bloc.watchlistData?.sId)
                                          ?.strRemainingTime !=
                                      null)
                                    ValueListenableBuilder(
                                      valueListenable: BlocProvider.of<WatchlistBloc>(context)
                                          .watchListingList
                                          .firstWhere((e) => e.id == bloc.watchlistData?.sId)
                                          .strRemainingTime!,
                                      builder: (context, child, value) {
                                        return Row(
                                          children: [
                                            SmartImage(path: AppImages.icClock, width: 20.w, height: 20.w),
                                            SizedBox(width: 10.w),
                                            SmartText(
                                              BlocProvider.of<WatchlistBloc>(context)
                                                  .watchListingList
                                                  .firstWhere((e) => e.id == bloc.watchlistData?.sId)
                                                  .strRemainingTime
                                                  ?.value,
                                              style: style.timeDurationValueStyle,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  SizedBox(height: 4.h),
                                  SmartText(
                                    APPStrings.theProductWillBeRemovedWhenTheTimeIsUp.tr,
                                    style: style.timeDurationDescStyle,
                                  ),
                                ],
                              ),
                            ),*/
                          ],
                          SizedBox(height: 32.h),
                          Row(
                            children: [
                              Expanded(
                                child: SmartButton.white(
                                  onTap: () {
                                    context.pop();
                                  },
                                  title: APPStrings.cancel.tr,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: SmartButton(
                                  onTap: () {
                                    bloc.add(EditWatchlistSaveEvent(context));
                                  },
                                  title: APPStrings.save.tr,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                        ],
                      );
                    } else {
                      return const SmartCircularProgressIndicator();
                    }
                  },
                ),
              ),
              PositionedDirectional(
                end: 16.w,
                top: 16.h,
                child: SmartImage(
                  path: AppImages.icCross,
                  width: 24.w,
                  height: 24.w,
                  color: style.primaryColor,
                  onTap: () {
                    context.pop();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget remainingTimeWidgetForEdit(BuildContext context, EditWatchlistStyle style, EditWatchlistBloc bloc) {
    // Get WatchlistBloc once instead of multiple times
    final watchlistBloc = BlocProvider.of<WatchlistBloc>(context);

    // Find the watchlist item once
    final watchlistItem = watchlistBloc.watchListingList.firstWhereOrNull((e) => e.id == bloc.watchlistData?.sId);

    // If no remaining time, return empty container
    if (watchlistItem?.strRemainingTime == null) {
      return const SizedBox.shrink();
    }

    return Container(
      color: style.durationBackgroundColor,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w, vertical: 16.h),
      child: Column(
        children: [
          ValueListenableBuilder<String?>(
            valueListenable: watchlistItem!.strRemainingTime!,
            builder: (context, value, _) {
              return Row(
                children: [
                  SmartImage(path: AppImages.icClock, width: 20.w, height: 20.w),
                  SizedBox(width: 10.w),
                  SmartText(value, style: style.timeDurationValueStyle),
                ],
              );
            },
          ),
          SizedBox(height: 4.h),
          SmartText(APPStrings.theProductWillBeRemovedWhenTheTimeIsUp.tr, style: style.timeDurationDescStyle),
        ],
      ),
    );
  }
}
