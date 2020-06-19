import 'package:inputwidgets/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

class DBHelper{
  // ignore: non_constant_identifier_names
  static final String CREATE_TABLE_PRODUCT = ''' create table $TABLE_PRODUCT(
  $COL_PRODUCT_ID integer primary key autoincrement,
  $COL_PRODUCT_NAME text not null,
  $COL_PRODUCT_PRICE real not null,
  $COL_PRODUCT_RATING real nullable,
  $COL_PRODUCT_CATEGORY text not null,
  $COL_PRODUCT_TARGET text nullable,
  $COL_PRODUCT_ISFAVORITE integer not null,
  $COL_PRODUCT_DESCRIPTION text not null,
  $COL_PRODUCT_QUANTITY integer not null,
  $COL_PRODUCT_IMAGE text not null) ''';


  static Future<Database> open() async {
    final root = await getDatabasesPath();
    final dbPath = Path.join(root, 'product.db');
    return openDatabase(dbPath, version: 2, onCreate: (db, version) async{
      await db.execute(CREATE_TABLE_PRODUCT);
    }, onUpgrade: (db, oldVersion, newVersion) async{
      await db.execute('alter table $TABLE_PRODUCT add column $COL_PRODUCT_DATE text');
    });
  }
  static Future<int> insert(Product product) async {
    final db = await open();
    return await db.insert(TABLE_PRODUCT, product.toMap());
  }
  //All product Query
  static Future<List<Product>> getAllProducts() async{
    final db = await open();
    //db.query(TABLE_PRODUCT);
     List<Map<String, dynamic>> productMap = await db.rawQuery('select * from $TABLE_PRODUCT order by $COL_PRODUCT_ID desc');
     return List.generate(productMap.length, (index){
       return Product.fromMap(productMap[index]);
     });
  }
  //Single Product query
  static Future<Product> getProductbyId(int id) async {
    final db = await open();
    List<Map<String, dynamic>> productMap = await db.query(TABLE_PRODUCT, where: '$COL_PRODUCT_ID = ?', whereArgs: [id]);
    if(productMap.length > 0){
      return Product.fromMap(productMap.first);
    }
  }

  //Update any product information
  static Future<int> updateProduct(Product product) async {
    final db = await open();
    return await db.update(TABLE_PRODUCT, product.toMap(), where: '$COL_PRODUCT_ID = ?', whereArgs: [product.id]);
  }
  //Delete any row
  static Future<int> deleteProduct(int id) async{
    final db = await open();
    return await db.delete(TABLE_PRODUCT, where: '$COL_PRODUCT_ID = ?', whereArgs: [id]);
  }
}