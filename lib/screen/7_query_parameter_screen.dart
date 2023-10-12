import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_practice/layout/default_layout.dart';

class QueryParameterScreen extends StatelessWidget {
  const QueryParameterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          Text('Query Parameters : ${GoRouterState.of(context).queryParameters}'),
          // /query_parameter?utm=google&source=123
          // /query_parameter?name=bxxloob&age=32
          ElevatedButton(
            onPressed: () {
              context.push(
                Uri(
                  //기본Path입력
                  path: '/query_param',
                  //쿼리파라미터
                  queryParameters: {
                    'name': 'bxxloob',
                    'age': '32',
                  },
                ).toString(),
              );
            },
            child: Text('Query Parameter'),
          ),
        ],
      ),
    );
  }
}
