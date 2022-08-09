import 'package:http/http.dart' as http;
import 'package:orange_valley_caa/models/video.dart';
import 'package:orange_valley_caa/utils/helper.dart';

Future<List<Video>> getVideoFromApi({VideoSort filter = VideoSort.id}) async {
  final url = Uri.http(
      "orangevalleycaa.org", 'api/videos/order/${filter.filterName()}');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var json = response.body;
    return videoFromJson(json);
  } else {
    return [];
  }
}
