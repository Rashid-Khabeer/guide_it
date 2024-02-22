import "dart:async";
import "dart:ui";

class ShowGuideParams {
  ShowGuideParams({
    required this.id,
    this.force = false,
    this.onComplete,
  });

  ShowGuideParams copyWith({
    String? id,
    bool? force,
    VoidCallback? onComplete,
    GuideActions? action,
  }) {
    return ShowGuideParams(
      id: id ?? this.id,
      force: force ?? this.force,
      onComplete: onComplete ?? this.onComplete,
    );
  }

  /// The identifier of the guide to be shown.
  ///
  /// This should be used to uniquely identify the guide.
  /// Whenever the guide is shown, it is possible to use the [onComplete] callback to serialize to a local storage that the guide has been processed by the user. This allows for one time only guides.
  final String? id;

  /// Whether to skip the [canShow] method and forcely show the guide.
  final bool force;

  /// Called when the guide has been shown
  final VoidCallback? onComplete;
}

class GuideController {
  final StreamController<ShowGuideParams> _showStream =
      StreamController.broadcast();

  final StreamController<GuideActions> _actionStream =
      StreamController.broadcast();

  Stream<ShowGuideParams> get show => _showStream.stream;

  Stream<GuideActions> get actions => _actionStream.stream;

  void showTutorial({required ShowGuideParams params}) =>
      _showStream.sink.add(params);

  void dispose() {
    _actionStream.close();
    _showStream.close();
  }

  void back() => _actionStream.sink.add(GuideActions.back);

  void next() => _actionStream.sink.add(GuideActions.next);
}

enum GuideActions {
  back,
  next;
}
