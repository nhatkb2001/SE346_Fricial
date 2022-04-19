import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se346_fricial_project/utils/colors.dart';

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.white,
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
