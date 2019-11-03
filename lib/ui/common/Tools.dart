import 'package:YAHNC/model/Story.dart';

class Tools {
  static List<List<int>> generatePages(List<int> data, int chunkSize) {
    int pages = (data.length / chunkSize).round();
    int pageStep = chunkSize - 1;
    int start = 0;
    int end = pageStep;
    List<List<int>> result = [];
    for(var i = 1; i <= pages; i++ ) {
      result.add(data.sublist(start,end));
      start = end + 1;
      end = start + pageStep;
      if(end >= data.length) {
        end = data.length - 1;
      }
    }
    return result;
  }
}
