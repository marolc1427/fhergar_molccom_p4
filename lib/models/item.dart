class Item {
  final String id;
  final String titulo;
  final String descripcion;
  final String imagenPath;
  final String etiqueta;

  Item({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.imagenPath,
    required this.etiqueta,
  });

  // factory constructor
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] ?? '',
      titulo: map['titulo'] ?? '',
      descripcion: map['descripcion'] ?? '',
      imagenPath: map['imagenPath'] ?? '',
      etiqueta: map['etiqueta'] ?? '',
    );
  }

  // Convierte Item a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'imagenPath': imagenPath,
      'etiqueta': etiqueta,
    };
  }
}
