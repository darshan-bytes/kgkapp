import 'package:kgk/kgk.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24,),
        _commonItemWidget(context,
            title: APPStrings.announcements.tr,
          desc: APPStrings.notifyMeForEveryAnnouncement.tr,
          onSwitchChange: (val) {

          }
        ),
        _commonItemWidget(context,
            title: APPStrings.fileSharedBySalesman.tr,
            desc: APPStrings.shareBySalesmanDesc.tr,
            onSwitchChange: (val) {

            }
        ),
        _commonItemWidget(context,
            title: APPStrings.orderStatusUpdate.tr,
            desc: APPStrings.changeInOrderStatus.tr,
            onSwitchChange: (val) {

            }
        ),
      ],
    );
  }

  Widget _commonItemWidget(BuildContext context, {required String title, required String desc,
    required Function(bool) onSwitchChange}) {
    final style = AppTheme.of(context).settingViewStyle;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: SmartText(
                  title,
                  style: style.titleStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SmartSwitch(
                value: true,
                onSwitchChange: onSwitchChange,
                thumbColor: style.thumbColor,
                height: 24,
                width: 50,
              ),
            ],
          ),
          const SizedBox(height: 4,),
          SmartText(
            desc,
            style: style.descStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16,),
          Divider(height: 1, color: style.dividerColor,),
          const SizedBox(height: 16,),
        ],
      ),
    );
  }

}