import 'package:kgk/kgk.dart';

class SmartPagination extends StatefulWidget {
  final List<String> pageNumbers;
  final String currentPage;
  final void Function(int index, String value) onPageChanged;
  final EdgeInsetsGeometry? padding;

  const SmartPagination({
    super.key,
    required this.pageNumbers,
    required this.onPageChanged,
    required this.currentPage,
    this.padding,
  });

  @override
  SmartPaginationState createState() => SmartPaginationState();
}

class SmartPaginationState extends State<SmartPagination> {
  late String currentPage;
  late int currentPageIndex;

  @override
  void initState() {
    currentPage = widget.currentPage;
    currentPageIndex = 0;
    super.initState();
  }

  void nextPage() {
    if (currentPageIndex < widget.pageNumbers.length - 1) {
      setState(() {
        currentPageIndex++;
        currentPage = widget.pageNumbers[currentPageIndex];
      });
      widget.onPageChanged(currentPageIndex, currentPage);
    }
  }

  void previousPage() {
    if (currentPageIndex > 0) {
      setState(() {
        currentPageIndex--;
        currentPage = widget.pageNumbers[currentPageIndex];
      });
      widget.onPageChanged(currentPageIndex, currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).customPageIndicatorStyle;
    bool isSelectionGreaterThanOne = widget.pageNumbers.indexOf(currentPage) > 0;
    bool isLastIndex = widget.pageNumbers.indexOf(currentPage) == widget.pageNumbers.length - 1;
    return Padding(
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 17.w, vertical: 24.h),
      child: Row(
        children: [
          SmartButton(
            onTap: previousPage,
            title: APPStrings.previous.tr,
            width: 118.w,
            isEnabled: isSelectionGreaterThanOne,
          ),
          SizedBox(width: 14.w),
          Expanded(
              child: SmartDropdownButtonFormField<String>(
                  textStyle: style.textStyle,
                  items: widget.pageNumbers,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      int index = widget.pageNumbers.indexOf(newValue);
                      setState(() {
                        currentPage = newValue;
                        currentPageIndex = index;
                      });
                      widget.onPageChanged(index, newValue);
                    }
                  },
                  itemLableBuilder: (item) => item,
                  value: currentPage)),
          SizedBox(width: 14.w),
          SmartButton(
            onTap: nextPage,
            title: APPStrings.next.tr,
            width: 118.w,
            isEnabled: !isLastIndex,
          ),
        ],
      ),
    );
  }
}
