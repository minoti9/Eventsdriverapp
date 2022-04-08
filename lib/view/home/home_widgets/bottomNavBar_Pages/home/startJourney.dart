import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:speedx_driver_122283/models/OrderListRes.dart';
import 'package:speedx_driver_122283/network/NetworkCall.dart';
import 'package:speedx_driver_122283/utils/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartJourney extends StatefulWidget {
  final DropAddress dropAddress;

  StartJourney({Key key, this.dropAddress}) : super(key: key);

  @override
  _StartJourneyState createState() => _StartJourneyState();
}

class _StartJourneyState extends State<StartJourney> {
  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  final Completer<GoogleMapController> _mapContrl = Completer();
  Map<MarkerId, Marker> markers = {};
  BitmapDescriptor myIcon;
  MarkerId _sourceMark = MarkerId('source');
  MarkerId _destMark = MarkerId('dest');
  double lat = 37.42796133580664, lng = -122.085749655962;
  StreamSubscription _currStream;
  double _distanceKm = 0;
  int _time = 0;
  PolylinePoints _points = PolylinePoints();
  Map<PolylineId, Polyline> _polyLineCords = {};

  @override
  void initState() {
    super.initState();
    getBytesFromAsset('assets/logo.png', 200).then((value) {
      myIcon = BitmapDescriptor.fromBytes(value);

      markers[_sourceMark] = Marker(
        markerId: _sourceMark,
        infoWindow: InfoWindow(title: 'My Location'),
        position: LatLng(lat, lng),
        icon: myIcon ?? BitmapDescriptor.defaultMarker,
      );
      markers[_destMark] = Marker(
        markerId: _destMark,
        infoWindow: InfoWindow(title: 'Drop Location'),
        position: LatLng(double.parse(widget.dropAddress.dropAddress.latitude),
            double.parse(widget.dropAddress.dropAddress.longitude)),
      );
      _getCurrentLocation();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _currStream.cancel();
  }

  void _getCurrentLocation() {
    _currStream = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
      accuracy: LocationAccuracy.best,
    )).listen((event) async {
      print('location- ${event.latitude}\n${event.longitude}');

      if (event.latitude != lat && event.longitude != lng) {
        lat = event.latitude;
        lng = event.longitude;
        markers[_sourceMark] = Marker(
          markerId: _sourceMark,
          infoWindow: InfoWindow(title: 'My Location'),
          position: LatLng(lat, lng),
          icon: myIcon ?? BitmapDescriptor.defaultMarker,
        );

        double distance = Geolocator.distanceBetween(
            lat,
            lng,
            double.parse(widget.dropAddress.dropAddress.latitude),
            double.parse(widget.dropAddress.dropAddress.longitude));

        //calculate speed of vehicle
        //print('distance- ${_distanceKm * 1000} \n $distance');
        if (_distanceKm > 0) {
          var diffDistanceMeter = (_distanceKm * 1000) - distance;
          print('diff- $diffDistanceMeter');
          final speed = diffDistanceMeter / 2; //get speed of vehicle
          print('speed- $speed');
          _time = (distance / speed).round(); //get time from distance and speed
          _time = (_time / 60).round(); //convert seconds to minutes

        }
        _distanceKm = distance / 1000;

        _getPolylinePoints();
        var contr = await _mapContrl.future;
        await Future.delayed(Duration(milliseconds: 50), () {
          contr.animateCamera(CameraUpdate.newLatLngBounds(
              _bounds(Set<Marker>.of(markers.values)), 40));
        });
        setState(() {});
      }
    });
  }

  LatLngBounds _bounds(Set<Marker> markers) {
    if (markers == null || markers.isEmpty) return null;
    return _createBounds(markers.map((m) => m.position).toList());
  }

  LatLngBounds _createBounds(List<LatLng> positions) {
    final southwestLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value < element ? value : element); // smallest
    final southwestLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value < element ? value : element);
    final northeastLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value > element ? value : element); // biggest
    final northeastLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value > element ? value : element);
    return LatLngBounds(
        southwest: LatLng(southwestLat, southwestLon),
        northeast: LatLng(northeastLat, northeastLon));
  }

  void _getPolylinePoints() async {
    var result = await _points.getRouteBetweenCoordinates(
        googlePlaceApiKey,
        PointLatLng(markers[_sourceMark].position.latitude,
            markers[_sourceMark].position.longitude),
        PointLatLng(markers[_destMark].position.latitude,
            markers[_destMark].position.longitude),
        travelMode: TravelMode.driving);
    //print(result.points);
    List<LatLng> _latlngList = [];

    result.points.forEach((element) {
      _latlngList.add(LatLng(element.latitude, element.longitude));
    });
    PolylineId _polyId = PolylineId('poly');
    Polyline _polyLine = Polyline(
        polylineId: _polyId, color: red, points: _latlngList, width: 3);
    setState(() {
      _polyLineCords[_polyId] = _polyLine;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Drop',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: black),
        ),
        leading: IconButton(
            color: black,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            }),
        backgroundColor: white,
        actions: [
          Container(
            padding: EdgeInsets.all(10),
            height: 0.01.sh,
            width: 0.5.sw,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: blueGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                // customBottomSheet(context);
              },
              child: Text('Emergency Rejected', style: TextStyle(color: white)),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _cameraPosition,
            markers: Set<Marker>.of(markers.values),
            polylines: Set<Polyline>.of(_polyLineCords.values),
            onMapCreated: (_contrl) {
              _mapContrl.complete(_contrl);
            },
          ),

          ///transperent----------------------------------------------
          Positioned(
            bottom: 0.13.sh,
            child: Container(
              padding: EdgeInsets.all(15),
              // height: 0.14.sh,
              width: 1.sw,
              color: Colors.blueGrey.withOpacity(0.8),
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: white),
                      ),
                      Flexible(
                        child: Text(
                          '${widget.dropAddress.dropAddress.detailAddress}, ${widget.dropAddress.dropAddress.landmark}, ${widget.dropAddress.dropAddress.address}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Contact Number: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: white),
                      ),
                      Text(
                        '+1 ${widget.dropAddress.dropAddress.phoneNo}',
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: white),
                      ),
                      SizedBox(
                        width: 0.22.sw,
                      ),
                      Icon(Icons.phone, color: white)
                    ],
                  ),
                ],
              ),
            ),
          ),

          ///bottom btn----------------------------------------------
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(15),
              // height: 0.09.sh,
              width: 1.sw,
              color: white,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  _showOtpDialog(widget.dropAddress.dropAddress.phoneNo,
                      widget.dropAddress.id.toString());
                  //Get.off(()=>DelivaryRemark());
                },
                child: Text(
                    'Reach in $_time min(${_distanceKm.toStringAsFixed(2)} KM)',
                    style: TextStyle(fontSize: 18, color: white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOtpDialog(String phoneNo, String dropAddId) {
    bool _isShowOtp = false;
    String _otp = '';
    Get.defaultDialog(
        title: 'Verify OTP',
        barrierDismissible: false,
        content: StatefulBuilder(
          builder: (context, mstate) => Column(
            children: [
              Divider(),
              Text('+1 $phoneNo'),
              ElevatedButton(
                onPressed: () async {
                  showProgress(context);
                  var result = await networkCall.sendDropOtp(
                      dropAddId: dropAddId, phoneNo: phoneNo);
                  hideProgress(context);
                  if (result != null) {
                    mstate(() {
                      _isShowOtp = true;
                      _otp = result['data']['otp'];
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  'Send OTP',
                  style: TextStyle(color: white),
                ),
              ),
              if (_isShowOtp)
                PinFieldAutoFill(
                  decoration: UnderlineDecoration(
                    textStyle: TextStyle(fontSize: 20, color: Colors.black),
                    colorBuilder:
                        FixedColorBuilder(Colors.black.withOpacity(0.3)),
                  ),
                  onCodeChanged: (code) {
                    if (code.length == 6) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (int.parse(code) == int.parse(_otp)) {
                        _otpValidate(code, dropAddId);
                      } else
                        showToast('Please enter valid code', Colors.black);
                    }
                  },
                ),
              SizedBox(
                height: 0.02.sh,
              )
            ],
          ),
        ));
  }

  void _otpValidate(String code, String dropAddId) async {
    // print('orderId- $orderId\n acceptId- ${widget.acceptId}');
    showProgress(context);
    bool result =
        await networkCall.verifyDropOtp(dropAddId: dropAddId, otp: code);
    hideProgress(context);
    if (result) {
      Get.back();
      Get.back();
    }
  }
}

/* class DelivaryRemark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delivary Remark',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: black),
        ),
        leading: IconButton(
            color: black,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            }),
        backgroundColor: white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: (BoxDecoration(
                border: Border.all(
                  color: black,
                  width: 1,
                ),
              )),
              child: TextFormField(
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Remarks',
                  contentPadding: EdgeInsets.only(left: 10.0, top: 10.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Add pics'),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 0.01.sw,
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
                  child: Icon(Icons.add),
                ),
                SizedBox(
                  width: 0.01.sw,
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
                  child: Icon(Icons.add),
                ),
                SizedBox(
                  width: 0.01.sw,
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
                  child: Icon(Icons.add),
                ),
                SizedBox(
                  width: 0.01.sw,
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
                  child: Icon(Icons.add),
                ),
              ],
            ),
            Expanded(child: Container()),
            Container(
              padding: EdgeInsets.all(15),
              height: 0.09.sh,
              width: 1.sw,
              color: white,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: blueGrey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  Get.to(AfterOnAcceptDropLocation());
                },
                child: Text('Complete',
                    style: TextStyle(fontSize: 18, color: white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */