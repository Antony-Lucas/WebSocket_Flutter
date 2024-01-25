import 'package:client/routes/professional.dart';
import 'package:client/routes/user.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Escolha uma tela"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Professional()));
              },
              style: TextButton.styleFrom(
                  side: BorderSide(color: Colors.black),
                  fixedSize: Size(350, 50)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tela do profissional',
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(Icons.chevron_right, color: Colors.black),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => User()));
              },
              style: TextButton.styleFrom(
                  side: BorderSide(color: Colors.black),
                  fixedSize: Size(350, 50)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tela do usuário',
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(Icons.chevron_right, color: Colors.black),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
