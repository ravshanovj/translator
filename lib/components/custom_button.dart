import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const CustomButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:(){
        onPressed;
      },
      child: Padding(
        padding:const EdgeInsets.symmetric(vertical: 9),
        child: Text(
            text,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 19)),
      ),
    );
  }
}
