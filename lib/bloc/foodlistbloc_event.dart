part of 'foodlistbloc_bloc.dart';

@immutable
abstract class FoodlistblocEvent {}

class AddItemEvent extends FoodlistblocEvent {
  final ItemCount specificItemCount;

  AddItemEvent(this.specificItemCount);
}

class RemoveItemEvent extends FoodlistblocEvent {
  final ItemCount specificItemCount;

  RemoveItemEvent(this.specificItemCount);
}
