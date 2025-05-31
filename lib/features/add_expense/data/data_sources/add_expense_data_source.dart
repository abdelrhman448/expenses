import 'package:dio/dio.dart';
import 'package:expenses/core/error_hnadler/handler.dart';
import '../../../../core/dio_helper/dio_helper.dart';
import '../../../../core/error_hnadler/error_model.dart';
import '../models/currency_model.dart';
import 'package:dartz/dartz.dart';

abstract class CurrencyApiService{
  Future<Either<ErrorModel, double>> getExchangeRate(String fromCurrency, String toCurrency);
}

class CurrencyApiServiceImpl extends CurrencyApiService{
  @override
  Future<Either<ErrorModel, double>> getExchangeRate(String fromCurrency, String toCurrency)async {
    DioHelper helper = DioHelper();
    try {
      final response = await helper.get("'https://open.er-api.com/v6/latest/$fromCurrency'");
      if(response.statusCode==200){
        final currencyResponse = CurrencyModel.fromJson(response.data);
        final rate = currencyResponse.rates[toCurrency];
        return Right(rate??0.0);
      }
      else{
        return Left(ErrorHandler().responseExceptionHandler(response));
      }
    } catch (e) {
      if(e is DioException){
        return Left(ErrorHandler().responseExceptionHandler(e.response!));
      }
      return Left(ErrorModel(code: 0, message: "unexpected"));
    }
  }

}



