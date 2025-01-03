import 'package:kgk/kgk.dart';

class EditWatchlistScreen extends StatelessWidget {
  const EditWatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EditWatchlistStyle style = AppTheme.of(context).editWatchlistStyle;
    final EditWatchlistBloc bloc = BlocProvider.of<EditWatchlistBloc>(context);
    return SmartSingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: style.backgroundColor,
                  borderRadius: BorderRadius.circular(16.w),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: BlocBuilder<EditWatchlistBloc, EditWatchlistState>(
                  buildWhen: (previous, current) => current is EditWatchlistLoadedState,
                  builder: (context, state) {
                    if (state is EditWatchlistLoadedState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SmartText(
                            bloc.appBarTitle,
                            style: style.titleStyle,
                          ),
                          SizedBox(height: 4.h),
                          SmartText(
                            APPStrings.watchListDesc.tr,
                            style: style.subTitleStyle,
                          ),
                          SizedBox(height: 16.h),
                          BlocBuilder<EditWatchlistBloc, EditWatchlistState>(
                            buildWhen: (previous, current) => current is EditWatchlistNameErrorState,
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
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(height: 16.h),
                          BlocBuilder<EditWatchlistBloc, EditWatchlistState>(
                            buildWhen: (previous, current) => current is EditWatchlistDurationChangedState,
                            builder: (context, state) {
                              return SmartDurationPicker(
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
                            Container(
                              color: style.durationBackgroundColor,
                              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SmartImage(path: AppImages.icClock, width: 20.w, height: 20.w),
                                      SizedBox(width: 10.w),
                                      SmartRichText(spans: [
                                        SmartTextSpan(text: bloc.durationDays.toString(), style: style.timeDurationValueStyle),
                                        SmartTextSpan(text: APPStrings.days.tr.toLowerCase(), style: style.timeDurationStyle),
                                        SmartTextSpan(text: " : ", style: style.timeDurationStyle),
                                        SmartTextSpan(text: bloc.durationHours.toString(), style: style.timeDurationValueStyle),
                                        SmartTextSpan(text: APPStrings.hours.tr.toString(), style: style.timeDurationStyle),
                                        SmartTextSpan(text: " : ", style: style.timeDurationStyle),
                                        SmartTextSpan(text: bloc.durationMinutes.toString(), style: style.timeDurationValueStyle),
                                        SmartTextSpan(text: APPStrings.mins.tr.toLowerCase(), style: style.timeDurationStyle),
                                      ]),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  SmartText(
                                    APPStrings.theProductWillBeRemovedWhenTheTimeIsUp.tr,
                                    style: style.timeDurationDescStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                          SizedBox(height: 32.h),
                          Row(
                            children: [
                              Expanded(
                                  child: SmartButton.white(
                                      onTap: () {
                                        context.pop();
                                      },
                                      title: APPStrings.cancel.tr)),
                              SizedBox(width: 16.w),
                              Expanded(
                                  child: SmartButton(
                                      onTap: () {
                                        bloc.add(EditWatchlistSaveEvent(context));
                                      },
                                      title: APPStrings.save.tr)),
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
              Positioned(
                right: 16.w,
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
}
