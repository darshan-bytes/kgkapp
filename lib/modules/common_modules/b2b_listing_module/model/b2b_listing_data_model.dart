import 'package:kgk/kgk.dart';

/// [B2BCustomListingDataModel] -  Here we are defining the wrapper Data model for B2B listing.
/// This model is designed to store and manage information related to B2B listings within the application.

class B2BCustomListingDataModel {
  String? id;
  String? conceptNumber;
  String? presentation;
  String? conceptName;
  OrderStatus? status;
  String? assignTo;
  String? assignToImageUrl;
  String? approvedBy;
  String? approvedByImageUrl;
  String? market;
  String? marketFlagImageUrl;
  String? createdBy;
  String? createdByImageUrl;
  String? createdOn;
  String? presentationNumber;
  String? project;
  String? projectNumber;
  String? projectName;
  String? design;
  String? customer;
  String? customerImageUrl;
  OrderStatus? holdStatus;
  String? dbfNumber;
  String? jewelleryType;
  String? subJewelleryType;
  String? version;
  String? designNumber;
  String? salesman;
  String? salesmanImageUrl;
  OrderStatus? designApproval;
  OrderStatus? stylesStatus;
  String? styleNumber;
  String? stoneCardLocked;
  String? exclusive;
  String? exclusiveCustomer;
  String? exclusiveCustomerImageUrl;
  OrderStatus? designCreation;
  OrderStatus? dbfApproval;
  String? revisedDate;
  String? name;
  String? nameImageUrl;
  String? from;
  String? to;
  String? numberOfProduct;
  String? remainingTime;
  String? itemSold;
  String? ordersReceived;
  String? totalSell;
  String? averageOrderValue;
  String? leads;
  String? orderId;
  String? orderName;
  String? items;
  String? orderOn;
  String? quality;
  OrderStatus? orderStatus;
  String? customerName;
  String? customerNameImageUrl;
  String? mobileNumber;
  OrderStatus? salesOrder;
  String? businessType;
  String? businessTypeImageUrl;
  String? companyRepresentative;
  String? email;
  String? addedOn;
  OrderStatus? purchaseOrder;
  String? totalAmount;
  String? designListingImageUrl;
  String? stoneCardLockedImageUrl;
  String? designer;
  String? designerImageUrl;
  String? approvedOn;
  String? orderedBy;
  String? orderedByImageUrl;

  B2BCustomListingDataModel({
    this.id,
    this.conceptNumber,
    this.presentation,
    this.conceptName,
    this.status,
    this.assignTo,
    this.assignToImageUrl,
    this.approvedBy,
    this.approvedByImageUrl,
    this.market,
    this.marketFlagImageUrl,
    this.createdBy,
    this.createdOn,
    this.presentationNumber,
    this.project,
    this.projectNumber,
    this.projectName,
    this.design,
    this.customer,
    this.customerImageUrl,
    this.holdStatus,
    this.dbfNumber,
    this.jewelleryType,
    this.subJewelleryType,
    this.version,
    this.designNumber,
    this.salesman,
    this.designApproval,
    this.stylesStatus,
    this.styleNumber,
    this.stoneCardLocked,
    this.exclusive,
    this.exclusiveCustomer,
    this.exclusiveCustomerImageUrl,
    this.designCreation,
    this.dbfApproval,
    this.revisedDate,
    this.name,
    this.nameImageUrl,
    this.from,
    this.to,
    this.numberOfProduct,
    this.remainingTime,
    this.itemSold,
    this.ordersReceived,
    this.totalSell,
    this.averageOrderValue,
    this.leads,
    this.orderId,
    this.orderName,
    this.items,
    this.orderOn,
    this.quality,
    this.orderStatus,
    this.customerName,
    this.customerNameImageUrl,
    this.mobileNumber,
    this.salesOrder,
    this.businessType,
    this.businessTypeImageUrl,
    this.companyRepresentative,
    this.email,
    this.addedOn,
    this.purchaseOrder,
    this.totalAmount,
    this.designer,
    this.designerImageUrl,
    this.approvedOn,
    this.orderedBy,
    this.orderedByImageUrl,
  });
}
