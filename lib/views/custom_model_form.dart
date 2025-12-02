import 'package:flutter/material.dart';
import 'dart:developer' as dev;

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
          return AlertDialog(
            title: const Text('Confirmar solicitud'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nombre: ${_name ?? '-'}'),
                  const SizedBox(height: 6),
                  Text('Correo: ${_email ?? '-'}'),
                  const SizedBox(height: 6),
                  Text('Fecha entrega: ${_preferredDate ?? '-'}'),
                  const SizedBox(height: 6),
                  Text('Acabado: ${_finish ?? '-'}'),
                  const SizedBox(height: 6),
                  Text('Producto: ${_modelName ?? '-'}'),
                  const SizedBox(height: 8),
                  const Text('Detalles:'),
                  const SizedBox(height: 4),
                  Text(detailsPreview),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text(
                  'Confirmar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      ).then((confirmed) {
        if (confirmed ?? false) {
          final message = 'Solicitud enviada';
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
                      message,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pedido personalizado',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nombre y apellidos',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty)
                    return 'Introduce nombre y apellidos';
                  final parts = v.trim().split(RegExp(r"\s+"));
                  if (parts.length < 2) return 'Introduce al menos un apellido';
                  // Asegurar que el apellido tiene más de una letra
                  if (parts.last.length < 2)
                    return 'Introduce un apellido válido';
                  return null;
                },
                onSaved: (v) => _name = v?.trim(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty)
                    return 'Introduce un correo';
                  final emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
                  if (!emailRegex.hasMatch(v.trim())) return 'Correo no válido';
                  return null;
                },
                onSaved: (v) => _email = v?.trim(),
              ),
              const SizedBox(height: 16),
              // Fecha con DatePicker
              GestureDetector(
                onTap: () async {
                  final now = DateTime.now();
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: now,
                    lastDate: DateTime(now.year + 2),
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
                      labelText: 'Fecha de entrega deseada (opcional)',
                      hintText: 'YYYY-MM-DD',
                      border: const OutlineInputBorder(),
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    controller: TextEditingController(
                      text: _preferredDate ?? '',
                    ),
                    onSaved: (v) => _preferredDate = v?.trim(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              //Widget de dropdown para acabado de impresión
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Acabado de impresión',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Mate', child: Text('Mate')),
                  DropdownMenuItem(
                    value: 'Brillante',
                    child: Text('Brillante'),
                  ),
                  DropdownMenuItem(
                    value: 'Apto para pintura',
                    child: Text('Apto para pintura'),
                  ),
                  DropdownMenuItem(
                    value: 'Suave al tacto',
                    child: Text('Suave al tacto'),
                  ),
                  DropdownMenuItem(
                    value: 'Texturizado',
                    child: Text('Texturizado'),
                  ),
                  DropdownMenuItem(value: 'Pulido', child: Text('Pulido')),
                  DropdownMenuItem(
                    value: 'Resistente UV',
                    child: Text('Resistente UV'),
                  ),
                ],
                onChanged: (v) => setState(() => _finish = v),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Selecciona un acabado';
                  return null;
                },
                onSaved: (v) => _finish = v,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Producto que deseas',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty)
                    return 'Describe el producto deseado';
                  return null;
                },
                onSaved: (v) => _modelName = v?.trim(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Detalles / notas adicionales',
                  border: OutlineInputBorder(),
                ),
                onSaved: (v) => _details = v?.trim(),
                onChanged: (v) => dev.log('Detalle: $v'),
              ),
              const SizedBox(height: 8),
              // Checkbox para empaquetado cuidado
              CheckboxListTile(
                title: const Text('Empaquetado cuidado'),
                subtitle: const Text(
                  'Marcar si necesita empaquetado extra para proteger la pieza',
                ),
                value: _carefulPackaging,
                onChanged: (v) =>
                    setState(() => _carefulPackaging = v ?? false),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 24),
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
                child: const Text(
                  'Enviar solicitud',
                  style: TextStyle(
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
