import 'dart:convert';

/*
  // Function to convert octal String to base10 (decimal)

  int octal_to_decimal({String octal}) {

  int number = 0;
  int octalLength = octal.length;

  for (int i = 0; i < octal.length; i++) {
    number += (int.parse(octal[--octalLength]) * math.pow(8, i));
  }

  return number;
}
*/


/*
  Function to extract file name from the Uint8List.
  Since there are 100 bytes for file name most of the List is empty i.e null(0).
*/
String extractName(var nameList) {
  String fileName = '';

  List<int> filteredList = nameList.where((item) => item != 0).toList();

  fileName = utf8.decode(filteredList);
  return fileName;
}



/*
  Function to read the File data(in Uint8List) and extract infomation about,
  different content files in the TAR file.
  Whole file is divided into blocks of 512 bytes. And end of the file is marked
  with atleast two null blocks.

  Header information is as follows :

  offset ||  size  || Description
  ------------------------------
      0       100	    File name
    100	        8     File mode
    108	        8     Owner's numeric user ID
    116	        8	    Group's numeric user ID
    124	       12     File size in bytes (octal base)
    136	       12     Last modification time in numeric Unix time format (octal)
    148	        8     Checksum for header record
    156	        1	    Link indicator (file type)
    157	      100	    Name of linked file
*/
List<Map<String, dynamic>> getFileDetails(var temp, int number_of_blocks) {
  List<Map<String, dynamic>> fileDetails = [];
  int lower = 0;
  int headerBlockNumber = 0;
  Map<String, dynamic> tempFileMap;
  var file_size_decimal;
  String file_name, file_size;

  for (int i=0; i < number_of_blocks; i++) {
    if (i == headerBlockNumber) {

      file_name = extractName(temp.sublist(lower, lower + 100));

      //  Last(12th byte) is null as only 11 octal digits are used for size
      file_size = utf8.decode(temp.sublist(lower + 124, lower + 135));

      // convert the octal(base 8) to decimal(base 10)
      file_size_decimal = int.parse(file_size, radix: 8);

      tempFileMap = {'name': file_name, 'size': file_size_decimal};

      fileDetails.insert(fileDetails.length, tempFileMap);

      if ((headerBlockNumber + (1 + (file_size_decimal / 512).ceil())) <
          number_of_blocks - 2) {
        headerBlockNumber += (1 + (file_size_decimal / 512).ceil());
      }
    }

    lower += 512;
  }

  return fileDetails;
}
