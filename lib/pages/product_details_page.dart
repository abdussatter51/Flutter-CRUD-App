import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inputwidgets/models/product_model.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  ProductDetailsPage(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Hero(
              tag: product.id,
                child: Image.file(File(product.image), width: double.infinity, height: MediaQuery.of(context).size.height * 0.40, fit: BoxFit.cover,)
            ),
            Text(product.name, textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
            SizedBox(height: 5.0),
            Text('Product Category: ${product.category}', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),),
            SizedBox(height: 10.0,),
            //Text('Price: BDT ${product.price}', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Price: BDT ${product.price}', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                Icon(Icons.star, color: Colors.red,),
                Icon(Icons.star, color: Colors.red,),
                Icon(Icons.star, color: Colors.red,),
                Icon(Icons.star, color: Colors.red,),
                Icon(Icons.star_half, color: Colors.red,),
              ],
            ),
            SizedBox(height: 5.0,),
            //Text('Available Stock: ${product.qty}', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Available Stock: ${product.qty}', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),),
                SizedBox(width: 10,),
                Icon(Icons.shopping_cart, color: Colors.green, size: 50.0, ),
              ],
            ),

            SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  '  Product Description:  ', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      backgroundColor: Colors.green,
                      color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('${product.description}', style: TextStyle(
                        color: Colors.black54,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0), textAlign: TextAlign.justify,),
                  ),

                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
