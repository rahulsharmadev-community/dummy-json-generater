import 'dart:convert';
import 'dart:io';

void main(List<String> args) async {
  var file = File('temp.txt');
  Set<String> list = (await file.readAsLines()).toSet();
  Map<String, List<String>> mapfirst = {};
  Map<String, List<String>> maplast = {};

  for (var j = 0; j < list.length; j++) {
    var word = list.elementAt(j).trim().toLowerCase();
    if (word.length > 2) {
      var sWord = word.split(' ').toSet().toList();
      var first = sWord.first.trim();
      var last = sWord.sublist(1).join(' ').trim();

      if (first[0].contains(RegExp(r'[a-zA-Z]')) && first.length < 20)
        mapfirst.update(
            first[0].toUpperCase(), (value) => [...value.toSet(), first],
            ifAbsent: () => [first]);

      if (sWord.length > 1 &&
          last.length > 2 &&
          last[0].contains(RegExp(r'[a-zA-Z]')) &&
          last.length < 20)
        maplast.update(
            last[0].toUpperCase(), (value) => [...value.toSet(), last],
            ifAbsent: () => [last]);

      list.remove(list.elementAt(j));
    }
  }

  await File('mapfirst-${DateTime.now().millisecondsSinceEpoch}.json')
      .writeAsString(jsonEncode(mapfirst));
  await File('mapLast-${DateTime.now().millisecondsSinceEpoch}.json')
      .writeAsString(jsonEncode(maplast));

  print('End');
}
