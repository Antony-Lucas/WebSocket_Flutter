import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final channel =
      IOWebSocketChannel.connect('ws://192.168.1.7:8080/api/v1/users/ws');
  final clientId = Uuid().v4();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebSocket',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('WebSocket Example'),
        ),
        body: StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            return Center(
              child: Text(snapshot.hasData
                  ? '${snapshot.data}'
                  : 'Waiting for data...'),
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
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    dispose();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
