import 'package:flutter/material.dart';
import 'list_view.dart';
import '../generated/l10n/app_localizations.dart';

class MainView extends StatelessWidget {
  final void Function(Locale) onLocaleChange;
  const MainView({super.key, required this.onLocaleChange});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          t.appTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF4F46E5),
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: t.appTitle,
            onPressed: () => _showLanguageDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: const Color(0xFFEDE9FE),
            child: Text(
              t.welcomeMessage,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    t.loginTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4F46E5),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: t.username,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: t.password,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ListViewPage()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 30,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        t.enterButton,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.appTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('English'),
              onTap: () {
                onLocaleChange(const Locale('en'));
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('Español'),
              onTap: () {
                onLocaleChange(const Locale('es'));
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('Français'),
              onTap: () {
                onLocaleChange(const Locale('fr'));
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('Deutsch'),
              onTap: () {
                onLocaleChange(const Locale('de'));
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }
}
