class Profesor {
  int idus;
  String nombre;
  String apellidos;
  String nombre_usuario;
  String password;
  bool es_admin;
  Profesor(
      {required this.idus,
      required this.nombre,
      required this.apellidos,
      required this.nombre_usuario,
      required this.password,
      required this.es_admin});

  factory Profesor.fromJson(Map json) {
    return Profesor(
        idus: json["idus"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        nombre_usuario: json["nombre_usuario"],
        password: json["password"],
        es_admin: json["es_admin"]);
  }
}
