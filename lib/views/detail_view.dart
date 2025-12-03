import 'package:flutter/material.dart';
import '../models/item.dart';
import '../generated/l10n/app_localizations.dart';

class DetailView extends StatelessWidget {
  final Item item;

  const DetailView({super.key, required this.item});

  // Función helper para traducir etiquetas
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

  // Función helper para traducir título según id del item
  String itemTitle(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    switch (item.id) {
      case '1':
        return t.item1Title;
      case '2':
        return t.item2Title;
      case '3':
        return t.item3Title;
      case '4':
        return t.item4Title;
      default:
        return item.titulo;
    }
  }

  // Función helper para traducir descripción según id del item
  String itemDescription(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    switch (item.id) {
      case '1':
        return t.item1Description;
      case '2':
        return t.item2Description;
      case '3':
        return t.item3Description;
      case '4':
        return t.item4Description;
      default:
        return item.descripcion;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F46E5),
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.white, size: 32),
        title: Text(
          itemTitle(context),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: item.imagenPath,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(item.imagenPath, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              itemTitle(context),
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              itemDescription(context),
              style: const TextStyle(fontSize: 18, height: 1.4),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                categoryLabel(item.etiqueta, context),
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4F46E5),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
