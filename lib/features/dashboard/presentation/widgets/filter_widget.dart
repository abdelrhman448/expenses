import 'package:expenses/core/apptheme_and_decoration/decoration_helper.dart';
import 'package:expenses/core/apptheme_and_decoration/text_style_helper.dart';
import 'package:expenses/core/utils/constants/padding.dart';
import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration:AppDecorations.dashboardFilterContainer(context: context),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: PaddingHelper.padding8Horizontal(context),vertical: PaddingHelper.padding8Vertical(context)),
        child: Row(
          children: [
            Text(
              "this month",
              style: Theme.of(context).textTheme.font14With400(),
            ),
            Icon(Icons.keyboard_arrow_down)
          ],
        ),
      ),
    );
  }
}
