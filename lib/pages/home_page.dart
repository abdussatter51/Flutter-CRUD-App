import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:inputwidgets/db/db_helper.dart';
import 'package:inputwidgets/models/cart_provider.dart';
import 'package:inputwidgets/models/product_model.dart';
import 'package:inputwidgets/pages/add_product_page.dart';
import 'package:inputwidgets/pages/cart_page.dart';
import 'package:inputwidgets/providers/products_provider.dart';
import 'package:inputwidgets/tempdb/temp_db.dart';
import 'package:inputwidgets/widgets/empty_product_page.dart';
import 'package:inputwidgets/widgets/product_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
  }

 /* void _showDialog() {

    // flutter defined function
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Product Add"),
          content: new Text("Have you product details? If have click continue button"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Continue"),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>AddProductPage()
                ));
              },
            ),
          ],
        );
      },
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CartPage()
                  ));
                },
              ),
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 20,
                    maxHeight: 20,
                  ),
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.red
                  ),
                  child: Consumer<CartProvider>(
                    builder: (context, provider, child) =>
                        FittedBox(child: Text('${provider.itemCount}')),
                  )
                ),
              )
            ],
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>AddProductPage()
              ));
            },
          ),
        ],
      ),
      body: Consumer<ProductsProvider>(
        builder: (context, provider, child) =>
        ListView.builder(
            itemBuilder: (context, index) =>ProductItem(provider.products[index]),
                itemCount: provider.products.length,

        ),
      )
      /*FutureBuilder(
          future: DBHelper.getAllProduct(),
          builder: (context, AsyncSnapshot<List<Product>> snapshot){
            if(snapshot.hasData){
              if(snapshot.data.length == 0){
                return Center(child: Text('No Product Found'),);
              }
              return ListView.builder(
                itemBuilder: (context, index) => ProductItem(snapshot.data[index]),
                itemCount: snapshot.data.length,

              );
            }
            if(snapshot.hasError){
              return Center(child: Text('Could not retrive data'),);
            }
            return Center(child: CircularProgressIndicator(),);
          }
      ),*/
 /*     products.length == 0 ? Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.hourglass_empty, size: 100, color: Colors.pink,),
          Text('Your Product List Is Empty!', style: TextStyle(color: Colors.red, fontSize: 25.0),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Click Here For Add Product:', style: TextStyle(color: Colors.green, fontSize: 18.0),),
              IconButton(
                icon: Icon(Icons.add_circle, color: Colors.green, size: 35.0,),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>AddProductPage()
                  )).then((_) {
                    setState(() {

                    });
                  });
                },
              ),
            ],
          ),
        ],
      ),
    ) :

      GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 10,
        children: productList.map((product) => ProductItem(product)).toList(),
      ),*/
     /* ListView.builder(
          itemBuilder: (context, index)=> ProductItem(productList[index]),
        itemCount: productList.length,
      ),*/
    );
  }
}
