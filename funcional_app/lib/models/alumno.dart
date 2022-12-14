class Alumno {
  int idus;
  String nombre;
  String apellidos;
  String nombre_usuario;
  String password;

  Alumno(
      {required this.idus,
      required this.nombre,
      required this.apellidos,
      required this.nombre_usuario,
      required this.password});

  factory Alumno.fromJson(Map json) {
    return Alumno(
        idus: json["idus"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        nombre_usuario: json["nombre_usuario"],
        password: json["password"]);
  }
}
