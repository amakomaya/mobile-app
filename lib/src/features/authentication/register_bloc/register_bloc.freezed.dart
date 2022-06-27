// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'register_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RegisterEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(RegisterRequestModel user) gegisterStarted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(RegisterRequestModel user)? gegisterStarted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(RegisterRequestModel user)? gegisterStarted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RegisterStart value) gegisterStarted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RegisterStart value)? gegisterStarted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RegisterStart value)? gegisterStarted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterEventCopyWith<$Res> {
  factory $RegisterEventCopyWith(
          RegisterEvent value, $Res Function(RegisterEvent) then) =
      _$RegisterEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$RegisterEventCopyWithImpl<$Res>
    implements $RegisterEventCopyWith<$Res> {
  _$RegisterEventCopyWithImpl(this._value, this._then);

  final RegisterEvent _value;
  // ignore: unused_field
  final $Res Function(RegisterEvent) _then;
}

/// @nodoc
abstract class _$$_StartedCopyWith<$Res> {
  factory _$$_StartedCopyWith(
          _$_Started value, $Res Function(_$_Started) then) =
      __$$_StartedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_StartedCopyWithImpl<$Res> extends _$RegisterEventCopyWithImpl<$Res>
    implements _$$_StartedCopyWith<$Res> {
  __$$_StartedCopyWithImpl(_$_Started _value, $Res Function(_$_Started) _then)
      : super(_value, (v) => _then(v as _$_Started));

  @override
  _$_Started get _value => super._value as _$_Started;
}

/// @nodoc

class _$_Started implements _Started {
  const _$_Started();

  @override
  String toString() {
    return 'RegisterEvent.started()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Started);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(RegisterRequestModel user) gegisterStarted,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(RegisterRequestModel user)? gegisterStarted,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(RegisterRequestModel user)? gegisterStarted,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RegisterStart value) gegisterStarted,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RegisterStart value)? gegisterStarted,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RegisterStart value)? gegisterStarted,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements RegisterEvent {
  const factory _Started() = _$_Started;
}

/// @nodoc
abstract class _$$_RegisterStartCopyWith<$Res> {
  factory _$$_RegisterStartCopyWith(
          _$_RegisterStart value, $Res Function(_$_RegisterStart) then) =
      __$$_RegisterStartCopyWithImpl<$Res>;
  $Res call({RegisterRequestModel user});
}

/// @nodoc
class __$$_RegisterStartCopyWithImpl<$Res>
    extends _$RegisterEventCopyWithImpl<$Res>
    implements _$$_RegisterStartCopyWith<$Res> {
  __$$_RegisterStartCopyWithImpl(
      _$_RegisterStart _value, $Res Function(_$_RegisterStart) _then)
      : super(_value, (v) => _then(v as _$_RegisterStart));

  @override
  _$_RegisterStart get _value => super._value as _$_RegisterStart;

  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(_$_RegisterStart(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as RegisterRequestModel,
    ));
  }
}

/// @nodoc

class _$_RegisterStart implements _RegisterStart {
  const _$_RegisterStart({required this.user});

  @override
  final RegisterRequestModel user;

  @override
  String toString() {
    return 'RegisterEvent.gegisterStarted(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegisterStart &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
  _$$_RegisterStartCopyWith<_$_RegisterStart> get copyWith =>
      __$$_RegisterStartCopyWithImpl<_$_RegisterStart>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(RegisterRequestModel user) gegisterStarted,
  }) {
    return gegisterStarted(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(RegisterRequestModel user)? gegisterStarted,
  }) {
    return gegisterStarted?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(RegisterRequestModel user)? gegisterStarted,
    required TResult orElse(),
  }) {
    if (gegisterStarted != null) {
      return gegisterStarted(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RegisterStart value) gegisterStarted,
  }) {
    return gegisterStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RegisterStart value)? gegisterStarted,
  }) {
    return gegisterStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RegisterStart value)? gegisterStarted,
    required TResult orElse(),
  }) {
    if (gegisterStarted != null) {
      return gegisterStarted(this);
    }
    return orElse();
  }
}

abstract class _RegisterStart implements RegisterEvent {
  const factory _RegisterStart({required final RegisterRequestModel user}) =
      _$_RegisterStart;

  RegisterRequestModel get user => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_RegisterStartCopyWith<_$_RegisterStart> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RegisterState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isLoading, String? error) initial,
    required TResult Function(bool isLoading, String? error, UserModel user)
        success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool isLoading, String? error)? initial,
    TResult Function(bool isLoading, String? error, UserModel user)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoading, String? error)? initial,
    TResult Function(bool isLoading, String? error, UserModel user)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_RegisterSuccess value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RegisterSuccess value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RegisterSuccess value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegisterStateCopyWith<RegisterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterStateCopyWith<$Res> {
  factory $RegisterStateCopyWith(
          RegisterState value, $Res Function(RegisterState) then) =
      _$RegisterStateCopyWithImpl<$Res>;
  $Res call({bool isLoading, String? error});
}

/// @nodoc
class _$RegisterStateCopyWithImpl<$Res>
    implements $RegisterStateCopyWith<$Res> {
  _$RegisterStateCopyWithImpl(this._value, this._then);

  final RegisterState _value;
  // ignore: unused_field
  final $Res Function(RegisterState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res>
    implements $RegisterStateCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  @override
  $Res call({bool isLoading, String? error});
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res> extends _$RegisterStateCopyWithImpl<$Res>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, (v) => _then(v as _$_Initial));

  @override
  _$_Initial get _value => super._value as _$_Initial;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? error = freezed,
  }) {
    return _then(_$_Initial(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial({this.isLoading = false, this.error});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'RegisterState.initial(isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Initial &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      __$$_InitialCopyWithImpl<_$_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isLoading, String? error) initial,
    required TResult Function(bool isLoading, String? error, UserModel user)
        success,
  }) {
    return initial(isLoading, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool isLoading, String? error)? initial,
    TResult Function(bool isLoading, String? error, UserModel user)? success,
  }) {
    return initial?.call(isLoading, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoading, String? error)? initial,
    TResult Function(bool isLoading, String? error, UserModel user)? success,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(isLoading, error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_RegisterSuccess value) success,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RegisterSuccess value)? success,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RegisterSuccess value)? success,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements RegisterState {
  const factory _Initial({final bool isLoading, final String? error}) =
      _$_Initial;

  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  String? get error => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_RegisterSuccessCopyWith<$Res>
    implements $RegisterStateCopyWith<$Res> {
  factory _$$_RegisterSuccessCopyWith(
          _$_RegisterSuccess value, $Res Function(_$_RegisterSuccess) then) =
      __$$_RegisterSuccessCopyWithImpl<$Res>;
  @override
  $Res call({bool isLoading, String? error, UserModel user});
}

/// @nodoc
class __$$_RegisterSuccessCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res>
    implements _$$_RegisterSuccessCopyWith<$Res> {
  __$$_RegisterSuccessCopyWithImpl(
      _$_RegisterSuccess _value, $Res Function(_$_RegisterSuccess) _then)
      : super(_value, (v) => _then(v as _$_RegisterSuccess));

  @override
  _$_RegisterSuccess get _value => super._value as _$_RegisterSuccess;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? error = freezed,
    Object? user = freezed,
  }) {
    return _then(_$_RegisterSuccess(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }
}

/// @nodoc

class _$_RegisterSuccess implements _RegisterSuccess {
  const _$_RegisterSuccess(
      {this.isLoading = false, this.error, required this.user});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  final UserModel user;

  @override
  String toString() {
    return 'RegisterState.success(isLoading: $isLoading, error: $error, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegisterSuccess &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
  _$$_RegisterSuccessCopyWith<_$_RegisterSuccess> get copyWith =>
      __$$_RegisterSuccessCopyWithImpl<_$_RegisterSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isLoading, String? error) initial,
    required TResult Function(bool isLoading, String? error, UserModel user)
        success,
  }) {
    return success(isLoading, error, user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool isLoading, String? error)? initial,
    TResult Function(bool isLoading, String? error, UserModel user)? success,
  }) {
    return success?.call(isLoading, error, user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoading, String? error)? initial,
    TResult Function(bool isLoading, String? error, UserModel user)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(isLoading, error, user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_RegisterSuccess value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RegisterSuccess value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RegisterSuccess value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _RegisterSuccess implements RegisterState {
  const factory _RegisterSuccess(
      {final bool isLoading,
      final String? error,
      required final UserModel user}) = _$_RegisterSuccess;

  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  String? get error => throw _privateConstructorUsedError;
  UserModel get user => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RegisterSuccessCopyWith<_$_RegisterSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}
