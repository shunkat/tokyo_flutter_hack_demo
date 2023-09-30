import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:tokyo_flutter_hack_demo/features/image_picker/image_picker_page2.dart';

class ImagePickerCollection extends HookConsumerWidget {
  final AssetPathEntity directory;
  final Function(List<AssetEntity>)? onLoaded;
  final Function(AssetEntity)? onSelected;
  final WidgetRef? forcedRef;
  const ImagePickerCollection({
    required this.directory,
    this.onLoaded,
    this.onSelected,
    this.forcedRef,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef widgetRef) {
    final ref = forcedRef ?? widgetRef;
    final selectImageController = ref.watch(selectedImageProvider.notifier);
    final images = useState<List<AssetEntity>?>(null);

    useEffect(() {
      getImages().then((value) {
        images.value = value;
      });

      return null;
    }, [directory]);

    return GridImageList(
      images: images.value ?? [],
      onSelected: (asset) {
        print("selected");
        selectImageController.state = asset;
        print(selectImageController.hashCode);
        onSelected?.call(asset);
      },
    );
  }

  Future<List<AssetEntity>> getImages() async {
    final assetCount = await directory.assetCountAsync;
    final images = await directory.getAssetListRange(start: 0, end: assetCount);
    return images;
  }
}

class GridImageList extends StatelessWidget {
  final List<AssetEntity> images;
  final Color placeholderColor;
  final void Function(AssetEntity) onSelected;
  const GridImageList({
    Key? key,
    required this.images,
    required this.onSelected,
    this.placeholderColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (_, i) {
        return FutureBuilder<Uint8List?>(
          future: images[i].thumbnailData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GestureDetector(
                child: Image.memory(
                  snapshot.data!,
                  fit: BoxFit.cover,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) {
                      return child;
                    } else {
                      return AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeOut,
                        child: child,
                      );
                    }
                  },
                ),
                onTap: () {
                  onSelected(images[i]);
                },
              );
            } else {
              return Container(
                color: placeholderColor,
                width: 100,
                height: 100,
              );
            }
          },
        );
      },
      itemCount: images.length,
    );
  }
}
