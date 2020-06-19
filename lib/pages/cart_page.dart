import 'dart:io';

import 'package:flutter/material.dart';
import 'file:///D:/Flutter%20App/Flutter-CRUD-App/lib/providers/cart_provider.dart';
import 'package:inputwidgets/models/product_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  Product product;
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartProvider cartProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    cartProvider = Provider.of<CartProvider>(context);
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        actions: <Widget>[
          IconButton(
            splashColor: Colors.red,
            icon: Icon(Icons.clear),
            onPressed: (){
              cartProvider.removeAll();
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          if (cartProvider.cartItems.length == 0) Expanded(
            child: Center(
              child: Text('No Product in Cart!', style: TextStyle(fontSize: 20,),),
            ),
          ) else Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) => ListTile(

                  title: Text('${cartProvider.cartItems[index].name}', textAlign: TextAlign.left,),

                  leading: Container(
                  width: 50,
                    height: 50,

                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5,
                        color: Colors.blue,
                      ),
                      color: Colors.red,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Image.file(File(cartProvider.cartItems[index].image), width: 40, height: 40, fit: BoxFit.cover,),
                  ),
                  subtitle: Text('${cartProvider.cartItems[index].price}', textAlign: TextAlign.left,),
                  trailing: RaisedButton(
                    splashColor: Colors.red,
                    child: Text('Remove'),
                    onPressed: (){
                     cartProvider.deleteToCart(cartProvider.cartItems[index]);

                    },
                  )
                  /*Chip(
                    backgroundColor: Colors.blue,
                    label: Text('${cartProvider.cartItems[index].price}', style: TextStyle(color: Colors.white),),
                  )*/
                  /*trailing: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: (){

                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: (){

                        },
                      ),
                    ],
                  ),*/
                ),
                itemCount: cartProvider.cartItems.length,

            ),
          ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 50,
            color: Colors.blue,
            child: Text('Total ${cartProvider.totalPrice}', style: TextStyle(fontSize: 20, color: Colors.white),),
          )
        ],
      ),
    );
  }
}
