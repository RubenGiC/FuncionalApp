class Tarea {
  int idta;
  String nombre;
  String descripcion;
  String fecha_inicio;
  String fecha_fin;
  bool estado;
  bool corregido;
  int usuario;

  Tarea(
      {required this.idta,
      required this.nombre,
      required this.descripcion,
      required this.fecha_inicio,
      required this.fecha_fin,
      required this.estado,
      required this.usuario,
      required this.corregido});

  factory Tarea.fromJson(Map json) {
    return Tarea(
        idta: json["idta"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        fecha_inicio: json["fecha_inicio"],
        fecha_fin: json["fecha_fin"],
        estado: json["estado"],
        usuario: json["usuario"],
        corregido: json["corregido"]);
  }
}
