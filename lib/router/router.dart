import 'package:go_router/go_router.dart';
import 'package:go_router_practice/screen/1_basic_screen.dart';
import 'package:go_router_practice/screen/2_named_screen.dart';
import 'package:go_router_practice/screen/3_push_screen.dart';
import 'package:go_router_practice/screen/4_pop_base_screen.dart';
import 'package:go_router_practice/screen/5_pop_return_screen.dart';
import 'package:go_router_practice/screen/6_path_param_screen.dart';
import 'package:go_router_practice/screen/7_query_parameter_screen.dart';
import 'package:go_router_practice/screen/8_nested_screen.dart';
import 'package:go_router_practice/screen/9_nested_child_screen.dart';
import 'package:go_router_practice/screen/route_screen.dart';

//GoRouter 선언 , routes => 리스트를 넣자
// https://blog.codefactory.ai -> /하는거랑 같다. 도메인은 무시한다고 하면!!.  -> path
final router = GoRouter(
  routes: [
    GoRoute(
      //라우터 등록
      path: '/', // 첫 페이지
      builder: (context, state) {
        return RootScreen();
      },
      routes: [
        // ★ route 속 routes -> 중첩된 url 관리하기 위함.!!
        GoRoute(
          path: 'basic',
          builder: (context, builder) {
            return BasicScreen();
          },
        ),
        GoRoute(
          path: 'named',
          name: 'named_screen',
          builder: (context, builder) {
            return NamedScreen();
          }, // name 파라미터를 이용해서 라우터를 이동할 수 있다 .url이 길어졌을 때 (= url을 찾기 힘들어졌을때!)유용!
        ),
        GoRoute(
          path: 'push',
          builder: (context, builder) {
            return PushScreen();
          }, // name 파라미터를 이용해서 라우터를 이동할 수 있다 .url이 길어졌을 때 (= url을 찾기 힘들어졌을때!)유용!
        ),
        GoRoute(
          path: 'pop',
          builder: (context, state) {
            return PopBaseScreen();
          },
          routes: [
            GoRoute(
              path: 'return',
              builder: (context, state) {
                return PopReturnScreen();
              },
            )
          ],
        ),
        GoRoute(
          path: 'path_param/:id', // :을 지정하면, 이 뒤에 들어오는 값을 우리가 변수의 이름으로 칭하겠다는 의미
          builder: (context, state) {
            return PathParamScreen();
          },
          routes: [
            GoRoute(
              path: ':name',
              builder: (context, state) {
                return PathParamScreen();
              },
            ),
          ],
        ),
        GoRoute(
          path: 'query_param',
          builder: (context, state) {
            return QueryParameterScreen();
          },
        ),
        ShellRoute( // ShellRoute로 감쌌지만 path가 없기 때문에, /nested/a로 해석된다. 하위의 routes들의 값들로 path가 지정된다.
          builder: (context, state, child) {
            // ShellRoute 하위에 GoRoute들을 쓸건데, GoRoute들은 각각 빌더를 갖고있다. 빌더에서 반환해주는 값을 CHild에서 또 입력을 다시 받게된다.
            // 그 말은 즉슨,
            return NestedScreen(child: child);
          }, // 하위에 입력할 모든 위젯을 감싸게 되는 Widget을 입력할 수 있다.
          routes: [
            GoRoute(
                path: 'nested/a', builder: (_, state) => NestedChildScreen(routeName: '/nested/a')),
            GoRoute(
                path: 'nested/b', builder: (_, state) => NestedChildScreen(routeName: '/nested/b')),
            GoRoute(
                path: 'nested/c', builder: (_, state) => NestedChildScreen(routeName: '/nested/c'))
          ],
        ),
      ],
    ),
  ],
);

// / -> home
// /basic -> basic screen
// /named
// /push
