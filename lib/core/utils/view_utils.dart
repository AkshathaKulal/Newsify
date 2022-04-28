import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @author Akshatha

class ViewUtils {
  callSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
