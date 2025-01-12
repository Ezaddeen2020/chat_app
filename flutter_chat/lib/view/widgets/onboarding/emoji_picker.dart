import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EmojiPickerWidget extends StatefulWidget {
  EmojiPickerWidget({
    super.key,
    this.width,
    this.height,
    required this.myController,
  });

  final double? width;
  final double? height;
  TextEditingController myController = TextEditingController();
  @override
  // ignore: library_private_types_in_public_api
  _EmojiPickerWidgetState createState() => _EmojiPickerWidgetState();
}

class _EmojiPickerWidgetState extends State<EmojiPickerWidget> {
  String selectedEmoji = '';

  // Método para obter o emoji selecionado externamente
  String getSelectedEmoji() {
    return selectedEmoji;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 250,
      width: widget.width ?? MediaQuery.of(context).size.width,
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {
          // Atualiza o estado local quando um emoji é selecionado
          setState(() {
            selectedEmoji = emoji.emoji;
            widget.myController.text += emoji.emoji;
          });
        },
        config: const Config(
            emojiViewConfig: EmojiViewConfig(
          columns: 7,
          emojiSizeMax: 28.0,
          verticalSpacing: 0,
          horizontalSpacing: 0,
          buttonMode: ButtonMode.MATERIAL,
        )),
      ),
    );
  }
}
 