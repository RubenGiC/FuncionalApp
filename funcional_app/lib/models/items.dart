class Item {
  int idit;
  String nombre;
  String descripcion;
  int stock;

  Item(
      {required this.idit,
      required this.nombre,
      required this.descripcion,
      required this.stock});

  factory Item.fromJson(Map json) {
    return Item(
        idit: json["id_item"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        stock: int.parse(json["stock"]));
  }
}
