
import 'package:employee_app/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';



class InputTextField extends StatelessWidget {
  final bool? enable;
  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final Color? textColor;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final int? errorMaxLines;
  final FocusNode? focusNode;
  final int maxLines;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final EdgeInsets? contentPadding;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final String? errorText;
  final bool isSecure;
  final bool readOnly;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  const InputTextField({
    Key? key,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.textColor,
    required this.controller,
    this.textInputType,
    this.errorMaxLines,
    this.maxLines = 1,
    this.maxLength,
    this.contentPadding,
    this.onTap,
    this.textInputAction,
    this.errorText,
    this.isSecure = false,
    this.enable = true,
    this.readOnly = false,
    this.onChanged,
    this.inputFormatters,
    this.prefixText,
    this.focusNode,
    this.onFieldSubmitted,
    this.textCapitalization,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildStackContainer();
  }

  _buildStackContainer() {
    return TextFormField(
      inputFormatters: inputFormatters,
      enabled: enable,
      readOnly:readOnly ,
      initialValue: initialValue,
      controller: controller,
      onTap: onTap,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: textInputType ?? TextInputType.text,
      maxLines: maxLines,
      maxLength: maxLength,
      focusNode: focusNode,
      //   minLines: 1,
      obscureText: isSecure,
      obscuringCharacter: '●',
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: textInputAction ?? TextInputAction.next,
      onChanged: onChanged,

      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.textFieldBorder)
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.textFieldBorder)
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.textFieldBorder)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.textFieldBorder)
        ),
        alignLabelWithHint: true,
        hintStyle: GoogleFonts.roboto(color: ColorConstants.hintColor,fontSize: 16),
        isDense: true,

        labelText: labelText,
        errorText: errorText,

        hintText: hintText,

        errorMaxLines: errorMaxLines ?? 1,

        //    prefixIconConstraints: BoxConstraints(maxHeight: getSize(50)),


        suffixIcon: suffixIcon,

        suffixIconConstraints: BoxConstraints(
          maxHeight: 50,
          minWidth: 80,
        ),
        prefixIcon: prefixIcon,
      ),
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
    );
  }
}

InputTextField getTextField(
    {required String hintText,
    required TextEditingController controller,
    required String? Function(String?) validator,
    dynamic Function(String)? onChanged,
    Widget? suffix,
    bool isSecure = false,
    FocusNode? focusNode,
    Function(String)? onFieldSubmitted,
    TextInputAction? textInputAction,
    TextInputType? textInputType,
    TextCapitalization? textCapitalization}) {
  return InputTextField(
    controller: controller,
    hintText: hintText,
    validator: validator,
    onChanged: onChanged,
    suffixIcon: suffix,
    focusNode: focusNode,
    onFieldSubmitted: onFieldSubmitted,
    isSecure: isSecure,
    textCapitalization: textCapitalization,
    textInputAction: textInputAction ?? TextInputAction.next,
    textInputType: textInputType,
  );
}
