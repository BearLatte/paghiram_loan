import 'package:flutter/material.dart';
import 'package:paghiram_loan/common/common_snack_bar.dart';
import 'package:paghiram_loan/models/product_model_entity.dart';
import 'package:paghiram_loan/util/global.dart';
import 'package:paghiram_loan/widget/count_down_widget.dart';

import '../../common/common_image.dart';
import '../../util/constant.dart';
import '../../util/hex_color.dart';

enum ProductStatus { normal, unverified, pending, canBorrow, rollback, repayment, reloan, offlineWithdraw, reject, paying, payFailed }

class ProductStatusItem {
  static Widget generateProductItem(ProductModelEntity product, {Function()? buttonClickedCallback}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: product.productState == ProductStatus.normal ? const BorderRadius.vertical(top: Radius.circular(10)) : BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(12, 17, 12, 17),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: HexColor('#FFE6E6E6'), width: 0.5))),
            child: Row(children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CommonImage(src: _getProductIcon(product.productState)),
                  if (product.productState == ProductStatus.normal) const Positioned(left: -10, top: -14, child: CommonImage(src: 'asset/icons/crown.png'))
                ],
              ),
              const Padding(padding: EdgeInsets.only(left: 4)),
              Expanded(
                  child: Text(product.appNames,
                      style: TextStyle(color: HexColor('#FF102729'), fontSize: 16, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis, maxLines: 1, softWrap: true))
            ]),
          ),
          if (product.productState == ProductStatus.normal || product.productState == ProductStatus.reloan || product.productState == ProductStatus.unverified)
            _getNormalStatusContent(product: product, applyClickedCallback: buttonClickedCallback),
          if (product.productState == ProductStatus.pending) _getPendingStatusContent(product: product),
          if (product.productState == ProductStatus.rollback || product.productState == ProductStatus.reject)
            _getRollbackOrRejectStatusContent(product.productState, product: product, buttonClickedCallback: buttonClickedCallback),
          if (product.productState == ProductStatus.canBorrow) _getWithdrawStatusContent(product: product, buttonClickedCallback: buttonClickedCallback),
          if (product.productState == ProductStatus.payFailed) _getPayFailedStatusContent(product: product, buttonClickedCallback: buttonClickedCallback),
          if (product.productState == ProductStatus.paying) _getPayingStatusContent(product: product),
          if (product.productState == ProductStatus.repayment) _getRepaymentStatusContent(product: product, buttonClickedCallback: buttonClickedCallback),
        ],
      ),
    );
  }

  static String _getProductIcon(ProductStatus status) {
    switch (status) {
      case ProductStatus.pending:
        return 'asset/icons/product_logo_pending.png';
      case ProductStatus.rollback:
      case ProductStatus.paying:
      case ProductStatus.reject:
        return 'asset/icons/product_logo_rollback.png';
      default:
        return 'asset/icons/product_logo_normal.png';
    }
  }

  static Widget _getNormalStatusContent({required ProductModelEntity product, Function? applyClickedCallback}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(color: HexColor('#FFFAFAFA'), borderRadius: BorderRadius.circular(4)),
            child: Center(child: Text('Term : ${product.loanTerm}', style: TextStyle(fontSize: 13, color: HexColor('#FF757F8C')))),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(color: HexColor('#FFFAFAFA'), borderRadius: BorderRadius.circular(4)),
            child: Center(child: Text('Rate : ${product.rate}%', style: TextStyle(fontSize: 13, color: HexColor('#FF757F8C')))),
          ),
        ]),
        const SizedBox(height: 24),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('PHP ${product.minMoneyFormat} ~ ${product.maxMoneyFormat}', style: TextStyle(color: Constant.themeColor, fontSize: 20, fontFamily: 'Impact')),
          ElevatedButton(
              onPressed: () => applyClickedCallback!(),
              style: ElevatedButton.styleFrom(backgroundColor: Constant.themeColor),
              child: const Text('Apply Now', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)))
        ])
      ]),
    );
  }

  static Widget _getPendingStatusContent({required ProductModelEntity product, int? countdownTime, String? statusDescription, Function()? countdownStopCallback}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
      child: Column(
        children: [
          Text('Under Review , The approval result will be given within 12 hours at the latest', style: TextStyle(fontSize: 15, color: HexColor('#FF3B414B'))),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              CommonSnackBar.showSnackBar('Under Review , The approval result will be given within 12 hours at the latest');
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 9),
              decoration: BoxDecoration(color: HexColor('#1AFFA940'), borderRadius: BorderRadius.circular(6)),
              child: Text('Please wait', style: TextStyle(color: HexColor('#FFFFA940'), fontSize: 15)),
            ),
          )
        ],
      ),
    );
  }

  static Widget _getRollbackOrRejectStatusContent(ProductStatus status, {required ProductModelEntity product, Function()? buttonClickedCallback}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        children: [
          Text(status == ProductStatus.rollback ? 'Application rollback!' : 'Approval rejected!',
              style: TextStyle(color: HexColor('#FFFF3232'), fontSize: 16, fontWeight: FontWeight.bold)),
          if (status == ProductStatus.rollback)
            Text('Please make sure that the photo you submit is clear and the ID is within the validity period.', style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 15)),
          if (status == ProductStatus.reject)
            Text.rich(TextSpan(children: [
              TextSpan(text: 'Sorry, you application has not been approved! You can reapply after ', style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 15)),
              TextSpan(text: '${product.countDown}', style: TextStyle(color: HexColor('#FFFF3232'), fontSize: 15)),
              TextSpan(text: ' days ', style: TextStyle(color: HexColor('#FF3B414B'), fontSize: 15)),
            ])),
          Container(
            width: 130,
            height: 40,
            margin: const EdgeInsets.only(top: 16),
            child: ElevatedButton(
              onPressed: buttonClickedCallback,
              style: ElevatedButton.styleFrom(backgroundColor: HexColor('#FFFF3232')),
              child: Text(
                status == ProductStatus.rollback ? 'Modify' : 'Feedback',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  static Widget _getWithdrawStatusContent({required ProductModelEntity product, Function()? buttonClickedCallback}) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Maximum amount required', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
          SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('PHP ${product.maxMoneyFormat}', style: TextStyle(color: Constant.themeColor, fontSize: 20, fontFamily: 'Impact')),
            ElevatedButton(
              onPressed: () => buttonClickedCallback!(),
              style: ElevatedButton.styleFrom(backgroundColor: Constant.themeColor),
              child: const Text('Withdraw money', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
            )
          ]),
          SizedBox(height: 12),
          Text('Loan approval granted, proceed to withdraw funds.', style: TextStyle(color: HexColor('#FFAAAAAA'), fontSize: 13))
        ],
      ),
    );
  }

  static Widget _getPayFailedStatusContent({required ProductModelEntity product, Function()? buttonClickedCallback}) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('Maximum amount required', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
        SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('PHP ${product.maxMoneyFormat}', style: TextStyle(color: Constant.themeColor, fontSize: 20, fontFamily: 'Impact')),
          ElevatedButton(
            onPressed: () => buttonClickedCallback!(),
            style: ElevatedButton.styleFrom(backgroundColor: Constant.themeColor),
            child: const Text('Re-Loan', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          )
        ]),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(color: HexColor('#1AFF3232'), borderRadius: BorderRadius.circular(10)),
          child: Text('Warning! Payment failed. Please attempt to withdraw money again.', style: TextStyle(color: HexColor('#FFFF3232'), fontSize: 13)),
        )
      ]),
    );
  }

  static Widget _getPayingStatusContent({required ProductModelEntity product}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 10),
          child: Text('Paying!', style: TextStyle(color: HexColor('#FFFFA940'), fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Text('The system is processing the remittance. Please wait patiently. If the payment fails, you can log into the app to request a re-remittance.')
      ]),
    );
  }

  static Widget _getRepaymentStatusContent({required ProductModelEntity product, Function()? buttonClickedCallback}) {
    return Container(
        padding: EdgeInsets.all(12),
        child: Column(children: [
          Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Refund amount', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
                  SizedBox(height: 12),
                  Text('PHP ${Global.formatCurrency(product.money ?? 0)}', style: TextStyle(color: Constant.themeColor, fontSize: 20, fontFamily: 'Impact'))
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Payment time', style: TextStyle(color: HexColor('#FF102729'), fontSize: 15)),
                  SizedBox(height: 12),
                  Text(product.backTimeDate,
                      style: TextStyle(color: product.overdueDays > 0 ? HexColor('#FFFF3232') : HexColor('#FF102729'), fontSize: 20, fontWeight: FontWeight.w600))
                ],
              ),
            ),
          ]),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => buttonClickedCallback!(),
            style: ElevatedButton.styleFrom(backgroundColor: product.overdueDays > 0 ? HexColor('#FFFF3232') : Constant.themeColor),
            child: const Text('Repay', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: product.overdueDays > 0 ? HexColor('#1AFF3232') : HexColor('#1AFFA940'), borderRadius: BorderRadius.circular(8)),
            child: Text(
              product.overdueDays > 0 ? 'Overdue ${product.overdueDays} days , please repay as soon as possible' : 'Repay on time to maintain good credit',
              style: TextStyle(color: product.overdueDays > 0 ? HexColor('#FFFF3232') : HexColor('#FFFFA940'), fontSize: 13),
            ),
          )
        ]));
  }
}
