import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  final channel =
      IOWebSocketChannel.connect('ws://192.168.43.17:8080/api/v1/users/ws');
  final clientId = Uuid().v4();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                return Center(
                  child: Text(snapshot.hasData
                      ? '${snapshot.data}'
                      : 'Waiting for data...'),
                );
              },
            ),
            Row(
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    channel.sink.add(":)");
                  },
                  style: TextButton.styleFrom(
                      side: BorderSide(color: Colors.black),
                      fixedSize: Size(50, 50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ':)',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    channel.sink.add(":(");
                  },
                  style: TextButton.styleFrom(
                      side: BorderSide(color: Colors.black),
                      fixedSize: Size(50, 50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ':(',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Enviar mensagem para todos os dispositivos conectados
          channel.sink.add('Mensagem do Flutter para todos os dispositivos');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
