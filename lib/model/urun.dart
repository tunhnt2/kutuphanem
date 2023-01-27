class Urun {
  List<String>? images;
  List<String>? favorites;
  String? isim;
  String? tur;
  String? fiyat;
  String? detay;
  String? uid;
  UrunTip? type;
  String? id;

  Urun(
      {this.detay,
      this.images,
      this.isim,
      this.tur,
      this.fiyat,
      this.type,
      this.id, this.uid, this.favorites});

  factory Urun.fromJson(Map<String, dynamic> map, {required String id}) => Urun(
      id: id,
      isim: map["isim"],
      tur: map["tur"],
      fiyat: map["fiyat"],
      detay: map["detay"],
      uid: map["uid"],
      images: map["images"].map<String>((i) => i as String).toList(),
      type: map["type"] == "book" ? UrunTip.book : UrunTip.movie,
      favorites: map["favorites"] == null ? [] : map["favorites"].map<String>((i) => i as String).toList() );

  Map<String, dynamic> toMap() {
    return {
      "type": type == UrunTip.book ? "book" : "movie",
      "images": images,
      "isim": isim,
      "tur": tur,
      "detay": detay,
      "fiyat": fiyat,
      "uid": uid,
      "favorites": favorites,
    };
  }
}

enum UrunTip { book, movie }
