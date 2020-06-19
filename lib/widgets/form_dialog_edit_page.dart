import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_checkbox/grouped_checkbox.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inputwidgets/models/product_model.dart';
import 'package:inputwidgets/providers/products_provider.dart';
import 'package:inputwidgets/tempdb/temp_db.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditDialogFormPage extends StatefulWidget {
  final int id;
  EditDialogFormPage(this.id);

  @override
  _EditDialogFormPageState createState() => _EditDialogFormPageState();
}

class _EditDialogFormPageState extends State<EditDialogFormPage> {

  //Target User Checkbox list
  static List<String> checkedItemList = [];
  List<String> selectedItemList = checkedItemList ?? [];


  String imagePath;
  final _formKey = GlobalKey<FormState>();
  Product product = Product();
  String category = 'Electronics';
  var unit = Unit.PCS;
  ProductsProvider productProvider;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductsProvider>(context, listen: false).fetchProduct(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, provider, child)=>
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('Edit Product Information?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red,),),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: TextEditingController(text: provider.product.name),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Edit Product Name:',
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
                        labelText: 'Edit Product Description:',
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
                        labelText: 'Edit Product Price:',
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
                        labelText: 'Edit Product Quantity:',
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(provider.product.date == null ? 'No date chosen' : provider.product.date),
                      FlatButton(
                        color: Colors.grey.shade300,
                        child: Text(provider.product.date == null ? 'Select Date' : 'Edit Date',),
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
                      Text('Edit Category: ', style: TextStyle(fontSize: 16.0,fontStyle: FontStyle.italic , color: Colors.grey.shade600),),
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

                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                    child: Text(
                      'Edit Target User: ',
                      style: TextStyle(color: Colors.grey.shade800, fontSize: 15.0,),textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: GroupedCheckbox(
                      wrapSpacing: 10.0,
                      wrapRunSpacing: 15.0,
                      wrapRunAlignment: WrapAlignment.center,
                      wrapVerticalDirection: VerticalDirection.down,
                      wrapAlignment: WrapAlignment.center,
                      itemList: allItemList,
                      checkedItemList:  selectedItemList,
                      onChanged: (itemList) {
                        setState(() {
                          selectedItemList = itemList;
                          print('SELECTED ITEM LIST $itemList');
                        });
                      },
                      orientation: CheckboxOrientation.VERTICAL,
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                    ),
                  ),


                  SizedBox(height: 10.0,),
                  Container(
                    width: double.infinity,
                    height: 200.0,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey)
                    ),
                    child: provider.product.image == null ? Text('No Image file'): Image.file(File(provider.product.image), fit: BoxFit.cover,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.blue,
                        hoverColor: Colors.blueAccent,
                        child: Text('Cancel', style: TextStyle(color: Colors.white),),
                        onPressed: (){

                          Navigator.of(context).pop();


                        },
                      ),
                      RaisedButton(
                        padding: EdgeInsets.all(10),
                        color: Colors.green,
                        child: Text('Update Product info', style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          if(_formKey.currentState.validate()){
                            _formKey.currentState.save();
                            provider.product.target = selectedItemList.toString();
                            Provider.of<ProductsProvider>(context, listen: false).updateProduct(provider.product);
                            Navigator.of(context).pop();
                            print(product);
                          }
                        },
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
