class ContactApiResponse {
  ContactApiResponse({
    required this.status,
    required this.count,
    required this.next,
    required this.prev,
    required this.pageNum,
    required this.data,
  });
  late final int status;
  late final int count;
  late final bool next;
  late final bool prev;
  late final int pageNum;
  late final List<Data> data;

  ContactApiResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    count = json['count'];
    next = json['next'];
    prev = json['prev'];
    pageNum = json['page_num'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['count'] = count;
    _data['next'] = next;
    _data['prev'] = prev;
    _data['page_num'] = pageNum;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.colorCode,
    required this.phoneNumber,
    required this.image,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String gender;
  late final String colorCode;
  late final String phoneNumber;
  late final String image;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    gender = json['gender'];
    colorCode = json['color_code'];
    phoneNumber = json['phone_number'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['gender'] = gender;
    _data['color_code'] = colorCode;
    _data['phone_number'] = phoneNumber;
    _data['image'] = image;
    return _data;
  }
}