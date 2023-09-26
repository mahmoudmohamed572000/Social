import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/home_layout.dart';
import 'package:social/modules/login/cubit/cubit.dart';
import 'package:social/modules/login/cubit/states.dart';
import 'package:social/modules/register/register_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/network/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocConsumer<SocialLoginCubit, SocialLoginStates>(
      listener: (context, state) {
        if (state is SocialLoginErrorState) {
          showToast(
            text: state.error,
            state: ToastStates.ERROR,
          );
        }
        if (state is SocialLoginSuccessState) {
          CacheHelper.setData(
            key: 'uId',
            value: state.uId,
          ).then((value) {
            navigateAndFinish(
              context,
              const HomeLayout(),
            );
          });
        }
      },
      builder: (context, state) {
        var cubit = SocialLoginCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 15.0),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                        ),
                        const SizedBox(height: 15.0),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffixIcon: cubit.suffix,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          isPassword: cubit.isPassword,
                          suffixPressed: () {
                            cubit.changePasswordVisibility();
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefixIcon: Icons.lock_outline,
                        ),
                        const SizedBox(height: 15.0),
                        state is! SocialLoginLoadingState
                            ? defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                text: 'sign in',
                              )
                            : const Center(
                                child: CircularProgressIndicator()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            defaultTextButton(
                              function: () {
                                navigateTo(
                                  context,
                                  const RegisterScreen(),
                                );
                              },
                              text: 'register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
