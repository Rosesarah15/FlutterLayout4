import 'dart:async';
import 'package:flutter/material.dart';
import 'package:submit_application/terms_of_use.dart';

class MySubmitPage extends StatefulWidget {
  const MySubmitPage({super.key, required String title});

  @override
  State<MySubmitPage> createState() => _MySubmitPageState();
}

class _MySubmitPageState extends State<MySubmitPage> {
  late TextEditingController _otpController;
  late List<FocusNode> _focusNodes;
  late Timer _timer;
  int _secondsRemaining = 60;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    _focusNodes = List<FocusNode>.generate(
      6,
      (index) => FocusNode(),
    );
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String timerText =
        '${_secondsRemaining ~/ 60} : ${(_secondsRemaining % 60).toString().padLeft(2, '0')}';
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 30, 45),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Submit Application',
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              'images/pls.jpg',
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PageContainer(
                    pageNumber: '1',
                    width: 30,
                    height: 30,
                  ),
                  PageContainer(
                    pageNumber: '2',
                    width: 33,
                    height: 33,
                  ),
                  PageContainer(
                    pageNumber: '3',
                    width: 35,
                    height: 35,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  PageContainer(
                    pageNumber: '4',
                    width: 60,
                    height: 60,
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              const Text(
                'Enter OTP to Invest',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                for (int i = 0; i < 6; i++)
                  Container(
                    width: 49,
                    height: 59,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        hintText: 'X',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                        counterText: '',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (i < 5) {
                            FocusScope.of(context)
                                .requestFocus(_focusNodes[i + 1]);
                          } else {
                            FocusScope.of(context).unfocus();
                          }
                        }
                      },
                      focusNode: _focusNodes[i],
                    ),
                  ),
              ]),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    // '(00:53)',
                    timerText,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  const Spacer(),
                  const Text(
                    "Didn't receive code?",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  const Text(
                    'Resend',
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              const Row(
                children: [
                  Text(
                    'Target Investment Amount',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    'UGX 690,000,000',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text(
                    'Period',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    '6 months',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text(
                    'Target ROI (Profit)',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    'UGX 51,900,000',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "By clicking 'SUBMIT' you confirm the above details and ",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              Row(
                children: [
                  const Text(
                    "agree to the application's  ",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TermsOfUsePage()),
                      );
                    },
                    child: const Text(
                      'Terms of Use',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  'Cancel Request',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PageContainer extends StatelessWidget {
  final String pageNumber;
  final double width;
  final double height;

  const PageContainer(
      {super.key,
      required this.pageNumber,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          pageNumber,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
