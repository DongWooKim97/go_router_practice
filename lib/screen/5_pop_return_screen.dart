import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_practice/layout/default_layout.dart';

class PopReturnScreen extends StatelessWidget {
  const PopReturnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              context.pop('code Factory'); // 괄호안에 들어가는 파라미터는 pop으로 돌아가는 스크린에 전달되는 반환값이다.
            },
            child: Text('Pop!'),
          ),
        ],
      ),
    );
  }
}
