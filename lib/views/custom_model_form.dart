import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import '../generated/l10n/app_localizations.dart';

class CustomModelForm extends StatefulWidget {
  const CustomModelForm({super.key});

  @override
  State<CustomModelForm> createState() => _CustomModelFormState();
}

class _CustomModelFormState extends State<CustomModelForm> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _email;
  String? _preferredDate;
  String? _finish;
  bool _carefulPackaging = false;
  String? _modelName;
  String? _details;

  void _submit() {
    final formState = _formKey.currentState;
    if (formState?.validate() ?? false) {
      formState!.save();

      final detailsPreview = (_details == null || _details!.trim().isEmpty)
          ? '-'
          : (_details!.length > 160
                ? '${_details!.substring(0, 160)}...'
                : _details!);

      showDialog<bool>(
        context: context,
        builder: (context) {
          final t = AppLocalizations.of(context)!;
          return AlertDialog(
            title: Text(t.confirmButton),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${t.nameField}: ${_name ?? '-'}'),
                  const SizedBox(height: 6),
                  Text('${t.emailField}: ${_email ?? '-'}'),
                  const SizedBox(height: 6),
                  Text('${t.dateField}: ${_preferredDate ?? '-'}'),
                  const SizedBox(height: 6),
                  Text('${t.finishField}: ${_finish ?? '-'}'),
                  const SizedBox(height: 6),
                  Text('${t.productField}: ${_modelName ?? '-'}'),
                  const SizedBox(height: 8),
                  Text('${t.detailsField}:'),
                  const SizedBox(height: 4),
                  Text(detailsPreview),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(t.cancelButton),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(
                  t.confirmButton,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      ).then((confirmed) {
        if (confirmed ?? false) {
          final t = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: const Color(0xFF4F46E5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      t.requestSent,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              duration: const Duration(seconds: 3),
            ),
          );
          dev.log(
            'Solicitud -> name: $_name, email: $_email, date: $_preferredDate, finish: $_finish, carefulPackaging: $_carefulPackaging, model: $_modelName, details: $_details',
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.customFormTitle,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF4F46E5),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Nombre
              TextFormField(
                decoration: InputDecoration(
                  labelText: t.nameField,
                  border: const OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return t.formNameRequired;
                  final parts = v.trim().split(RegExp(r"\s+"));
                  if (parts.length < 2) return t.formNameInvalid;
                  if (parts.last.length < 2) return t.formNameInvalid;
                  return null;
                },
                onSaved: (v) => _name = v?.trim(),
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: t.emailField,
                  border: const OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return t.formEmailRequired;
                  final emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
                  if (!emailRegex.hasMatch(v.trim())) return t.formEmailInvalid;
                  return null;
                },
                onSaved: (v) => _email = v?.trim(),
              ),
              const SizedBox(height: 16),

              // Fecha
              GestureDetector(
                onTap: () async {
                  final now = DateTime.now();
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: now,
                    lastDate: DateTime(now.year + 2),
                    locale: Localizations.localeOf(context), // Cambia idioma automáticamente
                  );
                  if (picked != null) {
                    setState(() {
                      _preferredDate =
                          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: t.dateField,
                      hintText: 'YYYY-MM-DD',
                      border: const OutlineInputBorder(),
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    controller: TextEditingController(text: _preferredDate ?? ''),
                    onSaved: (v) => _preferredDate = v?.trim(),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Dropdown de acabados
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: t.finishField,
                  border: const OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(value: 'Mate', child: Text(t.finishMate)),
                  DropdownMenuItem(value: 'Brillante', child: Text(t.finishBrillante)),
                  DropdownMenuItem(value: 'Apto para pintura', child: Text(t.finishAptoParaPintura)),
                  DropdownMenuItem(value: 'Suave al tacto', child: Text(t.finishSuaveAlTacto)),
                  DropdownMenuItem(value: 'Texturizado', child: Text(t.finishTexturizado)),
                  DropdownMenuItem(value: 'Pulido', child: Text(t.finishPulido)),
                  DropdownMenuItem(value: 'Resistente UV', child: Text(t.finishResistenteUV)),
                ],
                onChanged: (v) => setState(() => _finish = v),
                validator: (v) {
                  if (v == null || v.isEmpty) return t.formFinishRequired;
                  return null;
                },
                onSaved: (v) => _finish = v,
              ),
              const SizedBox(height: 16),

              // Producto
              TextFormField(
                decoration: InputDecoration(
                  labelText: t.productField,
                  border: const OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return t.formProductRequired;
                  return null;
                },
                onSaved: (v) => _modelName = v?.trim(),
              ),
              const SizedBox(height: 16),

              // Detalles
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: t.detailsField,
                  border: const OutlineInputBorder(),
                ),
                onSaved: (v) => _details = v?.trim(),
                onChanged: (v) => dev.log('Detalle: $v'),
              ),
              const SizedBox(height: 8),

              // Checkbox empaquetado
              CheckboxListTile(
                title: Text(t.carefulPackaging),
                value: _carefulPackaging,
                onChanged: (v) => setState(() => _carefulPackaging = v ?? false),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 24),

              // Botón enviar
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _submit,
                child: Text(
                  t.submitButton,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
