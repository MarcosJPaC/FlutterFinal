import 'package:flutter/material.dart';
import 'package:flutter_web_api/Venta/add_user.dart';
import 'package:flutter_web_api/Venta//api_handler.dart';
import 'package:flutter_web_api/Venta/edit_page.dart';
import 'package:flutter_web_api/Venta/find_user.dart';
import 'package:flutter_web_api/Venta/model.dart';

class MainPageVenta extends StatefulWidget {
  const MainPageVenta({Key? key}) : super(key: key);

  @override
  State<MainPageVenta> createState() => _MainPageVentaState();
}

class _MainPageVentaState extends State<MainPageVenta> {
  ApiHandler apiHandler = ApiHandler();
  late List<Venta> data = [];

  void getData() async {
    data = await apiHandler.getUserData();
    setState(() {});
  }

  void deleteUser(int userId) async {
    await apiHandler.deleteUser(userId: userId);
    getData();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Venta"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[900], // Cambia el color de fondo a gris oscuro
      bottomNavigationBar: MaterialButton(
        color: Colors.teal,
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: getData,
        child: const Text('Refresh'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 1,
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const FindUser()),
                ),
              );
            },
            child: const Icon(Icons.search),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: 2,
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddUser(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPage(user: data[index]),
                      ),
                    );
                  },
                  leading: Text(
                    "${data[index].idVenta}",
                    style: const TextStyle(color: Colors.white), // Color de texto blanco
                  ),
                  title: Text(
                    data[index].fecha,
                    style: const TextStyle(color: Colors.white), // Color de texto blanco
                  ),
                  subtitle: Text(
                    data[index].total.toString(),
                    style: const TextStyle(color: Colors.white), // Color de texto blanco
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      deleteUser(data[index].idVenta);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}