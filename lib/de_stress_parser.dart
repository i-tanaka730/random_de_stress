import 'dart:math' as math;

class DeStressParser {

  List<DeStressResult> _deStressResultList = new List<DeStressResult>();

  void parse(Map<String, dynamic> jsonData) {
      List<dynamic> contents = jsonData["contents"];
      contents.forEach((element) {
        var deStressParserResult = new DeStressResult(element["title"], element["image"]["url"], element["description"]);
        _deStressResultList.add(deStressParserResult);
      });
  }

  DeStressResult getDeStressAtRandom(){
    var random = new math.Random();
    var index = random.nextInt(_deStressResultList.length);
    return _deStressResultList[index];
  }

}

class DeStressResult {

  final String title;
  final String imageUrl;
  final String description;

  DeStressResult(this.title, this.imageUrl, this.description);

}
