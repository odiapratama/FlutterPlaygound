import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef CodeInputBuilder = Widget Function(bool hasFocus, String char);

class CodeInput extends StatefulWidget {

  final int length;
  final FocusNode focusNode;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final void Function(String value) onChanged;
  final void Function(String value) onFilled;
  final CodeInputBuilder builder;

  CodeInput._({
    Key key,
    @required this.length,
    @required this.focusNode,
    @required this.inputFormatters,
    @required this.keyboardType,
    @required this.builder,
    this.onChanged,
    this.onFilled
  }) : super(key: key);

  factory CodeInput({
    Key key,
    @required int length,
    FocusNode focusNode,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter> inputFormatters,
    @required CodeInputBuilder builder,
    void Function(String value) onChanged,
    void Function(String value) onFilled,
  }) {
    assert(length != null);
    assert(length > 0);
    assert(length.isFinite);
    assert(keyboardType != null);
    assert(builder != null);

    return CodeInput._(
      key: key,
      length: length,
      focusNode: focusNode ?? FocusNode(),
      inputFormatters: inputFormatters ??
          _createInputFormatters(length, keyboardType),
      keyboardType: keyboardType,
      builder: builder,
      onChanged: onChanged,
      onFilled: onFilled,
    );
  }

  static List<TextInputFormatter> _createInputFormatters(int length,
      TextInputType keyboardType) {
    final formatters = <TextInputFormatter>[
      LengthLimitingTextInputFormatter(length)
    ];

    if (keyboardType == TextInputType.number) {
      formatters.add(FilteringTextInputFormatter.allow(RegExp('^[0-9]*\$')));
    }

    return formatters;
  }

  @override
  _CodeInputState createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {

  final controller = TextEditingController();

  String get text => controller.text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 0,
          height: 0,
          child: EditableText(
            controller: controller,
            focusNode: widget.focusNode,
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.keyboardType,
            backgroundCursorColor: Colors.black,
            style: TextStyle(),
            cursorColor: Colors.black,
            onChanged: (value) =>
                setState(() {
                  widget.onChanged?.call(value);
                  if (value.length == widget.length) {
                    widget.onFilled?.call(value);
                  }
                }),
          ),
        ),
        GestureDetector(
          onTap: () {
            final focusScope = FocusScope.of(context);
            focusScope.requestFocus(FocusNode());
            Future.delayed(
                Duration.zero, () => focusScope.requestFocus(widget.focusNode));
          },
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(widget.length, (index) {
                final hasFocus = controller.selection.start == index;
                final char = index < text.length ? text[index] : '';
                final characterEntity = widget.builder(hasFocus, char);

                assert(characterEntity != null);

                return characterEntity;
              }
              ),
            ),
          ),
        )
      ],
    );
  }
}

abstract class CodeInputBuilders {
  static CodeInputBuilder containerized({
    Duration animationDuration = const Duration(milliseconds: 50),
    @required Size totalSize,
    @required Size emptySize,
    @required Size filledSize,
    @required BoxDecoration emptyDecoration,
    @required BoxDecoration filledDecoration,
    @required TextStyle emptyTextStyle,
    @required TextStyle filledTextStyle
  }) {
    return (bool hasFocus, String char) =>
        Container(
          width: totalSize.width,
          height: totalSize.height,
          alignment: Alignment.center,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            decoration: char.isEmpty ? emptyDecoration : filledDecoration,
            width: char.isEmpty ? emptySize.width : filledSize.width,
            height: char.isEmpty ? emptySize.height : filledSize.height,
            alignment: Alignment.center,
            child: Text(
              char,
              style: char.isEmpty ? emptyTextStyle : filledTextStyle,
            ),
          ),
        );
  }

  static CodeInputBuilder circle({
    double totalRadius = 30,
    double emptyRadius = 25,
    double filledRadius = 30,
    @required Border border,
    @required Color color,
    @required TextStyle textStyle
  }) {
    final decoration = BoxDecoration(
        shape: BoxShape.circle,
        border: border,
        color: color
    );

    return containerized(
        totalSize: Size.fromRadius(totalRadius),
        emptySize: Size.fromRadius(emptyRadius),
        filledSize: Size.fromRadius(filledRadius),
        emptyDecoration: decoration,
        filledDecoration: decoration,
        emptyTextStyle: textStyle.copyWith(fontSize: 0),
        filledTextStyle: textStyle
    );
  }

  static CodeInputBuilder darkCircle({
    double totalRadius = 30,
    double emptyRadius = 25,
    double filledRadius = 30
  }) {
    return circle(
        totalRadius: totalRadius,
        emptyRadius: emptyRadius,
        filledRadius: filledRadius,
        border: null,
        color: Colors.grey,
        textStyle: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold
        )
    );
  }
}