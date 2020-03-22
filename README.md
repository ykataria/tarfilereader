# TAR file reader

TAR files are very useful when it comes to backup and packaging multiple file together. Reading(decoding) TAR files and encoding files into tar format are essential functionality for any tar reader package.  

## About This project

This is initial version of project which act as POC for GSoC project `TAR-stream reader package`. It involves reading tar file and decoding different information of contents like name of files, size of files, header size, actual file size and total tar file size. 

### How to run

Using amazing functionality of `dart2native` a executable file `tarinfo.exe` is created for running on windows.  

To run the tarinfo.exe, use following command on cmd or powershell
```
tarinfo.exe "path to tar file"
```

To run the program, clone the repo and run `main.dart` on dart VM.
```
dart main.dart "path to tar file"
```

  

## Author
`Name : Yogesh Kataria`
 
`Email : ykataria118@gmail.com`

`github username : ykataria`
