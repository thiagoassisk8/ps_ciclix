import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          title: 'Flutter Challenge',
          channel: IOWebSocketChannel.connect(
              'wss://ps-1-fmfnvf266a-rj.a.run.app/ws')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final WebSocketChannel channel;

  MyHomePage({Key key, this.title, @required this.channel}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Desafio Ciclix",
            textScaleFactor: 1.1,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(child: TextFormField()),
              StreamBuilder(
                  stream: widget.channel.stream,
                  builder: (context, snapshot) {
                    return Container(
                        child: Text(
                      '${snapshot.data}',
                      style: TextStyle(fontSize: 20.0),
                    ));
                  }),
            ],
          )),
    );
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}
