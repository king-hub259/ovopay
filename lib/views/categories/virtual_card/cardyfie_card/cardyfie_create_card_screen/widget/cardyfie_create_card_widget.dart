part of "../cardyfie_create_card_screen.dart";

class CardyfieCreateCardWidget extends StatelessWidget {
  CardyfieCreateCardWidget({super.key});
  final controller = Get.put(VirtualCardyfieCardController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _inputWidget(context),
        _walletWidget(context),
        // _chargeWidget(context),
        _buttonWidget(context),
        _buttonCustomerUpdateWidget(context),
      ],
    );
  }

  Column _walletWidget(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Container(
            margin: EdgeInsets.only(bottom: Dimensions.heightSize),
            child: CustomDropDown<SupportedCurrency>(
              items: controller.supportedCurrencyList,
              title: Strings.cardCurrency,
              hint: controller.supportedCurrencyCode.value,

              onChanged: (value) {
                controller.selectSupportedCurrency.value = value!;
                controller.supportedCurrencyCode.value = value.code.toString();
              },
              padding: EdgeInsets.only(
                left: Dimensions.paddingSize * 0.5,
                right: Dimensions.paddingSize * 0.3,
              ),
              titleTextColor: CustomColor.primaryLightColor,
              titleStyle: TextStyle(color: CustomColor.primaryLightColor),
              borderEnable: true,
              dropDownColor: CustomColor.whiteColor,
            ),
          ),
        ),

        // from currency come to user wallet
        Obx(
          () => Container(
            margin: EdgeInsets.only(bottom: Dimensions.heightSize),
            child: CustomDropDown<UserWallet>(
              items: controller.walletsList,
              title: Strings.fromWallet,
              hint: controller.selectMainWallet.value!.title,
              onChanged: (value) {
                controller.selectMainWallet.value = value!;
                controller.fromCurrency.value = value.currency.code.toString();
              },
              padding: EdgeInsets.only(
                left: Dimensions.paddingSize * 0.5,
                right: Dimensions.paddingSize * 0.3,
              ),
              titleTextColor: CustomColor.primaryLightColor,
              titleStyle: TextStyle(color: CustomColor.primaryLightColor),
              borderEnable: true,
              dropDownColor: CustomColor.whiteColor,
            ),
          ),
        ),
      ],
    );
  }

  Column _inputWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        verticalSpace(Dimensions.heightSize),
        PrimaryTextInputWidget(
          controller: controller.cardHolderNameController,
          hint: Strings.cardHolder,
          labelText: Strings.cardHolder,
        ),
        verticalSpace(Dimensions.heightSize),
        CustomTitleHeadingWidget(
          text: Strings.cardTier,
          style: CustomStyle.lightHeading4TextStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
        KycDynamicDropDown(
          selectMethod: controller.selectTierName,
          itemsList: controller.cardTierList.map((e) => e['name']!).toList(),
          onChanged: (value) {
            controller.selectTierName.value = value!;

            final selectedItem = controller.cardTierList.firstWhere(
              (item) => item['name'] == value,
            );
            controller.selectTierSlug.value = selectedItem['slug']!;
          },
        ),
        verticalSpace(Dimensions.heightSize),
        CustomTitleHeadingWidget(
          text: Strings.cardType,
          style: CustomStyle.lightHeading4TextStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: Dimensions.marginBetweenInputTitleAndBox),
        KycDynamicDropDown(
          selectMethod: controller.selectCardTypeName,
          itemsList: controller.cardTypeList.map((e) => e['name']!).toList(),
          onChanged: (value) {
            controller.selectCardTypeName.value = value!;

            final selectedItem = controller.cardTypeList.firstWhere(
              (item) => item['name'] == value,
            );
            controller.selectCardTypeSlug.value = selectedItem['slug']!;
          },
        ),
        verticalSpace(Dimensions.heightSize),
      ],
    );
  }

  Container _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.paddingSize * 2,
        // bottom: Dimensions.paddingSize * 4.8,
      ),
      child: Obx(
        () => controller.isBuyCardLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.confirm,
                onPressed: () {
                  controller.issueCardProcess(context);
                },
                borderColor: CustomColor.primaryLightColor,
                buttonColor: CustomColor.primaryLightColor,
              ),
      ),
    );
  }

  Container _buttonCustomerUpdateWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.paddingSize,
        bottom: Dimensions.paddingSize * 4.8,
      ),
      child: Obx(
        () => controller.isCustomerCreateLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.updateCustomer,
                onPressed: () {
                  Get.toNamed(Routes.cardyfieUpdateCustomerScreen);
                },
                borderColor: CustomColor.primaryLightColor,
                buttonColor: CustomColor.primaryLightColor,
              ),
      ),
    );
  }
}
