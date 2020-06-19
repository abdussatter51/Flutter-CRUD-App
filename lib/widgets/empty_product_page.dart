import 'package:flutter/material.dart';
import 'package:inputwidgets/pages/add_product_page.dart';

class EmptyProdcutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.hourglass_empty, size: 100, color: Colors.pink,),
        Text('Your product list empty!', style: TextStyle(color: Colors.red, fontSize: 25.0),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Click To Add New Product:', style: TextStyle(color: Colors.green, fontSize: 18.0),),
            IconButton(
              icon: Icon(Icons.add_circle, color: Colors.green, size: 35.0,),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>AddProductPage()
                ));
              },
            ),
          ],
        ),
      ],
    ),
    );
  }

}
