import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProductController extends GetxController {
  //TODO: Implement UpdateProductController

  late TextEditingController cNama;
  late TextEditingController cHarga;

FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<DocumentSnapshot<Object?>> getData(String id) async{
  DocumentReference docDef = firestore.collection("products").doc(id);

  return docDef.get();
}

void updateProduct (String nama, String harga, String id) async{
  DocumentReference productByid = firestore.collection("products").doc(id);

  try {
    await productByid.update({
      "name": nama,
      "price": harga,
    });
     Get.defaultDialog(
      title: "Berhasil",
      middleText: "Berhasil mengubah data product",
      onConfirm: (){
        cNama.clear();
        cHarga.clear();
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
  cHarga = TextEditingController();
  super.onInit();
}

@override
void onClose(){
  cNama.dispose();
  cHarga.dispose();
  super.onClose();
}

}
