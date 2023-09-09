import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  //TODO: Implement AddProductController

  late TextEditingController cNama;
  late TextEditingController cNpm;
  late TextEditingController cJk;
  late TextEditingController cProdi;
  late TextEditingController cAlamat;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addProduct(String nama, String npm, String jenis_kelamin, String prodi, String alamat) async {
    CollectionReference product = firestore.collection("mahasiswa");

    try{
      await product.add({
        "nama": nama,
        "npm": npm,
        "jk" : jenis_kelamin,
        "program_studi": prodi,
        "alamat": alamat,

      });
      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil menyimpan data produk",
        onConfirm: () {
          cNama.clear();
          cNpm.clear();
          cJk.clear();
          cProdi.clear();
          cAlamat.clear();
          Get.back();
          Get.back();
          textConfirm: "OK";
        },
      );
    }catch(e){

    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    cNama = TextEditingController();
    cNpm = TextEditingController();
    cJk = TextEditingController();
    cProdi = TextEditingController();
    cAlamat = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    cNama.dispose();
    cNpm.dispose();
    cJk.dispose();
    cProdi.dispose();
    cAlamat.dispose();
    super.onClose();
  }

  }

