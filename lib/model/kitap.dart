class Kitap {
  String? userID, kitapID, name, kitap;

  Kitap.setMotto({String? userID, String? kitapID, String? name, String? kitap}) {
    this.userID = userID;
    this.kitapID = kitapID;
    this.name = name;
    this.kitap = kitap;
  }

  Kitap.fromMap(Map<String, dynamic> map) {
    this.userID = map['userID'];
    this.kitapID = map['kitapID'];
    this.name = map['name'];
    this.kitap = map['kitap'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['userID'] = this.userID;
    map['kitapID'] = this.kitapID;
    map['name'] = this.name;
    map['kitap'] = this.kitap;
    return map;
  }
}