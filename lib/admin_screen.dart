import 'package:flutter/material.dart';
import 'database_helper.dart';

class AdminScreen extends StatefulWidget {
  final bool isKZ;
  const AdminScreen({super.key, required this.isKZ});
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isKZ ? "Басқару" : "Управление")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DBHelper().getRooms(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final rooms = snapshot.data!;
          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (c, i) {
              final r = rooms[i];
              bool isFree = r['status'] == 'Свободен';
              return ListTile(
                leading: CircleAvatar(backgroundColor: isFree ? Colors.green : Colors.red, child: Text(r['id'], style: const TextStyle(color: Colors.white))),
                title: Text("${r['type']} - ${widget.isKZ && isFree ? "Бос" : r['status']}"),
                subtitle: Text(r['guest'].isEmpty ? "" : "${widget.isKZ ? "Қонақ" : "Гость"}: ${r['guest']}"),
                trailing: const Icon(Icons.refresh),
                onTap: () async {
                  await DBHelper().resetRoom(r['id']);
                  setState(() {});
                },
              );
            },
          );
        },
      ),
    );
  }
}