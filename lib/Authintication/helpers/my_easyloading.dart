import 'package:flutter_easyloading/flutter_easyloading.dart';

void showErrorMessage(String errorMessage) {
  EasyLoading.showError(errorMessage,maskType: EasyLoadingMaskType.black);
}

void showSuccessMessage(String message) {
  EasyLoading.showSuccess(message);
}

void showInfoMessage(String message) {
  EasyLoading.showInfo(message);
}

void showLoading() {
  EasyLoading.show();
}

void stopLoading() {
  EasyLoading.dismiss();
}
