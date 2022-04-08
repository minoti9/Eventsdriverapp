import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speedx_driver_122283/models/OrderListRes.dart';
import 'package:speedx_driver_122283/utils/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParcelDetail extends StatefulWidget {
  final List<Items> item;

  const ParcelDetail({Key key, this.item}) : super(key: key);
  @override
  _ParcelDetailState createState() => _ParcelDetailState();
}

class _ParcelDetailState extends State<ParcelDetail> {
  // final _name = TextEditingController();
  // final _weight = TextEditingController();
  // final _length = TextEditingController();
  // final _height = TextEditingController();
  // final _formKey = GlobalKey<FormState>();
  // File _itemImg, _idProofImg;
  List<Items> items;

  @override
  void initState() {
    super.initState();
    items = widget.item;
    // _name.text = widget.item != null ? widget.item.name : '';
    // _weight.text = widget.item != null ? widget.item.weight : '';
    // _length.text = widget.item != null ? widget.item.itemLength : '';
    // _height.text = widget.item != null ? widget.item.height : '';
    // _itemImg = widget.item != null ? widget.item.itemImg : null;
    // _idProofImg = widget.item != null ? widget.item.idProofImg : null;
  }

  @override
  void dispose() {
    super.dispose();
    // _name.dispose();
    // _weight.dispose();
    // _length.dispose();
    // _height.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'Parcel Detail',
          style: TextStyle(color: black),
        ),
        leading: IconButton(
            color: black,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            }),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) {
              return viewItem(context: context, index: i);
            }),
      ),
    );
    //  Column(
    //   children: [
    //     Expanded(
    //       child:
    //        SingleChildScrollView(
    //         child: Container(
    //           padding: EdgeInsets.all(10),
    //           child: Form(
    //             key: _formKey,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Row(
    //                   children: [
    //                     Expanded(
    //                       child: TextFormField(
    //                         controller: _name,
    //                         validator: (v) {
    //                           if (v.trim().isEmpty)
    //                             return 'Enter item name';
    //                           return null;
    //                         },
    //                         decoration: InputDecoration(
    //                             hintText: 'Item Name',
    //                             labelText: 'Item Name'),
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       width: 10,
    //                     ),
    //                     Expanded(
    //                       child: TextFormField(
    //                         controller: _weight,
    //                         inputFormatters: [
    //                           FilteringTextInputFormatter.digitsOnly
    //                         ],
    //                         validator: (v) {
    //                           if (v.trim().isEmpty)
    //                             return 'Enter item weight';
    //                           return null;
    //                         },
    //                         keyboardType: TextInputType.number,
    //                         decoration: InputDecoration(
    //                             hintText: 'Item Weight',
    //                             labelText: 'Weight'),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 Row(
    //                   children: [
    //                     Expanded(
    //                       child: TextFormField(
    //                         controller: _length,
    //                         validator: (v) {
    //                           if (v.trim().isEmpty)
    //                             return 'Enter item length';
    //                           return null;
    //                         },
    //                         keyboardType: TextInputType.number,
    //                         inputFormatters: [
    //                           FilteringTextInputFormatter.digitsOnly
    //                         ],
    //                         decoration: InputDecoration(
    //                             hintText: 'Item Length',
    //                             labelText: 'Length'),
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       width: 10,
    //                     ),
    //                     Expanded(
    //                       child: TextFormField(
    //                         controller: _height,
    //                         validator: (v) {
    //                           if (v.trim().isEmpty)
    //                             return 'Enter item height';
    //                           return null;
    //                         },
    //                         keyboardType: TextInputType.number,
    //                         inputFormatters: [
    //                           FilteringTextInputFormatter.digitsOnly
    //                         ],
    //                         decoration: InputDecoration(
    //                             hintText: 'Item Height',
    //                             labelText: 'Height'),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: 0.05.sh,
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text('Item Image:'),
    //                     InkWell(
    //                       onTap: () {
    //                         _choose(action: 'item');
    //                       },
    //                       child: Container(
    //                         decoration: (BoxDecoration(
    //                           border: Border.all(
    //                             color: black,
    //                             width: 1,
    //                           ),
    //                         )),
    //                         height: 0.1.sh,
    //                         width: 0.2.sw,
    //                         child: _itemImg == null
    //                             ? Icon(Icons.add)
    //                             : Image.file(
    //                                 _itemImg,
    //                                 fit: BoxFit.cover,
    //                               ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 Divider(
    //                   height: 0.05.sh,
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text('ID Proof Image:'),
    //                     InkWell(
    //                       onTap: () {
    //                         _choose(action: 'proof');
    //                       },
    //                       child: Container(
    //                         decoration: (BoxDecoration(
    //                           border: Border.all(
    //                             color: black,
    //                             width: 1,
    //                           ),
    //                         )),
    //                         height: 0.1.sh,
    //                         width: 0.2.sw,
    //                         child: _idProofImg == null
    //                             ? Icon(Icons.add)
    //                             : Image.file(
    //                                 _idProofImg,
    //                                 fit: BoxFit.cover,
    //                               ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //     Container(
    //       padding: EdgeInsets.all(10),
    //       //height: 0.1.sh,
    //       width: 1.sw,
    //       // color: white,
    //       child: ElevatedButton(
    //         style: ElevatedButton.styleFrom(
    //           primary: blueGrey,
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(30)),
    //         ),
    //         onPressed: () {
    //           _validateData();
    //         },
    //         child: Text('Submit',
    //             style: TextStyle(fontSize: 20, color: white)),
    //       ),
    //     ),
    //   ],
    // ));
  }

  Widget _customText(String text, {String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: 1.0.sw,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(text),
        ),
      ],
    );
  }

  Widget viewItem({BuildContext context, int index}) {
    //print('index $index');
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            width: 1.sw,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Text(
              'Item ${index + 1}',
              style: TextStyle(color: white),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: _customText(items[index].good.name,
                            label: 'Good Name')),
                    SizedBox(
                      width: 0.02.sw,
                    ),
                    Expanded(
                        child: _customText(items[index].itemName,
                            label: 'Item Name')),
                  ],
                ),
                SizedBox(
                  height: 0.02.sh,
                ),
                Row(
                  children: [
                    Expanded(
                        child: _customText(items[index].itemWeight,
                            label: 'Item Weight($weightUnit)')),
                    SizedBox(
                      width: 0.02.sw,
                    ),
                    Expanded(
                      child: _customText(items[index].itemLength,
                          label: 'Item Length($lengthUnit)'),
                    ),
                    SizedBox(
                      width: 0.02.sw,
                    ),
                    Expanded(
                        child: _customText(items[index].itemHeight,
                            label: 'Item Height($lengthUnit)')),
                  ],
                ),
                SizedBox(
                  height: 0.05.sh,
                ),
                Text('Item Image:'),
                SizedBox(
                  height: 0.01.sh,
                ),
                Container(
                  decoration: (BoxDecoration(
                    border: Border.all(
                      color: black,
                      width: 1,
                    ),
                  )),
                  height: 0.1.sh,
                  width: 0.2.sw,
                  child: Image.network(
                    items[index].image,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*  void _choose({String action}) {
    Get.bottomSheet(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Get.back();
                _selectImage(action, 'camera');
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Take Photo'),
              ),
            ),
            InkWell(
              onTap: () {
                Get.back();
                _selectImage(action, 'gallery');
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Choose From Gallery'),
              ),
            )
          ],
        ),
        backgroundColor: white);
  }

  void _selectImage(String action, String type) async {
    final _picker = ImagePicker();
    final img = await _picker.getImage(
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery);
    if (img != null) {
      if (action == 'proof') {
        _idProofImg = File(img.path);
      } else {
        _itemImg = File(img.path);
      }
      setState(() {});
    }
  }

  void _validateData() {
    if (_formKey.currentState.validate()) {
      if (_itemImg == null)
        showToast('Please select item image', red);
      else if (_idProofImg == null)
        showToast('Please select ID proof image', red);
      else {
        ParcelItem item = ParcelItem();

        item.name = _name.text;
        item.weight = _weight.text;
        item.itemLength = _length.text;
        item.height = _height.text;
        item.idProofImg = _idProofImg;
        item.itemImg = _itemImg;
        Get.back(result: item);
      }
    }
  }
 */
}
