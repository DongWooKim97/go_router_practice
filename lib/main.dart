import 'package:flutter/material.dart';
import 'package:go_router_practice/router/router.dart';

void main() {
  runApp(
    _App(),
  );
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router , // 기존에 선언한 라우터 값을 그대로 넣어준다.
    );
  }
}
