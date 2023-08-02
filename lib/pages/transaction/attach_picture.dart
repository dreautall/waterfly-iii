import 'dart:io';

import 'package:async/async.dart' show RestartableTimer;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:waterflyiii/animations.dart';

class CameraDialog extends StatefulWidget {
  const CameraDialog({
    super.key,
    required this.cameras,
  });

  final List<CameraDescription> cameras;

  @override
  State<CameraDialog> createState() => _CameraDialogState();
}

class _CameraDialogState extends State<CameraDialog>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  XFile? imageFile;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;

  Offset? _focusPoint;
  late AnimationController _focusPointAnimationController;
  late Animation<double> _focusPointAnimation;
  final double _focusPointIconSize = 72;
  late RestartableTimer _focusPointHideTimer;

  final Logger log = Logger("Pages.Transaction.AttachmentDialog.AttachPicture");

  // Counting pointers (number of user fingers on screen)
  int _pointers = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _focusPointAnimationController = AnimationController(
      duration: animDurationEmphasized,
      vsync: this,
    );
    _focusPointAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(
                  begin: _focusPointIconSize * 0.7,
                  end: _focusPointIconSize * 1.2)
              .chain(CurveTween(curve: animCurveEmphasizedDecelerate)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(
                  begin: _focusPointIconSize * 1.2, end: _focusPointIconSize)
              .chain(CurveTween(curve: animCurveEmphasizedAccelerate)),
          weight: 50.0,
        ),
      ],
    ).animate(_focusPointAnimationController);
    _focusPointHideTimer = RestartableTimer(
      const Duration(milliseconds: 1200),
      () {
        if (mounted) {
          setState(() {
            _focusPoint = null;
          });
        }
      },
    )..cancel();
  }

  @override
  void dispose() {
    if (controller != null) {
      controller!.dispose();
    }
    WidgetsBinding.instance.removeObserver(this);
    _focusPointAnimationController.dispose();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCameraController(cameraController.description);
    }
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (controller == null || _pointers != 2) {
      return;
    }

    // Clamp zoom to 1, crashes when zoom < 1!
    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await controller!.setZoomLevel(_currentScale);
  }

  /// Display the thumbnail of the captured image.
  Widget _thumbnailWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (imageFile == null)
              Container()
            else
              SizedBox(
                width: 64.0,
                height: 64.0,
                child: Image.file(File(imageFile!.path)),
              ),
          ],
        ),
      ),
    );
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final CameraController cameraController = controller!;

    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );

    _focusPointAnimationController.reset();
    _focusPointAnimationController.forward();
    _focusPointHideTimer.reset();
    if (mounted) {
      setState(() {
        _focusPoint = details.localPosition;
      });
    }

    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      return controller!.setDescription(cameraDescription);
    } else {
      return _initializeCameraController(cameraDescription);
    }
  }

  Future<void> _initializeCameraController(
      CameraDescription cameraDescription) async {
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        showInSnackBar(
            'Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
      await Future.wait(<Future<Object?>>[
        cameraController
            .getMaxZoomLevel()
            .then((double value) => _maxAvailableZoom = value),
        /*
        // Flutter crashes when minAvailableZoom < 1. So don't fetch this,
        // 1 is the default!
        cameraController
            .getMinZoomLevel()
            .then((double value) => _minAvailableZoom = value),*/
      ]);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          showInSnackBar('You have denied camera access.');
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable camera access.');
          break;
        case 'CameraAccessRestricted':
          // iOS only
          showInSnackBar('Camera access is restricted.');
          break;
        case 'AudioAccessDenied':
          showInSnackBar('You have denied audio access.');
          break;
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable audio access.');
          break;
        case 'AudioAccessRestricted':
          // iOS only
          showInSnackBar('Audio access is restricted.');
          break;
        default:
          _showCameraException(e);
          break;
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) {
      if (mounted) {
        setState(() {
          imageFile = file;
        });
        if (file != null) {
          showInSnackBar('Picture saved to ${file.path}');
        }
      }
    });
  }

  void onSetFlashModeButtonPressed(FlashMode mode) {
    setFlashMode(mode).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<void> setFlashMode(FlashMode mode) async {
    if (controller == null) {
      return;
    }

    try {
      await controller!.setFlashMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    log.severe("Camera error", e);
    showInSnackBar('Camera Error: ${e.code}\n${e.description}');
  }

  @override
  Widget build(BuildContext context) {
    final Logger log =
        Logger("Pages.Transaction.AttachmentDialog.AttachPicture");

    if (controller == null) {
      for (final CameraDescription cameraDescription in widget.cameras) {
        if (cameraDescription.lensDirection == CameraLensDirection.back) {
          _initializeCameraController(cameraDescription);
        }
      }
      if (controller == null) {
        _initializeCameraController(widget.cameras.first);
      }
      if (controller == null) {
        Navigator.of(context).pop();
        return const SizedBox.shrink();
      }
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Listener(
            onPointerDown: (_) => _pointers++,
            onPointerUp: (_) => _pointers--,
            child: CameraPreview(
              controller!,
              child: LayoutBuilder(
                builder: (
                  BuildContext context,
                  BoxConstraints constraints,
                ) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onScaleStart: _handleScaleStart,
                    onScaleUpdate: _handleScaleUpdate,
                    onTapDown: (TapDownDetails details) =>
                        onViewFinderTap(details, constraints),
                    child: Stack(
                      children: <Widget>[
                        _focusPoint != null
                            ? AnimatedBuilder(
                                animation: _focusPointAnimationController,
                                builder: (BuildContext context, Widget? child) {
                                  return Positioned(
                                    left: _focusPoint!.dx -
                                        (_focusPointAnimation.value / 2),
                                    top: _focusPoint!.dy -
                                        (_focusPointAnimation.value / 2),
                                    child: Icon(
                                      Icons.filter_center_focus_outlined,
                                      size: _focusPointAnimation.value,
                                    ),
                                  );
                                },
                              )
                            : const SizedBox.shrink(),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                        switch (controller?.value.flashMode) {
                                      FlashMode.off => Icons.flash_off,
                                      FlashMode.auto => Icons.flash_auto,
                                      FlashMode.always => Icons.flash_on,
                                      FlashMode.torch => Icons.highlight,
                                      null => Icons.flash_off,
                                    }),
                                    onPressed: () {
                                      switch (controller?.value.flashMode) {
                                        case FlashMode.auto:
                                          onSetFlashModeButtonPressed(
                                              FlashMode.off);
                                        case FlashMode.off:
                                          onSetFlashModeButtonPressed(
                                              FlashMode.always);
                                        default:
                                          onSetFlashModeButtonPressed(
                                              FlashMode.auto);
                                      }
                                    },
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const SizedBox(
                                    // Button placeholder
                                    width: 48,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.camera),
                                    iconSize: 72,
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.cameraswitch),
                                    onPressed: () {
                                      for (final CameraDescription cameraDescription
                                          in widget.cameras) {
                                        if (cameraDescription.lensDirection !=
                                            controller!
                                                .description.lensDirection) {
                                          onNewCameraSelected(
                                              cameraDescription);
                                        }
                                      }
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
