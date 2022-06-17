import '../model/model.dart';

class Repository {
  List<FoodListModel> foodList = [
    FoodListModel('The Mixed Salad', 'Fresh cut hearts', '\$14.50', 0),
    FoodListModel('Wagyo Kobe Short Rib', '', '', 0),
    FoodListModel('Cucumber salad', 'Fresh cut hearts', '\$14.50', 0),
    FoodListModel('Cucumber salad', 'Fresh cut hearts', '\$14.50', 0),
  ];

  int _currentItemCount = 0;

  int addItemToCart() {
    _currentItemCount++;
    return _currentItemCount;
  }

  int removeItemFromCart() {
    _currentItemCount--;
    return _currentItemCount;
  }

  FoodListModel specificItemAddUpdate(int index) {
    foodList[index].itemCount++;
    return foodList[index];
  }

  FoodListModel specificItemSubractUpdate(int index) {
    foodList[index].itemCount--;
    return foodList[index];
  }

  int clearCart() {
    return 0;
  }
}
