import 'package:flutter/material.dart';
import 'package:orange_valley_caa/services/video_api.dart';
import 'package:orange_valley_caa/utils/constants.dart';
import 'package:orange_valley_caa/utils/helper.dart';
import 'package:orange_valley_caa/widgets/video_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedFilter = VideoSort.id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orange Valley CAA'),
        backgroundColor: Colors.black,
        actions: [
          PopupMenuButton(
            onSelected: _onChangeFilter,
            icon: const Icon(Icons.sort),
            offset: const Offset(0, 100),
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: VideoSort.id, child: Text('Par défaut')),
              const PopupMenuItem(
                  value: VideoSort.name, child: Text('Par nom')),
              const PopupMenuItem(
                  value: VideoSort.duration, child: Text('Par durée')),
            ],
          ),
        ],
      ),
      body: Container(
        color: backgroundColor,
        child: FutureBuilder(
            future: getVideoFromApi(filter: _selectedFilter),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return VideosGrid(videos: snapshot.data);
              }
            }),
      ),
    );
  }

  void _onChangeFilter(VideoSort choice) {
    if (choice != _selectedFilter) {
      setState(() {
        _selectedFilter = choice;
      });
    }
  }
}
