// import 'package:asyncstate/asyncstate.dart';
import 'dart:async';
import 'dart:developer';

import 'package:dw_barbersho/src/core/constants/constants.dart';
import 'package:dw_barbersho/src/core/ui/helpers/messages.dart';

import 'package:dw_barbersho/src/features/splash/splash/splash_vm.dart';


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  var _scale = 10.0;
  final _animationDuration = const Duration(milliseconds: 3000);
  var _animationOpacityLogo = 0.0;

  double get _logoAnimationWidth => _scale * 100;
  double get _logoAnimationHeight => _scale * 120;

  var endAnimation = false;
  Timer? redirectTimer;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1.0;
      });
    });

    super.initState();
  }

  void _redirect(String routeName) {
    if (!endAnimation) {
      redirectTimer?.cancel();
      redirectTimer = Timer(
        const Duration(milliseconds: 300),
        () => _redirect(routeName),
      );
    } else {
      redirectTimer?.cancel();
      Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
    }
  }


  @override
  Widget build(BuildContext context) {

    ref.listen(splashVmProvider, (_, state) {
      state.whenOrNull(
        error: (error, stackTrace) {
          log('Erro ao validar o login', error: error, stackTrace: stackTrace);
          Messages.showError('Erro ao validar o login', context);
          _redirect('/auth/login');
        },
        data: (data) {
          switch (data) {
            case SplashState.loggedADM:
              _redirect('/home/adm');
              break;
            case SplashState.loggedEmployee:
              _redirect('/home/employee');
              break;
            case _:
              _redirect('/auth/login');
              break;
          } 
        },
      );
    });




    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.backgroundChair),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
              duration: _animationDuration,
              opacity: _animationOpacityLogo,
              curve: Curves.easeIn,
  
              //-----------------
              onEnd: () {

                setState(() {
                  endAnimation = true;
                });


 /*                Navigator.of(context).pushAndRemoveUntil(
                    PageRouteBuilder(
                      settings: const RouteSettings(name: 'auth/login'),
                      pageBuilder: (
                        context,
                        animation,
                        secondaryAnimation,
                      ) {
                        return const LoginPage();
                      },
                      transitionsBuilder: (
                        context,
                        animation,
                        secondaryAnimation,
                        child,
                      ) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                    (route) => false); */
              },

              //---------------------
              child: AnimatedContainer(
                duration: _animationDuration,
                width: _logoAnimationWidth,
                height: _logoAnimationHeight,
                curve: Curves.linearToEaseOut,
                child: Image.asset(
                  ImageConstants.imageLogo,
                  fit: BoxFit.cover,
                ),
              )),
        ), // tive que adicionar para a imagem aparecer
      ),
    );
  }
}
