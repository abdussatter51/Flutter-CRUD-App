import 'package:flutter/foundation.dart';
import 'package:inputwidgets/db/db_helper.dart';
import 'package:inputwidgets/models/product_model.dart';

class ProductsProvider extends ChangeNotifier{
  List<Product> _productList = [];
  Product _product;
  List<Product> get products =>_productList;
  Product get product =>_product;

  void fetchProducts() async {
    _productList = await DBHelper.getAllProducts();
    notifyListeners();
  }

  void fetchProduct(int id) async {
    _product = await DBHelper.getProductbyId(id);
    notifyListeners();
  }

  void addProduct(Product product) async {
    await DBHelper.insert(product);
    fetchProducts();
  }

  void delete(int id) async {
    await DBHelper.deleteProduct(id);
    fetchProducts();
  }

  void updateProduct(Product product) async {
    await DBHelper.updateProduct(product);
    notifyListeners();
    fetchProducts();
  }

}