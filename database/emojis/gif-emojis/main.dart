import 'dart:convert';
import 'dart:io';
import 'dart:math';

void main(List<String> args) async {
  var dir = Directory('_files_');

  var exist = dir.listSync();
  for (var event in exist) {
    var name = event.path.substring(8);
    createJson(name);
  }

  saveFile();
}

Map<String, dynamic> map = {};

bool angryFace(String name) =>
    RegExp(r'(?=.*angry)(?=.*face)', caseSensitive: false).hasMatch(name);

bool heartFace(String name) =>
    RegExp(r'(?=.*heart)(?=.*face)', caseSensitive: false).hasMatch(name);

bool heart(String name) => name.contains('heart');

bool manHair(String name) =>
    RegExp(r'(?=.*hair)(?=.*face)(?=.*beard)(?=.*man)', caseSensitive: false)
        .hasMatch(name);
bool woman(String name) => name.contains('woman');

void createJson(String name) {
  var ext = getExt(name);
  name = name.replaceAll('.$ext', '');
  var firstWord = name.split('-').first;

  Map<String, dynamic> base = {
    "name": '',
    "catagory": 'emoji',
    "keywords": [],
    "extension": ""
  };
  if (angryFace(name)) {
    base['name'] = name;
    base['keywords'] =
        'face,human,person,emoji,angry,anger'.split(',') + [firstWord];
    base['extension'] = ext;
    map.addAll({uniqueString: base});
  } else if (heartFace(name)) {
    base['name'] = name;
    base['keywords'] =
        'face,emoji,human,person,heart,love,like,crush,amazing,lovely'
                .split(',') +
            [firstWord];
    base['extension'] = ext;
    map.addAll({uniqueString: base});
  } else if (heart(name)) {
    base['name'] = name;
    base['keywords'] =
        'emoji,heart,love,like,crush,amazing,lovely'.split(',') + [firstWord];
    base['extension'] = ext;
    map.addAll({uniqueString: base});
  } else if (heart(name)) {
    base['name'] = name;
    base['keywords'] =
        'emoji,heart,love,like,crush,amazing,lovely'.split(',') + [firstWord];
    base['extension'] = ext;
    map.addAll({uniqueString: base});
  } else if (manHair(name)) {
    base['name'] = name;
    base['keywords'] =
        'face,emoji,hair,beard,man,person,male,adult,gentleman,guy'.split(',') +
            [firstWord];
    base['extension'] = ext;
    map.addAll({uniqueString: base});
  } else if (woman(name)) {
    base['name'] = name;
    base['keywords'] =
        'emoji,person,adult,woman,girl,female'.split(',') + [firstWord];
    base['extension'] = ext;
    map.addAll({uniqueString: base});
  } else if (name.contains('man')) {
    base['name'] = name;
    base['keywords'] =
        'emoji,man,person,male,adult,gentleman,guy'.split(',') + [firstWord];
    base['extension'] = ext;
    map.addAll({uniqueString: base});
  } else if (name.contains('man')) {
    base['name'] = name;
    base['keywords'] =
        'emoji,man,person,male,adult,gentleman,guy'.split(',') + [firstWord];
    base['extension'] = ext;
    map.addAll({uniqueString: base});
  } else if (name.contains('baby')) {
    base['name'] = name;
    base['keywords'] = 'face,emoji,baby,angle,cute'.split(',') + [firstWord];
    base['extension'] = ext;
    map.addAll({uniqueString: base});
  } else if (name.contains('face')) {
    base['name'] = name;
    base['keywords'] = 'emoji,face,human,person'.split(',') + [firstWord];
    base['extension'] = ext;
    map.addAll({uniqueString: base});
  } else if (name.contains(RegExp(r'[skin-tone|hand]'))) {
    base['name'] = name;
    base['keywords'] = 'emoji,hands'.split(',') + [firstWord];
    base['extension'] = ext;
    map.addAll({uniqueString: base});
  } else {
    base['name'] = name;
    base['keywords'] = ['emoji'];
    base['extension'] = ext;
    map.addAll({uniqueString: base});
  }
}

String get uniqueString {
  const String chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final Random random = Random();
  final StringBuffer buffer = StringBuffer();

  for (int i = 0; i < 15; i++) {
    buffer.write(chars[random.nextInt(chars.length)]);
  }
  return buffer.toString();
}

String getExt(String name) {
  int state = 0;
  for (int i = name.length - 1; i >= 0; i--) {
    if (name[i] == '.') break;
    state = i;
  }
  return name.substring(state, name.length);
}

saveFile() {
  var dir = Directory.current;
  var file = File('${dir.path}/gif_emojis.json');

  file.writeAsStringSync(jsonEncode(map));
  print('File saved successfully!');
}
