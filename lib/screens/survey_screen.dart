import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:momentum/api/service/survey/list_survey_service.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
late WebViewController _controller;
  String? _url;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false; 
            });
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    _loadSurveyLink();
  }

  Future<void> _loadSurveyLink() async {
    String link = await getSurveyLink();
    if (link.isNotEmpty) {
      setState(() {
        _url = link;
        _controller.loadRequest(Uri.parse(_url!));
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<String> getSurveyLink() async {
    ListSurveyService listSurveyService = ListSurveyService();
    Response surveyResponse = await listSurveyService.listSurveys();
    if (surveyResponse.statusCode == 200) {
      var surveyResponseBody = jsonDecode(surveyResponse.body);
      if (surveyResponseBody.isNotEmpty) {
        var latestSurvey = surveyResponseBody.last;
        return latestSurvey['link'];
      }
    }
    return '';
  }

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF371B34)),
          onPressed: () {
            Navigator.pushNamed(context, '/dashboard');
          },
        ),
        title: const Text(
          'Survey',
          style: TextStyle(
            color: Color(0xFF371B34),
          ),
        ),
      ),
        body: Stack(
        children: [
          if (_url != null)
            WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()), // Show loader while fetching
        ],
      ),
    );
  }
}
