import 'package:flutter/material.dart';
import 'package:tok_tik/config/helpers/human_formats.dart';
import 'package:tok_tik/domain/entities/video_post.dart';

class VideoButtons extends StatelessWidget {
  const VideoButtons({super.key, required this.video});
  final VideoPost video;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CustomIconButton(
          value: video.likes,
          iconColor: Colors.red,
          iconData: Icons.favorite,
        ),
        _CustomIconButton(
          value: video.views,
          iconData: Icons.remove_red_eye_outlined,
        ),
      ],
    );
  }
}

class _CustomIconButton extends StatelessWidget {
  const _CustomIconButton({
    required this.value,
    required this.iconData,
    iconColor,
  }) : color = iconColor ?? Colors.white;

  final int value;
  final IconData iconData;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            iconData,
            color: color,
            size: 30,
          ),
        ),
        Text(HumanFormats.humanReadableNumber(value.toDouble()))
      ],
    );
  }
}
