import 'dart:convert';

class Products {
    bool available;
    String name;
    String? picture;
    double price;
    String? id;

    Products({
        required this.available,
        required this.name,
        this.picture,
        required this.price,
        this.id
    });

    factory Products.fromRawJson(String str) => Products.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
    };

    Products copy() => Products(
      available: available,
      name: name,
      picture: picture,
      price: price,
      id: id
    );
}
