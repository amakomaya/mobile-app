// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'onboard_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OnboardEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() onboardStart,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? onboardStart,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? onboardStart,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StartOnboard value) onboardStart,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StartOnboard value)? onboardStart,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StartOnboard value)? onboardStart,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardEventCopyWith<$Res> {
  factory $OnboardEventCopyWith(
          OnboardEvent value, $Res Function(OnboardEvent) then) =
      _$OnboardEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$OnboardEventCopyWithImpl<$Res> implements $OnboardEventCopyWith<$Res> {
  _$OnboardEventCopyWithImpl(this._value, this._then);

  final OnboardEvent _value;
  // ignore: unused_field
  final $Res Function(OnboardEvent) _then;
}

/// @nodoc
abstract class _$$_StartedCopyWith<$Res> {
  factory _$$_StartedCopyWith(
          _$_Started value, $Res Function(_$_Started) then) =
      __$$_StartedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_StartedCopyWithImpl<$Res> extends _$OnboardEventCopyWithImpl<$Res>
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
    return 'OnboardEvent.started()';
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
    required TResult Function() onboardStart,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? onboardStart,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? onboardStart,
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
    required TResult Function(_StartOnboard value) onboardStart,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StartOnboard value)? onboardStart,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StartOnboard value)? onboardStart,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements OnboardEvent {
  const factory _Started() = _$_Started;
}

/// @nodoc
abstract class _$$_StartOnboardCopyWith<$Res> {
  factory _$$_StartOnboardCopyWith(
          _$_StartOnboard value, $Res Function(_$_StartOnboard) then) =
      __$$_StartOnboardCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_StartOnboardCopyWithImpl<$Res>
    extends _$OnboardEventCopyWithImpl<$Res>
    implements _$$_StartOnboardCopyWith<$Res> {
  __$$_StartOnboardCopyWithImpl(
      _$_StartOnboard _value, $Res Function(_$_StartOnboard) _then)
      : super(_value, (v) => _then(v as _$_StartOnboard));

  @override
  _$_StartOnboard get _value => super._value as _$_StartOnboard;
}

/// @nodoc

class _$_StartOnboard implements _StartOnboard {
  const _$_StartOnboard();

  @override
  String toString() {
    return 'OnboardEvent.onboardStart()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_StartOnboard);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() onboardStart,
  }) {
    return onboardStart();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? onboardStart,
  }) {
    return onboardStart?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? onboardStart,
    required TResult orElse(),
  }) {
    if (onboardStart != null) {
      return onboardStart();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StartOnboard value) onboardStart,
  }) {
    return onboardStart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StartOnboard value)? onboardStart,
  }) {
    return onboardStart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StartOnboard value)? onboardStart,
    required TResult orElse(),
  }) {
    if (onboardStart != null) {
      return onboardStart(this);
    }
    return orElse();
  }
}

abstract class _StartOnboard implements OnboardEvent {
  const factory _StartOnboard() = _$_StartOnboard;
}

/// @nodoc
mixin _$OnboardState {
  bool get isLoading => throw _privateConstructorUsedError;
  Exception? get error => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isLoading, Exception? error) initial,
    required TResult Function(
            bool isLoading, Exception? error, List<WizardModel> onboardList)
        success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool isLoading, Exception? error)? initial,
    TResult Function(
            bool isLoading, Exception? error, List<WizardModel> onboardList)?
        success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoading, Exception? error)? initial,
    TResult Function(
            bool isLoading, Exception? error, List<WizardModel> onboardList)?
        success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_OnboardSuccess value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_OnboardSuccess value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_OnboardSuccess value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OnboardStateCopyWith<OnboardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardStateCopyWith<$Res> {
  factory $OnboardStateCopyWith(
          OnboardState value, $Res Function(OnboardState) then) =
      _$OnboardStateCopyWithImpl<$Res>;
  $Res call({bool isLoading, Exception? error});
}

/// @nodoc
class _$OnboardStateCopyWithImpl<$Res> implements $OnboardStateCopyWith<$Res> {
  _$OnboardStateCopyWithImpl(this._value, this._then);

  final OnboardState _value;
  // ignore: unused_field
  final $Res Function(OnboardState) _then;

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
              as Exception?,
    ));
  }
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res>
    implements $OnboardStateCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  @override
  $Res call({bool isLoading, Exception? error});
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res> extends _$OnboardStateCopyWithImpl<$Res>
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
              as Exception?,
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
  final Exception? error;

  @override
  String toString() {
    return 'OnboardState.initial(isLoading: $isLoading, error: $error)';
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
    required TResult Function(bool isLoading, Exception? error) initial,
    required TResult Function(
            bool isLoading, Exception? error, List<WizardModel> onboardList)
        success,
  }) {
    return initial(isLoading, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool isLoading, Exception? error)? initial,
    TResult Function(
            bool isLoading, Exception? error, List<WizardModel> onboardList)?
        success,
  }) {
    return initial?.call(isLoading, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoading, Exception? error)? initial,
    TResult Function(
            bool isLoading, Exception? error, List<WizardModel> onboardList)?
        success,
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
    required TResult Function(_OnboardSuccess value) success,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_OnboardSuccess value)? success,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_OnboardSuccess value)? success,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements OnboardState {
  const factory _Initial({final bool isLoading, final Exception? error}) =
      _$_Initial;

  @override
  bool get isLoading;
  @override
  Exception? get error;
  @override
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_OnboardSuccessCopyWith<$Res>
    implements $OnboardStateCopyWith<$Res> {
  factory _$$_OnboardSuccessCopyWith(
          _$_OnboardSuccess value, $Res Function(_$_OnboardSuccess) then) =
      __$$_OnboardSuccessCopyWithImpl<$Res>;
  @override
  $Res call({bool isLoading, Exception? error, List<WizardModel> onboardList});
}

/// @nodoc
class __$$_OnboardSuccessCopyWithImpl<$Res>
    extends _$OnboardStateCopyWithImpl<$Res>
    implements _$$_OnboardSuccessCopyWith<$Res> {
  __$$_OnboardSuccessCopyWithImpl(
      _$_OnboardSuccess _value, $Res Function(_$_OnboardSuccess) _then)
      : super(_value, (v) => _then(v as _$_OnboardSuccess));

  @override
  _$_OnboardSuccess get _value => super._value as _$_OnboardSuccess;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? error = freezed,
    Object? onboardList = freezed,
  }) {
    return _then(_$_OnboardSuccess(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
      onboardList: onboardList == freezed
          ? _value._onboardList
          : onboardList // ignore: cast_nullable_to_non_nullable
              as List<WizardModel>,
    ));
  }
}

/// @nodoc

class _$_OnboardSuccess implements _OnboardSuccess {
  const _$_OnboardSuccess(
      {this.isLoading = false,
      this.error,
      required final List<WizardModel> onboardList})
      : _onboardList = onboardList;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final Exception? error;
  final List<WizardModel> _onboardList;
  @override
  List<WizardModel> get onboardList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_onboardList);
  }

  @override
  String toString() {
    return 'OnboardState.success(isLoading: $isLoading, error: $error, onboardList: $onboardList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OnboardSuccess &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality()
                .equals(other._onboardList, _onboardList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(_onboardList));

  @JsonKey(ignore: true)
  @override
  _$$_OnboardSuccessCopyWith<_$_OnboardSuccess> get copyWith =>
      __$$_OnboardSuccessCopyWithImpl<_$_OnboardSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isLoading, Exception? error) initial,
    required TResult Function(
            bool isLoading, Exception? error, List<WizardModel> onboardList)
        success,
  }) {
    return success(isLoading, error, onboardList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool isLoading, Exception? error)? initial,
    TResult Function(
            bool isLoading, Exception? error, List<WizardModel> onboardList)?
        success,
  }) {
    return success?.call(isLoading, error, onboardList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoading, Exception? error)? initial,
    TResult Function(
            bool isLoading, Exception? error, List<WizardModel> onboardList)?
        success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(isLoading, error, onboardList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_OnboardSuccess value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_OnboardSuccess value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_OnboardSuccess value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _OnboardSuccess implements OnboardState {
  const factory _OnboardSuccess(
      {final bool isLoading,
      final Exception? error,
      required final List<WizardModel> onboardList}) = _$_OnboardSuccess;

  @override
  bool get isLoading;
  @override
  Exception? get error;
  List<WizardModel> get onboardList;
  @override
  @JsonKey(ignore: true)
  _$$_OnboardSuccessCopyWith<_$_OnboardSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}
