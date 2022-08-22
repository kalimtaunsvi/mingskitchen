class MembershipPlanModel {
  int id;
  String title;
  String des;
  String price;
  String duration;
  String discount;
  String createdAt;
  String updatedAt;
  Null deletedAt;

  MembershipPlanModel({
    this.id,
    this.title,
    this.des,
    this.price,
    this.duration,
    this.discount,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  MembershipPlanModel.fromJson(Map<String, dynamic> json) {
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
    return 'MembershipPlanModel(id: $id, title: $title, des: $des, price: $price, duration: $duration, discount: $discount, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MembershipPlanModel &&
        other.id == id &&
        other.title == title &&
        other.des == des &&
        other.price == price &&
        other.duration == duration &&
        other.discount == discount &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        des.hashCode ^
        price.hashCode ^
        duration.hashCode ^
        discount.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode;
  }
}
