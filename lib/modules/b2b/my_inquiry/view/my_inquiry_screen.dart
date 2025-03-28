import 'package:kgk/kgk.dart';

class MyInquiryScreen extends StatelessWidget {
  const MyInquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MyInquiryBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.myInquiries.tr,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(bloc, context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRoutes.makeInquiryPage);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBottomNavigationBar(MyInquiryBloc myInquiryBloc, BuildContext context) {
    return BlocBuilder<MyInquiryBloc, MyInquiryState>(
      buildWhen: (previous, current) => current is MyInquiryLoadedState,
      builder: (context, state) {
        if (state is MyInquiryLoadedState) {
          return FilterBottomActionBar(
            controller: myInquiryBloc.smartPaginationScrollController.controller,
            onFilterTap: () {
              Utils.showSmartModalBottomSheet(
                context: context,
                builder: (_) => AdvanceFilterScreen(
                  onApply: (value) {
                    if (value != null && value is List<FilterData>) {
                      myInquiryBloc.add(FilterMyInquiryEvent(context, value));
                    }
                  },
                ),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
