import 'package:flutter/material.dart';
import 'details_screen.dart';

class CatalogScreen extends StatelessWidget {
  final bool isKZ;
  const CatalogScreen({super.key, required this.isKZ});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isKZ ? "Таңдау" : "Каталог")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _card(context, "Standard", "15 000 ₸", "assets/images/room1.jpg"),
          _card(context, "Comfort", "25 000 ₸", "assets/images/room2.jpg"),
          _card(context, "Luxe", "45 000 ₸", "assets/images/room3.jpg"),
        ],
      ),
    );
  }

  Widget _card(context, name, price, img) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => DetailsScreen(title: name, price: price, img: img, isKZ: isKZ))),
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(children: [
          Hero(tag: img, child: Image.asset(img, height: 200, width: double.infinity, fit: BoxFit.cover)),
          ListTile(title: Text(name), subtitle: Text(price, style: const TextStyle(color: Colors.blue))),
        ]),
      ),
    );
  }
}