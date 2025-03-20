import 'package:flutter/material.dart';

Widget buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 5),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Handwritten',
      ),
    ),
  );
}

Widget buildInputField(String hintText, TextEditingController controller,
    {bool readOnly = false}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.black26,
        width: 0.3,
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: TextField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'Handwritten',
        ),
      ),
    ),
  );
}
