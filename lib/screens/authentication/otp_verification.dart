import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:maratha_shivmudra/utils/extensions.dart';
import 'package:maratha_shivmudra/utils/responsive.dart';
import 'package:maratha_shivmudra/widgets/otp_field.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});

  Widget _buildOtpFieldSection(BuildContext context) {
    final isMobile =
        Responsive.isMobile(context) || Responsive.isMobileLarge(context);
    return Container(
      constraints: isMobile ? BoxConstraints(maxWidth: 450) : null,
      width: isMobile ? double.infinity : null,
      child: Padding(
        padding: isMobile
            ? const EdgeInsets.fromLTRB(32, 48, 32, 32)
            : EdgeInsets.only(left: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.verify_your_account,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              softWrap: true,
            ),
            SizedBox(height: 4),
            Text(
              context.l10n.enter_the_verification_code_sent_to_your_phone,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 24),
            OtpField(),
            SizedBox(height: 24),
            Wrap(
              spacing: 8,
              children: [
                Text(
                  context.l10n.havent_received_the_code,
                  style: TextStyle(fontSize: 14),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    context.l10n.send_again,
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildOtpFieldSection(context),
          SizedBox(width: 10),
          FittedBox(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Color(0xffedf1f7),
                    Color(0xffc9d7e8),
                    Color(0xffe1e8f2)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              height: 370,
              width: 264,
              child: DotLottieLoader.fromAsset(
                  "assets/lotties/otp_illustration.lottie",
                  frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                if (dotlottie != null) {
                  return Lottie.memory(dotlottie.animations.values.single);
                } else {
                  return Container();
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _buildOtpFieldSection(context),
      tablet: _buildTabletView(context),
    );
  }
}
