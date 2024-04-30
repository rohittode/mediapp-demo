import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/controlers/password_validator.dart';
// import 'package:mediapp/controllers/password_validator.dart';

class AuthController extends GetxController {
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  UserCredential? userCredential;

  signupUser() async {
    // Validate the password
    String password = passwordController.text;
    if (!PasswordValidator.validatePassword(password)) {
      // Handle invalid password (e.g., display error message)
      print(
          'Invalid password. Password should contain at least 1 special character, numbers, 1 capital, and 1 lowercase letter, and have a minimum length of 6 characters.');
      Get.snackbar(
        'Invalid Password',
        'Password should contain atleast 1 special character,numbers,1 capital letter,lowercase letter and have minimum length of 6 characters.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      return;
    }

    // Proceed with user sign-up
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: password,
      );
      await _storeUserData(userCredential!.user!.uid, fullnameController.text,
          emailController.text);
    } catch (error) {
      // Handle sign-up errors
      print('Error signing up: $error');
    }
  }

  Future<void> _storeUserData(String uid, String fullname, String email) async {
    var store = FirebaseFirestore.instance.collection('users').doc(uid);
    await store.set({'fullname': fullname, 'email': email});
  }
}
