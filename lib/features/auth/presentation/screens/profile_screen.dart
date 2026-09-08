import 'package:auth_flow_app/core/di/injection_container.dart';
import 'package:auth_flow_app/features/auth/presentation/bloc/profile/profile_bloc.dart';
import 'package:auth_flow_app/features/auth/presentation/bloc/profile/profile_event.dart';
import 'package:auth_flow_app/features/auth/presentation/bloc/profile/profile_state.dart';
import 'package:auth_flow_app/features/auth/presentation/bloc/session/session_bloc.dart';
import 'package:auth_flow_app/features/auth/presentation/bloc/session/session_event.dart';
import 'package:auth_flow_app/features/auth/presentation/bloc/session/session_state.dart';
import 'package:auth_flow_app/features/auth/presentation/widgets/profile/delete_account_button.dart';
import 'package:auth_flow_app/features/auth/presentation/widgets/profile/delete_account_dialog.dart';
import 'package:auth_flow_app/features/auth/presentation/widgets/profile/image_source_picker.dart';
import 'package:auth_flow_app/features/auth/presentation/widgets/profile/profile_avatar.dart';
import 'package:auth_flow_app/features/auth/presentation/widgets/profile/profile_name_field.dart';
import 'package:auth_flow_app/features/auth/presentation/widgets/profile/save_profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileBloc>(),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _nameController = TextEditingController();
  String? _selectedImagePath;
  String? _currentPhotoUrl;

  @override
  void initState() {
    super.initState();
    final sessionState = context.read<SessionBloc>().state;
    if (sessionState is Authenticated) {
      _nameController.text = sessionState.user.displayName ?? '';
      _currentPhotoUrl = sessionState.user.photoUrl;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleImageSelection() async {
    await ImageSourcePicker.show(
      context,
      onImageSelected: (filePath) {
        setState(() {
          _selectedImagePath = filePath;
        });
        context.read<ProfileBloc>().add(UploadProfilePictureEvent(filePath: filePath));
      },
    );
  }

  Future<void> _handleDeleteAccount() async {
    final confirmed = await DeleteAccountDialog.show(context);
    if (confirmed == true && mounted) {
      context.read<ProfileBloc>().add(const DeleteAccountEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfilePictureUploaded) {
            setState(() {
              _currentPhotoUrl = state.photoUrl;
            });
            context.read<ProfileBloc>().add(
                  UpdateProfileEvent(
                    displayName: _nameController.text.trim(),
                    photoUrl: state.photoUrl,
                  ),
                );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile picture uploaded successfully!')),
            );
          } else if (state is ProfileUpdated) {
            context.read<SessionBloc>().add(const CheckAuthStatusEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully!')),
            );
          } else if (state is AccountDeleted) {
            context.read<SessionBloc>().add(const SignOutEvent());
            Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final isLoading = state is ProfileLoading;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  ProfileAvatar(
                    selectedImagePath: _selectedImagePath,
                    currentPhotoUrl: _currentPhotoUrl,
                    isLoading: isLoading,
                    onCameraPressed: _handleImageSelection,
                  ),
                  const SizedBox(height: 32),
                  ProfileNameField(controller: _nameController),
                  const SizedBox(height: 32),
                  SaveProfileButton(
                    isLoading: isLoading,
                    onPressed: () {
                      context.read<ProfileBloc>().add(
                            UpdateProfileEvent(
                              displayName: _nameController.text.trim(),
                              photoUrl: _currentPhotoUrl,
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  DeleteAccountButton(
                    isLoading: isLoading,
                    onPressed: _handleDeleteAccount,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
