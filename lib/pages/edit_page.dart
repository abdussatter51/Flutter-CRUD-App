import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inputwidgets/models/product_model.dart';
import 'package:inputwidgets/providers/products_provider.dart';
import 'package:inputwidgets/tempdb/temp_db.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  final int id;
  EditPage(this.id);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String imagePath;
  final _formKey = GlobalKey<FormState>();
  Product product = Product();
  String category = 'Electronics';
  var unit = Unit.PCS;


  /*Future _takePicture() async{
    PickedFile file = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      imagePath = file.path;
      product.image = imagePath;
    });
  }*/
 /* Future _takeFromGallery() async{
    PickedFile file = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      imagePath = file.path;
      product.image = imagePath;
    });
  }*/

  /*void _selectDateFromUser(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1987),
      lastDate: DateTime.now(),
    ).then((newDate) {
      product.date = DateFormat('dd/MM/yyyy').format(newDate);
      setState(() {
        _selectedDate = newDate;
      });
    });
  }*/

  /*void _updateProduct() async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      product.category = category;
      product.unit = unit;
      Provider.of<ProductsProvider>(context, listen: false).updateProduct(product);
      Navigator.of(context).pop();
      print(product);
    }
  }*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductsProvider>(context, listen: false).fetchProduct(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Consumer<ProductsProvider>(
        builder: (context, provider, child)=>
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[

                SizedBox(height: 5,),
                TextFormField(
                  controller: TextEditingController(text: provider.product.name),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Enter Your Product Name:',
                      border: OutlineInputBorder()
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Product Name should Not Be Empty';
                    }
                    if(value.length<5){
                      return 'Product Name Must Be 6 Characters';
                    }
                    return null;
                  },
                  onSaved: (value){
                    provider.product.name = value;
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: TextEditingController(text: provider.product.description),
                  maxLines: 5,
                  decoration: InputDecoration(
                      icon: Icon(Icons.description,),
                      labelText: 'Enter Your Product Description:',
                      border: OutlineInputBorder()
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Product Description should Not Be Empty';
                    }
                    if(value.length<6){
                      return 'Product Description Must Be 6 Characters';
                    }
                    return null;
                  },
                  onSaved: (value){
                    provider.product.description = value;
                  },
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: TextEditingController(text: '${provider.product.price}'),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: Icon(Icons.attach_money,),
                      labelText: 'Enter Your Product Price:',
                      border: OutlineInputBorder()
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Price should Not Be Empty';
                    }
                    if(double.parse(value)<1){
                      return 'Price Must Be Greater Then 1';
                    }
                    return null;
                  },
                  onSaved: (value){
                    provider.product.price  = double.parse(value);
                  },
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: TextEditingController(text: '${provider.product.qty}'),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: Icon(Icons.add_to_queue,),
                      labelText: 'Enter Your Product Quantity:',
                      border: OutlineInputBorder()
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Quantity should Not Be Empty';
                    }
                    if(int.parse(value)<1){
                      return 'Quantity Must Be Greater Then 0';
                    }
                    return null;
                  },
                  onSaved: (value){
                    provider.product.qty  = int.parse(value);
                  },
                ),

                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(provider.product.date == null ? 'No date chosen' : provider.product.date),
                    FlatButton(
                      child: Text('Select Date'),
                      onPressed: (){
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1987),
                          lastDate: DateTime.now(),
                        ).then((newDate) {
                          provider.product.date = DateFormat('dd/MM/yyyy').format(newDate);
                          setState(() {

                          });
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Select Product Category:    ', style: TextStyle(fontSize: 16.0,fontStyle: FontStyle.italic , color: Colors.grey.shade600),),
                    DropdownButton(
                      style: TextStyle(fontSize: 16.0, color: Colors.grey.shade600),
                      iconEnabledColor: Colors.blue,
                      dropdownColor: Colors.grey.shade200,
                      iconSize: 30.0,
                      value: provider.product.category,
                      icon: Icon(Icons.keyboard_arrow_down,),
                      elevation: 15,
                      underline: Container(
                        height: 2,
                        color: Colors.blue,
                      ),
                      onChanged: (value){
                        setState(() {
                          provider.product.category = value;
                        });
                      },
                      items: categories.map((e) =>DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      )
                      ).toList(),
                    ),
                  ],
                ),

                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Select Unit:', style: TextStyle(fontSize: 16.0,fontStyle: FontStyle.italic , color: Colors.grey.shade600),),
                        Radio(
                          value: Unit.PCS,
                          groupValue: unit,
                          onChanged: (value){
                            setState(() {
                              unit = value;
                            });
                          },
                        ),
                        Text('Pices')
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: Unit.KG,
                          groupValue: unit,
                          onChanged: (value){
                            setState(() {
                              unit = value;
                            });
                          },
                        ),
                        Text('KiloGram')
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: Unit.LTR,
                          groupValue: unit,
                          onChanged: (value){
                            setState(() {
                              unit = value;
                            });
                          },
                        ),
                        Text('Litre')
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)
                      ),
                      child: provider.product.image == null ? Text('No Image file'): Image.file(File(provider.product.image), fit: BoxFit.cover,),
                    ),
                    FlatButton.icon(
                        onPressed: () async{
                      PickedFile file = await ImagePicker().getImage(source: ImageSource.camera);
                      setState(() {
                        imagePath = file.path;
                        provider.product.image = imagePath;
                      });
                    }, icon: Icon(Icons.camera), label: Text('Camera')),
                    FlatButton.icon(onPressed: () async{
                      PickedFile file = await ImagePicker().getImage(source: ImageSource.gallery);
                      setState(() {
                        imagePath = file.path;
                        provider.product.image = imagePath;
                      });
                    }, icon: Icon(Icons.image), label: Text('Gallery')),
                  ],
                ),
                SizedBox(height: 10.0,),
                RaisedButton(
                  color: Colors.blue,
                  hoverColor: Colors.blueAccent,
                  child: Text('Update Product', style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      _formKey.currentState.save();
                      provider.product.unit = unit;
                      Provider.of<ProductsProvider>(context, listen: false).updateProduct(provider.product);
                      Navigator.of(context).pop();
                      print(product);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
