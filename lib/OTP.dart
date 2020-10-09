import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackinutu/HomePage.dart';
import 'package:otp_text_field/otp_field.dart';

class OTP extends StatefulWidget {
  OTP(this.phoneNo);
  final String phoneNo;

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  var verId;
  final auth = FirebaseAuth.instance;
  var otpCo;

  @override
  void initState() {
    super.initState();
    _onVerifyCode();
  }

  void _onVerifyCode() async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      auth.signInWithCredential(phoneAuthCredential).then((value) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }).catchError((error) {
        print(error);
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print(authException.message);
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('SMS'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) => otpCo = value,
              )
            ],
          ),
          actions: [
            FlatButton(
              child: Text('Done'),
              onPressed: () {
                AuthCredential _credential = PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: otpCo);
                auth.signInWithCredential(_credential).then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                }).catchError((e) {
                  print(e);
                });
              },
            )
          ],
        ),
      );
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      verId = verificationId;
      setState(() {
        verId = verificationId;
      });
    };

    await auth.verifyPhoneNumber(
        phoneNumber: "+91${widget.phoneNo}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
