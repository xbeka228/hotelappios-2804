import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'database_helper.dart';

class BookingScreen extends StatefulWidget {
  final String roomTitle, roomPrice;
  final bool isKZ;
  const BookingScreen({super.key, required this.roomTitle, required this.roomPrice, required this.isKZ});
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _f = TextEditingController();
  final _i = TextEditingController();
  final _p = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isKZ ? "Мәліметтер" : "Данные")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          TextField(controller: _f, decoration: InputDecoration(labelText: widget.isKZ ? "Тегі" : "Фамилия")),
          TextField(controller: _i, decoration: InputDecoration(labelText: widget.isKZ ? "Аты" : "Имя")),
          TextField(
            controller: _p,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(11)],
            decoration: const InputDecoration(labelText: "87071234567"),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () async {
              if (_f.text.isNotEmpty && _p.text.length == 11) {
                String res = await DBHelper().bookRoom(widget.roomTitle, "${_f.text} ${_i.text}");
                if (res != "Full") _showTicket(res);
              }
            },
            child: Text(widget.isKZ ? "Растау" : "Подтвердить"),
          )
        ]),
      ),
    );
  }

  void _showTicket(String roomNo) {
    showModalBottomSheet(context: context, builder: (c) => Container(
      padding: const EdgeInsets.all(30),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 60),
        Text(widget.isKZ ? "Нөмір: $roomNo" : "Комната: $roomNo", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text("${_f.text} ${_i.text}"),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () => Navigator.popUntil(context, (r) => r.isFirst), child: const Text("OK"))
      ]),
    ));
  }
}