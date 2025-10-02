import 'package:flutter/material.dart';
import 'package:flutter_huevo/core/extension/context.dart';
import 'package:flutter_huevo/core/extension/formatter.dart';
import 'package:flutter_huevo/feature/article/model/article.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard(this.article, {super.key});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.createdAt.toNiceDateString(context),
                    style: context.textTheme.labelSmall,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border),
            ),
          ),
        ],
      ),
    );
  }
}
