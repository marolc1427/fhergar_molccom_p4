import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/item.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  late Future<List<Item>> _futureItems;

  @override
  void initState() {
    super.initState();
    _futureItems = _loadItemsFromJson();
  }

  // Cargar los datos desde el JSON local
  Future<List<Item>> _loadItemsFromJson() async {
    await Future.delayed(const Duration(seconds: 1)); // Simula carga lenta
    final jsonString =
        await DefaultAssetBundle.of(context).loadString('assets/data/items.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> itemsList = jsonData['items'];
    return itemsList.map((e) => Item.fromMap(e)).toList();
  }

  // Recargar al hacer "pull to refresh"
  Future<void> _reloadItems() async {
    setState(() {
      _futureItems = _loadItemsFromJson();
    });
    await _futureItems;
  }

  // Abrir enlace externo
  Future<void> _abrirEnlace(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('No se pudo abrir el enlace: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        iconTheme: const IconThemeData(color: Colors.white, size: 32),
        title: const Text(
          "Modelos 3D",
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF4F46E5),
        elevation: 2,
      ),
      body: FutureBuilder<List<Item>>(
        future: _futureItems,
        builder: (context, snapshot) {
          // 🌀 Indicador de progreso
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF4F46E5)),
            );
          }

          // Si hay error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al cargar los datos: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // Si no hay datos
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No hay productos disponibles.'),
            );
          }

          final items = snapshot.data!;

          // ✅ Lista principal con Pull-to-Refresh
          return RefreshIndicator(
            onRefresh: _reloadItems,
            color: const Color(0xFF4F46E5),
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: items.length + 1, // +1 para los patrocinadores
              itemBuilder: (context, index) {
                if (index < items.length) {
                  final item = items[index];

                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // En esta fase no hay detalle todavía
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'La visualización de detalles se implementará en la Fase 3',
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Imagen con etiqueta
                              Stack(
                                children: [
                                  Container(
                                    height: 250,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage(item.imagenPath),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        item.etiqueta.toUpperCase(),
                                        style: const TextStyle(
                                          color: Color(0xFF4F46E5),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Contenido debajo de la imagen
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.titulo,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            item.descripcion,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 12),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEEF2FF),
                                        borderRadius: BorderRadius.circular(6),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.download_rounded,
                                        color: Color(0xFF4F46E5),
                                        size: 28,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                } else {
                  // Bloque inferior con logos de patrocinadores
                  return Column(
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: GestureDetector(
                              onTap: () => _abrirEnlace(
                                'https://eu.store.bambulab.com/es',
                              ),
                              child: Image.asset(
                                'assets/images/bambu.png',
                                height: 80,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Flexible(
                            child: GestureDetector(
                              onTap: () => _abrirEnlace(
                                'https://www.smartmaterials3d.com/',
                              ),
                              child: Image.asset(
                                'assets/images/smart3d.jpg',
                                height: 80,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
