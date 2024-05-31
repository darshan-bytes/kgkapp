import 'package:kgk/kgk.dart';

// ignore chanages in this screen until the cretaed figma file is updated
class ImagePickDialogSheet extends StatelessWidget {
  final Function(ImageSource) onTapSource;

  const ImagePickDialogSheet({super.key, required this.onTapSource});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.all(40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            pickOption(context, icon: Icons.camera_alt_outlined, label: "Camera", onTap: () {
              Navigator.pop(context);
              onTapSource(ImageSource.camera);
            }),
            const SizedBox(width: 38),
            pickOption(context, icon: Icons.file_copy, label: "Gallery", onTap: () {
              Navigator.pop(context);
              onTapSource(ImageSource.gallery);
            }),
          ],
        ));
  }

  Widget pickOption(context, {required IconData icon, required String label, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 32,
              )),
          SmartText(
            label,
          ),
        ],
      ),
    );
  }
}
