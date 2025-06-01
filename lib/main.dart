import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/bloc_observer/bloc_observer.dart';
import 'core/database/database_helper.dart';
import 'core/service_locator/get_it.dart';
import 'features/material_app/my_app.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  await ScreenUtil.ensureScreenSize();
  await setupDependencyInjection();
  DatabaseHelper().database;
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());

}

