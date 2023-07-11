import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import '../../view/Style/style.dart';
import 'app_connectivity.dart';

abstract class AppHelper {
  AppHelper._();

  static String formatName(String? name) {
    return (name?.substring(0, 1).toUpperCase() ?? "") +
        (name?.substring(1) ?? "");
  }

  static formatDiscount({required num price, required num discount}) {
    return (price - ((price / 100).toDouble() * discount.toDouble()));
  }

  static showNoConnectionSnackBar(BuildContext context) {


    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'No Internet Connection',
        message: 'Please check your internet.',
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }


  static checker({required BuildContext context,required VoidCallback onConnect}) async {
    if (await AppConnectivity.connectivity() == false) {
      // ignore: use_build_context_synchronously
      showNoConnectionSnackBar(context);
    }
    else{
      onConnect();
    }
  }
  static showConfirm({
    required BuildContext context,
    required VoidCallback onSummit,
    required String title,
    required String content,
  }) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          title,
          style: Style.textStyleSemiBold(),
        ),
        content: Text(
          content,
          style: Style.textStyleNormal(),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Yo'q",
                style: Style.textStyleNormal(),
              )),
          TextButton(
            onPressed: () {
              onSummit();
              Navigator.pop(context);
            },
            child: Text(
              'Ha',
              style: Style.textStyleNormal(),
            ),
          ),
        ],
      ),
    );
  }
}
