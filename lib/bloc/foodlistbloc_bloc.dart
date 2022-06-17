import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/item_count_model.dart';
import '../model/model.dart';
import '../repository/repository.dart';

part 'foodlistbloc_event.dart';
part 'foodlistbloc_state.dart';

class FoodlistBloc extends Bloc<FoodlistblocEvent, FoodlistState> {
  final Repository repository;

  FoodlistBloc({required this.repository}) : super(FoodlistblocInitial()) {
    on<FoodlistblocEvent>((event, emit) {
      if (event is AddItemEvent) {
        int currentCount = repository.addItemToCart();
        final items = repository.foodList;
        // ItemCount specificItemCount = event.specificItemCount;
        event.specificItemCount.count++;
        emit(AddItemState(currentCount, items));
      } else if (event is RemoveItemEvent) {
        event.specificItemCount.count--;
        int currentCount = repository.removeItemFromCart();
        final items = repository.foodList;

        emit(RemoveItemState(currentCount, items));
      }
    });
  }
}
