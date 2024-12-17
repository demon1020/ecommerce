import '/core.dart';

class AppChipChoiceWidget extends StatelessWidget {
  final List<String> options;
  final List<String> selectedItems;
  final Function(String, bool) onSelectionChanged;

  const AppChipChoiceWidget({
    Key? key,
    required this.options,
    required this.selectedItems,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        spacing: 13.0,
        runSpacing: 8.0,
        children: options.map((option) {
          bool isSelected = selectedItems.contains(option);
          return ChoiceChip(
            label: AppTextWidget(
              text: option,
              color: isSelected
                  ? AppColor.primarytextwhitecolor
                  : AppColor.primarytextcolor,
              fontWeight: FontWeight.w400,
              fontSize: AppSizes.fontMedium,
            ),
            selected: isSelected,
            onSelected: (selected) {
              onSelectionChanged(option, selected);
            },
            selectedColor: AppColor.primary,
            backgroundColor: Color(0xffEDEEEE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            side: BorderSide.none,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            showCheckmark: false,
          );
        }).toList(),
      ),
    );
  }
}
