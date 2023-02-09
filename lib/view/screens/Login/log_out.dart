import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phone_store_app/core/Firebase/firebase_db.dart';
import 'package:phone_store_app/view/screens/Login/phone_screen.dart';
class LogOut extends StatefulWidget {
  const LogOut({Key? key}) : super(key: key);

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  final getStorage = GetStorage();
  late bool isLogin;
  @override
  void initState() {
    super.initState();
    var isLogined = getStorage.read("isLogin");
    if(isLogined){
      setState(() {
        isLogin = true;
      });

    }else if(isLogined == null||isLogined==false){
      setState(() {
        isLogin = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: isLogin? const Text("Log Out") :const Text("Login"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
         setState(() {
           isLogin?FirebaseDb.logOut():Get.to(()=> Login());
         });

          },
          child: isLogin? const Text("Log Out") :const Text("Login"),
        ),
      ),
    );
  }
}
