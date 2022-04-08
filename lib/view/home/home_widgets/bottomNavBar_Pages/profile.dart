import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speedx_driver_122283/models/CityResponse.dart';
import 'package:speedx_driver_122283/models/StatesResponse.dart';
import 'package:speedx_driver_122283/network/NetworkCall.dart';
import 'package:speedx_driver_122283/utils/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speedx_driver_122283/utils/sharedPref.dart';

class Profile extends StatefulWidget {
  final String action;

  const Profile({Key key, this.action}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _fName = TextEditingController(text: sharePrefereceInstance.getName());
  final _mName =
      TextEditingController(text: sharePrefereceInstance.getMiddleName());
  final _lName =
      TextEditingController(text: sharePrefereceInstance.getLastName());
  final _email = TextEditingController(text: sharePrefereceInstance.getEmail());
  final _mobile =
      TextEditingController(text: sharePrefereceInstance.getUserPhone());
  final _address =
      TextEditingController(text: sharePrefereceInstance.getUserAddress());
  final _address2 =
      TextEditingController(text: sharePrefereceInstance.getAddress2());
  final _zipCode =
      TextEditingController(text: sharePrefereceInstance.getZipCode());

  final _formKey = GlobalKey<FormState>();
  String _stateValue = sharepref.getState(),
      _stateId,
      _cityValue = sharepref.getCity(),
      _cityId,
      _imagePath;
  List<StatesData> _stateList = [];
  List<CityData> _cityList = [];

  @override
  void dispose() {
    super.dispose();
    _fName.dispose();
    _mName.dispose();
    _lName.dispose();
    _email.dispose();
    _mobile.dispose();
    _address.dispose();
    _address2.dispose();
    _zipCode.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //print('timestamp- $timeStamp');
      _getState();
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('mybuild');
    return Scaffold(
      appBar: widget.action != null
          ? AppBar(
              backgroundColor: primaryColor,
              title: Text('My Profile'),
            )
          : null,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 0.15.sh,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: blueGrey,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(10.0),
                              ),
                            ),
                            height: 0.1.sh,
                            width: 1.sw,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 0.045.sw, top: 0.035.sh),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      sharePrefereceInstance.getEmail(),
                                      style: customizeTextStyle(FontWeight.w300,
                                          fontSizeTwenty, white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 0.045.sw),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      sharePrefereceInstance.getName(),
                                      style: customizeTextStyle(FontWeight.w800,
                                          fontSizeTwenty, white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0.1.sh,
                          left: 0.35.sw,
                          child: CircleAvatar(
                            backgroundImage: _imagePath == null
                                ? NetworkImage(
                                    sharePrefereceInstance.getImage())
                                : FileImage(File(_imagePath)),
                            radius: 0.13.sw,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 0.17.sw, top: 0.09.sh),
                              child: InkWell(
                                onTap: () {
                                  _selectImage();
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: blueGrey,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 12,
                                    color: white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.14.sh,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.045.sw),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Vehicle Name : ${sharepref.getVehicleName().isEmpty ? 'Not Assign' : sharepref.getVehicleName()}",
                            style: customizeTextStyle(
                                FontWeight.w400, 15.0, black),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.045.sw, top: 0.01.sh),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Load Capacity : ${sharepref.getLoadCapacity().isEmpty ? 'Not Assign' : sharepref.getLoadCapacity() + ' ' + weightUnit}",
                          style:
                              customizeTextStyle(FontWeight.w400, 15.0, black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.045.sw, top: 0.01.sh),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Ride Type     : ${sharepref.getRideType()}",
                          style:
                              customizeTextStyle(FontWeight.w400, 15.0, black),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0.045.sw),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _fName,
                                  validator: (v) {
                                    if (v.trim().isEmpty)
                                      return 'Please enter first name';
                                    return null;
                                  },
                                  decoration:
                                      InputDecoration(labelText: "First Name"),
                                ),
                              ),
                              SizedBox(
                                width: 0.02.sw,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _mName,
                                  decoration:
                                      InputDecoration(labelText: "Middle Name"),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _lName,
                                  validator: (v) {
                                    if (v.trim().isEmpty)
                                      return 'Please enter last name';
                                    return null;
                                  },
                                  decoration:
                                      InputDecoration(labelText: "Last Name"),
                                ),
                              ),
                              SizedBox(
                                width: 0.02.sw,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _email,
                                  validator: (v) {
                                    if (v.trim().isEmpty)
                                      return 'Please enter email Id';
                                    return null;
                                  },
                                  decoration:
                                      InputDecoration(labelText: "Email"),
                                ),
                              )
                            ],
                          ),
                          TextFormField(
                            controller: _mobile,
                            validator: (v) {
                              if (v.trim().isEmpty)
                                return 'Please enter mobile no.';
                              else if (v.length < 10)
                                return 'Mobile No. should be 10 digits';
                              return null;
                            },
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                labelText: "Mobile No.", counterText: ''),
                          ),
                          TypeAheadFormField(
                              validator: (v) {
                                if (v.trim().isEmpty)
                                  return 'Please enter address';
                                return null;
                              },
                              textFieldConfiguration: TextFieldConfiguration(
                                  controller: _address,
                                  decoration:
                                      InputDecoration(labelText: 'Address 1')),
                              onSuggestionSelected:
                                  (AutocompletePrediction value) {
                                _address.text = value.description;
                              },
                              itemBuilder:
                                  (context, AutocompletePrediction value) {
                                return ListTile(
                                  title: Text(value.description),
                                );
                              },
                              suggestionsCallback: (pattern) async {
                                if (pattern.isNotEmpty) {
                                  var result = await googleplace.autocomplete
                                      .get(pattern);
                                  return result.predictions;
                                } else {
                                  var result =
                                      await googleplace.autocomplete.get('a');
                                  return result.predictions;
                                }
                              }),
                          TextFormField(
                            controller: _address2,
                            decoration: InputDecoration(labelText: "Address 2"),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField(
                                  validator: (String v) {
                                    if (v.isEmpty) return 'Please select State';
                                    return null;
                                  },
                                  value: _stateValue,
                                  icon: Icon(Icons.arrow_drop_down_circle),
                                  hint: Text('Select State'),
                                  isExpanded: true,
                                  onChanged: (value) {
                                    setState(() {
                                      _stateValue = value;

                                      _cityValue = null;
                                      _cityId = null;
                                      _cityList.clear();
                                    });
                                    _stateId = _stateList
                                        .where((element) =>
                                            element.stateName == value)
                                        .toList()
                                        .first
                                        .statusId
                                        .toString();
                                    _getCities(_stateId);
                                  },
                                  items: _stateList
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e.stateName,
                                          child: Text(e.stateName),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              SizedBox(
                                width: 0.02.sw,
                              ),
                              Expanded(
                                child: DropdownButtonFormField(
                                  validator: (String v) {
                                    if (v.isEmpty) return 'Please select City';
                                    return null;
                                  },
                                  icon: Icon(Icons.arrow_drop_down_circle),
                                  value: _cityValue,
                                  hint: Text('Select City'),
                                  isExpanded: true,
                                  onChanged: (value) {
                                    setState(() {
                                      _cityValue = value;
                                    });
                                    _cityId = _cityList
                                        .where((element) =>
                                            element.cityName == value)
                                        .toList()
                                        .first
                                        .cityId
                                        .toString();
                                  },
                                  items: _cityList
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e.cityName,
                                          child: Text(e.cityName),
                                        ),
                                      )
                                      .toList(),
                                ),
                              )
                            ],
                          ),
                          TextFormField(
                            validator: (v) {
                              if (v.trim().isEmpty)
                                return 'Please enter zipcode';
                              return null;
                            },
                            controller: _zipCode,
                            decoration: InputDecoration(labelText: "Zipcode"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 0.9.sw,
              height: 0.06.sh,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(blueGrey),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) _validate();
                },
                child: Text('Update',
                    style: TextStyle(color: white, fontSize: 20)),
              ),
            ),
            SizedBox(
              height: 0.03.sh,
            )
          ],
        ),
      ),
    );
  }

  void _selectImage() async {
    final picker = ImagePicker();
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    Get.back();
                    final _selectedImage = await picker.getImage(
                        source: ImageSource.camera, imageQuality: 50);
                    if (_selectedImage != null) {
                      setState(() {
                        _imagePath = _selectedImage.path;
                      });
                      print(_selectedImage.path);
                    }
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text('Take a Picture')),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    Get.back();
                    final _selectedImage =
                        await picker.getImage(source: ImageSource.gallery);
                    if (_selectedImage != null) {
                      setState(() {
                        _imagePath = _selectedImage.path;
                      });
                      print(_selectedImage.path);
                    }
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text('Choose from Gallery')),
                )
              ],
            ),
          );
        });
  }

  void _getState() async {
    showProgress(context);
    _stateList = await networkCall.getStates();
    hideProgress(context);
    try {
      _stateId = _stateList
          .where((element) =>
              element.stateName == sharePrefereceInstance.getState())
          .toList()
          .first
          .statusId
          .toString();
      _getCities(_stateId);
    } catch (e) {
      _stateId = null;
    }
    setState(() {});
  }

  void _getCities(String id) async {
    showProgress(context);
    _cityList = await networkCall.getCities(id);
    hideProgress(context);
    try {
      _cityId = _cityList
          .where((element) => element.cityName == _cityValue)
          .toList()
          .first
          .cityId
          .toString();
    } catch (e) {
      _cityId = null;
    }
    setState(() {});
  }

  void _validate() {
    if (_stateId == null) {
      showToast('Please select state', red);
    } else if (_cityId == null) {
      showToast('Please select city', red);
    } else {
      getLatLngFromAddress(_address.text).then((value) async {
        var params = {
          "f_name": _fName.text,
          "email": _email.text,
          "phone_no": _mobile.text,
          "address": _address.text,
          "address2": _address2.text,
          "latitude": value.latitude.toString(),
          "longitude": value.longitude.toString(),
          "m_name": _mName.text,
          "l_name": _lName.text,
          "state_id": _stateId,
          "city_id": _cityId,
          "zip_code": _zipCode.text,
          "image": _imagePath == null
              ? sharepref.getImage()
              : "data:image/jpeg;base64," +
                  base64.encode(File(_imagePath).readAsBytesSync())
        };

        showProgress(context);
        bool result = await networkCall.updateProfile(params);
        hideProgress(context);
        if (result) {
          showProgress(context);
          bool status = await networkCall.getUserData();
          hideProgress(context);
          if (status) {
            _fName.text = sharepref.getName();
            _lName.text = sharepref.getLastName();
            _mName.text = sharepref.getMiddleName();
            _email.text = sharepref.getEmail();
            _mobile.text = sharepref.getUserPhone();
            _address.text = sharepref.getUserAddress();
            _address2.text = sharepref.getAddress2();
            _zipCode.text = sharepref.getZipCode();
            _stateValue = sharepref.getState();
            _cityValue = sharepref.getCity();
            _getState();
            setState(() {});
          }
        }
      });
    }
  }
}
