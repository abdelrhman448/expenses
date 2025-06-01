import 'package:expenses/core/apptheme_and_decoration/color_helper.dart';
import 'package:expenses/core/apptheme_and_decoration/decoration_helper.dart';
import 'package:expenses/core/apptheme_and_decoration/text_style_helper.dart';
import 'package:expenses/core/extensions/sized_box_extension.dart';
import 'package:expenses/core/service_locator/get_it.dart';
import 'package:expenses/core/size_config/app_size_config.dart';
import 'package:expenses/core/utils/constants/padding.dart';
import 'package:expenses/features/dashboard/presentation/manager/dashboard_cubit.dart';
import 'package:expenses/features/dashboard/presentation/widgets/header_welcome_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/router/router_config.dart';
import '../widgets/expense_widget.dart';
import '../widgets/filter_widget.dart';
import '../widgets/money_card_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) => context.read<DashboardCubit>().loadMoreExpenses(),);
      // User reached the bottom, load more data

    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (context, state) {
        if (state is DashboardError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = DashboardCubit.get(context);
        return Scaffold(
          body: SizedBox(
            height: ScreenUtil().screenHeight,
            child: Stack(
              children: [
                Container(
                  height: ResponsiveUtils.isSmallScreen(context)
                      ? 290.h
                      : 320.h,
                  width: ScreenUtil().screenWidth,
                  decoration: AppDecorations.dashboardBlueContainer(context: context),
                ),

                // Header welcome widget with filter
                PositionedDirectional(
                  top: ResponsiveUtils.isSmallScreen(context)
                      ? 64.h
                      : 50.h,
                  end: 16.w,
                  start: 16.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const HeaderWelcomeWidget(
                        username: "ahmed ali33",
                        imageUrl: "https://img.freepik.com/premium-photo/artist-white_988361-3.jpg?semt=ais_hybrid&w=740",
                      ),
                      5.widthBox,
                      FilterWidget(
                        selectedFilter: cubit.currentFilter,
                        onFilterChanged: (selectedFilter) {
                          if (selectedFilter == FilterByDays.lastMonth) {
                            cubit.filterByThisMonth();
                          } else if (selectedFilter == FilterByDays.last7days) {
                            cubit.filterByLast7Days();
                          }
                        },
                      ),
                    ],
                  ),
                ),

                // Money card with income and expenses
                PositionedDirectional(
                  top: 150.h,
                  end: 16.w,
                  start: 16.w,
                  child: Skeletonizer(
                    enabled: state is DashboardLoading,
                    child: MoneyCardWidget(
                      expenses: _getTotalBalance(state).toStringAsFixed(2),
                      income: "100000",
                      totalBalance: "2222222",
                    ),
                  ),
                ),

                // List of expenses
                PositionedDirectional(
                  top: ResponsiveUtils.isSmallScreen(context)
                      ? 360.h
                      : 410.h,
                  end: 16.w,
                  start: 16.w,
                  child: _buildExpensesList(context, state, cubit),
                )
              ],
            ),
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.pushNamed(addExpenseScreen),
            backgroundColor: Theme.of(context).primaryColor,
            tooltip: 'Add Expense',
            child: Icon(
              Icons.add,
              color: NeutralColors.light,
              size: 24.sp,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }

  double _getTotalBalance(DashboardState state) {
    if (state is DashboardSuccess) {
      return state.totalBalance;
    } else if (state is ExpensesLoadingMore) {
      return state.totalBalance;
    }
    return 0.0;
  }

  List<dynamic> _getExpenses(DashboardState state) {
    if (state is DashboardSuccess) {
      return state.expenses;
    } else if (state is ExpensesLoadingMore) {
      return state.expenses;
    }
    return [];
  }

  bool _getHasMoreData(DashboardState state) {
    if (state is DashboardSuccess) {
      return state.hasMoreData;
    } else if (state is ExpensesLoadingMore) {
      return state.hasMoreData;
    }
    return false;
  }

  Widget _buildExpensesList(BuildContext context, DashboardState state, DashboardCubit cubit) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Recent Expenses",
              style: Theme.of(context)
                  .textTheme
                  .font18With400()
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        10.heightBox,
        SizedBox(
          height: ResponsiveUtils.isSmallScreen(context)
              ? 350.h
              : 300.h,
          child: _buildExpensesContent(context, state, cubit),
        )
      ],
    );
  }

  Widget _buildExpensesContent(BuildContext context, DashboardState state, DashboardCubit cubit) {
    // Loading state
    if (state is DashboardLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Error state
    if (state is DashboardError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: Colors.grey),
            8.heightBox,
            Text(
              "Failed to load expenses",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            8.heightBox,
            ElevatedButton(
              onPressed: () => cubit.refresh(),
              child: const Text("Retry"),
            ),
          ],
        ),
      );
    }

    final expenses = _getExpenses(state);
    final hasMoreData = _getHasMoreData(state);
    final isLoadingMore = state is ExpensesLoadingMore;

    // Empty state
    if (expenses.isEmpty && !isLoadingMore) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long_outlined, size: 48.sp, color: Colors.grey),
            8.heightBox,
            Text(
              "No expenses yet",
              style: Theme.of(context).textTheme.bodyMedium,
            ),

          ],
        ),
      );
    }

    // Expenses list with pagination
    return RefreshIndicator(
      onRefresh: () => cubit.refresh(),
      child: ListView.separated(
        controller: _scrollController,
        padding: EdgeInsets.only(
          top: PaddingHelper.padding16Vertical(),
          bottom: 16.h, // Add bottom padding for FAB
        ),
        itemBuilder: (context, index) {
          // Regular expense item
          if (index < expenses.length) {
            return ExpenseWidget(
              expenseEntity: expenses[index],
            );
          }

          // Loading more indicator or load more button
          if (hasMoreData) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: isLoadingMore
                  ?  Center(
                child: SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: CircularProgressIndicator(strokeWidth: 2.r),
                ),
              )
                  : Center(
                     child: ElevatedButton(
                      onPressed: () => cubit.loadMoreExpenses(),
                       style: ElevatedButton.styleFrom(
                       padding: EdgeInsets.symmetric(
                       horizontal: 24.w,
                       vertical: 12.h,
                       ),
                      ),
                          child: const Text("Load More"),
                ),
              ),
            );
          }

          // End of list indicator
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Center(
              child: Text(
                "No more expenses",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => 8.heightBox,
        itemCount: expenses.length + (hasMoreData || isLoadingMore ? 1 : 1), // +1 for pagination widget
      ),
    );
  }
}