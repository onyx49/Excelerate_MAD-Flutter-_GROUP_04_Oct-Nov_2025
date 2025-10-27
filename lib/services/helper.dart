import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:group_04_app/constants.dart';
import 'package:quickalert/quickalert.dart';



String? validatePassword(String? value) {
  if ((value?.length ?? 0) < 6) {
    return 'Password must be more than 5 characters';
  } else {
    return null;
  }
}



String? validateEmail(String? value) {
  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value ?? '')) {
    return 'Enter valid e-mail';
  } else {
    return null;
  }
}



String? validateConfirmPassword(String? password, String? confirmPassword) {
  if (password != confirmPassword) {
    return 'Password doesn\'t match';
  } else if (confirmPassword!.isEmpty) {
    return 'Confirm password is required';
  } else {
    return null;
  }
}


String? validateEmptyField(String? text) {
  if (text == null || text.isEmpty){
    return 'This field can\'t be empty.';
  } else {
    return null;
  }
}


//helper method to show progress
// void showSuccess(String message) {
//   EasyLoading.instance
//     ..loadingStyle = EasyLoadingStyle.custom
//     ..backgroundColor = Colors.green
//     ..indicatorColor = Colors.white
//     ..textColor = Colors.white;
  
//   EasyLoading.showSuccess(message);
 
// }

void showSuccess(String message, context) {
  QuickAlert.show(context: context, 
  type: QuickAlertType.success,
  text: message,
  showConfirmBtn: false
  
  );

}


// void showError(String message) {
//   EasyLoading.instance
//     ..loadingStyle = EasyLoadingStyle.custom
//     ..backgroundColor = Colors.red
//     ..indicatorColor = Colors.white
//     ..textColor = Colors.white;
  
//   EasyLoading.showError(message);
  
// }

void showError(String message, context) {
  QuickAlert.show(context: context, 
  type: QuickAlertType.error,
  text: message,
  confirmBtnColor: apptheme
  
  );
  

}


void showProgress(String message) {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..backgroundColor = apptheme; 

  EasyLoading.show(status: message);
  
  // configLoading();
}


void showInfo(String message, context) {
  QuickAlert.show(
 context: context,
 type: QuickAlertType.info,
 text: message,
);
}



void closeLoader(){
  EasyLoading.dismiss();
}

