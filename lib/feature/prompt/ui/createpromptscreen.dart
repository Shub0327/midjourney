import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midjourney/feature/prompt/bloc/prompt_bloc.dart';

class CreatePromptScreen extends StatefulWidget {
  const CreatePromptScreen({super.key});

  @override
  State<CreatePromptScreen> createState() => _CreatePromptScreenState();
}

class _CreatePromptScreenState extends State<CreatePromptScreen> {
  final TextEditingController _controller = TextEditingController();
  final PromptBloc promptBloc = PromptBloc();

  @override
  void initState() {
    promptBloc.add(PromptInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Midjourney')),
        ),
        body: BlocConsumer<PromptBloc, PromptState>(
          bloc: promptBloc,
          listener: (context, state) {
            if (state is PromptGeneratingImageSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Image generated successfully'),
                ),
              );
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case PromptGeneratingImageLoadState:
                return const Center(child: CircularProgressIndicator());

              case PromptGeneratingImageErrorState:
                return const Center(child: Text('Error generating image'));

              case PromptGeneratingImageSuccessState:
                final successState = state as PromptGeneratingImageSuccessState;
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(successState.file),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 250,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Enter your prompt here",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: _controller,
                              cursorColor: Colors.deepPurple,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.deepPurple),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                border: OutlineInputBorder(
                                  // borderSide: const BorderSide(
                                  //   color: Colors.deepPurple,
                                  // ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.maxFinite,
                              height: 48,
                              child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.deepPurple)),
                                  onPressed: () {
                                    if (_controller.text.isNotEmpty) {
                                      promptBloc.add(PromptEnteredEvent(
                                          prompt: _controller.text));
                                    }
                                  },
                                  icon: const Icon(
                                      Icons.generating_tokens_outlined),
                                  label: const Text("Generate Prompt")),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              default:
                return Center(child: Text('Error generating image'));
            }
          },
        ));
  }
}
