import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Layout extends StatelessWidget {
  final Color statusBarColor;
  final Widget content;

  final String? title;
  final Color? themeColor;
  final Widget? fab;
  final bool? showAppBar;
  final List<PopupMenuEntry<String>>? statusBarActions;
  final Function(String)? onStatusBarActionSelected;

  Layout({
    required this.statusBarColor,
    required this.content,
    this.title,
    this.themeColor,
    this.fab,
    this.showAppBar,
    this.statusBarActions,
    this.onStatusBarActionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar == true
          ? AppBar(
              title: Text(
                title ?? '',
                style: TextStyle(color: Colors.black),
              ),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: statusBarColor,
              ),
              backgroundColor: themeColor,
              iconTheme: IconThemeData(color: Colors.black),
              actions: statusBarActions != null
                  ? [
                      PopupMenuButton<String>(
                        onSelected: onStatusBarActionSelected,
                        itemBuilder: (BuildContext context) =>
                            statusBarActions ?? [],
                      )
                    ]
                  : null)
          : null,
      body: showAppBar != true
          ? AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: statusBarColor,
              ),
              child: content,
            )
          : content,
      floatingActionButton: fab,
    );
  }
}
