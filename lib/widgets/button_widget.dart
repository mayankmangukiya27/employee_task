import 'package:employee_app/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final Function onTap;
  final Color? color;
  final Color? textColor;
  final String text;
  const ButtonWidget({super.key,required this.onTap,this.height,this.width,required this.text, this.color,this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> onTap(),
      child: Container(
        height: height??45,
        width: width??MediaQuery.of(context).size.width ,
        decoration: BoxDecoration(
          color: color?? ColorConstants.primary,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(child: Text(text,style: GoogleFonts.poppins(color: textColor?? Colors.white),)),
      ),
    );
  }
}
