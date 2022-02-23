import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskaty/helpers/dio.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  Database? database;
   var meaning ;
  postWord({required String? word}) {
    emit(GetMeaningLoadingState());
    DioHelper.getData(url: 'entries/en/$word',).then((value) {
      meaning =value.data[0];
      print(value.data[0]);
      emit(GetMeaningSuccessState());
    }).catchError(
      (error) {
        print(error);
        emit(GetMeaningErrorState());
      },
    );
  }
}
