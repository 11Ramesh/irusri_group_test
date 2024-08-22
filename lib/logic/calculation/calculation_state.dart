part of 'calculation_bloc.dart';

@immutable
sealed class CalculationState {}

final class CalculationInitial extends CalculationState {}
// data get bloc this use for all data get
class DataGetState extends CalculationState {
  List<dynamic> countries;

  DataGetState({required this.countries});
}
//connection Error and another errors data get from the bloc
class DataGetErrorState extends CalculationState {
  String error;
  DataGetErrorState({required this.error});
}
// loading state when user show indicator because of this state
class DataGetLoadingState extends CalculationState {
  DataGetLoadingState();
}
