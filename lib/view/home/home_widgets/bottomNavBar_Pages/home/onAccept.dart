import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedx_driver_122283/controller/MyController.dart';
import 'package:speedx_driver_122283/models/OrderListRes.dart';
import 'package:speedx_driver_122283/network/NetworkCall.dart';
import 'package:speedx_driver_122283/utils/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'afterOnAccept.dart';

class OnAccept extends StatefulWidget {
  final Datum item;
  final String acceptId;

  const OnAccept({Key key, this.item, this.acceptId}) : super(key: key);

  @override
  _OnAcceptState createState() => _OnAcceptState();
}

class _OnAcceptState extends State<OnAccept> {
  final _mContr = MyController.to;
  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  double lat = 37.42796133580664, lng = -122.085749655962;
  final Completer<GoogleMapController> _mapContrl = Completer();
  BitmapDescriptor myIcon;
  StreamSubscription _currStream;
  Map<MarkerId, Marker> markers = {};
  MarkerId _sourceMark = MarkerId('source');
  MarkerId _destMark = MarkerId('dest');
  PolylinePoints _points = PolylinePoints();
  Map<PolylineId, Polyline> _polyLineCords = {};
  double _distanceKm = 0;
  int _time = 0;
  final _remark = TextEditingController();

  @override
  void initState() {
    super.initState();
    //print('hello');
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
        infoWindow: InfoWindow(title: 'Pickup Location'),
        position: LatLng(double.parse(widget.item.pickupAddress.latitude),
            double.parse(widget.item.pickupAddress.longitude)),
      );

      _getCurrentLocation();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _currStream.cancel();
    _remark.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var item = widget.item;
    return Scaffold(
      appBar: AppBar(
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
            width: 0.6.sw,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: blueGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                customBottomSheet(context, widget.item.id.toString(),
                    widget.acceptId.toString());
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
            bottom: 0.1.sh,
            child: Container(
                padding: EdgeInsets.all(10),
                //height: 0.23.sh,
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
                            '${item.pickupAddress.detailAddress},${item.pickupAddress.landmark},${item.pickupAddress.address}',
                            style: TextStyle(fontSize: 15, color: white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amount: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: white),
                        ),
                        Text(
                          '$currencyINR ${item.totalAmount}',
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
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
                          '+1 ${item.pickupAddress.phoneNo}',
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
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Contact Name: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: white),
                        ),
                        Text(
                          item.pickupAddress.name,
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: white),
                        ),
                      ],
                    ),
                  ],
                )),
          ),

          ///bottom btn----------------------------------------------
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(10),
              height: 0.1.sh,
              width: 1.sw,
              color: white,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: blueGrey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  _currStream.cancel();
                  Get.to(() => AfterOnAcceptDropLocation(
                        // orderDetail: item,
                        acceptId: widget.acceptId,
                      )).then((value) {
                    if (item.status.toLowerCase().contains('delivered')) {
                      Get.back();
                    }
                    _getCurrentLocation();
                  });
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

  void customBottomSheet(context, String orderId, String acceptId) {
    _remark.clear();
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: 0.35.sh,
          width: 0.1.sw,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 0.01.sh,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Reason of rejection ?",
                    style: customizeTextStyle(
                      FontWeight.normal,
                      fontSizeTwenty,
                      red,
                    ),
                  ),
                ),

                SizedBox(
                  height: 0.02.sh,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: TextFormField(
                    maxLines: 4,
                    controller: _remark,
                    decoration: InputDecoration(
                        hintText: 'Remark',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),

                SizedBox(
                  height: 0.02.sh,
                ),

                ///submit btn------------------------------------
                SizedBox(
                  height: 0.05.sh,
                  width: 0.9.sw,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: red,
                      onPrimary: white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        // side: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    onPressed: () async {
                      if (_remark.text.trim().isEmpty)
                        showToast('Please enter remark', red);
                      else {
                        showProgress(context);
                        bool result = await networkCall.emergencyOrderReject(
                            remark: _remark.text,
                            orderId: orderId,
                            acceptId: acceptId);
                        hideProgress(context);
                        if (result) {
                          await _mContr.getOrderList(
                              latitude: lat, longitude: lng);
                          await _mContr.getAcceptedOrderList();
                          Get.back();
                          Get.back();
                        }
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
                SizedBox(
                  height: 0.02.sh,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _getCurrentLocation() {
    _currStream = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
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
            double.parse(widget.item.pickupAddress.latitude),
            double.parse(widget.item.pickupAddress.longitude));

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
}
