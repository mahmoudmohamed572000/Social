import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/home_layout.dart';
import 'package:social/modules/register/cubit/cubit.dart';
import 'package:social/modules/register/cubit/states.dart';
import 'package:social/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
      listener: (context, state) {
        if (state is SocialCreateUserSuccessState) {
          navigateAndFinish(
            context,
            const HomeLayout(),
          );
        }
      },
      builder: (context, state) {
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
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register now to communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 15.0),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          label: 'User Name',
                          prefixIcon: Icons.person,
                        ),
                        const SizedBox(height: 15.0),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
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
                          suffixIcon: SocialRegisterCubit.get(context).suffix,
                          isPassword:
                              SocialRegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            SocialRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefixIcon: Icons.lock_outline,
                        ),
                        const SizedBox(height: 15.0),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone number';
                            }
                            return null;
                          },
                          label: 'Phone',
                          prefixIcon: Icons.phone,
                        ),
                        const SizedBox(height: 15.0),
                        state is! SocialRegisterLoadingState
                            ? defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialRegisterCubit.get(context)
                                        .userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                text: 'register',
                              )
                            : const Center(child: CircularProgressIndicator()),
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
