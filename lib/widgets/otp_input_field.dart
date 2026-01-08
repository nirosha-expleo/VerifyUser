import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verifyuser/utility/app_colors.dart';

/// OTP Input Field Widget
/// Displays 6 individual input boxes for OTP entry
class OTPInputField extends StatelessWidget {
  final List<TextEditingController> controllers;
  final Function(String)? onCompleted;

  const OTPInputField({
    super.key,
    required this.controllers,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 50,
          height: 50,
          child: TextField(
            controller: controllers[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.inputFieldBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.inputFieldBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.hdbBlue, width: 2),
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }
              
              // Check if all fields are filled
              if (value.isNotEmpty && index == 5) {
                final otp = controllers.map((c) => c.text).join();
                if (otp.length == 6 && onCompleted != null) {
                  onCompleted!(otp);
                }
              }
            },
          ),
        );
      }),
    );
  }
}

