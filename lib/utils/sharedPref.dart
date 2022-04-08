import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceInstance {
  //keys

  final _userEmail = 'email';

  final _userToken = 'token';
  final _userId = 'id';
  final _fName = 'name';
  final _userPhoneNumber = 'phone_no';
  final _iSLOGIN = 'isLogin';
  final _imgUrl = 'image';
  final _userAddress = 'address';
  final _userCreatedAccAt = 'created_at';
  final _userReferralCode = 'referral_code';
  final _wallet = 'wallet';
  final _zipCode = 'zipcode';
  final _mName = 'mName';
  final _lName = 'lname';
  final _state = 'state';
  final _city = 'city';
  final _address2 = 'address2';
  final _rideType = 'rideType';
  final _vehicleName = 'vehicleName';
  final _loadCapacity = 'loadcapacity';

  static SharedPreferences prefs;

  static final SharePreferenceInstance networkcall =
      new SharePreferenceInstance._internal();

  SharePreferenceInstance._internal();

  factory SharePreferenceInstance() {
    return networkcall;
  }

  //shared pref initialize
  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // ---------------- email --------------------
  void setEmail(email) => prefs.setString(_userEmail, email);

  String getEmail() => prefs.getString(_userEmail);

  //  ---------------- image  ----------------
  void setImage(img) => prefs.setString(_imgUrl, img);

  String getImage() => prefs.getString(_imgUrl);

  //  ---------------- address  ----------------
  void setUserAddress(address) => prefs.setString(_userAddress, address);

  String getUserAddress() => prefs.getString(_userAddress);

  //  ---------------- create date  ----------------
  void setAccCreateAt(date) => prefs.setString(_userCreatedAccAt, date);

  String getAccCreateAt() => prefs.getString(_userCreatedAccAt);

  //  ---------------- token  ----------------
  void setToken(token) => prefs.setString(_userToken, token);

  String getToken() => prefs.getString(_userToken);

  //  ---------------- user_id  ----------------
  void setUserId(id) => prefs.setString(_userId, id.toString());

  String getUserId() => prefs.getString(_userId);

  //  ---------------- user_phone  ----------------
  void setUserPhone(phone_no) => prefs.setString(_userPhoneNumber, phone_no);

  String getUserPhone() => prefs.getString(_userPhoneNumber);

  //  ---------------- name  ----------------
  void setName(firstname) => prefs.setString(_fName, firstname);

  String getName() => prefs.getString(_fName);

  //  ----------------middle name  ----------------
  void setMiddleName(value) => prefs.setString(_mName, value);

  String getMiddleName() => prefs.getString(_mName);

  //  ----------------last name  ----------------
  void setLastName(value) => prefs.setString(_lName, value);

  String getLastName() => prefs.getString(_lName);

  //  ---------------- referral_code  ----------------
  void setRefCode(refCode) => prefs.setString(_userReferralCode, refCode);

  String getRefCode() => prefs.getString(_userReferralCode);

  //  ---------------- isLogin  ----------------
  void setIsLogin(firstname) => prefs.setBool(_iSLOGIN, firstname);

  bool getIsLogin() => prefs.getBool(_iSLOGIN) ?? false;

  //--------------------------wallet-----------------------
  void setWallet(value) => prefs.setString(_wallet, value);

  String getWallet() => prefs.getString(_wallet);

  //--------------------------zipcode-----------------------
  void setZipCode(value) => prefs.setString(_zipCode, value);

  String getZipCode() => prefs.getString(_zipCode);

  //--------------------------state-----------------------
  void setState(value) => prefs.setString(_state, value);

  String getState() => prefs.getString(_state);

  //--------------------------city-----------------------
  void setCity(value) => prefs.setString(_city, value);

  String getCity() => prefs.getString(_city);

  //--------------------------address2-----------------------
  void setAddress2(value) => prefs.setString(_address2, value);

  String getAddress2() => prefs.getString(_address2);

  //-------------------------ride type-----------------------
  void setRideType(value) => prefs.setString(_rideType, value);

  String getRideType() => prefs.getString(_rideType);

  //-------------------------vehicle Name-----------------------
  void setVehicleName(value) => prefs.setString(_vehicleName, value);

  String getVehicleName() => prefs.getString(_vehicleName);

  //-------------------------Load Capacity-----------------------
  void setLoadCapacity(value) => prefs.setString(_loadCapacity, value);

  String getLoadCapacity() => prefs.getString(_loadCapacity);

  void clear() {
    prefs.clear();
  }

  saveUserDetail(Map<String, dynamic> userData) {
    print("saveUserDetail  $userData");
    setEmail(userData["user"]['email']);
    setUserId(userData["user"]['id']);
    setUserPhone(userData["user"]['phone_no']);
    setName(userData["user"]['f_name']);
    setImage(userData["user"]['image']);
    setUserAddress(userData["user"]['address']);
    setAccCreateAt(userData["user"]['created_at']);
    setRefCode(userData["user"]['referral_code']);
    setWallet(userData["user"]["wallet"]);
    setMiddleName(userData["user"]["m_name"] ?? '');
    setLastName(userData["user"]["l_name"] ?? '');
    setZipCode(userData["user"]["zip_code"] ?? '');
    setAddress2(userData['user']['address2'] ?? '');
    setRideType(userData['user']['driver_vehicle'] == null
        ? ''
        : userData['user']['driver_vehicle']['vehicle']['type']);
    setVehicleName(userData['user']['driver_vehicle'] == null
        ? ''
        : userData['user']['driver_vehicle']['vehicle']['name']);
    setLoadCapacity(userData['user']['driver_vehicle'] == null
        ? ''
        : userData['user']['driver_vehicle']['vehicle']['vehicle_type']['load_capacity']);

    print(userData['user']['state_id']);
    if (userData['user']['state_id'] != null) {
      setState(userData["user"]["state"]['state_name'] ?? '');
    }
    if (userData['user']['city_id'] != null) {
      setCity(userData["user"]["city"]['city_name'] ?? '');
    }

    setToken(userData['token']);
    setIsLogin(true);
    print('status- ${sharePrefereceInstance.getIsLogin()}');
  }
  // userAuthToken(Map<String, dynamic> authToken) {
  //   print("saveUserDetail  $authToken");
  //   setToken(authToken['token']);
  // }
}

SharePreferenceInstance sharePrefereceInstance = new SharePreferenceInstance();
SharePreferenceInstance sharepref = sharePrefereceInstance;
