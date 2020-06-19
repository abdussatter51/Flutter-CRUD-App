import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inputwidgets/db/db_helper.dart';
import 'file:///D:/Flutter%20App/Flutter-CRUD-App/lib/providers/cart_provider.dart';
import 'package:inputwidgets/models/product_model.dart';
import 'package:inputwidgets/pages/product_details.dart';
import 'package:inputwidgets/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  Product product;

  ProductItem(this.product);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool _isRowExpanded = false;
  double _rowContainerHeight = 0.0;
  CartProvider cartProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    cartProvider = Provider.of<CartProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 15),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        color: Colors.red,
        child: Icon(Icons.delete_outline, color: Colors.white, size: 50,),
      ),
      onDismissed: (direction){
        DBHelper.deleteProduct(widget.product.id);
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('${widget.product.name} Deleted'),
            )
        );
      },
      confirmDismiss: (direction){
        return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context)=>AlertDialog(
            title: Text('Delete ${widget.product.name} ?', textAlign: TextAlign.center,),
            content: Text('Are you sure to delete ${widget.product.name}? You can not undo this operation!'),
            actions: <Widget>[
              FlatButton(child: Text('Cancel'), onPressed: () => Navigator.of(context).pop(false),),
              RaisedButton(
                child: Text('Confirm Delete', style: TextStyle(color: Colors.white),),
                color: Theme.of(context).errorColor,
                onPressed: (){
                  Provider.of<ProductsProvider>(context, listen:  false).delete(widget.product.id);
                  Navigator.of(context).pop(true);

                }
              )

            ],
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        elevation: 5,
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () {
                //Single product information pass product details page
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductDetails(widget.product.id)
                ));

                /*//Its use for all product information
                Navigator.of(context).push(MaterialPageRoute(
                   builder: (context) => ProductDetailsPage(widget.product)
                ));*/
              },
              leading: Hero(
                tag: widget.product.id,
                  child: Image.file(File(widget.product.image), fit: BoxFit.cover, width: 50, height: 70,)
              ),
              title: Row(
                children: <Widget>[
                  Text(widget.product.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                  /*IconButton(
                    icon: Icon(widget.product.isFavorite ? Icons.favorite : Icons.favorite_border),
                    onPressed: () {
                      setState(() {
                        widget.product.toggleFavorite();
                        Provider.of<ProductsProvider>(context, listen: false).updateProduct(widget.product);
                        *//*DBHelper.updateProduct(widget.product).then((value) {
                          setState(() {

                          });
                        });*//*
                      });
                    },
                  ),*/
                ],
              ),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.product.category),
                  Text(' Stock: (${widget.product.qty})', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14, color: Colors.green),),
                ],
              ),
              trailing: IconButton(
                  icon: Icon(_isRowExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                  onPressed: (){
                    setState(() {
                      _isRowExpanded = !_isRowExpanded;
                      _rowContainerHeight = _isRowExpanded ? 100.0 : 0.0;
                    });
                  },
              ),

            ),
            AnimatedContainer(
              duration: Duration(microseconds: 200),
              height: _rowContainerHeight,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton.icon(
                      onPressed: (){
                        if(!cartProvider.cartItems.contains(widget.product)){
                          cartProvider.addToCart(widget.product);
                        }else{
                          cartProvider.deleteToCart(widget.product);
                        }

                      },
                      icon: Icon(cartProvider.cartItems.contains(widget.product) ? Icons.check : Icons.add),
                      label: Text(cartProvider.cartItems.contains(widget.product) ? 'ADDED TO CART' : 'ADD TO CART')
                  ),
                  RaisedButton.icon(
                      onPressed: (){
                        widget.product.toggleFavorite();
                        Provider.of<ProductsProvider>(context, listen: false).updateProduct(widget.product);
                      },
                      icon: Icon(widget.product.isFavorite ? Icons.favorite : Icons.favorite_border),
                      label: Text(widget.product.isFavorite ?'REMOVE TO FAVORITE' : 'ADD TO FAVORITE')
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}
