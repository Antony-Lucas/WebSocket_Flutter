import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final _router = Router()..get('/api/v1/users/ws', _wsHandler);

final connectedClients = <String, WebSocketChannel>{};

Handler _wsHandler = webSocketHandler((WebSocketChannel webSocket) {
  final clientId = Uuid().v4();
  print('Novo cliente conectado $clientId');

  connectedClients[clientId] = webSocket;

  webSocket.stream.listen((message) {
    print('mensagem do cliente $clientId: $message');

    for (var client in connectedClients.values) {
      client.sink.add('Recebido no servidor pelo cliente $clientId: $message');
    }
  });

  webSocket.sink.done.then((_) {
    connectedClients.remove(clientId);
    print('Cliente desconectado: $clientId');
  });
});

void main(List<String> args) async {
  final ip = InternetAddress.anyIPv4;

  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  print(ip);
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
