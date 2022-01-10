import 'package:absurd_toolbox/widgets/_general/empty_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

enum ThemeStyle {
  Light,
  Dark,
}

class Layout extends StatelessWidget {
  final Color statusBarColor;
  final Widget content;

  final bool? showAppBar;
  final String? title;
  final Color? themeColor;
  final ThemeStyle? themeStyle;
  final Widget? fab;
  final List<PopupMenuEntry<String>>? statusBarActions;
  final Function(String)? onStatusBarActionSelected;
  final List<Widget>? tabBarItems;
  final Color? tabBarIndicatorColor;
  final bool? avoidSafeArea;

  Layout({
    required this.statusBarColor,
    required this.content,
    this.title,
    this.themeColor,
    this.themeStyle,
    this.fab,
    this.showAppBar,
    this.statusBarActions,
    this.onStatusBarActionSelected,
    this.tabBarItems,
    this.tabBarIndicatorColor,
    this.avoidSafeArea,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar == true
          ? AppBar(
              title: Text(
                title ?? '',
                style: TextStyle(
                  color: themeStyle == ThemeStyle.Light
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: statusBarColor,
              ),
              backgroundColor: themeColor,
              iconTheme: IconThemeData(
                color: themeStyle == ThemeStyle.Light
                    ? Colors.white
                    : Colors.black,
              ),
              actions: statusBarActions != null
                  ? [
                      PopupMenuButton<String>(
                        onSelected: onStatusBarActionSelected,
                        itemBuilder: (BuildContext context) =>
                            statusBarActions ?? [],
                      )
                    ]
                  : null,
              bottom: tabBarItems != null
                  ? TabBar(
                      tabs: tabBarItems ?? [],
                      indicatorColor: tabBarIndicatorColor,
                    )
                  : null,
            )
          : !kIsWeb && Platform.isIOS
              ? EmptyAppBar(
                  statusBarColor: statusBarColor,
                )
              : null,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: statusBarColor,
        ),
        child: avoidSafeArea == true ? content : SafeArea(child: content),
      ),
      floatingActionButton: fab,
    );
  }
}
