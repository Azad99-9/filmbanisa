import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmbanisa/models/movie.dart';
import 'package:filmbanisa/user_pages/movie_page/movie_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MoviesPage extends StackedView<MovieViewModel> {
  const MoviesPage({super.key, required this.movie});

  final Movie movie;

  @override
  MovieViewModel viewModelBuilder(BuildContext context) => MovieViewModel();

  @override
  void onViewModelReady(MovieViewModel viewModel) {
    viewModel.init(movie);
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
      BuildContext context, MovieViewModel viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: viewModel.pageIsLoading
            ? const Center(child: CircularProgressIndicator())
            : CustomScrollView(
                controller: viewModel.scrollController,
                slivers: [
                  // Movie poster taking 30% of screen height
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: movie.posterUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Discussion Thread',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SliverList.builder(
                    itemCount: viewModel
                        .comments.length, // Replace with actual comment count
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 16,
                                    child: Icon(Icons.person),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    viewModel.comments[index].userName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(viewModel.comments[index].content),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  // Add comment section
                ],
              ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: viewModel.commentTextController,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                  ),
                ),
                const SizedBox(width: 8),
                viewModel.isSubmittingComment
                    ? const SizedBox(
                        width: 48,
                        height: 48,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : IconButton(
                        onPressed: viewModel.submitComment,
                        icon: const Icon(Icons.send),
                        color: Theme.of(context).primaryColor,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
