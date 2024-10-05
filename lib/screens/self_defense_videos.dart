import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mpempe3/screens/landing_page.dart';

class SelfDefenseVideos extends StatelessWidget {
  final List<Map<String, String>> adultVideos = [
    {
      'title': 'Self Defense for Adults 1',
      'url': 'https://m.youtube.com/watch?v=M4_8PoRQP8w',
    },
    {
      'title': 'Self Defense for Adults 2',
      'url': 'https://m.youtube.com/watch?v=HG1XiQgss9s',
    },
    {
      'title': 'Self Defense for Adults 3',
      'url': 'https://m.youtube.com/watch?v=CKaa19kpqzM',
    },
  ];

  final List<Map<String, String>> childrenVideos = [
    {
      'title': 'Self Defense for Children 1',
      'url': 'https://m.youtube.com/watch?v=kmQe29r6PE0',
    },
    {
      'title': 'Self Defense for Children 2',
      'url': 'https://m.youtube.com/watch?v=LWYGfdrV_fY&pp=ygUPI3NlbGZkZWZlbnNla2lk',
    },
    {
      'title': 'Self Defense for Children 3',
      'url': 'https://m.youtube.com/watch?v=DbkjbGRhjeI',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => LandingPage()),
              );
            },
            child: Container(height: 50, width: 50, child: Icon(CupertinoIcons.back))),
        title: Text(
          'Impempe Self Defense',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Adults',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...adultVideos.map((video) => VideoThumbnail(
                    title: video['title']!,
                    url: video['url']!,
                  )),
              const SizedBox(height: 32),
              Text(
                'Children',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...childrenVideos.map((video) => VideoThumbnail(
                    title: video['title']!,
                    url: video['url']!,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoThumbnail extends StatelessWidget {
  final String title;
  final String url;

  const VideoThumbnail({Key? key, required this.title, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(title),
        trailing: Icon(Icons.play_arrow),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoPlayerScreen(videoUrl: url),
            ),
          );
        },
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late InAppWebViewController _webViewController;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          'Playing Video',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri(widget.videoUrl),
              headers: {'Example-Header': 'Example-Value'},
            ),
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                _isLoading = true;
              });
            },
            onLoadStop: (controller, url) {
              setState(() {
                _isLoading = false;
              });
            },
            onLoadError: (controller, url, code, message) {
              // Handle load errors appropriately
              print("Load Error: $message");
              // Consider showing an error message to the user
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error loading video: $message')),
              );
            },
            onProgressChanged: (controller, progress) {
              // Optionally update a progress indicator
              print("Loading progress: $progress%");
            },
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
