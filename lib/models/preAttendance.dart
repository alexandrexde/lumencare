

class preForm{
  preForm({this.uid, this.nomeResponsavel, this.contatoMedico, this.responsavelFiscal, this.diagnostico, this.cpfLegal, this.ruaResp,
    this.numCasaResp, this.complementoResp, this.bairroResp, this.cidadeResp, this.cepResp, this.telefoneResp, this.emailLegal, this.hour
    ,  this.sexo, this.possuiResponsavel, this.telefone, this.cep, this.logradouro, this.bairro, this.cidade, this.estado, this.possuiExame, this.peso, this.altura, this.nomeMedico, this.especialidadeMedico, this.outrosMedicos, this.comoEncontrou, this.outrosEqp, this.quaisEqp, this.numCasa, this.complemento,});

  final String telefone;
  final String cep;
  final String logradouro;
  final String bairro;
  final String cidade;
  final String estado;
  final String sexo;
  final String possuiResponsavel;
  final String peso;
  final String altura;
  final String nomeMedico;
  final String possuiExame;
  final String especialidadeMedico;
  final String outrosMedicos;
  final String outrosEqp;
  final String comoEncontrou;
  final String quaisEqp;
  final String numCasa;
  final String complemento;
  String nomeResponsavel;
  String contatoMedico;
  String responsavelFiscal;
  Map<String, bool> diagnostico;
  String cpfLegal;
  String ruaResp;
  String numCasaResp;
  String complementoResp;
  String bairroResp;
  String cidadeResp;
  String cepResp;
  String telefoneResp;
  String emailLegal;
  DateTime hour;
  String uid;

  Map<String, dynamic> toMap() {
    return {
      //Page 1
      'Nome do Responsável Legal': nomeResponsavel,
      'Contato do médico': contatoMedico,
      'Gênero': sexo,
      'Possui Responsável?': possuiResponsavel,
      'Telefone': telefone,
      'CEP': cep,
      'Logradouro': logradouro,
      'Bairro': bairro,
      'Cidade': cidade,
      'Estado': estado,
      'Peso': peso,
      'Altura': altura,
      'Nome do médico responsável': nomeMedico,
      'Especialidade do médico': especialidadeMedico,
      'Outros médicos': outrosMedicos,
      'Como encontrou a Lumen?': comoEncontrou,
      'Faz uso de outros equipamentos?': outrosEqp,
      'Se respodeu sim, quais são?': quaisEqp,
      'Número do endereço': numCasa,
      'Complemento do endereço': complemento,
      //Page 2
      'Diagnostico': diagnostico,
      'Nome do responsável fiscal': responsavelFiscal,
      'CPF do responsável': cpfLegal,
      'Rua do responsável': ruaResp,
      'Número do responsável': numCasaResp,
      'Complemento do responsável': complementoResp,
      'Bairro do responsável': bairroResp,
      'Cidade do responsável': cidadeResp,
      'Cep do responsável': cepResp,
      'Telefone do responsável': telefoneResp,
      'Email do responsável': emailLegal,
      'Hora da requisição': hour,
      'UID' : uid,
    };
  }

}