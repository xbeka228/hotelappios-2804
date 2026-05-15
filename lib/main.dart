import 'package:flutter/material.dart';
import 'catalog_screen.dart';
import 'admin_screen.dart';

void main() => runApp(const HotelApp());

class HotelApp extends StatefulWidget {
  const HotelApp({super.key});
  @override
  State<HotelApp> createState() => _HotelAppState();
}

class _HotelAppState extends State<HotelApp> {
  bool isKZ = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, 
        colorSchemeSeed: Colors.blue,
      ),
      home: RoleSelectionScreen(
        isKZ: isKZ, 
        onLangChange: () => setState(() => isKZ = !isKZ),
      ),
    );
  }
}

class RoleSelectionScreen extends StatelessWidget {
  final bool isKZ;
  final VoidCallback onLangChange;

  const RoleSelectionScreen({
    super.key, 
    required this.isKZ, 
    required this.onLangChange
  });

  // Функция для окна входа
  void _showLoginDialog(BuildContext context) {
    final userController = TextEditingController();
    final passController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isKZ ? "Жүйеге кіру" : "Вход в систему"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: userController, 
              decoration: const InputDecoration(labelText: "Login"),
            ),
            TextField(
              controller: passController, 
              obscureText: true, 
              decoration: const InputDecoration(labelText: "Password"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isKZ ? "Бас тарту" : "Отмена"),
          ),
          ElevatedButton(
            onPressed: () {
              // ПРОВЕРКА ЛОГИНА И ПАРОЛЯ
              if (userController.text == 'admin' && passController.text == '123') {
                Navigator.pop(context); // Закрыть диалог
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (c) => AdminScreen(isKZ: isKZ)),
                );
              } else {
                // Если пароль неверный
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(isKZ ? "Қате логин немесе пароль!" : "Неверный логин или пароль!")),
                );
              }
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: onLangChange, 
            child: Text(isKZ ? "RU" : "KZ", style: const TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("🏨", style: TextStyle(fontSize: 80)),
              const SizedBox(height: 10),
              Text(
                isKZ ? "Қонақ үй жүйесі" : "Система Отеля", 
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              _btn(context, isKZ ? "Қонақ" : "Гость", Colors.blue, () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (c) => CatalogScreen(isKZ: isKZ)),
                );
              }),
              const SizedBox(height: 16),
              _btn(context, isKZ ? "Қызметкер" : "Сотрудник", Colors.black87, () {
                _showLoginDialog(context); // Теперь вызываем диалог
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _btn(BuildContext context, String txt, Color col, VoidCallback on) => ElevatedButton(
    onPressed: on, 
    style: ElevatedButton.styleFrom(
      backgroundColor: col, 
      foregroundColor: Colors.white, 
      minimumSize: const Size(double.infinity, 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ), 
    child: Text(txt, style: const TextStyle(fontSize: 18)),
  );
}