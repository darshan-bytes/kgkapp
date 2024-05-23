import 'package:kgk/kgk.dart';

class SmartPagination extends StatefulWidget {
  final List<String> pageNumbers;
  final String currentPage;
  final void Function(int index, String value) onPageChanged;

  const SmartPagination({
    super.key,
    required this.pageNumbers,
    required this.onPageChanged,
    required this.currentPage,
  });

  @override
  _SmartPaginationState createState() => _SmartPaginationState();
}

class _SmartPaginationState extends State<SmartPagination> {
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
    return Row(
      children: [
        SmartButton(
          onTap: previousPage,
          title: APPStrings.previous.tr,
          width: 118,
          isEnabled: isSelectionGreaterThanOne ? true : false,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: SizedBox(
            height: 48,
            child: DropdownButtonFormField<String>(
              value: currentPage,
              style: style.textStyle,
              menuMaxHeight: 300,
              icon: Icon(
                Icons.keyboard_arrow_down_sharp,
                color: style.textColor,
                weight: 0.5,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                    color: style.borderColor,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                    color: style.borderColor,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                    color: style.borderColor,
                    width: 1,
                  ),
                ),
              ),
              onChanged: (newValue) {
                int index = widget.pageNumbers.indexOf(newValue!);
                setState(() {
                  currentPage = newValue;
                  currentPageIndex = index;
                });
                widget.onPageChanged(index, newValue);
              },
              items: widget.pageNumbers.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(width: 14),
        SmartButton(
          onTap: nextPage,
          title: APPStrings.next.tr,
          width: 118,
          isEnabled: isLastIndex ? false : true,
        ),
      ],
    );
  }
}
