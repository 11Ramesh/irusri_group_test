part of 'calculation_bloc.dart';

@immutable
abstract class CalculationEvent {}


class DataGetEvent extends CalculationEvent {
  String sortBy;

  DataGetEvent(this.sortBy);
}
