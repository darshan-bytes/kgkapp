import 'package:kgk/kgk.dart';

class IsolateRunner {
  static Future<T> run<T, R>(Future<T> Function(R) function, R argument) async {
    final RootIsolateToken? rootToken = RootIsolateToken.instance;
    if (rootToken == null) {
      return function(argument);
    }
    final task = IsolateTask<T, R>(function, argument, rootToken);
    try {
      return await compute<IsolateTask<T, R>, T>(_isolateRunner, task);
    } catch (e) {
      debugPrint('Error isolate computation: ${e.toString()}');
      rethrow;
    }
  }

  /*static Future<T> run<T, R>(Future<T> Function(R) function, R argument) async {
    final RootIsolateToken? rootToken = RootIsolateToken.instance;
    // Check if we're already in a background isolate
    // If rootToken is null, we're already in a background isolate
    if (rootToken == null) {
      // If we're not on the root isolate, just run the function directly
      return function(argument);
    }
    final task = IsolateTask<T, R>(function, argument, rootToken);
    try {
      // Execute the function in a new isolate
      return await compute<IsolateTask<T, R>, T>(_isolateRunner, task);
    } catch (e) {
      debugPrint('Error isolate computation: ${e.toString()}');
      rethrow;
    }
  }*/

  static Future<T> _isolateRunner<T, R>(IsolateTask<T, R> task) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(task.rootToken);
    try {
      // Execute the function with the given argument
      return await task.function(task.argument);
    } catch (e) {
      // Handle any errors that occur during function execution
      debugPrint('Error function execution in isolate: ${e.toString()}');
      rethrow; // Optionally rethrow the error after logging it
    }
  }
}

class IsolateTask<T, R> {
  final Future<T> Function(R) function;
  final R argument;
  final RootIsolateToken rootToken;

  IsolateTask(this.function, this.argument, this.rootToken);
}
