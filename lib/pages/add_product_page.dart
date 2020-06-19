import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inputwidgets/db/db_helper.dart';
import 'package:inputwidgets/models/product_model.dart';
import 'package:inputwidgets/providers/products_provider.dart';
import 'package:inputwidgets/tempdb/temp_db.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  DateTime _selectedDate;
  String imagePath = null;
  final _formKey = GlobalKey<FormState>();
  Product product = Product();
  String category = 'Electronics';
  var unit = Unit.PCS;


  Future _takePicture() async{
   PickedFile file = await ImagePicker().getImage(source: ImageSource.camera);
   setState(() {
     imagePath = file.path;
     product.image = imagePath;
   });
  }
  Future _takeFromGallery() async{
   PickedFile file = await ImagePicker().getImage(source: ImageSource.gallery);
   setState(() {
     imagePath = file.path;
     product.image = imagePath;
   });
  }

  void _selectDateFromUser(){
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
  }

  void _saveProduct() async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      product.category = category;
      product.unit = unit;
      Provider.of<ProductsProvider>(context, listen: false).addProduct(product);
      Navigator.of(context).pop();
     /* if(id > 0){
        Navigator.of(context).pop();
        print('Saved!');
      }else{
        print('failed to save');
      }*/

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[

              SizedBox(height: 5,),
              TextFormField(
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
                    product.name = value;
                },
              ),
              SizedBox(height: 10.0,),
              TextFormField(
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
                  product.price  = double.parse(value);
                },
              ),
              SizedBox(height: 10.0,),
              TextFormField(
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
                  product.qty  = int.parse(value);
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
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
                  product.description = value;
                },
              ),
              SizedBox(height: 10.0,),
              Row(
                children: <Widget>[
                  Text(_selectedDate == null ? 'No date chosen' : DateFormat('dd/MM/yyyy').format(_selectedDate)),
                  FlatButton(
                    child: Text('Select Date'),
                    onPressed: _selectDateFromUser,
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
                    value: category,
                    icon: Icon(Icons.keyboard_arrow_down,),
                    elevation: 15,
                    underline: Container(
                      height: 2,
                      color: Colors.blue,
                    ),
                    onChanged: (value){
                      setState(() {
                        category = value;
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
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Target User:', style: TextStyle(fontSize: 16.0,fontStyle: FontStyle.italic , color: Colors.grey.shade600),),
                      Checkbox(
                        value: men,
                        onChanged: (value){
                          setState(() {
                            men = value;
                          });
                        },
                      ),
                      Text('Men'),
                      Checkbox(
                        value: women,
                        onChanged: (value){
                          setState(() {
                            women = value;
                          });
                        },
                      ),
                      Text('Women'),
                      Checkbox(
                        value: child,
                        onChanged: (value){
                          setState(() {
                            child = value;
                          });
                        },
                      ),
                      Text('Child'),
                    ],
                  ),
                ],
              ),*/
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
                    child: imagePath ==null ? Text('No Image file'): Image.file(File(imagePath), fit: BoxFit.cover,),
                  ),
                  FlatButton.icon(onPressed: _takePicture, icon: Icon(Icons.camera), label: Text('Camera')),
                  FlatButton.icon(onPressed: _takeFromGallery, icon: Icon(Icons.image), label: Text('Gallery')),
                ],
              ),
              SizedBox(height: 10.0,),
              RaisedButton(
                color: Colors.blue,
                hoverColor: Colors.blueAccent,
                child: Text('Save Product', style: TextStyle(color: Colors.white),),
                onPressed: _saveProduct,
              )
            ],
          ),
        ),
      ),
    );
  }
}
