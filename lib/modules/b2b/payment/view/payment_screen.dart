import 'package:flutter/material.dart';
import 'package:kgk/kgk.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.checkout.tr),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              print("Paypal");
            },
            child: Container(
              height: 48,
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SmartImage(path: AppImages.icPaypal, height: 24, width: 24),
                  const SizedBox(
                    width: 10,
                  ),
                  SmartText(APPStrings.paypal.tr),
                  Spacer(),
                  SmartImage(path: AppImages.icPlus, height: 24, width: 24),
                ],
              ),
            ),
          ),
          Container(
            height: 0.5,
            margin: const EdgeInsets.symmetric(horizontal: 14),
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
          InkWell(
            onTap: () {
              print("UPI");
            },
            child: Container(
              height: 48,
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SmartImage(path: AppImages.icUpi, height: 24, width: 24),
                  const SizedBox(
                    width: 10,
                  ),
                  SmartText(APPStrings.upi.tr),
                  const Spacer(),
                  const SmartImage(path: AppImages.icPlus, height: 24, width: 24),
                ],
              ),
            ),
          ),
          Container(
            height: 0.5,
            margin: const EdgeInsets.symmetric(horizontal: 14),
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
