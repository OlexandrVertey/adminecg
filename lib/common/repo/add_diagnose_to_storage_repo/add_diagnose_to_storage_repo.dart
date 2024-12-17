import 'package:adminecg/common/firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class AddDiagnoseToStorageRepo {
  const AddDiagnoseToStorageRepo({required this.diagnoseStorage});

  final DiagnoseStorage diagnoseStorage;

  ///TODO: need user from provider or Page :)
  // void addDiagnoseToStorage() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //     allowMultiple: false,
  //   );
  //
  //   if (result != null && result.files.isNotEmpty) {
  //     String fileName = result.files.first.name;
  //     Uint8List data = result.files.first.bytes!;
  //     await addDiagnoseToStorageRepo.addDiagnose(
  //       name: fileName,
  //       data: data,
  //       callBack: (_) {
  //         print('---addDiagnoseToStorage provider callBack = ${_}');
  //       },
  //     );
  //   } else {
  //     print('---addDiagnoseToStorage provider else');
  //   }
  // }

  Future<void> addDiagnose({
    String? name,
    String? path,
    required Function(String) callBack,
    required Uint8List data,
  }) async {
    if (name != null && name.isNotEmpty) {
      final uploadTask = diagnoseStorage.storageReference.child('diagnose').child(name).putData(data);

      await Future(() => uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
            switch (taskSnapshot.state) {
              case TaskState.running:
                final progress = 100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
                print("Upload is $progress% complete.");
                break;
              case TaskState.paused:
                print("Upload is paused.");
                callBack('');
              case TaskState.canceled:
                print("Upload was canceled");
                callBack('');
              case TaskState.error:
                print("Error");
                callBack('');
              case TaskState.success:
                String imageUrl = await diagnoseStorage.storageReference.child("diagnose").child(name).getDownloadURL();
                print('---addDiagnose Repo callBack = ${imageUrl}');
                callBack(imageUrl);
            }
          }));
    } else {
      callBack('');
    }
    callBack('');
  }
}
