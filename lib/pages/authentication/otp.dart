import 'package:card_game_sockets/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPPage extends StatelessWidget {
  final String verificationId;
  OTPPage({super.key, required this.verificationId});

  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();
  final TextEditingController otpController5 = TextEditingController();
  final TextEditingController otpController6 = TextEditingController();

  final AuthService _auth = AuthService();

  void onVerify(context) async {
    final String userOtp = otpController1.text +
        otpController2.text +
        otpController3.text +
        otpController4.text +
        otpController5.text +
        otpController6.text;

    await _auth.verifyOTP(context, verificationId, userOtp);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Verification Code',
                  style: width > 375
                    ? Theme.of(context).textTheme.titleLarge
                    : Theme.of(context).textTheme.titleMedium),
              Text(
                "Enter the verfication code sent to your numeber below",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OTPInputBox(otpController: otpController1),
                  OTPInputBox(otpController: otpController2),
                  OTPInputBox(otpController: otpController3),
                  OTPInputBox(otpController: otpController4),
                  OTPInputBox(otpController: otpController5),
                  OTPInputBox(otpController: otpController6),
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(400, 50)),
                  onPressed: () => onVerify(context),
                  child: Text('Verify',
                      style: width > 375
                          ? Theme.of(context).textTheme.labelLarge
                          : Theme.of(context).textTheme.labelMedium)),
            ],
          ),
        ),
      ),
    );
  }
}

class OTPInputBox extends StatelessWidget {
  const OTPInputBox({
    super.key,
    required this.otpController,
  });

  final TextEditingController otpController;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor)),
        height: 68,
        width: 64,
        child: TextFormField(
          controller: otpController,
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          style: Theme.of(context).textTheme.headlineSmall,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
        ));
  }
}
