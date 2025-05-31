import 'package:expenses/features/dashboard/domain/entities/expense_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'add_expense_state.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  AddExpenseCubit() : super(AddExpenseInitial());
  static AddExpenseCubit get(context)=>BlocProvider.of(context);

  bool showCategories=false;

  void updateExpenseSelection({required List<ExpensesModel> expenses,required int selectedIndex,}) {
     expenses[selectedIndex].updateExpenseSelection(expenses, selectedIndex);
     emit(UpdateSelectCategoryState());
  }


}
