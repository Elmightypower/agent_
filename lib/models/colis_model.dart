class ColisModel {
  String? status;
  List<Data>? data;

  ColisModel({this.status, this.data});

  ColisModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? colisNumber;
  String? colisShippementId;
  String? flightNumber;
  String? pickupCity;
  String? destinationCity;
  String? kiloColis;
  String? montantColis;
  String? nomDestinataire;
  String? contactDestinataire;
  String? statutColisRam;
  String? statutColisVerification;
  String? imageColis;
  String? qrCodeColis;
  String? createdAt;
  String? colisUserId;
  String? colisPriseId;
  String? shipUid;
  String? shipFlightNumber;
  String? villeExpeditionId;
  String? villeDestinationId;
  String? paysExpeditionId;
  String? paysDestinationId;
  String? typeColisId;
  String? kiloTransporte;
  String? totalMontantKilo;
  String? statutColisSoumis;
  String? statutColisRamasse;
  String? statutColisExpedie;
  String? statutColisLivre;
  String? statutVolShip;
  String? dateHeureDepart;
  String? dateHeureArrive;
  String? shipVolId;
  String? billetPhoto;
  String? shipId;
  String? shipUserId;
  String? typageColis;
  String? natureColis;
  String? villeExp;
  String? villeDest;
  String? nombreJours;

  Data(
      {this.colisNumber,
        this.colisShippementId,
        this.flightNumber,
        this.pickupCity,
        this.destinationCity,
        this.kiloColis,
        this.montantColis,
        this.nomDestinataire,
        this.contactDestinataire,
        this.statutColisRam,
        this.statutColisVerification,
        this.imageColis,
        this.qrCodeColis,
        this.createdAt,
        this.colisUserId,
        this.colisPriseId,
        this.shipUid,
        this.shipFlightNumber,
        this.villeExpeditionId,
        this.villeDestinationId,
        this.paysExpeditionId,
        this.paysDestinationId,
        this.typeColisId,
        this.kiloTransporte,
        this.totalMontantKilo,
        this.statutColisSoumis,
        this.statutColisRamasse,
        this.statutColisExpedie,
        this.statutColisLivre,
        this.statutVolShip,
        this.dateHeureDepart,
        this.dateHeureArrive,
        this.shipVolId,
        this.billetPhoto,
        this.shipId,
        this.shipUserId,
        this.typageColis,
        this.natureColis,
        this.villeExp,
        this.villeDest,
        this.nombreJours});

  Data.fromJson(Map<String, dynamic> json) {
    colisNumber = json['colis_number'];
    colisShippementId = json['colis_shippement_id'];
    flightNumber = json['flight_number'];
    pickupCity = json['pickup_city'];
    destinationCity = json['destination_city'];
    kiloColis = json['kilo_colis'];
    montantColis = json['montant_colis'];
    nomDestinataire = json['nom_destinataire'];
    contactDestinataire = json['contact_destinataire'];
    statutColisRam = json['statut_colis_ram'];
    statutColisVerification = json['statut_colis_verification'];
    imageColis = json['image_colis'];
    qrCodeColis = json['qr_code_colis'];
    createdAt = json['created_at'];
    colisUserId = json['colis_user_id'];
    colisPriseId = json['colis_prise_id'];
    shipUid = json['ship_uid'];
    shipFlightNumber = json['ship_flight_number'];
    villeExpeditionId = json['ville_expedition_id'];
    villeDestinationId = json['ville_destination_id'];
    paysExpeditionId = json['pays_expedition_id'];
    paysDestinationId = json['pays_destination_id'];
    typeColisId = json['type_colis_id'];
    kiloTransporte = json['kilo_transporte'];
    totalMontantKilo = json['total_montant_kilo'];
    statutColisSoumis = json['statut_colis_soumis'];
    statutColisRamasse = json['statut_colis_ramasse'];
    statutColisExpedie = json['statut_colis_expedie'];
    statutColisLivre = json['statut_colis_livre'];
    statutVolShip = json['statut_vol_ship'];
    dateHeureDepart = json['date_heure_depart'];
    dateHeureArrive = json['date_heure_arrive'];
    shipVolId = json['ship_vol_id'];
    billetPhoto = json['billet_photo'];
    shipId = json['ship_id'];
    shipUserId = json['ship_user_id'];
    typageColis = json['typage_colis'];
    natureColis = json['nature_colis'];
    villeExp = json['ville_exp'];
    villeDest = json['ville_dest'];
    nombreJours = json['nombre_jours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['colis_number'] = this.colisNumber;
    data['colis_shippement_id'] = this.colisShippementId;
    data['flight_number'] = this.flightNumber;
    data['pickup_city'] = this.pickupCity;
    data['destination_city'] = this.destinationCity;
    data['kilo_colis'] = this.kiloColis;
    data['montant_colis'] = this.montantColis;
    data['nom_destinataire'] = this.nomDestinataire;
    data['contact_destinataire'] = this.contactDestinataire;
    data['statut_colis_ram'] = this.statutColisRam;
    data['statut_colis_verification'] = this.statutColisVerification;
    data['image_colis'] = this.imageColis;
    data['qr_code_colis'] = this.qrCodeColis;
    data['created_at'] = this.createdAt;
    data['colis_user_id'] = this.colisUserId;
    data['colis_prise_id'] = this.colisPriseId;
    data['ship_uid'] = this.shipUid;
    data['ship_flight_number'] = this.shipFlightNumber;
    data['ville_expedition_id'] = this.villeExpeditionId;
    data['ville_destination_id'] = this.villeDestinationId;
    data['pays_expedition_id'] = this.paysExpeditionId;
    data['pays_destination_id'] = this.paysDestinationId;
    data['type_colis_id'] = this.typeColisId;
    data['kilo_transporte'] = this.kiloTransporte;
    data['total_montant_kilo'] = this.totalMontantKilo;
    data['statut_colis_soumis'] = this.statutColisSoumis;
    data['statut_colis_ramasse'] = this.statutColisRamasse;
    data['statut_colis_expedie'] = this.statutColisExpedie;
    data['statut_colis_livre'] = this.statutColisLivre;
    data['statut_vol_ship'] = this.statutVolShip;
    data['date_heure_depart'] = this.dateHeureDepart;
    data['date_heure_arrive'] = this.dateHeureArrive;
    data['ship_vol_id'] = this.shipVolId;
    data['billet_photo'] = this.billetPhoto;
    data['ship_id'] = this.shipId;
    data['ship_user_id'] = this.shipUserId;
    data['typage_colis'] = this.typageColis;
    data['nature_colis'] = this.natureColis;
    data['ville_exp'] = this.villeExp;
    data['ville_dest'] = this.villeDest;
    data['nombre_jours'] = this.nombreJours;
    return data;
  }
}
