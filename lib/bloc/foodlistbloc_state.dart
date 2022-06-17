part of 'foodlistbloc_bloc.dart';

@immutable
abstract class FoodlistState {}

class FoodlistblocInitial extends FoodlistState {}

class AddItemState extends FoodlistState {
  final int currentItemCount;
  final List<FoodListModel> specificItemCount;

  AddItemState(this.currentItemCount, this.specificItemCount);
}

class RemoveItemState extends FoodlistState {
  final int currentItemCount;
  final List<FoodListModel> specificItemCount;

  RemoveItemState(this.currentItemCount, this.specificItemCount);
}
