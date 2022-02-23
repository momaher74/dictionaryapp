part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class GetMeaningLoadingState extends AppState {}

class GetMeaningSuccessState extends AppState {}

class GetMeaningErrorState extends AppState {}
