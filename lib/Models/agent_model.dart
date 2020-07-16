class AgentModel {
  String id;
  String uid;
  int category;
  String agentName;
  String email;
  String phoneNumber;
  String password;
  String address;
  String city;
  int numOfCars;
  bool isRentProperties;
  bool isEstateAgent;
  bool isApproved;
  String token;
  int ts;

  AgentModel({
    this.id = "unknown",
    this.uid = "",
    this.category = 0,
    this.agentName = "",
    this.email = "",
    this.phoneNumber = "",
    this.password = "",
    this.address = "",
    this.city = "",
    this.numOfCars = 0,
    this.isRentProperties = false,
    this.isEstateAgent = false,
    this.isApproved = false,
    this.token = "",
    this.ts,
  }) {
    this.id = id;
    this.uid = uid;
    this.category = category;
    this.agentName = agentName;
    this.email = email;
    this.phoneNumber = phoneNumber;
    this.password = password;
    this.address = address;
    this.city = city;
    this.numOfCars = numOfCars;
    this.isRentProperties = isRentProperties;
    this.isEstateAgent = isEstateAgent;
    this.isApproved = isApproved;
    this.token = token;
    this.ts = ts ?? DateTime.now().millisecondsSinceEpoch;
  }

  AgentModel.fromJson(Map<String, dynamic> json)
      : id = (json['id'] != null) ? json['id'] : "unknown",
        uid = (json['uid'] != null) ? json['uid'] : "",
        category = (json['category'] != null) ? json['category'] : 0,
        agentName = (json['agentName'] != null) ? json['agentName'] : "",
        email = (json['email'] != null) ? json['email'] : "",
        phoneNumber = (json['phoneNumber'] != null) ? json['phoneNumber'] : "",
        password = (json['password'] != null) ? json['password'] : "",
        address = (json['address'] != null) ? json['address'] : "",
        city = (json['city'] != null) ? json['city'] : "",
        numOfCars = (json['numOfCars'] != null) ? json['numOfCars'] : 0,
        isRentProperties = (json['isRentProperties'] != null) ? json['isRentProperties'] : false,
        isEstateAgent = (json['isEstateAgent'] != null) ? json['isEstateAgent'] : false,
        isApproved = (json['isApproved'] != null) ? json['isApproved'] : false,
        token = (json['token'] != null) ? json['token'] : "",
        ts = (json['ts'] != null) ? json['ts'] : DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() {
    return {
      "id": (id == null) ? "unknown" : id,
      "uid": (uid == null) ? "" : uid,
      "category": (category == null) ? 0 : category,
      "agentName": (agentName == null) ? "" : agentName,
      "email": (email == null) ? "" : email,
      "phoneNumber": (phoneNumber == null) ? "" : phoneNumber,
      "password": (password == null) ? "" : password,
      "address": (address == null) ? "" : address,
      "city": (city == null) ? "" : city,
      "numOfCars": (numOfCars == null) ? 0 : numOfCars,
      "isRentProperties": (isRentProperties == null) ? false : isRentProperties,
      "isEstateAgent": (isEstateAgent == null) ? false : isEstateAgent,
      "isApproved": (isApproved == null) ? false : isApproved,
      "token": (token == null) ? "" : token,
      "ts": (ts == null) ? DateTime.now().millisecondsSinceEpoch : ts,
    };
  }
}
