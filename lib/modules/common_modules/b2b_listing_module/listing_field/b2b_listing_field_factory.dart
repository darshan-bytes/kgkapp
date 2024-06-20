import 'package:kgk/kgk.dart';

/// Factory class to generate a list of `PddItemField` objects based on the specified `B2BListingType`
/// and `B2BCustomListingDataModel`, providing structured data fields for different types of listings.

class B2BListingFieldFactory {
  static List<B2BItemField> getListingFields({required B2BListingType type, required B2BCustomListingDataModel model}) {
    switch (type) {
      case B2BListingType.conceptListingType:
        return [
          B2BItemField(label: APPStrings.conceptNumber.tr, value: model.conceptNumber),
          B2BItemField(label: APPStrings.presentation.tr, value: model.presentation, isCircleWithValue: true),
          B2BItemField(label: APPStrings.conceptName.tr, value: model.conceptName),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.assignTo.tr, value: model.assignTo, imageUrl: model.assignToImageUrl),
          B2BItemField(label: APPStrings.market.tr, value: model.market, imageUrl: model.marketFlagImageUrl, isCircleImage: false),
          B2BItemField(label: APPStrings.createdBy.tr, value: model.createdBy, imageUrl: model.createdByImageUrl),
          B2BItemField(label: APPStrings.createdOn.tr, value: model.createdOn),
        ];

      case B2BListingType.presentationType:
        return [
          B2BItemField(label: APPStrings.presentationNumber.tr, value: model.presentationNumber),
          B2BItemField(label: APPStrings.project.tr, value: model.project, isCircleWithValue: true),
          B2BItemField(label: APPStrings.conceptNumber.tr, value: model.conceptNumber),
          B2BItemField(label: APPStrings.conceptName.tr, value: model.conceptName),
          B2BItemField(label: APPStrings.createdBy.tr, value: model.createdBy, imageUrl: model.createdByImageUrl),
          B2BItemField(label: APPStrings.createdOn.tr, value: model.createdOn),
          B2BItemField(label: APPStrings.assignTo.tr, value: model.assignTo, imageUrl: model.assignToImageUrl),
          B2BItemField(label: APPStrings.approvedBy.tr, value: model.approvedBy, imageUrl: model.approvedByImageUrl),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
        ];

      case B2BListingType.presentationListingType:
        return [
          B2BItemField(label: APPStrings.presentationNumber.tr, value: model.presentationNumber),
          B2BItemField(label: APPStrings.project.tr, value: model.project, isCircleWithValue: true),
          B2BItemField(label: APPStrings.conceptName.tr, value: model.conceptName),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.createdBy.tr, value: model.createdBy, imageUrl: model.createdByImageUrl),
          B2BItemField(label: APPStrings.createdOn.tr, value: model.createdOn),
          B2BItemField(label: APPStrings.assignTo.tr, value: model.assignTo, imageUrl: model.assignToImageUrl),
          B2BItemField(label: APPStrings.approvedBy.tr, value: model.approvedBy, imageUrl: model.approvedByImageUrl),
        ];

      case B2BListingType.projectListingType:
        return [
          B2BItemField(label: APPStrings.projectNumber.tr, value: model.projectNumber),
          B2BItemField(label: APPStrings.design.tr, value: model.design, isCircleWithValue: true),
          B2BItemField(label: APPStrings.projectName.tr, value: model.projectName),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.customer.tr, value: model.customer, imageUrl: model.customerImageUrl),
          B2BItemField(label: APPStrings.holdStatus.tr, orderStatus: model.holdStatus),
          B2BItemField(label: APPStrings.createdBy.tr, value: model.createdBy, imageUrl: model.createdByImageUrl),
          B2BItemField(label: APPStrings.createdOn.tr, value: model.createdOn),
        ];

      case B2BListingType.designBriefsType:
        return [
          B2BItemField(label: APPStrings.dbfNumber.tr, value: model.dbfNumber),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.jewelleryType.tr, value: model.jewelleryType),
          B2BItemField(label: APPStrings.subJewelleryType.tr, value: model.subJewelleryType),
          B2BItemField(label: APPStrings.createdBy.tr, value: model.createdBy, imageUrl: model.createdByImageUrl),
          B2BItemField(label: APPStrings.createdOn.tr, value: model.createdOn),
          B2BItemField(label: APPStrings.assignTo.tr, value: model.assignTo, imageUrl: model.assignToImageUrl),
          B2BItemField(label: APPStrings.approvedBy.tr, value: model.approvedBy),
        ];

      case B2BListingType.designListingType:
        return [
          B2BItemField(isOnlyImageView: true, imageUrl: model.designListingImageUrl),
          B2BItemField(label: APPStrings.dbfNumber.tr, value: model.dbfNumber),
          B2BItemField(label: APPStrings.version.tr, value: model.version, isCircleWithValue: true),
          B2BItemField(label: APPStrings.designNumber.tr, value: model.designNumber),
          B2BItemField(label: APPStrings.salesman.tr, value: model.salesman, imageUrl: model.salesmanImageUrl),
          B2BItemField(label: APPStrings.createdBy.tr, value: model.createdBy, imageUrl: model.createdByImageUrl),
          B2BItemField(label: APPStrings.createdOn.tr, value: model.createdOn),
          B2BItemField(label: APPStrings.designApproval.tr, orderStatus: model.designApproval),
          B2BItemField(label: APPStrings.stylesStatus.tr, orderStatus: model.stylesStatus),
        ];

      case B2BListingType.stylesListingType:
        return [
          B2BItemField(label: APPStrings.styleNumber.tr, value: model.styleNumber),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.designNumber.tr, value: model.designNumber),
          B2BItemField(label: APPStrings.customer.tr, value: model.customer, imageUrl: model.customerImageUrl),
          B2BItemField(label: APPStrings.market.tr, value: model.market),
          B2BItemField(label: APPStrings.stoneCardLocked.tr, value: model.stoneCardLocked, imageUrl: model.stoneCardLockedImageUrl),
          B2BItemField(label: APPStrings.exclusive.tr, value: model.exclusive),
          B2BItemField(label: APPStrings.exclusiveCustomer.tr, value: model.exclusiveCustomer, imageUrl: model.exclusiveCustomerImageUrl),
        ];

      case B2BListingType.monitoringPresentationListingType:
        return [
          B2BItemField(label: APPStrings.presentationNumber.tr, value: model.presentationNumber),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.conceptNumber.tr, value: model.conceptNumber),
          B2BItemField(label: APPStrings.designer.tr, value: model.designer, imageUrl: model.designerImageUrl),
          B2BItemField(label: APPStrings.salesman.tr, value: model.salesman, imageUrl: model.salesmanImageUrl),
          B2BItemField(label: APPStrings.createdOn.tr, value: model.createdOn),
          B2BItemField(label: APPStrings.approvedBy.tr, value: model.approvedBy, imageUrl: model.approvedByImageUrl),
          B2BItemField(label: APPStrings.approvedOn.tr, value: model.approvedOn),
        ];
      case B2BListingType.monitoringPresentationGridType:
        return [
          B2BItemField(label: APPStrings.presentationNumber.tr, value: model.presentationNumber),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.conceptNumber.tr, value: model.conceptNumber),
          B2BItemField(label: APPStrings.salesman.tr, value: model.salesman, imageUrl: model.salesmanImageUrl),
          B2BItemField(label: APPStrings.designer.tr, value: model.designer, imageUrl: model.designerImageUrl),
          B2BItemField(label: APPStrings.createdOn.tr, value: model.createdOn),
          B2BItemField(label: APPStrings.approvedBy.tr, value: model.approvedBy, imageUrl: model.approvedByImageUrl),
          B2BItemField(label: APPStrings.approvedOn.tr, value: model.approvedOn),
        ];
      case B2BListingType.monitoringDbfType:
        return [
          B2BItemField(label: APPStrings.dbfNumber.tr, value: model.dbfNumber),
          B2BItemField(label: APPStrings.designCreation.tr, orderStatus: model.designCreation),
          B2BItemField(label: APPStrings.customer.tr, value: model.customer, imageUrl: model.customerImageUrl),
          B2BItemField(label: APPStrings.designApproval.tr, orderStatus: model.designApproval),
          B2BItemField(label: APPStrings.salesman.tr, value: model.salesman, imageUrl: model.salesmanImageUrl),
          B2BItemField(label: APPStrings.dbfApproval.tr, orderStatus: model.dbfApproval),
          B2BItemField(label: APPStrings.revisedDate.tr, value: model.revisedDate),
          B2BItemField(label: APPStrings.holdStatus.tr, orderStatus: model.holdStatus),
        ];
      case B2BListingType.monitoringDesignsType:
        return [
          B2BItemField(isOnlyImageView: true, imageUrl: model.designListingImageUrl),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.designNumber.tr, value: model.designNumber),
          B2BItemField(label: APPStrings.dbfNumber.tr, value: model.dbfNumber),
          B2BItemField(label: APPStrings.customer.tr, value: model.customer, imageUrl: model.customerImageUrl),
          B2BItemField(label: APPStrings.salesman.tr, value: model.salesman, imageUrl: model.salesmanImageUrl),
          B2BItemField(label: APPStrings.approvedBy.tr, value: model.approvedBy, imageUrl: model.approvedByImageUrl),
          B2BItemField(label: APPStrings.approvedOn.tr, value: model.approvedOn),
        ];
      case B2BListingType.monitoringStylesType:
        return [
          B2BItemField(isOnlyImageView: true, imageUrl: model.designListingImageUrl),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.styleNumber.tr, value: model.styleNumber),
          B2BItemField(label: APPStrings.designNumber.tr, value: model.designNumber),
          B2BItemField(label: APPStrings.customer.tr, value: model.customer, imageUrl: model.customerImageUrl),
          B2BItemField(label: APPStrings.salesman.tr, value: model.salesman, imageUrl: model.salesmanImageUrl),
          B2BItemField(label: APPStrings.approvedBy.tr, value: model.approvedBy, imageUrl: model.approvedByImageUrl),
          B2BItemField(label: APPStrings.approvedOn.tr, value: model.approvedOn),
        ];
      case B2BListingType.watchlistType:
        return [
          B2BItemField(label: APPStrings.name.tr, value: model.name),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.conceptNumber.tr, value: model.conceptNumber),
          B2BItemField(label: APPStrings.salesman.tr, value: model.salesman, imageUrl: model.salesmanImageUrl),
          B2BItemField(label: APPStrings.from.tr, value: model.from),
          B2BItemField(label: APPStrings.to.tr, value: model.to),
          B2BItemField(label: APPStrings.numberOfProduct.tr, value: model.numberOfProduct),
          B2BItemField(label: APPStrings.remainingTime.tr, value: model.remainingTime),
        ];
      case B2BListingType.exhibitionDetailPageProductsType:
        return [
          B2BItemField(label: APPStrings.itemsSold.tr, value: model.itemSold),
          B2BItemField(label: APPStrings.orderReceived.tr, value: model.ordersReceived),
          B2BItemField(label: APPStrings.totalSell.tr, value: model.totalSell),
          B2BItemField(label: APPStrings.averageOrderValue.tr, value: model.averageOrderValue),
          B2BItemField(label: APPStrings.leads.tr, value: model.leads),
        ];
      case B2BListingType.exhibitionDetailPageOrdersType:
        return [
          B2BItemField(label: APPStrings.orderId.tr, value: model.orderId),
          B2BItemField(label: APPStrings.orderName.tr, value: model.orderName),
          B2BItemField(label: APPStrings.market.tr, value: model.market, imageUrl: model.marketFlagImageUrl, isCircleImage: false),
          B2BItemField(label: APPStrings.items.tr, value: model.items),
          B2BItemField(label: APPStrings.totalAmount.tr, value: model.totalAmount),
          B2BItemField(label: APPStrings.approvedBy.tr, value: model.approvedBy, imageUrl: model.approvedByImageUrl),
        ];
      case B2BListingType.retailerOrderListingJewelleryType:
        return [
          B2BItemField(label: APPStrings.orderId.tr, value: model.orderId),
          B2BItemField(label: APPStrings.orderStatus.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.customerName.tr, value: model.customerName),
          B2BItemField(label: APPStrings.mobileNumber.tr, value: model.mobileNumber),
          B2BItemField(label: APPStrings.items.tr, value: model.items),
          B2BItemField(label: APPStrings.quality.tr, value: model.quality),
          B2BItemField(label: APPStrings.orderedOn.tr, value: model.orderOn),
          B2BItemField(label: APPStrings.salesOrder.tr, orderStatus: model.salesOrder),
        ];
      case B2BListingType.retailerOrderListingDiamondType:
        return [
          B2BItemField(label: APPStrings.orderId.tr, value: model.orderId),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.orderedBy.tr, value: model.orderedBy, imageUrl: model.orderedByImageUrl),
          B2BItemField(label: APPStrings.mobileNumber.tr, value: model.mobileNumber),
          B2BItemField(label: APPStrings.items.tr, value: model.items),
          B2BItemField(label: APPStrings.totalAmount.tr, value: model.totalAmount),
          B2BItemField(label: APPStrings.orderedOn.tr, value: model.orderOn),
        ];
      case B2BListingType.userListingType:
        return [
          B2BItemField(label: APPStrings.name.tr, value: model.name, imageUrl: model.nameImageUrl),
          B2BItemField(label: APPStrings.businessType.tr, value: model.businessType, imageUrl: model.businessTypeImageUrl),
          B2BItemField(label: APPStrings.companyRepresentative.tr, value: model.companyRepresentative),
          B2BItemField(label: APPStrings.market.tr, value: model.market, imageUrl: model.marketFlagImageUrl, isCircleImage: false),
          B2BItemField(label: APPStrings.email.tr, value: model.email),
        ];
      case B2BListingType.newsletterSubscribersType:
        return [
          B2BItemField(label: APPStrings.name.tr, value: model.name, imageUrl: model.nameImageUrl),
          B2BItemField(label: APPStrings.email.tr, value: model.email),
          B2BItemField(label: APPStrings.addedOn.tr, value: model.addedOn),
        ];
      case B2BListingType.manufacturerOrderListingType:
        return [
          B2BItemField(label: APPStrings.orderId.tr, value: model.orderId),
          B2BItemField(label: APPStrings.orderStatus.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.customerName.tr, value: model.customerName, imageUrl: model.customerImageUrl),
          B2BItemField(label: APPStrings.mobileNumber.tr, value: model.mobileNumber),
          B2BItemField(label: APPStrings.items.tr, value: model.items),
          B2BItemField(label: APPStrings.quality.tr, value: model.quality),
          B2BItemField(label: APPStrings.orderedOn.tr, value: model.orderOn),
          B2BItemField(label: APPStrings.purchaseOrder.tr, orderStatus: model.purchaseOrder),
        ];

      default:
        return [];
    }
  }
}
