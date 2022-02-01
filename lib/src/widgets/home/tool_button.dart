import 'package:absurd_toolbox/src/models/tool.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ToolButton extends StatelessWidget {
  final Tool tool;

  const ToolButton({
    Key? key,
    required this.tool,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(tool.route),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        splashColor: Colors.grey,
        highlightColor: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            color: tool.primaryColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Icon(
                  tool.icon,
                  size: 40,
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: AutoSizeText(
                      tool.name,
                      maxLines: 2,
                      wrapWords: false,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      minFontSize: 10,
                      maxFontSize: 12,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        // fontSize: 12,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
