import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/post_model.dart';
import 'package:social/shared/styles/colors.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return cubit.posts.isNotEmpty && cubit.userModel != null
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5.0,
                      margin: const EdgeInsets.all(10.0),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          const Image(
                            image: NetworkImage(
                              'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                            ),
                            fit: BoxFit.cover,
                            height: 200.0,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'communicate with friends',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPostItem(
                        cubit.posts[index],
                        context,
                        index,
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10.0),
                      itemCount: cubit.posts.length,
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildPostItem(PostModel model, context, index) {
    var cubit = SocialCubit.get(context);
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    '${model.image}',
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: const TextStyle(height: 1.5),
                          ),
                          const SizedBox(width: 10.0),
                          const Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 15.0,
                          ),
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(height: 1.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20.0),
                IconButton(
                  icon: const Icon(Icons.more_horiz, size: 15.0),
                  onPressed: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${model.text}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 15.0),
                child: Container(
                  height: 140.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${model.postImage}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.favorite,
                              size: 15.0,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              '${cubit.isLiked ? cubit.likes[index] + 1 : cubit.likes[index]} like',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        cubit.likePost(cubit.postsId[index]);
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.chat,
                              size: 15.0,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              '${cubit.isCommented ? cubit.comments[index] + 1 : cubit.comments[index]} comment',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        cubit.commentPost(cubit.postsId[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18.0,
                          backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel!.image}',
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Text(
                          'write a comment ...',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        size: 15.0,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
