import 'package:flutter/material.dart';

class Meditate extends StatelessWidget {
  const Meditate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/breathe.gif',
          width: 700,
          height: 700,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
/*import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Meditate extends StatefulWidget {
  const Meditate({super.key});

  @override
  State<Meditate> createState() => _MeditateState();
}

class _MeditateState extends State<Meditate> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://xhalr.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meditation")),
      body: WebViewWidget(controller: _controller),
    );
  }
}*/
