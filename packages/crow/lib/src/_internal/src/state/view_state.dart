//  Copyright (c) 2020-2022 Talat El Beick. All rights reserved.
//  Use of this source code is governed by a MIT-style license that can be
//  found in the LICENSE file.

// ignore_for_file: invalid_use_of_protected_member

part of internal;

/// The State mixin.
///
/// This allows the [StateViewModel] to deal with [State] methods.
mixin StateMixin<T extends StatefulWidget, V extends StateViewModel>
    on State<T> {
  GetIt get _getIt => GetIt.instance;

  /// The instance of the ViewModel.
  @protected
  V get viewModel => _getIt.get<V>();

  @protected
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    viewModel.initState();
  }

  @protected
  @override
  @mustCallSuper
  void reassemble() {
    viewModel.reassemble();
    super.reassemble();
  }

  @protected
  @override
  @mustCallSuper
  void deactivate() {
    viewModel.deactivate();
    super.deactivate();
  }

  @protected
  @override
  @mustCallSuper
  void activate() {
    super.activate();
    viewModel.activate();
  }

  @protected
  @override
  @mustCallSuper
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @protected
  @override
  @mustCallSuper
  void didChangeDependencies() {
    viewModel.didChangeDependencies();
    super.didChangeDependencies();
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<V>('viewModel', viewModel));
    viewModel.debugFillProperties(properties);
  }

  /// The widget method which get the place of build method.
  @protected
  Widget? builder();

  /// The Widget build method, don't override this method instead use [builder].
  ///
  /// If do you override this than you'll lose the global context.
  @override
  @protected
  Widget build(final BuildContext context) {
    viewModel._context = context;
    return builder()!;
  }
}
