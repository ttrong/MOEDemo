// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:moe_cfims/application/account/account_cubit.dart' as _i9;
import 'package:moe_cfims/application/auth/auth_status_bloc.dart' as _i10;
import 'package:moe_cfims/application/login_form/login_form_bloc.dart' as _i11;
import 'package:moe_cfims/domain/account/i_account_repository.dart' as _i3;
import 'package:moe_cfims/domain/auth/i_auth_facade.dart' as _i6;
import 'package:moe_cfims/infrastructure/account/account_repository.dart'
    as _i4;
import 'package:moe_cfims/infrastructure/auth/auth_facade.dart' as _i7;
import 'package:moe_cfims/infrastructure/core/dioClient.dart' as _i5;
import 'package:moe_cfims/infrastructure/core/injectable_module.dart' as _i12;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    gh.factory<String>(
      () => injectableModule.wsUrl,
      instanceName: 'WSUrl',
    );
    gh.factory<String>(
      () => injectableModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.factory<String>(
      () => injectableModule.httpUrl,
      instanceName: 'HttpUrl',
    );
    gh.lazySingleton<_i3.IAccountRepository>(
        () => _i4.AccountRepository(gh<_i5.DioClient>()));
    gh.lazySingleton<_i6.IAuthFacade>(
        () => _i7.AuthFacade(gh<_i5.DioClient>()));
    gh.lazySingleton<_i8.Dio>(
        () => injectableModule.dio(gh<String>(instanceName: 'HttpUrl')));
    gh.factory<_i9.AccountCubit>(
        () => _i9.AccountCubit(gh<_i3.IAccountRepository>()));
    gh.factory<_i10.AuthStatusBloc>(
        () => _i10.AuthStatusBloc(gh<_i6.IAuthFacade>()));
    gh.factory<_i11.LoginFormBloc>(
        () => _i11.LoginFormBloc(gh<_i6.IAuthFacade>()));
    return this;
  }
}

class _$InjectableModule extends _i12.InjectableModule {}
