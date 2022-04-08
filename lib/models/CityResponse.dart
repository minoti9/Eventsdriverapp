class CityResponse {
  final String status;
  final List<CityData> dataList;

  CityResponse({this.status, this.dataList});
  factory CityResponse.fromJson(Map<String, dynamic> myjson) {
    return CityResponse(
      status: myjson['status'],
      dataList: (myjson['data'] as List).map((e) => CityData.fromJson(e)).toList()
    );
  }
}

class CityData {
  final int cityId, stateId;
  final String cityName, status;

  CityData({this.cityId, this.stateId, this.cityName, this.status});
  factory CityData.fromJson(Map<String, dynamic> myjson) {
    return CityData(
        cityId: myjson['id'],
        stateId: myjson['state_id'],
        cityName: myjson['city_name'],
        status: myjson['status']);
  }
}
