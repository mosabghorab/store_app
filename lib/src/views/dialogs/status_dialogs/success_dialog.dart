import 'package:flutter/material.dart';
import 'package:storeapp/src/views/components/parent_component.dart';
import 'package:storeapp/src/views/components/status_components/success_component.dart';

class SuccessDialog extends StatelessWidget {
  final String message;

  SuccessDialog(this.message);

  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: AlertDialog(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            style: BorderStyle.none,
          ),
        ),
        content: SuccessComponent(message: message),
      ),
    );
  }
}
