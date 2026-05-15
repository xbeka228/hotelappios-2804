import 'package:flutter/material.dart';
import 'booking_screen.dart';

class DetailsScreen extends StatelessWidget {
  final String title, price, img;
  final bool isKZ;
  const DetailsScreen({super.key, required this.title, required this.price, required this.img, required this.isKZ});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(children: [
        Hero(tag: img, child: Image.asset(img, height: 300, width: double.infinity, fit: BoxFit.cover)),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(price, style: const TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(isKZ ? "• Тегін Wi-Fi\n• Кондиционер" : "• Бесплатный Wi-Fi\n• Кондиционер", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => BookingScreen(roomTitle: title, roomPrice: price, isKZ: isKZ))),
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 60), backgroundColor: Colors.black, foregroundColor: Colors.white),
              child: Text(isKZ ? "Брондау" : "Забронировать"),
            )
          ]),
        )
      ]),
    );
  }
}