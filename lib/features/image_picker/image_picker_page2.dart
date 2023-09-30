import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:photo_manager/photo_manager.dart';
import 'package:tokyo_flutter_hack_demo/features/image_picker/image_picker_collection.dart';

final selectedImageProvider = StateProvider<AssetEntity?>((ref) => null);

class ImagePicker2 extends StatelessWidget {
  final Function(img.Image)? onImageSelected;
  final String actionText;
  final Widget title;
  final double? ratio;
  final Widget? loadingWidget;
  const ImagePicker2({
    Key? key,
    required this.title,
    this.onImageSelected,
    this.ratio,
    this.actionText = '次へ',
    this.loadingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ImagePickerPage2(
        onImageSelected: onImageSelected,
        actionText: actionText,
        title: title,
        ratio: ratio,
        loadingWidget: loadingWidget,
      ),
    );
  }
}

class _GridStatusNotifier {
  final Rect imageRect;
  double opacity;
  _GridStatusNotifier(this.imageRect, this.opacity);
}

final directoriesProvider = StateProvider<List<AssetPathEntity>>((ref) => []);
final selectedDirectoryProvider =
    StateProvider<AssetPathEntity?>((ref) => null);

class ImagePickerPage2 extends HookConsumerWidget {
  final Function(img.Image)? onImageSelected;
  final String actionText;
  final Widget title;
  final double? ratio;
  final Widget? loadingWidget;

  ImagePickerPage2({
    Key? key,
    required this.title,
    this.onImageSelected,
    this.ratio,
    this.actionText = '次へ',
    this.loadingWidget,
  }) : super(key: key);

  static const double _MAX_CROP_RATIO = 5 / 4; // height / width
  static const double _MIN_CROP_RATIO = 1 / 1.91;

  List<AssetEntity>? images;

  final GlobalKey<ExtendedImageGestureState> _gestureKey =
      GlobalKey<ExtendedImageGestureState>();
  final gridStatus = ValueNotifier<_GridStatusNotifier?>(null);
  Timer? gridTimer;

  initDirectories(WidgetRef ref) async {
    final directoriesController = ref.watch(directoriesProvider.notifier);
    final selectedDirectoryController =
        ref.watch(selectedDirectoryProvider.notifier);
    final selectedImageController = ref.watch(selectedImageProvider.notifier);
    final directories =
        await PhotoManager.getAssetPathList(type: RequestType.image);
    directoriesController.state = directories;
    final firstDirectory = directories.firstWhere((d) => d.isAll);
    final assetCount = await firstDirectory.assetCountAsync;
    selectedDirectoryController.state = firstDirectory;
    final images =
        await firstDirectory.getAssetListRange(start: 0, end: assetCount);
    selectedImageController.state = images.first;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCropping = useState(false);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        initDirectories(ref);
      });
      return null;
    }, []);

    final selectedDirectory = ref.watch(selectedDirectoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: [
          TextButton(
            onPressed: () async {
              // isCropping.value = true;
              executer() async {
                final selectedImage = ref.read(selectedImageProvider);

                final gestureDetails = _gestureKey.currentState!.gestureDetails;
                final file = await selectedImage!.file;
                final data = file!.readAsBytesSync();
                final src = img.decodeImage(data)!;

                final cropArea = computeCropRect(
                  src,
                  destinationRect: gestureDetails!.destinationRect!,
                  cropAreaRect: gestureDetails.layoutRect!,
                );

                final croppedImage = cropImage(src, cropArea);
                final resizedImage = img.copyResize(croppedImage, width: 1080);

                onImageSelected?.call(resizedImage);
              }

              showGeneralDialog(
                context: context,
                barrierDismissible: false,
                transitionDuration: const Duration(milliseconds: 300),
                barrierColor: Colors.black.withOpacity(0.5),
                pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) {
                  executer().then((_) => Navigator.of(context).pop());
                  return const Center(child: CircularProgressIndicator());
                },
              );
            },
            child: Text(actionText, style: const TextStyle(fontSize: 18)),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Stack(
              children: [
                Consumer(
                  builder: (context, ref, _) {
                    final selectedImage = ref.watch(selectedImageProvider);
                    return selectedImage != null
                        ? FutureBuilder<Uint8List?>(
                            future: selectedImage.thumbnailDataWithSize(
                                const ThumbnailSize(2400, 2400)),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return CustomPaint(
                                  foregroundPainter:
                                      GridPainter(repaint: gridStatus),
                                  child: Listener(
                                    onPointerDown: (_) => {startShowGrid()},
                                    onPointerUp: (_) => {endShowGrid()},
                                    child: ExtendedImage.memory(
                                      snapshot.data!,
                                      fit: BoxFit.contain,
                                      constraints:
                                          const BoxConstraints.expand(),
                                      mode: ExtendedImageMode.gesture,
                                      extendedImageGestureKey: _gestureKey,
                                      initGestureConfigHandler: (state) {
                                        final image =
                                            state.extendedImageInfo!.image;
                                        final ratio =
                                            image.height / image.width;
                                        final initialScale =
                                            max(ratio, 1 / ratio).toDouble();

                                        final double minimumScale;
                                        if (ratio == null) {
                                          final needCrop =
                                              ratio > _MAX_CROP_RATIO ||
                                                  ratio < _MIN_CROP_RATIO;
                                          minimumScale = max(
                                              needCrop
                                                  ? (ratio > _MAX_CROP_RATIO
                                                      ? initialScale /
                                                          _MAX_CROP_RATIO
                                                      : initialScale *
                                                          _MIN_CROP_RATIO)
                                                  : 1.0,
                                              1.0);
                                        } else {
                                          final needCrop =
                                              ratio > ratio || ratio < ratio;
                                          minimumScale = max(
                                              needCrop
                                                  ? (ratio > ratio
                                                      ? initialScale / ratio
                                                      : initialScale * ratio)
                                                  : 1.0,
                                              1.0);
                                        }

                                        return GestureConfig(
                                          minScale: minimumScale,
                                          initialScale: initialScale,
                                          animationMinScale:
                                              minimumScale * 0.85,
                                        );
                                      },
                                    ),
                                  ),
                                );
                              } else {
                                return loading();
                              }
                            })
                        : loading();
                  },
                ),
                Positioned(
                  left: 5,
                  bottom: 5,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black.withAlpha(160),
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        minimumSize: const Size(0, 0),
                      ),
                      onPressed: () => showFolderList(ref),
                      icon: const Icon(
                        Icons.folder,
                        color: Colors.white,
                        size: 20,
                      ),
                      label: Consumer(builder: (context, ref, _) {
                        final selectedDirectory =
                            ref.watch(selectedDirectoryProvider);
                        return Text(
                          selectedDirectory?.name ?? 'loading...',
                        );
                      })),
                ),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black.withAlpha(160),
                      padding: const EdgeInsets.all(5),
                      minimumSize: const Size(0, 0),
                    ),
                    onPressed: () => showImageList(ref),
                    child: const Icon(
                      Icons.grid_view,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: isCropping.value
                      ? const Center(child: CircularProgressIndicator())
                      : Container(),
                ),
              ],
            ),
          ),
          const Divider(height: 2),
          Expanded(
            child: Container(
              color: Colors.white,
              child: selectedDirectory != null
                  ? ImagePickerCollection(directory: selectedDirectory)
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }

  Widget loading() {
    return loadingWidget ?? const Center(child: CircularProgressIndicator());
  }

  showImageList(WidgetRef ref) {
    final selectedDirectory = ref.watch(selectedDirectoryProvider);
    showModalBottomSheet(
      context: ref.context,
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('画像選択'),
              automaticallyImplyLeading: true,
              leading: GestureDetector(
                onTap: () => {Navigator.of(context).pop()},
                child: Transform.rotate(
                    angle: pi / 4, child: const Icon(Icons.add, size: 40)),
              ),
            ),
            body: ImagePickerCollection(
                directory: selectedDirectory!, forcedRef: ref),
          ),
        );
      },
    );
  }

  showFolderList(WidgetRef ref) {
    final directories = ref.watch(directoriesProvider);
    final selectedDirectoryController =
        ref.watch(selectedDirectoryProvider.notifier);

    showModalBottomSheet(
      context: ref.context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('アルバムの選択'),
            automaticallyImplyLeading: true,
            leading: GestureDetector(
              onTap: () => {Navigator.of(context).pop()},
              child: Transform.rotate(
                  angle: pi / 4, child: const Icon(Icons.add, size: 40)),
            ),
          ),
          body: FolderList(
            directories: directories,
            onSelected: (directory) async {
              Navigator.of(context).pop();
              selectedDirectoryController.state = directory;
              final assetCount = await directory.assetCountAsync;
              images =
                  await directory.getAssetListRange(start: 0, end: assetCount);
              ref.read(selectedImageProvider.notifier).state = images!.first;
            },
          ),
        );
      },
    );
  }

  List<DropdownMenuItem<AssetPathEntity>> getItems(WidgetRef ref) {
    final directories = ref.watch(directoriesProvider);

    if (directories == null) return [];
    return directories.map((directory) {
      return DropdownMenuItem(
        value: directory,
        child: Text(directory.name),
      );
    }).toList();
  }

  startShowGrid() {
    final gesture = _gestureKey.currentState;
    if (gesture == null) return;

    gridTimer?.cancel();
    gridTimer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      final rectOnScreen = gesture.gestureDetails!.destinationRect!
          .intersect(gesture.gestureDetails!.layoutRect!);
      gridStatus.value = _GridStatusNotifier(
          rectOnScreen.translate(0, -gesture.gestureDetails!.layoutRect!.top),
          1);
    });
  }

  endShowGrid() {
    gridTimer?.cancel();
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (timer.tick <= 30) {
        final gesture = _gestureKey.currentState;
        if (gesture?.gestureDetails?.destinationRect == null) return;
        final rectOnScreen = gesture!.gestureDetails!.destinationRect!
            .intersect(gesture.gestureDetails!.layoutRect!);
        final rect =
            rectOnScreen.translate(0, -gesture.gestureDetails!.layoutRect!.top);
        gridStatus.value = _GridStatusNotifier(rect, 1 - 0.03 * timer.tick);
      } else {
        timer.cancel();
        gridStatus.value = null;
      }
    });
  }

  Rect computeCropRect(
    img.Image original, {
    required Rect destinationRect,
    required Rect cropAreaRect,
  }) {
    final scaling = original.width / destinationRect.width;
    final stdDestination = destinationRect.shift(-destinationRect.topLeft);
    final stdLayout = cropAreaRect.shift(-destinationRect.topLeft);
    final intersect = stdDestination.intersect(stdLayout);
    return Rect.fromPoints(
        intersect.topLeft * scaling, intersect.bottomRight * scaling);
  }

  img.Image cropImage(img.Image original, Rect cropRect) {
    return img.copyCrop(
      original,
      x: cropRect.topLeft.dx.toInt(),
      y: cropRect.topLeft.dy.toInt(),
      width: cropRect.width.toInt(),
      height: cropRect.height.toInt(),
    );
  }
}

class GridImageList extends StatelessWidget {
  final List<AssetEntity> images;
  final void Function(AssetEntity) onSelected;
  const GridImageList({
    Key? key,
    required this.images,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, crossAxisSpacing: 2, mainAxisSpacing: 2),
      itemBuilder: (_, i) {
        return FutureBuilder<Uint8List?>(
          future: images[i].thumbnailData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GestureDetector(
                child: Image.memory(snapshot.data!, fit: BoxFit.cover),
                onTap: () {
                  onSelected(images[i]);
                },
              );
            } else {
              return Container();
            }
          },
        );
      },
      itemCount: images.length,
    );
  }
}

class FolderList extends StatelessWidget {
  static const _ITEM_HEIGHT = 85.0;
  static const _IMAGE_SIZE = 80.0;
  static const _ITEM_PADDING = (_ITEM_HEIGHT - _IMAGE_SIZE) / 2;
  final List<AssetPathEntity> directories;
  final void Function(AssetPathEntity) onSelected;
  const FolderList(
      {Key? key, required this.directories, required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemBuilder: (context, index) {
        final directory = directories[index];
        topImageLoader() async {
          final assetsFuture =
              await directory.getAssetListRange(start: 0, end: 1);
          final imageData = await assetsFuture[0].thumbnailData;
          return imageData!;
        }

        return InkWell(
          onTap: () => onSelected(directory),
          child: Container(
            height: _ITEM_HEIGHT,
            padding: const EdgeInsets.only(
                top: _ITEM_PADDING, bottom: _ITEM_PADDING),
            child: Row(
              children: [
                FutureBuilder<Uint8List>(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Image.memory(snapshot.data!,
                          width: _IMAGE_SIZE,
                          height: _IMAGE_SIZE,
                          fit: BoxFit.cover);
                    } else {
                      return const SizedBox(
                          width: 60,
                          child: Center(child: CircularProgressIndicator()));
                    }
                  },
                  future: topImageLoader(),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(directory.name, style: const TextStyle(fontSize: 16)),
                    FutureBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data.toString());
                          } else {
                            return const Text("...");
                          }
                        },
                        future: directory.assetCountAsync),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      itemCount: directories.length,
    );
  }
}

class GridPainter extends CustomPainter {
  ValueNotifier<_GridStatusNotifier?>? _repaint;

  GridPainter({ValueNotifier<_GridStatusNotifier?>? repaint})
      : super(repaint: repaint) {
    _repaint = repaint;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final data = _repaint?.value;
    if (data == null) return;
    final imageRect = data.imageRect;
    final paint = Paint();
    final left = imageRect.left;
    final right = imageRect.right;
    final top = imageRect.top;
    final bottom = imageRect.bottom;
    final width = imageRect.width;
    final height = imageRect.height;
    final x1 = left + width * 1 / 3;
    final x2 = left + width * 2 / 3;
    final y1 = top + height * 1 / 3;
    final y2 = top + height * 2 / 3;

    paint.color = Colors.grey.shade300.withOpacity(data.opacity);
    paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.5);
    paint.strokeWidth = 1;
    canvas.drawLine(Offset(x1, top), Offset(x1, bottom), paint);
    canvas.drawLine(Offset(x2, top), Offset(x2, bottom), paint);
    canvas.drawLine(Offset(left, y1), Offset(right, y1), paint);
    canvas.drawLine(Offset(left, y2), Offset(right, y2), paint);

    paint.color = Colors.white.withOpacity(data.opacity);
    paint.maskFilter = null;
    paint.strokeWidth = 0.5;
    canvas.drawLine(Offset(x1, top), Offset(x1, bottom), paint);
    canvas.drawLine(Offset(x2, top), Offset(x2, bottom), paint);
    canvas.drawLine(Offset(left, y1), Offset(right, y1), paint);
    canvas.drawLine(Offset(left, y2), Offset(right, y2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
