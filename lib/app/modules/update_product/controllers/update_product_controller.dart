import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProductController extends GetxController {
  //TODO: Implement UpdateProductController

  late TextEditingController cNama;
  late TextEditingController cNpm;
  late TextEditingController cJk;
  late TextEditingController cProdi;
  late TextEditingController cAlamat;

FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<DocumentSnapshot<Object?>> getData(String id) async{
  DocumentReference docDef = firestore.collection("mahasiswa").doc(id);

  return docDef.get();
}

void updateProduct (String nama, String npm, String jenis_kelamin, String prodi, String alamat, String id) async{
  DocumentReference productByid = firestore.collection("mahasiswa").doc(id);

  try {
    await productByid.update({
      "nama": nama,
      "npm": npm,
      "jk" : jenis_kelamin,
      "program_studi": prodi,
      "alamat": alamat,
    });
     Get.defaultDialog(
      title: "Berhasil",
      middleText: "Berhasil mengubah data product",
      onConfirm: (){
        cNama.clear();
        cNpm.clear();
        cJk.clear();
        cProdi.clear();
        cAlamat.clear();
        Get.back();
        Get.back();
      },
      textConfirm: "OK",
    );
  } catch (e) {
    print(e);
    Get.defaultDialog(
      title: "Terjadi kesalahan",
      middleText: "Gagal Menambahkan Data Product",  
    );
  }
}

@override
void onInit(){
  cNama = TextEditingController();
  cNpm = TextEditingController();
  cJk = TextEditingController();
  cProdi = TextEditingController();
  cAlamat = TextEditingController();
  super.onInit();
}

@override
void onClose(){
  cNama.dispose();
  cNpm.dispose();
  cJk.dispose();
  cProdi.dispose();
  cAlamat.dispose();
  super.onClose();
}

}
