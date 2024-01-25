import 'package:client/routes/home.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WebSocket',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Home());
  }
}

/*class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final channel =
      IOWebSocketChannel.connect('ws://192.168.1.3:8080/api/v1/users/ws');
  final clientId = Uuid().v4();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket'),
      ),
      body: StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          return Center(
            child: Text(
                snapshot.hasData ? '${snapshot.data}' : 'Waiting for data...'),
          );
        },
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
}*/
