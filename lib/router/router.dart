import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_practice/screen/10_transition_screen_1.dart';
import 'package:go_router_practice/screen/10_transition_screen_2.dart';
import 'package:go_router_practice/screen/11_error_screen.dart';
import 'package:go_router_practice/screen/1_basic_screen.dart';
import 'package:go_router_practice/screen/2_named_screen.dart';
import 'package:go_router_practice/screen/3_push_screen.dart';
import 'package:go_router_practice/screen/4_pop_base_screen.dart';
import 'package:go_router_practice/screen/5_pop_return_screen.dart';
import 'package:go_router_practice/screen/6_path_param_screen.dart';
import 'package:go_router_practice/screen/7_query_parameter_screen.dart';
import 'package:go_router_practice/screen/8_nested_child_screen.dart';
import 'package:go_router_practice/screen/8_nested_screen.dart';
import 'package:go_router_practice/screen/9_login_screen.dart';
import 'package:go_router_practice/screen/9_private_screen.dart';
import 'package:go_router_practice/screen/root_screen.dart';

// 로그인이 됐는지 안됐는지, true - OK / false - NO!
bool authState = false;

//GoRouter 선언 , routes => 리스트를 넣자
// https://blog.codefactory.ai -> /하는거랑 같다. 도메인은 무시한다고 하면!!.  -> path
final router = GoRouter(
  // 여기서 state는 GoRoute의 state와 동일하다.
  redirect: (context, state) {
    // return String -> 해당 라우트로 이동한다(path)
    // return null -> 원래 이동하려던 라우트로 이동한다. !!
    print(state.location);
    print('상위 redirect');

    if (state.location == '/login/private' && !authState) {
      return '/login';
    }
    return null; // 로그인 상황만 고려해봤을 때, 원래 가려던 url은 /login/private 인데, authState가 false일때는 못가니까 login으로 가고, if문을 통과하게 되면
  },

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
        ShellRoute(
          // ShellRoute로 감쌌지만 path가 없기 때문에, /nested/a로 해석된다. 하위의 routes들의 값들로 path가 지정된다.
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
        GoRoute(
          path: 'login',
          builder: (_, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'private',
              builder: (_, state) => PrivateScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'login2',
          builder: (_, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'private',
              builder: (_, state) => PrivateScreen(),
              // GoRoute속 routes안에 있는 하위 GoRoute에서 redirect를 사용하는 경우 , 룰은 똑같이 적용되는데, redirect를 작성하고 라우트에 이동할려고 할때만 적용된다.
              redirect: (context, state) {
                print(state.location);
                print('하위 redirect');
                if (!authState) {
                  return '/login2';
                }
                return null;
              },
            ),
          ],
        ),
        GoRoute(
          path: 'transition',
          builder: (_, state) => TransitionScreenOne(),
          routes: [
            GoRoute(
              path: 'detail',
              // 디테일에서만 (일반)빌더 삭제
              pageBuilder: (_, state) => CustomTransitionPage(
                transitionDuration: Duration(seconds: 3),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  // 애니메이션이 어떻게 동작하고, 무엇을 동작하는지 따로 공부!!
                  //transitionBuilder의 child는 아래에 있는 child(TransitionScreenTwo)에 입력된 값을 이 파라미터로 다시 입력받는 child.
                  // 위에서 봤던 child와 동일.
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                  // 여기서 animation값은 0에서 1로 점점 늘어난다. 즉, 화면이 전환될 때 순간이 0이고 완전히 보여줬을 떄가 1인데, 0에서 1로 천천히 밝아지는것.
                  // secondary는 거꾸로다. 1에서 0으로. go to 는 0에서 1로. pop은 반대로 1에서 0으로.
                },
                child: TransionScreenTwo(), // child = 이동하려는 페이지를 넣자
              ),
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => ErrorScreen(error: state.error.toString()),
  // 여기서 state는 Widget들에서 사용한 GoRouterState Class이다.
);
