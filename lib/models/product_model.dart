import 'package:flutter/foundation.dart';
import 'package:inputwidgets/tempdb/temp_db.dart';

//for sqflite
final String TABLE_PRODUCT = 'table_product';
final String COL_PRODUCT_ID = 'product_id';
final String COL_PRODUCT_NAME = 'product_name';
final String COL_PRODUCT_PRICE = 'product_price';
final String COL_PRODUCT_RATING = 'product_rating';
final String COL_PRODUCT_CATEGORY = 'product_category';
final String COL_PRODUCT_TARGET = 'product_target';
final String COL_PRODUCT_ISFAVORITE = 'product_is_favorite';
final String COL_PRODUCT_DESCRIPTION = 'product_description';
final String COL_PRODUCT_QUANTITY = 'product_qty';
final String COL_PRODUCT_IMAGE = 'product_image';
final String COL_PRODUCT_DATE = 'product_date';


class Product{
  int id;
  String name;
  double price;
  double rating;
  String category;
  String target;
  bool isFavorite;
  String description;
  int qty;
  Unit unit;
  String image;
  String date;

  //for sqflite
  Map<String, dynamic> toMap(){
    var map = <String, dynamic> {
      COL_PRODUCT_NAME: name,
      COL_PRODUCT_PRICE: price,
      COL_PRODUCT_RATING: rating,
      COL_PRODUCT_CATEGORY: category,
      COL_PRODUCT_TARGET: target,
      COL_PRODUCT_ISFAVORITE: isFavorite? 1 : 0,
      COL_PRODUCT_DESCRIPTION: description,
      COL_PRODUCT_QUANTITY: qty,
      COL_PRODUCT_IMAGE: image,
      COL_PRODUCT_DATE: date

    };
    if(id != null){
      map[COL_PRODUCT_ID] = id;
    }
    return map;
  }

  //for sqflite
  Product.fromMap(Map<String, dynamic> map){
    id = map[COL_PRODUCT_ID];
    name = map[COL_PRODUCT_NAME];
    price = map[COL_PRODUCT_PRICE];
    rating = map[COL_PRODUCT_RATING];
    category = map[COL_PRODUCT_CATEGORY];
    target = map[COL_PRODUCT_TARGET];
    isFavorite = map[COL_PRODUCT_ISFAVORITE] == 0 ? false : true;
    description = map[COL_PRODUCT_DESCRIPTION];
    qty = map[COL_PRODUCT_QUANTITY];
    image = map[COL_PRODUCT_IMAGE];
    date = map[COL_PRODUCT_DATE];

  }

  Product({
    this.name,
    this.price,
    this.rating,
    this.category,
    this.target,
    this.isFavorite = false,
    this.description,
    this.qty,
    this.unit,
    this.image,
    this.date,

  });

  void toggleFavorite(){
    isFavorite = !isFavorite;
  }

  @override
  String toString() {
    return 'Product{name: $name, price: $price, rating:$rating, category: $category, target: $target isFavorite: $isFavorite, description: $description, qty: $qty, unit: $unit, image: $image, date: $date}';
  }
}