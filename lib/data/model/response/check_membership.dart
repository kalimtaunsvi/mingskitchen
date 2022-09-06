class CheckMembership {
  int id;
  String userId;
  String membershipId;
  String buyAt;
  String expireAt;
  String payStatus;
  String createdAt;
  Null updatedAt;
  Null deletedAt;
  Usermembershipplan usermembershipplan;

  CheckMembership(
      {this.id,
      this.userId,
      this.membershipId,
      this.buyAt,
      this.expireAt,
      this.payStatus,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.usermembershipplan});

  CheckMembership.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    membershipId = json['membership_id'];
    buyAt = json['buy_at'];
    expireAt = json['expire_at'];
    payStatus = json['pay_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    usermembershipplan = json['usermembershipplan'] != null
        ? Usermembershipplan.fromJson(json['usermembershipplan'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['membership_id'] = this.membershipId;
    data['buy_at'] = this.buyAt;
    data['expire_at'] = this.expireAt;
    data['pay_status'] = this.payStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.usermembershipplan != null) {
      data['usermembershipplan'] = this.usermembershipplan.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'CheckMembership(id: $id, userId: $userId, membershipId: $membershipId, buyAt: $buyAt, expireAt: $expireAt, payStatus: $payStatus, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, usermembershipplan: $usermembershipplan)';
  }
}

class Usermembershipplan {
  int id;
  String title;
  String des;
  String price;
  String duration;
  String discount;
  String createdAt;
  String updatedAt;
  Null deletedAt;

  Usermembershipplan(
      {this.id,
      this.title,
      this.des,
      this.price,
      this.duration,
      this.discount,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Usermembershipplan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    des = json['des'];
    price = json['price'];
    duration = json['duration'];
    discount = json['discount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['des'] = this.des;
    data['price'] = this.price;
    data['duration'] = this.duration;
    data['discount'] = this.discount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }

  @override
  String toString() {
    return 'Usermembershipplan(id: $id, title: $title, des: $des, price: $price, duration: $duration, discount: $discount, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }
}
