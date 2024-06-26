import 'package:kgk/kgk.dart';

/// Factory class to generate a list of `PddItemField` objects based on the specified `B2BListingType`
/// and `B2BCustomListingDataModel`, providing structured data fields for different types of listings.

class B2BListingFieldFactory {
  static List<B2BItemField> getListingFields({required B2BListingType type, required B2BCustomListingDataModel model}) {
    switch (type) {
      case B2BListingType.conceptListingType:
        return [
          B2BItemField(label: APPStrings.conceptNumber.tr, value: model.strConceptNumber),
          B2BItemField(label: APPStrings.presentation.tr, value: model.strPresentation, isCircleWithValue: true),
          B2BItemField(label: APPStrings.conceptName.tr, value: model.strConceptName),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.assignTo.tr, value: model.strAssignTo, imageUrl: model.strAssignToImageUrl),
          B2BItemField(label: APPStrings.market.tr, value: model.strMarket, imageUrl: model.strMarketFlagImageUrl, isCircleImage: false),
          B2BItemField(label: APPStrings.createdBy.tr, value: model.strCreatedBy, imageUrl: model.strCreatedByImageUrl),
          B2BItemField(label: APPStrings.createdOn.tr, value: model.strCreatedOn),
        ];

      case B2BListingType.presentationType:
        return [
          B2BItemField(label: APPStrings.presentationNumber.tr, value: model.strPresentationNumber),
          B2BItemField(label: APPStrings.project.tr, value: model.strProject, isCircleWithValue: true),
          B2BItemField(label: APPStrings.conceptNumber.tr, value: model.strConceptNumber),
          B2BItemField(label: APPStrings.conceptName.tr, value: model.strConceptName),
          B2BItemField(label: APPStrings.createdBy.tr, value: model.strCreatedBy, imageUrl: model.strCreatedByImageUrl),
          B2BItemField(label: APPStrings.createdOn.tr, value: model.strCreatedOn),
          B2BItemField(label: APPStrings.assignTo.tr, value: model.strAssignTo, imageUrl: model.strAssignToImageUrl),
          B2BItemField(label: APPStrings.approvedBy.tr, value: model.strApprovedBy, imageUrl: model.strApprovedByImageUrl),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
        ];

      case B2BListingType.presentationListingType:
        return [
          B2BItemField(label: APPStrings.presentationNumber.tr, value: model.strPresentationNumber),
          B2BItemField(label: APPStrings.project.tr, value: model.strProject, isCircleWithValue: true),
          B2BItemField(label: APPStrings.conceptName.tr, value: model.strConceptName),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.createdBy.tr, value: model.strCreatedBy, imageUrl: model.strCreatedByImageUrl),
          B2BItemField(label: APPStrings.createdOn.tr, value: model.strCreatedOn),
          B2BItemField(label: APPStrings.assignTo.tr, value: model.strAssignTo, imageUrl: model.strAssignToImageUrl),
          B2BItemField(label: APPStrings.approvedBy.tr, value: model.strApprovedBy, imageUrl: model.strApprovedByImageUrl),
        ];

      case B2BListingType.projectListingType:
        return [
          B2BItemField(label: APPStrings.projectNumber.tr, value: model.strProjectNumber),
          B2BItemField(label: APPStrings.design.tr, value: model.strDesign, isCircleWithValue: true),
          B2BItemField(label: APPStrings.projectName.tr, value: model.strProjectName),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.customer.tr, value: model.strCustomer, imageUrl: model.strCustomerImageUrl),
          B2BItemField(label: APPStrings.holdStatus.tr, orderStatus: model.holdStatus),
          B2BItemField(label: APPStrings.createdBy.tr, value: model.strCreatedBy, imageUrl: model.strCreatedByImageUrl),
          B2BItemField(label: APPStrings.createdOn.tr, value: model.strCreatedOn),
        ];

      case B2BListingType.designBriefsType:
        return [
          B2BItemField(label: APPStrings.dbfNumber.tr, value: model.strDbfNumber),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.jewelleryType.tr, value: model.strJewelleryType),
          B2BItemField(label: APPStrings.subJewelleryType.tr, value: model.strSubJewelleryType),
          B2BItemField(label: APPStrings.createdBy.tr, value: model.strCreatedBy, imageUrl: model.strCreatedByImageUrl),
          B2BItemField(label: APPStrings.createdOn.tr, value: model.strCreatedOn),
          B2BItemField(label: APPStrings.assignTo.tr, value: model.strAssignTo, imageUrl: model.strAssignToImageUrl),
          B2BItemField(label: APPStrings.approvedBy.tr, value: model.strApprovedBy),
        ];

      case B2BListingType.designListingType:
        return [
          B2BItemField(isOnlyImageView: true, imageUrl: model.strDesignListingImageUrl),
          B2BItemField(label: APPStrings.version.tr, value: model.strVersion, isCircleWithValue: true),
          B2BItemField(label: APPStrings.designNumber.tr, value: model.strDesignNumber),
          B2BItemField(label: APPStrings.salesman.tr, value: model.strSalesman, imageUrl: model.strSalesmanImageUrl),
          B2BItemField(label: APPStrings.createdBy.tr, value: model.strCreatedBy, imageUrl: model.strCreatedByImageUrl),
          B2BItemField(label: APPStrings.createdOn.tr, value: model.strCreatedOn),
          B2BItemField(label: APPStrings.designApproval.tr, orderStatus: model.designApprovalStatus),
          B2BItemField(label: APPStrings.stylesStatus.tr, orderStatus: model.stylesStatus),
        ];

      case B2BListingType.stylesListingType:
        return [
          B2BItemField(label: APPStrings.styleNumber.tr, value: model.strStyleNumber),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.designNumber.tr, value: model.strDesignNumber),
          B2BItemField(label: APPStrings.customer.tr, value: model.strCustomer, imageUrl: model.strCustomerImageUrl),
          B2BItemField(label: APPStrings.market.tr, value: model.strMarket),
          B2BItemField(label: APPStrings.stoneCardLocked.tr, value: model.strStoneCardLocked, imageUrl: model.strStoneCardLockedImageUrl),
          B2BItemField(label: APPStrings.exclusive.tr, value: model.strExclusive),
          B2BItemField(
              label: APPStrings.exclusiveCustomer.tr, value: model.strExclusiveCustomer, imageUrl: model.strExclusiveCustomerImageUrl),
        ];

      case B2BListingType.monitoringPresentationListingType:
        return [
          B2BItemField(label: APPStrings.presentationNumber.tr, value: model.strPresentationNumber),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.conceptNumber.tr, value: model.strConceptNumber),
          B2BItemField(label: APPStrings.designer.tr, value: model.strDesigner, imageUrl: model.strDesignerImageUrl),
          B2BItemField(label: APPStrings.salesman.tr, value: model.strSalesman, imageUrl: model.strSalesmanImageUrl),
          B2BItemField(label: APPStrings.createdOn.tr, value: model.strCreatedOn),
          B2BItemField(label: APPStrings.approvedBy.tr, value: model.strApprovedBy, imageUrl: model.strApprovedByImageUrl),
          B2BItemField(label: APPStrings.approvedOn.tr, value: model.strApprovedOn),
        ];
      case B2BListingType.monitoringPresentationGridType:
        return [
          B2BItemField(label: APPStrings.presentationNumber.tr, value: model.strPresentationNumber),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.conceptNumber.tr, value: model.strConceptNumber),
          B2BItemField(label: APPStrings.salesman.tr, value: model.strSalesman, imageUrl: model.strSalesmanImageUrl),
          B2BItemField(label: APPStrings.designer.tr, value: model.strDesigner, imageUrl: model.strDesignerImageUrl),
          B2BItemField(label: APPStrings.createdOn.tr, value: model.strCreatedOn),
          B2BItemField(label: APPStrings.approvedBy.tr, value: model.strApprovedBy, imageUrl: model.strApprovedByImageUrl),
          B2BItemField(label: APPStrings.approvedOn.tr, value: model.strApprovedOn),
        ];
      case B2BListingType.monitoringDbfType:
        return [
          B2BItemField(label: APPStrings.dbfNumber.tr, value: model.strDbfNumber),
          B2BItemField(label: APPStrings.designCreation.tr, orderStatus: model.designCreationStatus),
          B2BItemField(label: APPStrings.customer.tr, value: model.strCustomer, imageUrl: model.strCustomerImageUrl),
          B2BItemField(label: APPStrings.designApproval.tr, orderStatus: model.designApprovalStatus),
          B2BItemField(label: APPStrings.salesman.tr, value: model.strSalesman, imageUrl: model.strSalesmanImageUrl),
          B2BItemField(label: APPStrings.dbfApproval.tr, orderStatus: model.dbfApprovalStatus),
          B2BItemField(label: APPStrings.revisedDate.tr, value: model.strRevisedDate),
          B2BItemField(label: APPStrings.holdStatus.tr, orderStatus: model.holdStatus),
        ];
      case B2BListingType.monitoringDesignsType:
        return [
          B2BItemField(isOnlyImageView: true, imageUrl: model.strDesignListingImageUrl),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.designNumber.tr, value: model.strDesignNumber),
          B2BItemField(label: APPStrings.dbfNumber.tr, value: model.strDbfNumber),
          B2BItemField(label: APPStrings.customer.tr, value: model.strCustomer, imageUrl: model.strCustomerImageUrl),
          B2BItemField(label: APPStrings.salesman.tr, value: model.strSalesman, imageUrl: model.strSalesmanImageUrl),
          B2BItemField(label: APPStrings.approvedBy.tr, value: model.strApprovedBy, imageUrl: model.strApprovedByImageUrl),
          B2BItemField(label: APPStrings.approvedOn.tr, value: model.strApprovedOn),
        ];
      case B2BListingType.monitoringStylesType:
        return [
          B2BItemField(isOnlyImageView: true, imageUrl: model.strDesignListingImageUrl),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.styleNumber.tr, value: model.strStyleNumber),
          B2BItemField(label: APPStrings.designNumber.tr, value: model.strDesignNumber),
          B2BItemField(label: APPStrings.customer.tr, value: model.strCustomer, imageUrl: model.strCustomerImageUrl),
          B2BItemField(label: APPStrings.salesman.tr, value: model.strSalesman, imageUrl: model.strSalesmanImageUrl),
          B2BItemField(label: APPStrings.approvedBy.tr, value: model.strApprovedBy, imageUrl: model.strApprovedByImageUrl),
          B2BItemField(label: APPStrings.approvedOn.tr, value: model.strApprovedOn),
        ];
      case B2BListingType.watchlistType:
        return [
          B2BItemField(label: APPStrings.name.tr, value: model.strName),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.conceptNumber.tr, value: model.strConceptNumber),
          B2BItemField(label: APPStrings.salesman.tr, value: model.strSalesman, imageUrl: model.strSalesmanImageUrl),
          B2BItemField(label: APPStrings.from.tr, value: model.strFrom),
          B2BItemField(label: APPStrings.to.tr, value: model.strTo),
          B2BItemField(label: APPStrings.numberOfProduct.tr, value: model.strNumberOfProduct),
          B2BItemField(label: APPStrings.remainingTime.tr, value: model.strRemainingTime),
        ];
      case B2BListingType.exhibitionDetailPageProductsType:
        return [
          B2BItemField(label: APPStrings.itemsSold.tr, value: model.strItemSold),
          B2BItemField(label: APPStrings.orderReceived.tr, value: model.strOrdersReceived),
          B2BItemField(label: APPStrings.totalSell.tr, value: model.strTotalSell),
          B2BItemField(label: APPStrings.averageOrderValue.tr, value: model.strAverageOrderValue),
          B2BItemField(label: APPStrings.leads.tr, value: model.strLeads),
        ];
      case B2BListingType.exhibitionDetailPageOrdersType:
        return [
          B2BItemField(label: APPStrings.orderId.tr, value: model.strOrderId),
          B2BItemField(label: APPStrings.orderName.tr, value: model.strOrderName),
          B2BItemField(label: APPStrings.market.tr, value: model.strMarket, imageUrl: model.strMarketFlagImageUrl, isCircleImage: false),
          B2BItemField(label: APPStrings.items.tr, value: model.strItems),
          B2BItemField(label: APPStrings.totalAmount.tr, value: model.strTotalAmount),
          B2BItemField(label: APPStrings.approvedBy.tr, value: model.strApprovedBy, imageUrl: model.strApprovedByImageUrl),
        ];
      case B2BListingType.retailerOrderListingJewelleryType:
        return [
          B2BItemField(label: APPStrings.orderId.tr, value: model.strOrderId),
          B2BItemField(label: APPStrings.orderStatus.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.customerName.tr, value: model.strCustomerName),
          B2BItemField(label: APPStrings.mobileNumber.tr, value: model.strMobileNumber),
          B2BItemField(label: APPStrings.items.tr, value: model.strItems),
          B2BItemField(label: APPStrings.quality.tr, value: model.strQuality),
          B2BItemField(label: APPStrings.orderedOn.tr, value: model.strOrderOn),
          B2BItemField(label: APPStrings.salesOrder.tr, orderStatus: model.salesOrderStatus),
        ];
      case B2BListingType.retailerOrderListingDiamondType:
        return [
          B2BItemField(label: APPStrings.orderId.tr, value: model.strOrderId),
          B2BItemField(label: APPStrings.status.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.orderedBy.tr, value: model.strOrderedBy, imageUrl: model.strOrderedByImageUrl),
          B2BItemField(label: APPStrings.mobileNumber.tr, value: model.strMobileNumber),
          B2BItemField(label: APPStrings.items.tr, value: model.strItems),
          B2BItemField(label: APPStrings.totalAmount.tr, value: model.strTotalAmount),
          B2BItemField(label: APPStrings.orderedOn.tr, value: model.strOrderOn),
        ];
      case B2BListingType.userListingType:
        return [
          B2BItemField(label: APPStrings.name.tr, value: model.strName, imageUrl: model.strNameImageUrl),
          B2BItemField(label: APPStrings.businessType.tr, value: model.strBusinessType, imageUrl: model.strBusinessTypeImageUrl),
          B2BItemField(label: APPStrings.companyRepresentative.tr, value: model.strCompanyRepresentative),
          B2BItemField(label: APPStrings.market.tr, value: model.strMarket, imageUrl: model.strMarketFlagImageUrl, isCircleImage: false),
          B2BItemField(label: APPStrings.email.tr, value: model.strEmail),
        ];
      case B2BListingType.newsletterSubscribersType:
        return [
          B2BItemField(label: APPStrings.name.tr, value: model.strName, imageUrl: model.strNameImageUrl),
          B2BItemField(label: APPStrings.email.tr, value: model.strEmail),
          B2BItemField(label: APPStrings.addedOn.tr, value: model.strAddedOn),
        ];
      case B2BListingType.manufacturerOrderListingType:
        return [
          B2BItemField(label: APPStrings.orderId.tr, value: model.strOrderId),
          B2BItemField(label: APPStrings.orderStatus.tr, orderStatus: model.status),
          B2BItemField(label: APPStrings.customerName.tr, value: model.strCustomerName, imageUrl: model.strCustomerImageUrl),
          B2BItemField(label: APPStrings.mobileNumber.tr, value: model.strMobileNumber),
          B2BItemField(label: APPStrings.items.tr, value: model.strItems),
          B2BItemField(label: APPStrings.quality.tr, value: model.strQuality),
          B2BItemField(label: APPStrings.orderedOn.tr, value: model.strOrderOn),
          B2BItemField(label: APPStrings.purchaseOrder.tr, orderStatus: model.purchaseOrderStatus),
        ];

      default:
        return [];
    }
  }
}
