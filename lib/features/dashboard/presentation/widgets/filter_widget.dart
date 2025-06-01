import 'package:expenses/core/apptheme_and_decoration/decoration_helper.dart';
import 'package:expenses/core/apptheme_and_decoration/text_style_helper.dart';
import 'package:expenses/core/utils/constants/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
enum FilterByDays {lastMonth,last7days}

class FilterWidget extends StatefulWidget {
   FilterByDays selectedFilter;
  final Function(FilterByDays)? onFilterChanged;

   FilterWidget({super.key, this.onFilterChanged,required this.selectedFilter});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {



  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.dashboardFilterContainer(context: context),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: PaddingHelper.padding8Horizontal(context),
            vertical: PaddingHelper.padding8Vertical(context)
        ),
        child: InkWell(
          onTap: () => _showFilterOptions(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.selectedFilter.index==0?"this month":"last 7 days",
                style: Theme.of(context).textTheme.font14With400(),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(PaddingHelper.padding8Horizontal(context)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.h,
                height: 4.w,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ...FilterByDays.values.map((option) => ListTile(
                title: Text(
                  option.index==0? "this month":"last 7 days",
                  style: Theme.of(context).textTheme.font14With400(),
                ),
                trailing: widget.selectedFilter == option
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  setState(() {
                    widget.selectedFilter = option;
                  });
                  widget.onFilterChanged?.call(option);
                  Navigator.pop(context);
                },
              )),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}