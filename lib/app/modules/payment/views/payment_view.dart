// ignore_for_file: no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_unnecessary_containers, avoid_renaming_method_parameters, prefer_interpolation_to_compose_strings, unused_import
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:foodking/widget/custom_snackbar.dart';
import 'package:get/get.dart';
import '../../../../util/api-list.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/custom_toast.dart';
import '../../order/controllers/order_controller.dart';
import 'payment_failed_view.dart';

class PaymentView extends StatefulWidget {
  final int? orderId;
  const PaymentView({super.key, this.orderId});
  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  String? selectedUrl;
  double value = 0.0;
  bool isLoading = true;
  PullToRefreshController pullToRefreshController = PullToRefreshController();
  MyInAppBrowser? browser;

  @override
  void initState() {
    super.initState();
    selectedUrl = APIList.paymentUrl! + widget.orderId.toString() + "/pay";
    _initData();
  }

  void _initData() async {
    browser = MyInAppBrowser();
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

      bool swAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
      bool swInterceptAvailable =
          await AndroidWebViewFeature.isFeatureSupported(
              AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

      if (swAvailable && swInterceptAvailable) {
        AndroidServiceWorkerController serviceWorkerController =
            AndroidServiceWorkerController.instance();
        await serviceWorkerController
            .setServiceWorkerClient(AndroidServiceWorkerClient(
          shouldInterceptRequest: (request) async {
            return null;
          },
        ));
      }
    }

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: AppColor.primaryColor,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          browser?.webViewController.reload();
        } else if (Platform.isIOS) {
          browser?.webViewController.loadUrl(
              urlRequest:
                  URLRequest(url: await browser?.webViewController.getUrl()));
        }
      },
    );
    browser?.pullToRefreshController = pullToRefreshController;

    await browser?.openUrlRequest(
      urlRequest: URLRequest(url: Uri.parse(selectedUrl!)),
      options: InAppBrowserClassOptions(
        crossPlatform:
            InAppBrowserOptions(hideUrlBar: true, hideToolbarTop: true),
        inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true, useOnLoadResource: true),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'DIGITAL_PAYMENT'.tr,
          style: fontBoldWithColorBlack,
        ),
      ),
      body: Center(
        child: Container(
          child: Stack(
            children: [
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColor.primaryColor)),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyInAppBrowser extends InAppBrowser {
  bool _canRedirect = true;

  @override
  Future onBrowserCreated() async {}

  @override
  Future onLoadStart(url) async {
    _pageRedirect(url.toString());
  }

  @override
  Future onLoadStop(url) async {
    pullToRefreshController?.endRefreshing();
    _pageRedirect(url.toString());
  }

  @override
  void onLoadError(url, code, message) {
    pullToRefreshController?.endRefreshing();
  }

  @override
  void onProgressChanged(progress) {
    if (progress == 100) {
      pullToRefreshController?.endRefreshing();
    }
  }

  @override
  void onExit() {
    if (_canRedirect) {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: const AlertDialog(
              contentPadding: EdgeInsets.all(10),
              content: PaymentFailedView(),
            ),
          );
        },
      );
    }
  }

  @override
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
      navigationAction) async {
    return NavigationActionPolicy.ALLOW;
  }

  @override
  void onLoadResource(response) {
    // print("Started at: " + response.startTime.toString() + "ms ---> duration: " + response.duration.toString() + "ms " + (response.url ?? '').toString());
  }

  @override
  void onConsoleMessage(consoleMessage) {}

  void _pageRedirect(String url) async {
    Future.delayed(const Duration(seconds: 3), () {
      if (_canRedirect) {
        bool _isSuccess =
            url.contains('successful') && url.contains(APIList.baseUrl!);
        bool _isFailed = url.contains('fail') && url.contains(APIList.baseUrl!);
        bool _isCancel =
            url.contains('cancel') && url.contains(APIList.baseUrl!);
        bool _isBack = url.contains('home') && url.contains(APIList.baseUrl!);
        if (_isSuccess || _isFailed || _isCancel || _isBack) {
          _canRedirect = false;
          close();
        }
        if (_isSuccess) {
          // Future.delayed(const Duration(seconds: 3), () {
          Get.find<OrderController>()
              .getOrderDetails(Get.find<OrderController>().orderId!);
          Get.back();
          // customTast("YOUR_PAYMENT_HAS_BEEN_CONFIRMED".tr, AppColor.success);
          customSnackbar("DIGITAL_PAYMENT".tr,
              "YOUR_PAYMENT_HAS_BEEN_CONFIRMED".tr, AppColor.success);
          // });
        } else if (_isFailed || _isCancel || _isBack) {
          Get.back();
          customSnackbar(
              "DIGITAL_PAYMENT".tr, "PAYMENT_FAILED".tr, AppColor.error);
        }
      }
    });
  }
}
