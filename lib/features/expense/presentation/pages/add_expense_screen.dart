import 'package:expenses/core/apptheme_and_decoration/color_helper.dart';
import 'package:expenses/core/apptheme_and_decoration/text_style_helper.dart';
import 'package:expenses/core/extensions/sized_box_extension.dart';
import 'package:expenses/core/image_helper/image_picker_helper.dart';
import 'package:expenses/core/service_locator/get_it.dart';
import 'package:expenses/core/utils/constants/padding.dart';
import 'package:expenses/core/validation/date_time.dart';
import 'package:expenses/features/dashboard/presentation/manager/dashboard_cubit.dart';
import 'package:expenses/features/dashboard/presentation/widgets/filter_widget.dart';
import 'package:expenses/widget/buttons/main_button.dart';
import 'package:expenses/widget/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../dashboard/domain/entities/expense_model.dart';
import '../manager/add_expense_cubit.dart';
import '../widgets/categoris_widget.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen>
    with SingleTickerProviderStateMixin {

  final TextEditingController categoryController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController attachReceiptController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotationAnimation;
  bool _showCategories = false;
  DateTime? selectedDate;

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
    categoryController.dispose();
    amountController.dispose();
    dateController.dispose();
    attachReceiptController.dispose();
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

  void _showCurrencyPicker(AddExpenseCubit cubit) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Currency',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: cubit.availableCurrencies.length,
                itemBuilder: (context, index) {
                  final currency = cubit.availableCurrencies[index];
                  return ListTile(
                    title: Text(currency),
                    trailing: cubit.selectedCurrency == currency
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                    onTap: () {
                      cubit.updateCurrency(currency);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>AddExpenseCubit(addExpenseUseCase: getIt()) ,
      child: BlocConsumer<AddExpenseCubit, AddExpenseState>(
        listener: (context, state) {
          if (state is AddExpenseSuccess) {
            DashboardCubit.get(context).loadDashboard(filter:FilterByDays.lastMonth);
            DashboardCubit.get(context).changeFilterValue(FilterByDays.lastMonth);
            
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                content: Text(
                    'Expense added successfully!',
                  style: Theme.of(context).textTheme.font14With400().copyWith(color: NeutralColors.light),
                ),
                backgroundColor: PrimaryColors.main,
              ),
            );
            Navigator.pop(context);
          } else if (state is AddExpenseError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    state.message,
                  style: Theme.of(context).textTheme.font14With400().copyWith(color: NeutralColors.light),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = AddExpenseCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: NeutralColors.light,
              centerTitle: true,
              title: Text(
                "Add expense",
                style: Theme.of(context).textTheme.font24With400().copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: PaddingHelper.padding16Horizontal(),
                  vertical: PaddingHelper.padding22Vertical(),
                ),
                child: SingleChildScrollView(
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
                                size: 28.h,
                                color: NeutralColors.dark,
                              ),
                            );
                          },
                        ),
                        enabled: false,
                        onTap: _toggleCategories,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                      ),
                  
                      10.heightBox,

                      CustomTextField(
                          controller: amountController,
                          title: "Amount",
                          hintText: "Write your amount..",
                          textInputType: const TextInputType.numberWithOptions(decimal: true),
                          suffixIcon:  GestureDetector(
                            onTap: () => _showCurrencyPicker(cubit),
                            child: SizedBox(
                              child: Container(
                                width: 50.w,
                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  border: Border.all(color: PrimaryColors.groceriesBg),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  cubit.selectedCurrency,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ),
                          ),
                          validator: (value) => (value == null || value.isEmpty)?'Please enter amount':null
                      ),
                  
                      10.heightBox,
                      CustomTextField(
                        controller: dateController,
                        title: "Date",
                        hintText: "pick date",
                        suffixIcon: Icon(
                          Icons.calendar_month_outlined,
                          size: 28.h,
                          color: NeutralColors.dark,
                        ),
                        enabled: false,
                        onTap: () async {
                          var pickedDate = await pickDate(
                            initialDate: DateTime.now(), context,);
                          if (pickedDate != null) {
                            selectedDate = pickedDate;
                            dateController.text = DateFormat("dd-MM-yyyy").format(pickedDate);
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a date';
                          }
                          return null;
                        },
                      ),
                      10.heightBox,
                      CustomTextField(
                        controller: attachReceiptController,
                        title: "Attach receipt",
                        hintText: "Pick image",
                        suffixIcon: Icon(
                          Icons.camera_alt_outlined,
                          size: 28.h,
                          color: NeutralColors.dark,
                        ),
                        enabled: false,
                        onTap: () async{
                          var path= await ImagePickerHelper.pickImage(context);
                          if(path!=null){
                            attachReceiptController.text=path;
                          }
                        },
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
                              style: Theme.of(context).textTheme.font18With400().copyWith(fontWeight: FontWeight.w700),
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
                      80.heightBox,
                        MainButton(
                          title: "Save",
                          loading: state is AddExpenseLoading,
                          onPress: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              final amount = double.tryParse(amountController.text.replaceAll(",", "")) ?? 0;
                              cubit.addExpense(
                                category: categoryController.text,
                                amount: amount,
                                date: selectedDate ?? DateTime.now(),
                                receiptPath: attachReceiptController.text.isNotEmpty ? attachReceiptController.text : null,
                              );
                            }
                          },
                        ),
                      20.heightBox,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}