import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Post'),
            actions: [
              defaultTextButton(
                function: () {
                  var now = DateTime.now();
                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createPost(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  } else {
                    SocialCubit.get(context).uploadPostImage(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  }
                },
                text: 'Post',
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialCreatePostLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialCreatePostLoadingState)
                    const SizedBox(height: 10.0),
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg',
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        child: Text(
                          'Mahmoud Mohamed',
                          style: TextStyle(height: 1.5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: const Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image),
                              SizedBox(width: 10.0),
                              Text('add photo'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('# tags'),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'what is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  if (SocialCubit.get(context).postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 300.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            image: DecorationImage(
                              image: FileImage(
                                  SocialCubit.get(context).postImage!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const CircleAvatar(
                            radius: 20.0,
                            child: Icon(Icons.close, size: 15.0),
                          ),
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                        ),
                      ],
                    ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
