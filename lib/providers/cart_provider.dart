import 'package:flutter/foundation.dart';
import 'package:inputwidgets/models/product_model.dart';

class CartProvider extends ChangeNotifier{
  List<Product> _cartList = [];
  List<Product> get cartItems =>_cartList;

  void addToCart(Product product){
    _cartList.add(product);
    notifyListeners();
  }

  void deleteToCart(Product product){
    _cartList.remove(product);
    notifyListeners();
  }

  double get totalPrice{
    var total = 0.0;
    _cartList.forEach((product) {
      total +=product.price;
    });
    return total;
  }

  int get itemCount =>_cartList.length;


  void removeAll(){
    _cartList.clear();
    notifyListeners();
  }


}