import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rhythm/src/controllers/firestore/firestore_state.dart';
import 'package:rhythm/src/controllers/firestore/friendships_controller.dart';
import 'package:rhythm/src/repositories/friendships/friendships_error.dart';

import 'package:rhythm/src/widgets/banners/vertical_rhythm_banner.dart';
import 'package:rhythm/src/widgets/dialogs/dialog_helper.dart';
import 'package:rhythm/src/widgets/dialogs/widgets/loading_spinner.dart';
import 'package:rhythm/src/widgets/dialogs/widgets/popup_dialog.dart';
import 'package:rhythm/src/widgets/utils/custom_qr_code.dart';

class QrCodeView extends StatefulHookConsumerWidget {
  static const String route = '/qr';

  final String username;

  const QrCodeView({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  ConsumerState<QrCodeView> createState() => _QrCodeViewState();
}

class _QrCodeViewState extends ConsumerState<QrCodeView> {
  String? _qrCode;

  @override
  Widget build(BuildContext context) {
    ref.listen<FirestoreQueryState>(
      friendshipsControllerProvider,
      (previousState, nextState) {
        const DialogHelper loadingDialog = DialogHelper(
          child: LoadingSpinner(),
          canBeDismissed: false,
        );

        switch (nextState.runtimeType) {
          case FirestoreQueryLoadingState:
            loadingDialog.displayDialog(context);
            break;

          case FirestoreQuerySuccessState:
            loadingDialog.dismissDialog(context);

            final DialogHelper failureDialog = DialogHelper(
              child: PopupDialog(
                title: AppLocalizations.of(context)!.friendRequest,
                description:
                    AppLocalizations.of(context)!.friendRequestSent(_qrCode!),
                onAccept: () {
                  Navigator.of(context).pop();
                },
              ),
              canBeDismissed: true,
            );

            failureDialog.displayDialog(context);
            break;

          case FirestoreFriendshipsDataErrorState:
            loadingDialog.dismissDialog(context);

            final DialogHelper messageDialog = DialogHelper(
              child: PopupDialog(
                title: AppLocalizations.of(context)!.friendRequest,
                description: FriendshipDataErrorHandler.determineError(
                  context,
                  (nextState as FirestoreFriendshipsDataErrorState).error,
                ),
                onAccept: () {
                  Navigator.of(context).pop();
                  loadingDialog.dismissDialog(context);
                },
              ),
              canBeDismissed: true,
            );

            messageDialog.displayDialog(context);
            break;

          case FirestoreQueryErrorState:
            loadingDialog.dismissDialog(context);

            final DialogHelper failureDialog = DialogHelper(
              child: PopupDialog(
                title: AppLocalizations.of(context)!.friendRequest,
                description:
                    AppLocalizations.of(context)!.friendRequestErrorOnSend,
                onAccept: () {
                  Navigator.of(context).pop();
                },
              ),
              canBeDismissed: true,
            );

            failureDialog.displayDialog(context);
            break;
        }
      },
    );

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
        onPressed: () => _scanQR(),
      ),
    );
  }

  void _scanQR() async {
    try {
      _qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#FF6666',
        AppLocalizations.of(context)!.cancel,
        false,
        ScanMode.QR,
      );

      if (!mounted) return;

      await ref
          .watch(friendshipsControllerProvider.notifier)
          .sendFriendRequest(widget.username, _qrCode!);
    } on PlatformException {
      throw Exception('Error: Failed to scan QR code');
    }
  }
}
