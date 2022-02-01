import 'package:absurd_toolbox/src/helpers.dart';
import 'package:absurd_toolbox/src/widgets/_general/empty_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

enum ThemeStyle {
  light,
  dark,
}

class Layout extends StatelessWidget {
  final Color secondaryColor;
  final Widget content;
  final bool showAppBar;
  final String? title;
  final Color primaryColor;
  final ThemeStyle themeStyle;
  final Widget? fab;
  final List<PopupMenuEntry<String>>? statusBarActions;
  final Function(String)? onStatusBarActionSelected;
  final List<Widget>? tabBarItems;
  final Color? tabBarIndicatorColor;
  final bool? avoidSafeArea;

  const Layout({
    Key? key,
    required this.content,
    required this.primaryColor,
    required this.secondaryColor,
    this.title,
    this.themeStyle = ThemeStyle.dark,
    this.fab,
    this.showAppBar = true,
    this.statusBarActions,
    this.onStatusBarActionSelected,
    this.tabBarItems,
    this.tabBarIndicatorColor,
    this.avoidSafeArea,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: generateAppTheme(context, createMaterialColor(primaryColor)),
      child: Scaffold(
        appBar: showAppBar == true
            ? AppBar(
                title: Text(
                  title ?? '',
                  style: TextStyle(
                    color: themeStyle == ThemeStyle.light
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: secondaryColor,
                ),
                backgroundColor: primaryColor,
                iconTheme: IconThemeData(
                  color: themeStyle == ThemeStyle.light
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
                    statusBarColor: secondaryColor,
                  )
                : null,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: secondaryColor,
          ),
          child: avoidSafeArea == true ? content : SafeArea(child: content),
        ),
        floatingActionButton: fab,
      ),
    );
  }
}
