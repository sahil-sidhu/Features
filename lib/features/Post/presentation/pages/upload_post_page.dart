import 'dart:typed_data';
import 'package:chambas/features/Auth/domain/models/user_model.dart';
import 'package:chambas/features/Auth/presentation/components/my_text_field.dart';
import 'package:chambas/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:chambas/features/Post/domain/model/post_model.dart';
import 'package:chambas/features/Post/presentation/cubit/post_cubit.dart';
import 'package:chambas/features/Post/presentation/cubit/post_states.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  // mobile image pick
  // PlatformFile? imagePickedFile;
  // web image pick
  Uint8List? webImage;

  // text controller for caption
  final jobTitleController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final jobLocationController = TextEditingController();

  // current user
  UserModel? currentUser;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  // get current user
  void getCurrentUser() async {
    final authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
  }

  // pick image
  Future<void> pickImage() async {
    // final result = await FilePicker.platform.pickFiles(
    //   type: FileType.image,
    //   withData: kIsWeb,
    // );

    // if (result != null) {
    //   setState(() {
    //     imagePickedFile = result.files.first;
    //     if (kIsWeb) {
    //       webImage = imagePickedFile!.bytes;
    //     }
    //   });
    // }
  }

  // create and upload post
  void uploadPost() {
    const imagePickedFile = "";
    if (jobTitleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please provide a caption."),
        ),
      );
      return;
    }

    // create a new post object
    final newPost = PostModel(
      postId: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: currentUser!.uid,
      jobTitle: jobTitleController.text,
      jobDescription: jobDescriptionController.text,
      jobLocation: jobLocationController.text,
      isAvailable: true, // TODO: change this to update with a switch later
      imageUrl: "",
      timestamp: DateTime.now(),
    );

    // post cubit
    final postCubit = context.read<PostCubit>();

    // web image upload
    if (kIsWeb) {
      postCubit.createPost(
        newPost,
        imageBytes: null,
      );
    } else {
      // mobile image upload
      postCubit.createPost(
        newPost,
        imagePath: null,
      );
    }
  }

  @override
  void dispose() {
    jobTitleController.dispose();
    jobDescriptionController.dispose();
    jobLocationController.dispose();
    super.dispose();
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // Bloc Consumer = builder + listener
    return BlocConsumer<PostCubit, PostState>(
      builder: (context, state) {
        print(state);
        // Post loading... or uploading...
        if (state is PostLoading || state is PostUploading) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }
        // build upload page
        return buildUploadPage();
      },
      listener: (context, state) {
        if (state is PostLoaded) {
          Navigator.of(context).pop();
        }
      },
    );
  }

  Widget buildUploadPage() {
    // SCAFFOLD
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        title: const Text("Upload Post"),
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          // upload button
          IconButton(
            icon: const Icon(Icons.upload),
            onPressed: uploadPost,
          ),
        ],
      ),
      // BODY
      body: Center(
        child: Column(
          children: [
            // image preview for web
            if (kIsWeb && webImage != null) Image.memory(webImage!),

            // image preview for mobile
            // if (!kIsWeb && imagePickedFile != null)
            //   Image.file(File(imagePickedFile!.path!)),

            // pick image button
            MaterialButton(
              onPressed: pickImage,
              color: Colors.blue,
              child: Text("Pick Image"),
            ),

            // caption text field
            MyTextField(
              controller: jobTitleController,
              hintText: "What you are looking for?",
              obscureText: false,
            ),

            // caption text field
            MyTextField(
              controller: jobDescriptionController,
              hintText: "Description",
              obscureText: false,
            ),

            // caption text field
            MyTextField(
              controller: jobLocationController,
              hintText: "Location",
              obscureText: false,
            ),
          ],
        ),
      ),
    );
  }
}
