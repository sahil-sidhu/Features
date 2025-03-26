import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chambas/features/Profile/domain/models/profile_model.dart';
import 'package:chambas/features/Profile/presentation/cubit/profile_cubit.dart';
import 'package:chambas/features/Profile/presentation/cubit/profile_states.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileModel user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  //  Controllers
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final profileTitleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  final unitNumberTextController = TextEditingController();
  final streetNumberTextController = TextEditingController();
  final streetNameTextController = TextEditingController();
  final cityTextController = TextEditingController();
  final stateOrProvinceTextController = TextEditingController();
  final zipOrPostalTextController = TextEditingController();

  //  Focus Nodes
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _titleFocusNode = FocusNode();
  final _descFocusNode = FocusNode();

  final _unitFocusNode = FocusNode();
  final _streetNoFocusNode = FocusNode();
  final _streetNameFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _stateFocusNode = FocusNode();
  final _zipFocusNode = FocusNode();

  // Image picker
  PlatformFile? imagePickedFile;
  Uint8List? webImage;

  @override
  void initState() {
    super.initState();

    // Initialize text controllers
    firstNameTextController.text = widget.user.firstName;
    lastNameTextController.text = widget.user.lastName;
    phoneTextController.text = widget.user.phone ?? '';
    profileTitleTextController.text = widget.user.title ?? '';
    descriptionTextController.text = widget.user.description ?? '';

    unitNumberTextController.text = widget.user.unitNumber ?? '';
    streetNumberTextController.text = widget.user.streetNumber ?? '';
    streetNameTextController.text = widget.user.streetName ?? '';
    cityTextController.text = widget.user.city ?? '';
    stateOrProvinceTextController.text = widget.user.stateOrProvince ?? '';
    zipOrPostalTextController.text = widget.user.zipOrPostal ?? '';

    // Listen for focus changes on each text field so we can rebuild for color updates
    _firstNameFocusNode.addListener(() => setState(() {}));
    _lastNameFocusNode.addListener(() => setState(() {}));
    _phoneFocusNode.addListener(() => setState(() {}));
    _titleFocusNode.addListener(() => setState(() {}));
    _descFocusNode.addListener(() => setState(() {}));

    _unitFocusNode.addListener(() => setState(() {}));
    _streetNoFocusNode.addListener(() => setState(() {}));
    _streetNameFocusNode.addListener(() => setState(() {}));
    _cityFocusNode.addListener(() => setState(() {}));
    _stateFocusNode.addListener(() => setState(() {}));
    _zipFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // Dispose controllers
    firstNameTextController.dispose();
    lastNameTextController.dispose();
    phoneTextController.dispose();
    profileTitleTextController.dispose();
    descriptionTextController.dispose();
    unitNumberTextController.dispose();
    streetNumberTextController.dispose();
    streetNameTextController.dispose();
    cityTextController.dispose();
    stateOrProvinceTextController.dispose();
    zipOrPostalTextController.dispose();

    // Dispose focus nodes
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _titleFocusNode.dispose();
    _descFocusNode.dispose();

    _unitFocusNode.dispose();
    _streetNoFocusNode.dispose();
    _streetNameFocusNode.dispose();
    _cityFocusNode.dispose();
    _stateFocusNode.dispose();
    _zipFocusNode.dispose();

    super.dispose();
  }

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: kIsWeb,
    );

    if (result != null) {
      setState(() {
        imagePickedFile = result.files.first;
        if (kIsWeb) {
          webImage = imagePickedFile!.bytes;
        }
      });
    }
  }

  // Save / Update profile
  void updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final profileCubit = context.read<ProfileCubit>();

      await profileCubit.updateProfile(
        uid: widget.user.uid,
        firstName: firstNameTextController.text,
        lastName: lastNameTextController.text,
        phone: phoneTextController.text.isNotEmpty
            ? phoneTextController.text
            : null,
        title: profileTitleTextController.text.isNotEmpty
            ? profileTitleTextController.text
            : null,
        description: descriptionTextController.text.isNotEmpty
            ? descriptionTextController.text
            : null,
        unitNumber: unitNumberTextController.text.isNotEmpty
            ? unitNumberTextController.text
            : null,
        streetNumber: streetNumberTextController.text.isNotEmpty
            ? streetNumberTextController.text
            : null,
        streetName: streetNameTextController.text.isNotEmpty
            ? streetNameTextController.text
            : null,
        city:
            cityTextController.text.isNotEmpty ? cityTextController.text : null,
        stateOrProvince: stateOrProvinceTextController.text.isNotEmpty
            ? stateOrProvinceTextController.text
            : null,
        zipOrPostal: zipOrPostalTextController.text.isNotEmpty
            ? zipOrPostalTextController.text
            : null,
        profilePicturePath: imagePickedFile?.path,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          Navigator.pop(context); // Pop on success
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          // Custom AppBar Title
          appBar: AppBar(
            title: Text(
              "Change ${widget.user.firstName}'s Information",
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),

          // Floating Action Button for Save
          floatingActionButton: FloatingActionButton.extended(
            onPressed: updateProfile,
            icon: const Icon(Icons.save),
            label: const Text("Save Changes"),
          ),

          // Scrollable content
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // ------------------ LARGE SQUARE IMAGE AREA ------------------
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        image: imagePickedFile != null
                            ? DecorationImage(
                                image: kIsWeb
                                    ? MemoryImage(webImage!)
                                    : FileImage(File(imagePickedFile!.path!))
                                        as ImageProvider,
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      // If no image is picked, show an icon placeholder
                      child: imagePickedFile == null
                          ? const Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),

                  //  BASIC INFO SECTION
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // First Name
                          _buildAnimatedField(
                            focusNode: _firstNameFocusNode,
                            controller: firstNameTextController,
                            labelText: "First Name",
                            prefixIcon: Icons.person,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "First name is required";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Last Name
                          _buildAnimatedField(
                            focusNode: _lastNameFocusNode,
                            controller: lastNameTextController,
                            labelText: "Last Name",
                            prefixIcon: Icons.person_outline,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Last name is required";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Phone
                          _buildAnimatedField(
                            focusNode: _phoneFocusNode,
                            controller: phoneTextController,
                            labelText: "Phone",
                            prefixIcon: Icons.phone,
                          ),
                          const SizedBox(height: 16),

                          // Title
                          _buildAnimatedField(
                            focusNode: _titleFocusNode,
                            controller: profileTitleTextController,
                            labelText: "Title",
                            prefixIcon: Icons.title,
                          ),
                          const SizedBox(height: 16),

                          // Description
                          _buildAnimatedField(
                            focusNode: _descFocusNode,
                            controller: descriptionTextController,
                            labelText: "Description",
                            prefixIcon: Icons.description,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ADDRESS SECTION
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Address",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Unit Number
                          _buildAnimatedField(
                            focusNode: _unitFocusNode,
                            controller: unitNumberTextController,
                            labelText: "Unit Number",
                          ),
                          const SizedBox(height: 16),

                          // Street Number
                          _buildAnimatedField(
                            focusNode: _streetNoFocusNode,
                            controller: streetNumberTextController,
                            labelText: "Street Number",
                          ),
                          const SizedBox(height: 16),

                          // Street Name
                          _buildAnimatedField(
                            focusNode: _streetNameFocusNode,
                            controller: streetNameTextController,
                            labelText: "Street Name",
                          ),
                          const SizedBox(height: 16),

                          // City
                          _buildAnimatedField(
                            focusNode: _cityFocusNode,
                            controller: cityTextController,
                            labelText: "City",
                          ),
                          const SizedBox(height: 16),

                          // State/Province
                          _buildAnimatedField(
                            focusNode: _stateFocusNode,
                            controller: stateOrProvinceTextController,
                            labelText: "State/Province",
                          ),
                          const SizedBox(height: 16),

                          // Zip/Postal Code
                          _buildAnimatedField(
                            focusNode: _zipFocusNode,
                            controller: zipOrPostalTextController,
                            labelText: "Zip/Postal Code",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Reusable helper that builds an AnimatedContainer + TextFormField
  Widget _buildAnimatedField({
    required FocusNode focusNode,
    required TextEditingController controller,
    String? labelText,
    IconData? prefixIcon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: focusNode.hasFocus ? Colors.purple.shade50 : Colors.white,
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
