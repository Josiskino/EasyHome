import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../controllers/AgentController.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Variable pour contrôler l'état de chargement
  bool loading = false;

  String nomError = '';
  String prenomError = '';
  String phoneError = '';
  String emailError = '';

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      // Si loading est vrai, affichage du chargement
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/register.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 35, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Créer votre\nCompte',
                    style: TextStyle(color: Colors.white, fontSize: 33),
                  ),
                  const SizedBox(height: 140),
                  Form(
                    key: _formKey,
                    child: Container(
                      //margin: const EdgeInsets.symmetric(horizontal: 35),
                      padding: EdgeInsets.only(
                        top: 05.0,
                        bottom: 20.0,
                        left: 10.0,
                        right: 56.0,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: nomController,
                            decoration: InputDecoration(
                              fillColor: const Color.fromRGBO(245, 245, 245, 1),
                              filled: true,
                              hintText: "Entrer votre Nom",
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorText: nomError.isNotEmpty ? nomError : null,
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  nomError = 'Veuillez saisir votre nom';
                                } else {
                                  final alphaRegExp = RegExp(r'^[a-zA-Z]{2,}$');
                                  if (!alphaRegExp.hasMatch(value)) {
                                    nomError =
                                        'Veuillez saisir un nom valide (au moins deux caractères alphabétiques)';
                                  } else {
                                    nomError = '';
                                  }
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: prenomController,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Entrer votre Prénom",
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorText:
                                  prenomError.isNotEmpty ? prenomError : null,
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  prenomError = 'Veuillez saisir votre prénom';
                                } else {
                                  final alphaRegExp = RegExp(r'^[a-zA-Z]{2,}$');
                                  if (!alphaRegExp.hasMatch(value)) {
                                    prenomError =
                                        'Veuillez saisir un prénom valide (au moins deux caractères alphabétiques)';
                                  } else {
                                    prenomError = '';
                                  }
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(11),
                            ],
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Numéro de téléphone",
                              prefixIcon: Icon(Icons.phone),
                              prefix: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '+228',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              errorText:
                                  phoneError.isNotEmpty ? phoneError : null,
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  phoneError =
                                      'Veuillez saisir votre numéro de téléphone';
                                } else {
                                  final phone = value.replaceAll('+228', '');
                                  if (phone.length != 8) {
                                    phoneError =
                                        'Le numéro de téléphone doit contenir 8 chiffres';
                                  } else if (!RegExp(r'^[0-9]*$')
                                      .hasMatch(phone)) {
                                    phoneError =
                                        'Le numéro de téléphone doit contenir uniquement des chiffres';
                                  } else {
                                    phoneError = '';
                                  }
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: emailController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(Icons.email),
                              errorText:
                                  emailError.isNotEmpty ? emailError : null,
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  emailError = 'Veuillez saisir votre email';
                                } else {
                                  final emailRegExp = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                  if (!emailRegExp.hasMatch(value)) {
                                    emailError =
                                        'Veuillez saisir un email valide';
                                  } else {
                                    emailError = '';
                                  }
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Mot de passe",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(Icons.lock),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez saisir votre mot de passe';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 63),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'S\'inscrire',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color(0xff4c505b),
                                child: IconButton(
                                  color: Colors.white,
                                  onPressed: () async {
                                    // Activation de l'état de chargement avant la requête
                                    setState(() {
                                      loading = true;
                                    });

                                    Map<String, dynamic> agentData = {
                                      "nomAgent": nomController.text,
                                      "prenomAgent": prenomController.text,
                                      "email": emailController.text,
                                      "motDePasse": passwordController.text,
                                      "telephone": phoneController.text,
                                    };

                                    if (_formKey.currentState!.validate()) {
                                      // Soumission des données validées
                                      final resultat =
                                          await Provider.of<AuthController>(
                                        context,
                                        listen: false,
                                      ).registerAgent(agentData: agentData);

                                      print(resultat);

                                      // Désactivation de l'état de chargement après la requête
                                      setState(() {
                                        loading = false;
                                      });

                                      // Gestion de la réponse (succès ou échec)
                                      if (resultat == "ok") {
                                        // Boîte de dialogue de succès
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Colors
                                                  .green, // Couleur verte pour le succès
                                              title:
                                                  const Text('Compte créé !'),
                                              content: Row(
                                                children: [
                                                  const CircularProgressIndicator(),
                                                  const SizedBox(width: 20),
                                                  const Text(
                                                      'Votre compte a été créé \navec succès.'),
                                                ],
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context); // Ferme la boîte de dialogue de succès
                                                    Navigator.pushNamed(context,
                                                        'login'); // Redirige vers la page de connexion
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        // Boîte de dialogue d'échec
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Colors
                                                  .red, // Couleur rouge pour l'échec
                                              title: const Text(
                                                  'Echec de création'),
                                              content: Row(
                                                children: [
                                                  const Icon(Icons
                                                      .clear), // Icône de croix pour l'échec
                                                  const SizedBox(width: 20),
                                                  const Text(
                                                      'Echec de la création du compte.\nVeuillez réessayer.'),
                                                ],
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context); // Ferme la boîte de dialogue d'échec
                                                    // Redirige vers la page de création de compte
                                                    // Ici, tu pourrais utiliser la même page (MyRegister)
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    }
                                  },
                                  icon: const Icon(Icons.arrow_forward),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'login');
                                },
                                style: const ButtonStyle(),
                                child: const Text(
                                  'Se connecter',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
