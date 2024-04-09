part of 'auth_settings_cubit.dart';

@immutable
sealed class AuthSettingsState {}

final class AuthSettingsInitial extends AuthSettingsState {}

final class AuthSettingsLoading extends AuthSettingsState {}

final class ResetPasswordSuccess extends AuthSettingsState {}

final class SignOutSuccess extends AuthSettingsState {}

final class VerificationEmailSuccess extends AuthSettingsState {}

final class AuthSettingsFailure extends AuthSettingsState {
  final String errorMessage;

  AuthSettingsFailure({required this.errorMessage});
}
