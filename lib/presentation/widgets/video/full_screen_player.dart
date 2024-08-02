import 'package:flutter/material.dart';
import 'package:tok_tik/presentation/widgets/video/video_background.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayer extends StatefulWidget {
  const FullScreenPlayer({
    super.key,
    required this.videoUrl,
    required this.caption,
  });

  final String videoUrl;
  final String caption;

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late VideoPlayerController controller;
  final ValueNotifier<bool> isPausedNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.asset(widget.videoUrl)
      ..setVolume(0)
      ..setLooping(true)
      ..play();
  }

  @override
  void dispose() {
    controller.dispose();
    isPausedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        }
        return GestureDetector(
          onTap: () {
            if (controller.value.isPlaying) {
              controller.pause();
              isPausedNotifier.value = true;
            } else {
              controller.play();
              isPausedNotifier.value = false;
            }
          },
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(
              children: [
                VideoPlayer(controller),
                VideoBackground(stops: const [0.8, 1.0]),
                Positioned(
                  bottom: 50,
                  left: 20,
                  child: _VideoCaption(
                    caption: widget.caption,
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: isPausedNotifier,
                  builder: (context, isPaused, child) {
                    return Center(
                      child: AnimatedOpacity(
                        opacity: isPaused ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 100),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          size: 100,
                          color: Colors.black45,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _VideoCaption extends StatelessWidget {
  const _VideoCaption({required this.caption});

  final String caption;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return SizedBox(
      width: size.width * 0.6,
      child: Text(
        caption,
        maxLines: 2,
        style: titleStyle,
      ),
    );
  }
}
