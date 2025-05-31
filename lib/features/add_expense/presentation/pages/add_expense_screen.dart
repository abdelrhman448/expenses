import 'package:expenses/core/apptheme_and_decoration/color_helper.dart';
import 'package:expenses/core/apptheme_and_decoration/text_style_helper.dart';
import 'package:expenses/core/extensions/sized_box_extension.dart';
import 'package:expenses/core/utils/constants/padding.dart';
import 'package:expenses/core/validation/date_time.dart';
import 'package:expenses/features/add_expense/presentation/manager/add_expense_cubit.dart';
import 'package:expenses/widget/buttons/main_button.dart';
import 'package:expenses/widget/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../dashboard/domain/entities/expense_model.dart';
import '../widgets/categoris_widget.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen>
    with SingleTickerProviderStateMixin {

  final TextEditingController categoryController = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController attachReceipt = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotationAnimation;
  bool _showCategories = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5, // 180 degrees (0.5 * 2 * pi)
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleCategories() {
    setState(() {
      _showCategories = !_showCategories;
    });
    if (_showCategories) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddExpenseCubit(),
      child: BlocConsumer<AddExpenseCubit, AddExpenseState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AddExpenseCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: NeutralColors.light,
              title: Text(
                "Add expense",
                style: Theme.of(context)
                    .textTheme
                    .font24With400()
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: PaddingHelper.padding16Horizontal(),
                vertical: PaddingHelper.padding22Vertical(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: categoryController,
                    title: "Category",
                    hintText: "Choose",
                    suffixIcon: AnimatedBuilder(
                      animation: _rotationAnimation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _rotationAnimation.value * 3.14159, // π radians = 180°
                          child: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 28.setHeight(),
                            color: NeutralColors.dark,
                          ),
                        );
                      },
                    ),
                    enabled: false,
                    onTap: _toggleCategories,
                  ),

                  10.heightBox,
                  CustomTextField(
                    controller: amount,
                    title: "Amount",
                    hintText: "Write your amount..",
                  ),
                  10.heightBox,
                  CustomTextField(
                    controller: date,
                    title: "Date",
                    hintText: "pick date",
                    suffixIcon: Icon(
                      Icons.calendar_month_outlined,
                      size: 28.setHeight(),
                      color: NeutralColors.dark,
                    ),
                    enabled: false,
                    onTap: () async {
                      var pickedDate = await pickDate(
                        initialDate: DateTime.now(),
                        context,
                      );
                      if (pickedDate != null) {
                        date.text = DateFormat("dd-MM-yyyy").format(pickedDate);
                      }
                    },
                  ),
                  10.heightBox,
                  CustomTextField(
                    controller: attachReceipt,
                    title: "Attach receipt",
                    hintText: "Pick image",
                    suffixIcon: Icon(
                      Icons.camera_alt_outlined,
                      size: 28.setHeight(),
                      color: NeutralColors.dark,
                    ),
                    enabled: false,
                    onTap: () {},
                  ),
                  10.heightBox,
                  // Animated Categories Section
                  SizeTransition(
                    sizeFactor: _expandAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        15.heightBox,
                        Text(
                          "Categories",
                          style: Theme.of(context)
                              .textTheme
                              .font18With400()
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        10.heightBox,
                        ExpensesGridWidget(
                          onCategoryClick: (index) {
                            categoryController.text = sampleExpenses[index].categoriesEnum.name;
                            cubit.updateExpenseSelection(
                              expenses: sampleExpenses,
                              selectedIndex: index,
                            );
                            // Auto-hide categories after selection
                            Future.delayed(const Duration(milliseconds: 200), () {
                              _toggleCategories();
                            });
                          },
                          expenses: sampleExpenses,
                        ),
                        15.heightBox,
                      ],
                    ),
                  ),
                  const Spacer(),
                  MainButton(
                    title: "Save",
                    onPress: () {},
                  ),
                  20.heightBox,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}