import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:speedx_driver_122283/models/CityResponse.dart';
import 'package:speedx_driver_122283/models/StatesResponse.dart';
import 'package:speedx_driver_122283/network/NetworkCall.dart';
import 'package:speedx_driver_122283/utils/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speedx_driver_122283/view/login/login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool checkedValue = false;
  String _stateValue,
      _cityValue,
      _stateId,
      _cityId,
      _imgDl,
      _imgAadhar,
      _imgPAN;
  List<StatesData> _stateList = [];
  List<CityData> _cityList = [];
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  final _fName = TextEditingController();
  final _mName = TextEditingController();
  final _lName = TextEditingController();
  final _email = TextEditingController();
  final _mobile = TextEditingController();
  final _address = TextEditingController();
  final _address2 = TextEditingController();
  final _referal = TextEditingController();
  final _password = TextEditingController();
  final _confPass = TextEditingController();
  final _zipCode = TextEditingController();
  final _drivingLicense = TextEditingController();
  final _aadharNo = TextEditingController();
  final _panNo = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getState();
    });
  }

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
    _referal.dispose();
    _password.dispose();
    _confPass.dispose();
    _zipCode.dispose();
    _drivingLicense.dispose();
    _aadharNo.dispose();
    _panNo.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Sign Up",
          style: customizeTextStyle(FontWeight.normal, fontSizeTwenty, black),
        ),
      ),
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    Center(
                        child: Text(
                      "Create Account",
                      style: customizeTextStyle(
                          FontWeight.normal, fontSizeTwentyFour, red),
                    )),
                    Divider(
                      thickness: 0.0050.sw,
                      endIndent: 0.3.sw,
                      indent: 0.3.sw,
                    ),
                    /* SizedBox(
                            height: 0.02.sh,
                          ),
                          Center(
                              child: Text(
                            "Please sign up to proceed",
                            style: customizeTextStyle(FontWeight.normal, 18.0, black),
                          )),
                          SizedBox(
                            height: 0.01.sh,
                          ),
                          Center(
                              child: Text(
                            "Vehicle Owner",
                            style: customizeTextStyle(FontWeight.normal, 18.0, black),
                          )),
                          SizedBox(
                            height: 0.02.sh,
                          ),
                          Container(
                            height: 0.06.sh,
                            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                            child: LayoutBuilder(
                              builder: (context, constraints) => ToggleButtons(
                                constraints: BoxConstraints.expand(
                                    width: constraints.maxWidth / 3),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                                selectedColor: Colors.black,
                                fillColor: Colors.green,
                                children: <Widget>[
                                  Text('Yes'),
                                  Text('No'),
                                ],
                                onPressed: (int index) {
                                  setState(() {
                                    for (int buttonIndex = 0;
                                        buttonIndex < isSelected.length;
                                        buttonIndex++) {
                                      if (buttonIndex == index) {
                                        isSelected[buttonIndex] = true;
                                      } else {
                                        isSelected[buttonIndex] = false;
                                      }
                                    }
      
                                    // if (index == 1) {
                                    //   getGlobalResult();
                                    //   isGlobal = true;
                                    //   isTotal = true;
                                    // } else {
                                    //   getCountryTotalResult(selectedValue);
                                    //   isGlobal = false;
                                    //   isTotal = true;
                                    //   isDaySelected = [true, false, false];
                                    // }
                                  });
                                },
                                isSelected: isSelected,
                              ),
                            ),
                          ), */
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    Container(
                      child: CircleAvatar(
                        backgroundColor: grey,
                        radius: 0.11.sw,
                        child: CircleAvatar(
                          backgroundColor: white,
                          radius: 0.1.sw,
                          child: Center(
                            child: Icon(
                              Icons.person,
                              size: 0.15.sw,
                              color: black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _fName,
                            validator: (value) {
                              if (value.trim().isEmpty)
                                return 'Please enter first name';
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z]+|\s"))
                            ],
                            decoration:
                                (InputDecoration(hintText: "First Name")),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _mName,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z]+|\s"))
                            ],
                            decoration:
                                (InputDecoration(hintText: "Middle Name")),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _lName,
                            validator: (value) {
                              if (value.trim().isEmpty)
                                return 'Please enter last name';
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z]+|\s"))
                            ],
                            decoration:
                                (InputDecoration(hintText: "Last Name")),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _email,
                            validator: (value) {
                              if (value.trim().isEmpty)
                                return 'Please enter email Id';
                              else if (!GetUtils.isEmail(value))
                                return 'Please enter valid email';
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: (InputDecoration(hintText: "Email Id")),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: _mobile,
                      validator: (v) {
                        if (v.trim().isEmpty)
                          return 'Please enter mobile no.';
                        else if (v.length < 10)
                          return 'Mobile no. should be 10 digits';
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: (InputDecoration(
                          hintText: "Mobile No", counterText: '')),
                    ),
                    TypeAheadFormField(
                        validator: (value) {
                          if (value.isEmpty) return 'Please enter address';
                          return null;
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: _address,
                          decoration: InputDecoration(
                            hintText: 'Address 1',
                            labelText: 'Address 1',
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          if (pattern.isNotEmpty) {
                            var result =
                                await googleplace.autocomplete.get(pattern);
                            return result.predictions;
                          } else {
                            var result =
                                await googleplace.autocomplete.get('a');
                            return result.predictions;
                          }
                        },
                        itemBuilder:
                            (context, AutocompletePrediction suggestion) {
                          return ListTile(
                            title: Text(suggestion.description),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          _address.text = suggestion.description;
                        }),
                    TextField(
                      controller: _address2,
                      decoration: (InputDecoration(hintText: "Address2")),
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButton(
                              hint: Text('Select State'),
                              isExpanded: true,
                              value: _stateValue,
                              icon: Icon(Icons.keyboard_arrow_down),
                              onChanged: (value) {
                                setState(() {
                                  _stateValue = value;

                                  _cityValue = null;
                                  _cityId = null;
                                  _cityList.clear();
                                });
                                _stateId = _stateList
                                    .where(
                                        (element) => element.stateName == value)
                                    .toList()
                                    .first
                                    .statusId
                                    .toString();
                                _getCities(_stateId);
                              },
                              items: _stateList
                                  .map((e) => DropdownMenuItem(
                                      value: e.stateName,
                                      child: Text(e.stateName)))
                                  .toList()),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: DropdownButton(
                              hint: Text('Select City'),
                              isExpanded: true,
                              icon: Icon(Icons.keyboard_arrow_down),
                              value: _cityValue,
                              onChanged: (value) {
                                setState(() {
                                  _cityValue = value;
                                });
                                _cityId = _cityList
                                    .where(
                                        (element) => element.cityName == value)
                                    .toList()
                                    .first
                                    .cityId
                                    .toString();
                              },
                              items: _cityList
                                  .map((e) => DropdownMenuItem(
                                      value: e.cityName,
                                      child: Text(e.cityName)))
                                  .toList()),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    TextFormField(
                      controller: _zipCode,
                      validator: (v) {
                        if (v.trim().isEmpty) return 'Please enter zipcode';
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: "Zipcode"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _drivingLicense,
                            validator: (v) {
                              if (v.trim().isEmpty)
                                return 'Please enter driving license no.';
                              return null;
                            },
                            decoration:
                                InputDecoration(hintText: "Driving License No"),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            _selectImage(action: 'dl');
                          },
                          child: Container(
                            decoration: (BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            )),
                            //   color: Colors.orange,
                            height: 0.1.sh,
                            width: 0.2.sw,
                            child: _imgDl == null
                                ? Icon(Icons.add)
                                : Image.file(
                                    File(_imgDl),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('ID Prrof 1 : ')),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            _selectImage(action: 'aadhar');
                          },
                          child: Container(
                            decoration: (BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            )),
                            //   color: Colors.orange,
                            height: 0.1.sh,
                            width: 0.2.sw,
                            child: _imgAadhar == null
                                ? Icon(Icons.add)
                                : Image.file(
                                    File(_imgAadhar),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('ID Proof 2 : ')),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            _selectImage(action: 'pan');
                          },
                          child: Container(
                            decoration: (BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            )),
                            //   color: Colors.orange,
                            height: 0.1.sh,
                            width: 0.2.sw,
                            child: _imgPAN == null
                                ? Icon(Icons.add)
                                : Image.file(
                                    File(_imgPAN),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: _password,
                      validator: (v) {
                        if (v.trim().isEmpty) return 'Please enter password';
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Password"),
                    ),
                    TextFormField(
                      controller: _confPass,
                      validator: (v) {
                        if (v.trim().isEmpty)
                          return 'Please enter confirm password';
                        else if (v.trim() != _password.text.trim())
                          return 'Password does not match';
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Confirm Password"),
                    ),
                    TextField(
                      controller: _referal,
                      decoration: (InputDecoration(hintText: "Referal Code")),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: checkedValue,
                          checkColor: Colors.white,
                          activeColor: blueGrey,
                          onChanged: (bool newValue) {
                            setState(() {
                              checkedValue = newValue;
                            });
                          },
                        ),
                        Text("i Agree.Terms of use | Privacy policy")
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 0.01.sh,
        ),
        SizedBox(
          width: 0.9.sw,
          //height: 0.05.sh,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            onPressed: () {
              _validateData();
            },
            child:
                Text('Register', style: TextStyle(color: white, fontSize: 18)),
            color: primaryColor,
          ),
        ),
        SizedBox(
          height: 0.01.sh,
        )
      ]),
    );
  }

  void _getState() async {
    showProgress(context);
    _stateList = await networkCall.getStates();
    hideProgress(context);
    setState(() {});
  }

  void _getCities(String id) async {
    showProgress(context);
    _cityList = await networkCall.getCities(id);
    setState(() {});
    hideProgress(context);
  }

  void _selectImage({String action}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton(
                    onPressed: () async {
                      Get.back();
                      final img =
                          await _picker.getImage(source: ImageSource.camera);
                      _setImage(img, action);
                    },
                    child: Text('Take Picture'),
                  ),
                  FlatButton(
                    onPressed: () async {
                      Get.back();
                      final img =
                          await _picker.getImage(source: ImageSource.gallery);
                      _setImage(img, action);
                    },
                    child: Text('Choose From Gallery'),
                  ),
                ],
              ));
        });
  }

  void _setImage(PickedFile img, String action) {
    setState(() {
      if (img != null) {
        if (action == 'dl')
          _imgDl = img.path;
        else if (action == 'aadhar')
          _imgAadhar = img.path;
        else if (action == 'pan') _imgPAN = img.path;
      }
    });
  }

  void _validateData() {
    if (_formKey.currentState.validate()) {
      if (_stateId == null)
        showToast('Please select state', red);
      else if (_cityId == null)
        showToast('Please select city', red);
      else if (_imgDl == null)
        showToast('Please choose driving license photo', red);
      else if (_imgAadhar == null)
        showToast('Please choose aadhar photo', red);
      else if (_imgPAN == null)
        showToast('Please choose PAN card photo', red);
      else if (!checkedValue)
        showToast('Please accept terms and condition', red);
      else {
        final base64_DL = base64.encode(File(_imgDl).readAsBytesSync());
        final base64_aadhar = base64.encode(File(_imgAadhar).readAsBytesSync());
        final base64_pan = base64.encode(File(_imgPAN).readAsBytesSync());

        getLatLngFromAddress(_address.text).then((value) async {
          showProgress(context);
          var result = await networkCall.register(
              fName: _fName.text,
              mName: _mName.text,
              lName: _lName.text,
              email: _email.text,
              phoneNo: _mobile.text,
              address: _address.text,
              address2: _address2.text,
              stateId: _stateId,
              cityId: _cityId,
              zipCode: _zipCode.text,
              drivingLicsnc: _drivingLicense.text,
              drivingLImg: base64_DL,
              referalCode: _referal.text,
              password: _password.text,
              idProof1: 'Aadhar Card',
              idProrf1Img: base64_aadhar,
              idProof2: 'PAN Card',
              idProof2Img: base64_pan,
              latitude: value.latitude.toString(),
              longitude: value.longitude.toString());
          hideProgress(context);
          if (result != null) {
            int otp = result['data']['otp'];
            int id = result['data']['id'];
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('OTP Validate'),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('Cancel'),
                      )
                    ],
                    content: PinFieldAutoFill(
                      decoration: UnderlineDecoration(
                        textStyle: TextStyle(fontSize: 20, color: Colors.black),
                        colorBuilder:
                            FixedColorBuilder(Colors.black.withOpacity(0.3)),
                      ),
                      onCodeChanged: (code) {
                        if (code.length == 6) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (int.parse(code) == otp) {
                            _otpValidate(code, id);
                          } else
                            showToast('Please enter valid code', Colors.black);
                        }
                      },
                    ),
                  );
                });
          }
        });
      }
    }
  }

  void _otpValidate(String code, int id) async {
    bool result = await networkCall.otpValidate(id.toString(), code);
    print(result);
    if (result)
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }
}
