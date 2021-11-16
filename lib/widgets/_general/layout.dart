import 'package:absurd_toolbox/widgets/empty_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Layout extends StatelessWidget {
  final Color statusBarColor;
  final Widget content;

  final bool? showAppBar;
  final String? title;
  final Color? themeColor;
  final Widget? fab;
  final List<PopupMenuEntry<String>>? statusBarActions;
  final Function(String)? onStatusBarActionSelected;
  final List<Widget>? tabBarItems;
  final Color? tabBarIndicatorColor;

  Layout({
    required this.statusBarColor,
    required this.content,
    this.title,
    this.themeColor,
    this.fab,
    this.showAppBar,
    this.statusBarActions,
    this.onStatusBarActionSelected,
    this.tabBarItems,
    this.tabBarIndicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: statusBarColor,
    //     systemNavigationBarColor: statusBarColor,
    //     systemNavigationBarDividerColor: statusBarColor,
    //     systemNavigationBarIconBrightness: Brightness.light,
    //     statusBarBrightness: Brightness.light,
    //     statusBarIconBrightness: Brightness.light,
    //   ),
    // );
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
                  : null,
              bottom: tabBarItems != null
                  ? TabBar(
                      tabs: tabBarItems ?? [],
                      indicatorColor: tabBarIndicatorColor,
                    )
                  : null,
            )
          : EmptyAppBar(
              statusBarColor: statusBarColor,
            ),
      body: showAppBar != true
          ? AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: statusBarColor,
                systemNavigationBarColor: statusBarColor,
                systemNavigationBarDividerColor: statusBarColor,
                systemNavigationBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.light,
              ),
              child: content,
            )
          : content,
      floatingActionButton: fab,
    );
  }
}
