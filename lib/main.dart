import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';  // Para decodificar JSON
import './ProductCard.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Lojas Cavalcanti & Souza'),
    );
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
  List<dynamic> _produtos = [];

@override
void initState() {
  super.initState();
  fazerRequisicao(); // Chama a função de requisição GET
}
Future<void> fazerRequisicao() async {
  final url = 'https://dummyjson.com/products'; // Substitua pela sua URL

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Se a requisição for bem-sucedida, decodifique o JSON
      final dados = json.decode(response.body);
      setState((){
        _produtos = dados["products"];
      });
    } else {
      // Se a requisição falhar, lance uma exceção
      throw Exception('Falha ao carregar dados: ${response.statusCode}');
    }
  } catch (e) {
    print('Erro: $e');
  }
}



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            const Text('Produtos:'),
            Expanded(
              child: ListView.builder(
                itemCount: _produtos.length,
                itemBuilder: (context, index) {
                  // Instanciando o nome de cada produto
                  return ProductCard(
                    imageUrl: _produtos[index]['thumbnail'], // Substitua pela URL real
            productName: _produtos[index]['title'],
            price: _produtos[index]['price'],
            description: _produtos[index]['description']
            );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

