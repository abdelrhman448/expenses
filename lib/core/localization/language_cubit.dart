import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared_pref/shared_pref_helper.dart';
import '../utils/constants/shared_preference_constants.dart';
part 'language_state.dart';


class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  static LanguageCubit get(context)=>BlocProvider.of(context);

  Locale _appLocale =  const Locale('en');
  Locale get appLocal => _appLocale;

  // index of the language container 0 arabic and 1 english
  int tabIndex = 0;
  changeTabIndex(index){
    tabIndex=index;
  }





  fetchLocalization() async {
    if (SharedPreferencesHelper().getString(SharedPrefConstants().language).isEmpty) {
      SharedPreferencesHelper().saveString(SharedPrefConstants().language,'en');
      _appLocale = const Locale("en");
      changeLanguage(index: 1);
      if (kDebugMode) {
        print('lang ........................... ${SharedPreferencesHelper().getString(SharedPrefConstants().language)}');
      }

      return null;
    } else {
      _appLocale = Locale(SharedPreferencesHelper().getString(SharedPrefConstants().language));
    }
    if (kDebugMode) {
      print('i have old lang ===${_appLocale.toString()}');
    }
    return null;
  }

  Future changeLanguage({required int index,}) async {
    String languageCode ='';
   switch (index) {
     case 0:
       languageCode = 'ar';
       break;
     case 1:
       languageCode = 'en';
       break;
     default:
       languageCode = 'ar';
   }
    SharedPreferencesHelper().saveString(SharedPrefConstants().language,languageCode);
    _appLocale =  Locale(languageCode);
    changeTabIndex(index);
    emit(ChangeLanguage());

  }

}
