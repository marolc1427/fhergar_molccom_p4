import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/item.dart';
import '../generated/l10n/app_localizations.dart';
import 'detail_view.dart';
import 'custom_model_form.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage>
    with SingleTickerProviderStateMixin {
  late Future<List<Item>> _futureItems;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _futureItems = _loadItems();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List<Item>> _loadItems() async {
    await Future.delayed(const Duration(seconds: 2));
    final jsonString =
        await DefaultAssetBundle.of(context).loadString('assets/data/items.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final List<dynamic> jsonList = jsonMap['items'];
    return jsonList.map((e) => Item.fromMap(e)).toList();
  }

  Future<void> _refreshData() async {
    setState(() {
      _futureItems = _loadItems();
    });
  }

  Future<void> _abrirEnlace(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('No se pudo abrir el enlace: $url');
    }
  }

  // Helper para traducir las etiquetas de los items
  String categoryLabel(String etiqueta, BuildContext context) {
    final t = AppLocalizations.of(context)!;
    switch (etiqueta) {
      case 'Juguete':
        return t.categoryLabelJuguete;
      case 'Decorativo':
        return t.categoryLabelDecorativo;
      case 'Útil':
        return t.categoryLabelUtil;
      default:
        return etiqueta;
    }
  }

  // Helper para traducir títulos de items
  String itemTitle(String id, BuildContext context) {
    final t = AppLocalizations.of(context)!;
    switch (id) {
      case '1':
        return t.item1Title;
      case '2':
        return t.item2Title;
      case '3':
        return t.item3Title;
      case '4':
        return t.item4Title;
      default:
        return '';
    }
  }

  // Helper para traducir descripciones de items
  String itemDescription(String id, BuildContext context) {
    final t = AppLocalizations.of(context)!;
    switch (id) {
      case '1':
        return t.item1Description;
      case '2':
        return t.item2Description;
      case '3':
        return t.item3Description;
      case '4':
        return t.item4Description;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        iconTheme: const IconThemeData(color: Colors.white, size: 32),
        title: Text(
          t.modelTitle,
          style: const TextStyle(
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    t.loadingModels,
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(t.noItemsFound));
          }

          final items = snapshot.data!;
          return RefreshIndicator(
            onRefresh: _refreshData,
            color: const Color(0xFF4F46E5),
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: items.length + 1,
              itemBuilder: (context, index) {
                if (index < items.length) {
                  final item = items[index];
                  return Column(
                    children: [
                      Container(
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
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailView(item: item),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: item.imagenPath,
                                    child: Container(
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
                                      categoryLabel(item.etiqueta, context)
                                          .toUpperCase(),
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
                                          itemTitle(item.id, context),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          itemDescription(item.id, context),
                                          style: const TextStyle(fontSize: 16),
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
                      const SizedBox(height: 20),
                    ],
                  );
                } else {
                  // Último widget: botón de pedido y logos
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4F46E5),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CustomModelForm(),
                                ),
                              );
                            },
                            child: Text(
                              t.customFormTitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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
