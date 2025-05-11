// enum TiposLogin { email, cpf, telefone }

// class LoginDetails {
//   late final String hint;
//   late final String label;
//   late final Icon prefixIcon;
  

//   LoginDetails({
//     required this.hint,
//     required this.label,
//     required this.prefixIcon,
//   });

//   // é um metodo estático pois assim não força a classe a ser instanciada
//   static Map<TiposLogin, LoginDetails> loginDetails() {
//     return {
//       TiposLogin.cpf: LoginDetails(
//         hint: '111.111.111-11',
//         label: 'CPF',
//         prefixIcon: Icon(Icons.person),
//       ),
//       TiposLogin.email: LoginDetails(
//         hint: 'example@email.com',
//         label: 'E-mail',
//         prefixIcon: Icon(Icons.email),
//       ),
//       TiposLogin.telefone: LoginDetails(
//         hint: '15 11111111',
//         label: 'Telemóvel',
//         prefixIcon: Icon(Icons.phone),
//       ),
//     };
//   }
// }
