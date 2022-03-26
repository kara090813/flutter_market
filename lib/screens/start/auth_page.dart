import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:market/constants/common_size.dart';
import 'package:market/states/user_provider.dart';
import 'package:market/utils/logger.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final inputBorder =
      OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));
  final TextEditingController _phoneNumberController =
      TextEditingController(text: "010");
  final TextEditingController _codeController = TextEditingController(text: "");

  int _phoneChk = 0;
  int _chkChk = 0;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey _inputBoxKey = GlobalKey();
  GlobalKey _textButtonKey = GlobalKey();
  VerificationStatus _verificationStatus = VerificationStatus.none;

  @override
  Widget build(BuildContext context) {
    ButtonStyle _btnStyle1 = TextButton.styleFrom(
        minimumSize: Size.fromHeight(55),
        backgroundColor: _phoneChk >= 13 ? null : Colors.black26);

    ButtonStyle _btnStyle2 = TextButton.styleFrom(
        minimumSize: Size.fromHeight(55),
        backgroundColor: _chkChk >= 6 ? null : Colors.black26);

    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;

        return IgnorePointer(
          ignoring: _verificationStatus == VerificationStatus.verifying,
          child: Form(
            key: _formKey,
            child: Scaffold(
                appBar: AppBar(
                  title: Text('전화번호 로그인'),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(common_padding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ExtendedImage.asset('assets/imgs/padlock.png',
                              width: size.width * 0.15,
                              height: size.width * 0.15),
                          SizedBox(
                            width: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              '토마토마켓은 휴대폰 번호로 가입해요.\n번호는 안전하게 보관되며\n어디에도 공개되지 않아요.',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: common_padding),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            onChanged: (txt) {
                              setState(() {
                                _phoneChk = txt.length;
                              });
                            },
                            controller: _phoneNumberController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              MaskedInputFormatter("000-0000-0000")
                            ],
                            decoration: InputDecoration(
                              border: inputBorder,
                              focusedBorder: inputBorder,
                            ),
                            validator: (phoneNumber) {
                              if (phoneNumber != null &&
                                  phoneNumber.length == 13) {
                                return null;
                              } else {
                                return '전화번호를 정확히 입력해주세요';
                              }
                            },
                          ),
                          SizedBox(height: 6),
                          TextButton(
                            onPressed: () {
                              bool passed = _formKey.currentState!.validate();
                              if (passed) {
                                setState(() {
                                  _verificationStatus =
                                      VerificationStatus.codeSent;
                                });
                              } else {
                                setState(() {
                                  _verificationStatus = VerificationStatus.none;
                                });
                              }
                            },
                            child: Text(
                              '인증문자 받기',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            style: _btnStyle1,
                          )
                        ],
                      ),
                      SizedBox(height: common_padding),
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 500),
                        opacity: getVerficationHeight(_verificationStatus),
                        curve: Curves.easeInOut,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              key: _inputBoxKey,
                              onChanged: (numbers) {
                                setState(() {
                                  _chkChk = numbers.length;
                                });
                              },
                              controller: _codeController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [MaskedInputFormatter("000000")],
                              decoration: InputDecoration(
                                border: inputBorder,
                                focusedBorder: inputBorder,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            TextButton(
                              key: _textButtonKey,
                              onPressed: () {
                                attemptVerify();
                              },
                              child: (_verificationStatus ==
                                      VerificationStatus.verifying)
                                  ? CircularProgressIndicator(color: Colors.white,)
                                  : Text(
                                      '인증번호 확인',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                              style: _btnStyle2,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  double getVerficationHeight(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
        return 0;
        break;
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verficationDone:
        return 1;
        break;
    }
  }

  void attemptVerify() async {
    setState(() {
      _verificationStatus = VerificationStatus.verifying;
    });
    logger.d(_verificationStatus);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _verificationStatus = VerificationStatus.verficationDone;
    });

    context.read<UserProvider>().setUserAuth(true);
  }
}

enum VerificationStatus { none, codeSent, verifying, verficationDone }
