import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:rhythm/src/widgets/banners/vertical_rhythm_banner.dart';
import 'package:rhythm/src/widgets/utils/custom_qr_code.dart';

class QrCodeView extends StatefulWidget {
  static const String route = '/qr';

  final String username;

  const QrCodeView({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<QrCodeView> createState() => _QrCodeViewState();
}

class _QrCodeViewState extends State<QrCodeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              VerticalRhythmBanner(
                subtitle: AppLocalizations.of(context)!.yourRhythmQR,
              ),
              const SizedBox(height: 16.0),
              Center(
                child: CustomQrCode(
                  data: widget.username,
                  size: MediaQuery.of(context).size.height / 3,
                ),
              ),
              const SizedBox(height: 32.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child:
                    Text(AppLocalizations.of(context)!.yourRhythmQRDescription),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: AppLocalizations.of(context)!.scanQr,
        child: const Icon(FontAwesomeIcons.barcode),
        onPressed: () {

        },
      ),
    );
  }
}
