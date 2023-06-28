
import 'dart:io';
import 'dart:convert';

void main() {
  _run();
}

//Reading a tsv - Tab separated value files, to create dynamic json like .arb language files
_run() async {
  final exportPath = 'assets/l10n';
  final tsvFilesLocation = 'gen/tsv_files';

  const separator = '	'; // this is a tab, not space

  //Column indexes in Excel sheets
  const keyIndex = 0;
  const enIndex = 1;
  const npIndex = 2;

  //supported languages in app
  const langs = [
    _LangInfo(localeName: 'en', index: enIndex),
    _LangInfo(localeName: 'ne', index: npIndex),
  ];

  List<FileSystemEntity> allFiles =
      await Directory(tsvFilesLocation).list().toList();

  if (allFiles.isEmpty) {
    print('No exported tsv file found in $tsvFilesLocation');
    return;
  }

  Map<_LangInfo, Map<String, dynamic>> outputObject = {};

  langs.forEach((l) {
    outputObject[l] = {};
  });

  //Looping through all files in the directory
  Future.forEach(allFiles, (FileSystemEntity element) async {
    final file = File(element.path);

    var lines = file.readAsStringSync().split('\n');

    for (var mapEntry in outputObject.entries) {
      var lang = mapEntry.key;
      for (var i = 0; i < lines.length; i++) {
        if (i == 0) continue; //skipping table header title
        if (!lines[i].contains(separator))
          continue; //skipping lines who dont have tab sperated values

        var column = lines[i].split(separator);

        if (column.length < 3) continue;
        try {
          var key = column[keyIndex].trim().toLowerCase();
          if (key.isEmpty) continue;
          var val = column[lang.index].trim();

          ///if language text is empty, use English as default
          if (val.isEmpty) {
            val = column[enIndex].trim();
          }
          outputObject[lang]?[key] = val;
        } catch (e) {
          print(e);
        }
      }
    }
    outputObject.forEach((k, v) {
      File('$exportPath/${k.localeName}.json')
          .writeAsStringSync(json.encode(v).replaceAll('","', '",\n"'));
    });
  });
}

class _LangInfo {
  final String localeName;
  final int index;

  const _LangInfo({required this.localeName, required this.index});
  @override
  String toString() {
    return localeName;
  }
}
