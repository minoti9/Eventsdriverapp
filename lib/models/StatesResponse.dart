class StatesResponse {
  final String status;
  final List<StatesData> dataList;

  StatesResponse({this.status, this.dataList});
  factory StatesResponse.fromJson(Map<String, dynamic> myjson) {
    return StatesResponse(
      status: myjson['status'],
      dataList: (myjson['data'] as List).map((e) => StatesData.fromJson(e)).toList()
    );
  }
}

class StatesData {
  final int statusId;
  final String stateName, status;

  StatesData({this.statusId, this.stateName, this.status});
  factory StatesData.fromJson(Map<String, dynamic> myjson) {
    return StatesData(
        statusId: myjson['id'],
        stateName: myjson['state_name'],
        status: myjson['status']);
  }
}
