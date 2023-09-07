import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

class AuthController extends GetxController {
 FirebaseAuth auth = FirebaseAuth.instance;

 Stream<User?> get streamAuthStatus => auth.authStateChanges();

 void signup(String emailAddress, String password) async{
  try {
  UserCredential myUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailAddress,
    password: password,
  );
  await myUser.user!.sendEmailVerification();
  Get.defaultDialog(
    title: "Verifikasi Email",
    middleText: "Kami telah mengirimkan verifikasi ke email $emailAddress",
    onConfirm: (){
      Get.back();
      Get.back();
    }
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
 }

 void login(String emailAddress, String password) async{
  try {
  UserCredential myUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailAddress,
    password: password
  );
  if (myUser.user!.emailVerified){
    Get.offAllNamed(Routes.HOME);
  } else {
    Get.defaultDialog(
      title: "Verifikasi email",
      middleText: "Harap verifikasi email anda terlebih dahulu",
    );
  }
  
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    Get.defaultDialog(
        title: "Terjadi Kesalahan!",
        middleText: "Email Belum terdaftar",
    );
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    Get.defaultDialog(
        title: "Terjadi Kesalahan!",
        middleText: "Password yang anda masukkan salah",
    );
    print('Wrong password provided for that user.');
  }
}
 }

 void logout() async{
  await auth.signOut();
  Get.offAllNamed(Routes.LOGIN);
 }

 void resetPassword(String email) async{
  if(email != "" && GetUtils.isEmail(email)){
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Kami telah mengirimkan reset password ke $email ",
        onConfirm: () {
          Get.back();
          Get.back();
        },
        textConfirm: "OK",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan!",
        middleText: "Tidak dapat melakukan reset password! Periksa kembali email anda!",
    );
    }
  } else {
    Get.defaultDialog(
      title: "Terjadi Kesalahan!",
      middleText: "Email tidak valid",
    );
  }
 }
}
