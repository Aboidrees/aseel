import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ExpandText extends StatefulWidget {
  final String labelHeader;
  final String desc;
  final String shortDesc;

  const ExpandText({super.key, required this.labelHeader, required this.desc, required this.shortDesc});

  @override
  State<ExpandText> createState() => _ExpandTextState();
}

class _ExpandTextState extends State<ExpandText> {
  bool descTextShowFlag = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Text(
            widget.labelHeader,
            style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Html(
            data: descTextShowFlag ? widget.desc : widget.shortDesc,
            style: {'div': Style(padding: HtmlPaddings.only(top: 5, bottom: 5), fontSize: FontSize.medium)},
          ),
          Align(
            child: GestureDetector(
              child: Text(descTextShowFlag ? "اخفاء التفاصيل" : "قراءة المزيد", style: const TextStyle(color: Colors.blue)),
              onTap: () => setState(() => descTextShowFlag = !descTextShowFlag),
            ),
          )
        ],
      ),
    );
  }
}
