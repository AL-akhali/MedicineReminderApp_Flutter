import 'package:flutter/material.dart';

Widget _textFiledItem({
  bool? isSrecure,
  required TextEditingController controller,
  required String hintText

}) {
  return TextFormField(
    controller: controller,
    validator: (input)
    {
      if(controller.text.isEmpty)
      {
        return "$hintText name must not null";
      }
      else
      {
        return null ;
      }
    },
    obscureText: isSrecure ?? false,
    decoration: InputDecoration(
      fillColor:Colors.white,
      hintText: hintText,
    ),
  );
}

Widget defaultTextButton({
  required void Function() onTap,
  required String text
})=> TextButton(
    onPressed: (){onTap();},
    child: Text(text.toUpperCase())
);

Widget defaultAppBar({
  required BuildContext context,
  String ?title,
  List<Widget>? actions,
})=>AppBar(
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: (){
      Navigator.pop(context);
    },
  ),
  title: Text(
      title!
  ),
  titleSpacing: 5.0,
  actions: actions,
);

Widget defaultFormText({
  required TextEditingController control,
  required TextInputType type,
  required dynamic validator,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixClicked,
}) => TextFormField(
  controller: control,
  keyboardType: type,
  validator: validator,
  onFieldSubmitted: (s) {
    onSubmit!(s);
  },
  onTap: () {
    onTap!();
  },
  obscureText: isPassword,
  onChanged: (value) {
    onChanged!(value);
  },
  decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(
        onPressed: () {
          suffixClicked!();
        },
        icon: Icon(suffix),
      )
          : null,
      border: OutlineInputBorder()),
);