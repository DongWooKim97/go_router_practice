import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 실질적으로 이 위젯 내부에서 그리고 있는 건 appbar와 bottomNavigation(header, footer)만 그리고 있다. 그 외는 외부에서 값을 받아오고있음.
// 정확히 말하면 가운데 메인 내용들은 ShellRoute로부터 받을 수 있었던  routes들의 GoRoute의 리턴값인 NestedChildScreen이다.
// child를 외부에서 받아오고, child를 body에 넣고 있기 때문이다. !!
class NestedScreen extends StatelessWidget {
  final Widget child;

  const NestedScreen({
    required this.child,
    Key? key,
  }) : super(key: key);

  int getIndex(BuildContext context) {
    if (GoRouterState.of(context).location == '/nested/a') {
      return 0;
    } else if (GoRouterState.of(context).location == '/nested/b') {
      return 1;
    }
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GoRouterState.of(context).location),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: getIndex(context),
        onTap: (index) {
          if (index == 0) {
            context.go('/nested/a');
          } else if (index == 1) {
            context.go('/nested/b');
          } else {
            context.go('/nested/c');
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'person'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'notification'),
        ],
      ),
    );
  }
}
