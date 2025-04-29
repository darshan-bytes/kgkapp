import 'package:kgk/kgk.dart';

class B2BCustomListingDataModel {
  String? id;
  String? strConceptNumber;
  String? strPresentation;
  String? strConceptName;
  String? strConceptBy;
  ProjectStatus? status;
  String? strApprovedBy;
  String? strApprovedByImageUrl;
  String? strMarket;
  String? strMarketFlagImageUrl;
  String? strCreatedBy;
  String? strCreatedByImageUrl;
  String? strCreatedOn;
  String? strPresentationNumber;
  String? strProject;
  String? strProjectNumber;
  String? strProjectName;
  String? strDesign;
  String? strCustomer;
  String? strCustomerImageUrl;
  ProjectStatus? holdStatus;
  String? strDbfNumber;
  String? strJewelleryType;
  String? strSubJewelleryType;
  String? strVersion;
  String? strDesignNumber;
  String? strSalesman;
  String? strSalesmanImageUrl;
  ProjectStatus? designApprovalStatus;
  ProjectStatus? stylesStatus;
  String? strStyleNumber;
  String? strStoneCardLocked;
  String? strExclusive;
  String? strExclusiveCustomer;
  String? strExclusiveCustomerImageUrl;
  ProjectStatus? designCreationStatus;
  ProjectStatus? dbfApprovalStatus;
  String? strRevisedDate;
  String? strName;
  String? strDescription;
  String? strNameImageUrl;
  String? strFrom;
  String? strTo;
  String? strNumberOfProduct;
  ValueNotifier<String>? strRemainingTime;
  String? strItemSold;
  String? strOrdersReceived;
  String? strTotalSell;
  String? strAverageOrderValue;
  String? strLeads;
  String? strOrderId;
  String? strOrderName;
  String? strItems;
  String? strOrderOn;
  String? strQuality;
  ProjectStatus? orderStatus;
  String? strCustomerName;
  String? strCustomerNameImageUrl;
  String? strMobileNumber;
  ProjectStatus? salesOrderStatus;
  String? strBusinessType;
  String? strBusinessTypeImageUrl;
  String? strCompanyRepresentative;
  String? strEmail;
  String? strAddedOn;
  ProjectStatus? purchaseOrderStatus;
  String? strTotalAmount;
  String? strDesignListingImageUrl;
  String? strStoneCardLockedImageUrl;
  String? strDesigner;
  String? strDesignerImageUrl;
  String? strApprovedOn;
  String? strOrderedBy;
  String? strOrderedByImageUrl;
  String? strPresentationImageUrl;
  bool isStoneCardLockedImage;
  String? strCADLibraryNumber;
  String? strCADLibraryProductName;
  String? strCADLibraryImageUrl;
  String? strCountry;
  String? strCountryImageUrl;
  String? strValidity;
  String? strTotalQuantity;
  String? strInquiryId;
  String? strType;
  String? strProduct;
  String? strComment;
  List<B2BItemField>? fields;
  List<String>? descriptionImageList;
  List<Presentation>? presentationList;
  String? strCarats;
  String? strGrams;
  String? tagImagePath;

  B2BCustomListingDataModel({
    this.id,
    this.strConceptNumber,
    this.strPresentation,
    this.strConceptName,
    this.strConceptBy,
    this.status,
    this.strApprovedBy,
    this.strApprovedByImageUrl,
    this.strMarket,
    this.strMarketFlagImageUrl,
    this.strCreatedBy,
    this.strCreatedByImageUrl,
    this.strCreatedOn,
    this.strPresentationNumber,
    this.strProject,
    this.strProjectNumber,
    this.strProjectName,
    this.strDesign,
    this.strCustomer,
    this.strCustomerImageUrl,
    this.holdStatus,
    this.strDbfNumber,
    this.strJewelleryType,
    this.strSubJewelleryType,
    this.strVersion,
    this.strDesignNumber,
    this.strSalesman,
    this.designApprovalStatus,
    this.stylesStatus,
    this.strStyleNumber,
    this.strStoneCardLocked,
    this.strExclusive,
    this.strExclusiveCustomer,
    this.strExclusiveCustomerImageUrl,
    this.designCreationStatus,
    this.dbfApprovalStatus,
    this.strRevisedDate,
    this.strName,
    this.strDescription,
    this.strNameImageUrl,
    this.strFrom,
    this.strTo,
    this.strNumberOfProduct,
    this.strRemainingTime,
    this.strItemSold,
    this.strOrdersReceived,
    this.strTotalSell,
    this.strAverageOrderValue,
    this.strLeads,
    this.strOrderId,
    this.strOrderName,
    this.strItems,
    this.strOrderOn,
    this.strQuality,
    this.orderStatus,
    this.strCustomerName,
    this.strCustomerNameImageUrl,
    this.strMobileNumber,
    this.salesOrderStatus,
    this.strBusinessType,
    this.strBusinessTypeImageUrl,
    this.strCompanyRepresentative,
    this.strEmail,
    this.strAddedOn,
    this.purchaseOrderStatus,
    this.strTotalAmount,
    this.strDesignListingImageUrl,
    this.strStoneCardLockedImageUrl,
    this.strDesigner,
    this.strDesignerImageUrl,
    this.strApprovedOn,
    this.strOrderedBy,
    this.strOrderedByImageUrl,
    this.strSalesmanImageUrl,
    this.strPresentationImageUrl,
    this.isStoneCardLockedImage = false,
    this.strCADLibraryNumber,
    this.strCADLibraryProductName,
    this.strCADLibraryImageUrl,
    this.strCountry,
    this.strCountryImageUrl,
    this.strValidity,
    this.strInquiryId,
    this.strType,
    this.strProduct,
    this.strComment,
    this.fields,
    this.descriptionImageList,
    this.presentationList,
    this.strTotalQuantity,
    this.strCarats,
    this.strGrams,
    this.tagImagePath,
  });
}
