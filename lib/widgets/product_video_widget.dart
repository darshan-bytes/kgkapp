import 'package:kgk/kgk.dart';

/// A widget that displays a video player for a given video URL.
///
/// This widget uses the `VideoPlayerController` to play a video from a network URL.
/// The video is initialized, played, and set to loop automatically.
///
/// The widget displays a loading indicator while the video is being initialized.
class ProductVideoWidget extends StatelessWidget {
  /// The URL path of the video to be played.
  final String path;

  /// Creates a \[ProductVideoWidget\] with the given video URL \[path\].
  ///
  /// The \[path\] parameter must not be null.
  const ProductVideoWidget({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    // Create the VideoPlayerController directly in the build method
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(path),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: false),
    );

    // Initialize the controller in the build method and handle the future
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: FutureBuilder(
          // Initialize the video player controller and start playing the video
          future: controller.initialize().then((_) async {
            await controller.play();
            await controller.setLooping(true);
          }),
          builder: (context, snapshot) {
            return AspectRatio(
              aspectRatio: 16 / 9,
              // Display the video player if the video is initialized, otherwise show a loading indicator
              child: (snapshot.connectionState == ConnectionState.done)
                  ? VideoPlayer(controller)
                  : Container(
                      color: Colors.white,
                      child: const SmartCircularProgressIndicator(),
                    ),
            );
          },
        ),
      ),
    );
  }
}
