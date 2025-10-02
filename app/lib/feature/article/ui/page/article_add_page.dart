import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_huevo/core/extension/context.dart';
import 'package:flutter_huevo/core/ui/input/input_field.dart';
import 'package:flutter_huevo/core/ui/widget/item/single_action_bloc_listener.dart';
import 'package:flutter_huevo/core/util/validators.dart';
import 'package:flutter_huevo/feature/article/bloc/article_add_cubit.dart';
import 'package:flutter_huevo/feature/article/model/article.dart';

class ArticleAddPage extends StatefulWidget {
  const ArticleAddPage({super.key});

  @override
  State<ArticleAddPage> createState() => _ArticleAddPageState();
}

class _ArticleAddPageState extends State<ArticleAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleActionBlocListener<ArticleAddCubit>(
      onSuccess: _onSuccess,
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.addAnArticle)),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InputField(
                    controller: _titleController,
                    label: context.l10n.title,
                    validator: Validators.required,
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 16),
                  InputField(
                    controller: _subtitleController,
                    label: context.l10n.subtitle,
                    validator: Validators.required,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const SizedBox(height: 16),
                  InputField.multiline(
                    controller: _textController,
                    label: context.l10n.text,
                  ),
                  const Spacer(),
                  FilledButton(onPressed: _add, child: Text(context.l10n.add)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _add() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.closeKeyboard();

    final title = _titleController.text.trim();
    final subtitle = _subtitleController.text.trim();
    final text = _textController.text.trim();

    final article = Article(
      id: '',
      title: title,
      subtitle: subtitle,
      imageUrl: '',
      text: text,
      createdAt: DateTime.now(),
    );

    context.read<ArticleAddCubit>().add(article);
  }

  void _onSuccess() {
    context
      ..showSnackBarMessage(context.l10n.added)
      ..pop();
  }
}
