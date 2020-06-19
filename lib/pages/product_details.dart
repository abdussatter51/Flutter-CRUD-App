import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:inputwidgets/db/db_helper.dart';
import 'package:inputwidgets/models/product_model.dart';
import 'package:inputwidgets/pages/edit_form.dart';
import 'package:inputwidgets/pages/edit_page.dart';
import 'package:inputwidgets/providers/products_provider.dart';
import 'package:inputwidgets/widgets/form_dialog_edit_page.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final int id;

  ProductDetails(this.id);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductsProvider>(context, listen: false).fetchProduct(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductsProvider>(
        builder: (context, provider, child)=>
        provider.product == null ? Center(child: CircularProgressIndicator(),):
            ListView(
              children: <Widget>[
                Stack(
                 children: <Widget>[
                   Hero(
                       tag: widget.id,
                       child: Image.file(File(provider.product.image), width: double.infinity,)
                   ),
                   Positioned(
                     top: 10,
                     left: 10,
                     child: Container(
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(15),
                       ),
                       child: Text(provider.product.name, style: Theme.of(context).textTheme.headline3, textAlign: TextAlign.center,),
                     )
                   ),
                   Positioned(
                       left: 10,
                       bottom: 10,
                       child: Container(
                         decoration: BoxDecoration(
                           color: Colors.red,
                           borderRadius: BorderRadius.only(
                             bottomLeft: Radius.circular(20),
                             topRight: Radius.circular(20),
                           )
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text('\$${provider.product.price}' , style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                         ),
                       )
                   ),
                   Positioned(
                       right: 10,
                       bottom: 10,
                       child: Container(
                         decoration: BoxDecoration(
                             color: Colors.blue,
                             borderRadius: BorderRadius.only(
                               bottomRight: Radius.circular(20),
                               topLeft: Radius.circular(20),
                             )
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text(provider.product.category , style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                         ),
                       )
                   ),
                   Positioned(
                       left: 10,
                       bottom: 49,
                       child: Container(
                         decoration: BoxDecoration(
                             color: Colors.blue,
                             borderRadius: BorderRadius.only(
                               topLeft: Radius.circular(20),
                               bottomRight: Radius.circular(20),
                             )
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text(provider.product.date, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                         ),
                       )
                   ),
                   Positioned(
                       right: 10,
                       bottom: 49,
                       child: Container(
                         decoration: BoxDecoration(
                             color: Colors.red,
                             borderRadius: BorderRadius.only(
                               bottomLeft: Radius.circular(20),
                               topRight: Radius.circular(20),
                             )
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text('Stock: ${provider.product.qty}', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                         ),
                       )
                   ),
                   Positioned(
                       right: 170,
                       bottom: 0,
                       child: Container(
                         decoration: BoxDecoration(
                             color: Colors.green,
                             borderRadius: BorderRadius.only(
                               topLeft: Radius.circular(15),
                               topRight: Radius.circular(15),
                             )
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: IconButton(
                             icon: Icon(Icons.edit, color: Colors.white,),
                             onPressed: (){
                               AwesomeDialog(
                                 dismissOnTouchOutside: false,
                                 context: context,
                                 animType: AnimType.SCALE,
                                 dialogType: DialogType.WARNING,
                                 keyboardAware: false,
                                 body: EditDialogFormPage(widget.id),
                                 /*Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Edit Product',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              elevation: 0,
                              color: Colors.blueGrey.withAlpha(40),
                              child: TextFormField(
                                controller: TextEditingController(text: provider.product.name),
                                autofocus: true,
                                minLines: 1,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Edit Product Name',
                                  prefixIcon: Icon(Icons.text_fields),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              elevation: 0,
                              color: Colors.blueGrey.withAlpha(40),
                              child: TextFormField(
                                controller: TextEditingController(text: provider.product.description),
                                autofocus: true,
                                keyboardType: TextInputType.multiline,
                                maxLengthEnforced: true,
                                minLines: 2,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Edit Description',
                                  prefixIcon: Icon(Icons.description),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              elevation: 0,
                              color: Colors.blueGrey.withAlpha(40),
                              child: TextFormField(
                                controller: TextEditingController(text: provider.product.price.toString()),
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                maxLengthEnforced: true,
                                minLines: 2,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Edit Price',
                                  prefixIcon: Icon(Icons.attach_money),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              elevation: 0,
                              color: Colors.blueGrey.withAlpha(40),
                              child: TextFormField(
                                controller: TextEditingController(text: provider.product.qty.toString()),
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                maxLengthEnforced: true,
                                minLines: 2,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Edit Quantity',
                                  prefixIcon: Icon(Icons.add_to_queue),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),*/
                               )..show();
                             },
                           ),
                         ),
                       )
                   )
                 ],
                ),
                /*Text(provider.product.name, style: Theme.of(context).textTheme.headline3, textAlign: TextAlign.center,),*/
                //Text('Category: ${provider.product.category}'),
                /*Text('Date: (${provider.product.date == null ? 'Date not set' : provider.product.date})',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18, color: Colors.green),),*/
                /*Text('Price: ${provider.product.price}',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18, color: Colors.red),),*/
                SizedBox(height: 10,),
                Column(
                  children: <Widget>[
                    Text('Description:  ', style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold,),),
                    Text('Description: ${provider.product.description}',
                      style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18, color: Colors.grey),),
                  ],
                ),
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text('EDIT PRODUCT INFO', style: TextStyle(fontSize: 18, color: Colors.white), ),
                  onPressed: (){
                    AwesomeDialog(
                      dismissOnTouchOutside: false,
                      context: context,
                      animType: AnimType.SCALE,
                      dialogType: DialogType.WARNING,
                      keyboardAware: false,
                      body: EditDialogFormPage(widget.id),
                      /*Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Edit Product',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              elevation: 0,
                              color: Colors.blueGrey.withAlpha(40),
                              child: TextFormField(
                                controller: TextEditingController(text: provider.product.name),
                                autofocus: true,
                                minLines: 1,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Edit Product Name',
                                  prefixIcon: Icon(Icons.text_fields),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              elevation: 0,
                              color: Colors.blueGrey.withAlpha(40),
                              child: TextFormField(
                                controller: TextEditingController(text: provider.product.description),
                                autofocus: true,
                                keyboardType: TextInputType.multiline,
                                maxLengthEnforced: true,
                                minLines: 2,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Edit Description',
                                  prefixIcon: Icon(Icons.description),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              elevation: 0,
                              color: Colors.blueGrey.withAlpha(40),
                              child: TextFormField(
                                controller: TextEditingController(text: provider.product.price.toString()),
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                maxLengthEnforced: true,
                                minLines: 2,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Edit Price',
                                  prefixIcon: Icon(Icons.attach_money),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              elevation: 0,
                              color: Colors.blueGrey.withAlpha(40),
                              child: TextFormField(
                                controller: TextEditingController(text: provider.product.qty.toString()),
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                maxLengthEnforced: true,
                                minLines: 2,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Edit Quantity',
                                  prefixIcon: Icon(Icons.add_to_queue),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),*/
                    )..show();
                  },
                ),
                
                /*RaisedButton(
                  child: Icon(Icons.edit),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditFormPage(provider.product.id)
                    ));
                  },
                )*/
              ],
            )
      )
    );
  }
}
