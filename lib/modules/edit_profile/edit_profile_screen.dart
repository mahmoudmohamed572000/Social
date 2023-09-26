import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var bioController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel!;
        var profileImage = SocialCubit.get(context).profileImage;
        Object imageProvider1 = profileImage == null
            ? NetworkImage(userModel.image)
            : FileImage(profileImage);
        var coverImage = SocialCubit.get(context).coverImage;
        Object imageProvider2 = coverImage == null
            ? NetworkImage(userModel.cover)
            : FileImage(coverImage);
        nameController.text = userModel.name;
        phoneController.text = userModel.phone;
        bioController.text = userModel.bio;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
            actions: [
              defaultTextButton(
                function: () {
                  SocialCubit.get(context).updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                    context: context,
                  );
                },
                text: 'Update',
              ),
              const SizedBox(width: 20.0),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  if (state is SocialUpdateUserLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialUpdateUserLoadingState)
                    const SizedBox(height: 10.0),
                  SizedBox(
                    height: 200.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 150.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0),
                                  ),
                                  image: DecorationImage(
                                    image:
                                        imageProvider2 as ImageProvider<Object>,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    Icons.camera,
                                    size: 15.0,
                                  ),
                                ),
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage:
                                    imageProvider1 as ImageProvider<Object>,
                              ),
                            ),
                            IconButton(
                              icon: const CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  Icons.camera,
                                  size: 15.0,
                                ),
                              ),
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: defaultButton(
                              function: () {
                                SocialCubit.get(context).uploadProfileImage(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text,
                                  context: context,
                                );
                              },
                              text: 'upload profile',
                            ),
                          ),
                        const SizedBox(width: 10.0),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: defaultButton(
                              function: () {
                                SocialCubit.get(context).uploadCoverImage(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text,
                                  context: context,
                                );
                              },
                              text: 'upload cover',
                            ),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    const SizedBox(height: 20.0),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefixIcon: Icons.person,
                  ),
                  const SizedBox(height: 10.0),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    label: 'Bio',
                    prefixIcon: Icons.info_rounded,
                  ),
                  const SizedBox(height: 10.0),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'phone number must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefixIcon: Icons.call,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
