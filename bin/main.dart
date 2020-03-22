import 'dart:io';
import 'package:tarReader/tarReader.dart' as tar;

void main(List<String> arguments) {
  double totalSize = 0;

  if (arguments.isEmpty) {
    print('provide full path of TAR file');
  } else if (arguments.length != 1) {
    print('provide valid arguments');
  } else {

    if (arguments[0].contains('.tar')) {

      try {
        // Read file as bytes, in TAR content is stored in octal form
        final file = File(arguments[0]);
        var fileBytes = file.readAsBytesSync();

        num number_of_blocks;

        List<Map<String, dynamic>> fileDetails;

        number_of_blocks = (fileBytes.length) / 512;
        print('Number of blocks : ${number_of_blocks.toInt()}');
        print(
            'Total size : ${fileBytes.length} Bytes or ${(fileBytes.length) / 1024} KB\n');

        fileDetails = tar.getFileDetails(fileBytes, number_of_blocks.toInt());

        for (var item in fileDetails) {
          print("File name : ${item['name']}  ------>  File size : ${item['size']/1024} KB");
          totalSize += item['size']/1024;
        }

        print('\nActual File content size: $totalSize KB');
        print('Header size : ${((fileBytes.length) / 1024) - totalSize} KB');

      } catch (e) {
        print('Exception : $e');
      }
    } else {
      print('provide path to .tar file only');
    }
  }
}
