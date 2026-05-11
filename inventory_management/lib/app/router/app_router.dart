import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [GoRoute(path: '/', builder: (context, state) => const LoginPage())],
);
