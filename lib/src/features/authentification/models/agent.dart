class Agent {
  int? id;
  String nomAgent;
  String prenomAgent;
  String email;
  DateTime? emailVerifiedAt;
  //String motDePasse;
  String? adresse;
  String telephone;
  //String rememberToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  Agent({
    this.id,
    required this.nomAgent,
    required this.prenomAgent,
    required this.email,
    this.emailVerifiedAt,
    //required this.motDePasse,
    this.adresse,
    required this.telephone,
    //required this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });

  Agent.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nomAgent = json['nomAgent'],
        prenomAgent = json['prenomAgent'],
        email = json['email'],
        //emailVerifiedAt = json['emailVerifiedAt'],
        adresse = json['adresse'],
        telephone = json['telephone'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
  //motDePasse = json['motDePasse'];
}
