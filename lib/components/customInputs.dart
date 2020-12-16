import "package:flutter/material.dart";

typedef String Validator(String value);

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final Validator validator;
  final bool isObscure;
  final Icon icon;
  final TextInputType type;
  final onTap;
  final bool readonly;
  final String intialValue;

  CustomInput(
      {this.controller,
      this.intialValue,
      this.readonly = false,
      this.placeholder,
      this.validator,
      this.isObscure = false,
      this.icon,
      this.type,
      this.onTap});
  final OutlineInputBorder customOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.deepPurple),
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: (TextFormField(
        decoration: InputDecoration(
          prefixIcon: this.icon ?? this.icon,
          filled: true,
          fillColor: Theme.of(context).primaryColorLight,
          hintText: this.placeholder,
          contentPadding: EdgeInsets.all(12),
          isDense: true,
          border: InputBorder.none,
          enabledBorder: customOutlineInputBorder,
          focusedBorder: customOutlineInputBorder,
          errorBorder: customOutlineInputBorder,
          focusedErrorBorder: customOutlineInputBorder,
        ),
        obscureText: this.isObscure,
        controller: this.controller,
        validator: validator,
        keyboardType: this.type,
        readOnly: this.readonly,
        onTap: () {
          this.onTap();
        },
      )),
    );
  }
}
