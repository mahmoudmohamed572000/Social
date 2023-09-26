import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/user_model.dart';
import 'package:social/modules/chat_details/chat_details_screen.dart';
import 'package:social/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SocialCubit.get(context).users.isNotEmpty
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem(
                    SocialCubit.get(context).users[index], context),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: SocialCubit.get(context).users.length,
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildChatItem(SocialUserModel model, context) => InkWell(
        onTap: () {
          navigateTo(
            context,
            ChatDetailsScreen(
              userModel: model,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              const SizedBox(width: 20.0),
              Text(
                '${model.name}',
                style: const TextStyle(height: 1.5),
              ),
            ],
          ),
        ),
      );
}
