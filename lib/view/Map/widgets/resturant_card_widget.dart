import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ResturantCardWidget extends StatefulWidget {
  const ResturantCardWidget({super.key});

  @override
  State<ResturantCardWidget> createState() => _ResturantCardWidgetState();
}

class _ResturantCardWidgetState extends State<ResturantCardWidget> {
  final MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 150.h,
      child: GetBuilder<MainController>(
        builder: (controller) => controller.selectedRestaurant.rating != null
            ? Visibility(
                visible: controller.showRestaurantInfo.value,
                child: AnimatedSlide(
                  offset: const Offset(0, 1),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: InkWell(
                    onTap: () {
                      controller.onMarkerTapped();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 0,
                        right: 5.w,
                        left: 5.w,
                      ),
                      height: 140.h,
                      padding: EdgeInsets.symmetric(
                        vertical: 5.h,
                        horizontal: 5.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildRestaurantImage(),
                          _buildRestaurantInfo(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildRestaurantImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.sp),
      child: CachedNetworkImage(
        imageUrl: controller.selectedRestaurant.photoReference != null
            ? controller.getPhotoUrl(controller.selectedRestaurant.photoReference!)
            : '',
        width: 115.w,
        height: 200.h,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: 115.w,
          height: 200.h,
          child: Image.asset(
            'assets/images/resturant.jpg',
            fit: BoxFit.fill,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  Widget _buildRestaurantInfo() {
    return Padding(
      padding: EdgeInsets.all(10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildLocation(),
          _buildStatus(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 215.w,
          child: Text(
            controller.selectedRestaurant.name.length > 20
                ? controller.selectedRestaurant.name.substring(0, 20)
                : controller.selectedRestaurant.name,
            style: TextStyle(
              fontSize: 16.0.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        _buildBackButton(),
      ],
    );
  }

  Widget _buildBackButton() {
    return InkWell(
      onTap: () {
        controller.showRestaurantInfo.value = false;
        controller.showLocation.value = false;
        controller.showMap.value = true;
        controller.markers.clear();
        controller.update();
      },
      child: Image.asset(
        'assets/images/filter.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildLocation() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on_outlined,
          color: AppColors.primary,
          size: 22.sp,
        ),
        Text(
          controller.selectedRestaurant.address!.length > 25
              ? controller.selectedRestaurant.address!.substring(0, 25)
              : controller.selectedRestaurant.address!,
          style: TextStyle(
            fontSize: 14.0.sp,
            color: AppColors.textSecoundary,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _buildStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 205.w,
          child: Text(
            controller.selectedRestaurant.isOpen != null
                ? 'open'.tr
                : 'closed'.tr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize:16.sp,
              color: controller.selectedRestaurant.isOpen != null
                  ? const Color.fromARGB(255, 44, 146, 47)
                  : Colors.red,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/star.png',
              fit: BoxFit.cover,
            ),
            Text(
              controller.selectedRestaurant.rating!.toDouble().toString(),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}