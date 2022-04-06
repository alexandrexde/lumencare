
class FormATT {
  FormATT({this.hour, this.uid, this.postura, this.deficit, this.estadoMatrimonial, this.grauEscolaridade, this.ocupacao, this.diagAttendance, this.queixaPrincipal, this.historicoAtual, this.qualCirurgia, this.medicacao, this.descAmput, this.processoDoenca, this.motivoAvaliacao,
    this.usoCadeira, this.descLocal, this.descAssento, this.distanciaPercorrida, this.horaUtilizada, this.qualAssento, this.qualBanheiro, this.comoSenta, this.descBanheiro, this.acessibilidadePorta, this.acessibilidadeArea, this.acessibilidadeBanheiro, this.tipoEntrada, this.tipoResidencia, this.descReside,
    this.quaisTransporte, this.descSenta, this.usaTransporte, this.atendeNecessidadeStr, this.atendeCondicoesStr, this.seguraStr, this.adequadaStr, this.ofereceAlivioStr, this.condicaoAuditiva, this.condicaoCognitiva, this.condicaoVisual, this.expressao,
    this.lateralidadeManual, this.recepcao, this.condicaoResp, this.eqpRespiratorio, this.condSeveraStr, this.condicaoPsico, this.presencaDor, this.sistemaSuplementar, this.ulcera, this.alimentacao, this.banho, this.condMotora, this.controleIntestinal, this.controleVesical, this.higiene, this.reflexo, this.vestirse, this.tonus,
  this.joelhoDireito, this.joelhoEsquerdo, this.possuiUlcera});

  final String estadoMatrimonial, grauEscolaridade, ocupacao, diagAttendance, queixaPrincipal, historicoAtual, qualCirurgia, medicacao, descAmput, processoDoenca,
      descAssento, descLocal, distanciaPercorrida, horaUtilizada,  comoSenta, descBanheiro, descSenta, usaTransporte, descReside, tipoResidencia, tipoEntrada, acessibilidadeBanheiro,
      acessibilidadeArea, acessibilidadePorta, atendeNecessidadeStr, atendeCondicoesStr, seguraStr, ofereceAlivioStr, adequadaStr, lateralidadeManual, condicaoVisual, condicaoAuditiva, condicaoCognitiva, expressao, recepcao,
      condicaoPsico, condSeveraStr, presencaDor, alimentacao, vestirse, banho, higiene, controleVesical, controleIntestinal, condMotora, reflexo, deficit, joelhoDireito, joelhoEsquerdo;
  final Map<String, bool>  qualBanheiro, motivoAvaliacao, usoCadeira, qualAssento, quaisTransporte, condicaoResp;
  final Map<String, String> tonus, possuiUlcera;
  final Map<String, dynamic> postura;
  final List<String> sistemaSuplementar;
  final List<Map<String, String>> eqpRespiratorio, ulcera;
  DateTime hour;
  String uid;

  Map<String, dynamic> toMap() {
    return {
      //Page 1
      'Estado Matrimonial Atual': estadoMatrimonial,
      'Grau de escolaridade atual': grauEscolaridade,
      'Ocupação Atual': ocupacao,
      'Diagnóstico médico': diagAttendance,
      //Page 2
      'Queixa principal': queixaPrincipal,
      'Histórico atual e pregresso da doença': historicoAtual,
      'Já realizou cirurgia?': qualCirurgia,
      'Faz uso de medicação?': medicacao,
      'Processo da doença': processoDoenca,
      'Qual motivo da avaliação?': motivoAvaliacao,
      //Page 3
      'Onde o usuário utilizará a cadeira de rodas?': usoCadeira,
      'Distancia percorrida por dia': distanciaPercorrida,
      'Hora de uso da cadeira de rodas por dia': horaUtilizada,
      'Quando fora da cadeira de rodas, onde o usuário senta ou deita?': qualAssento,
      'Quando fora da cadeira de rodas, onde o usuário senta ou deita?(Outros)': descAssento,
      'Como o usuário senta ou deita (posição e superfície)': comoSenta,
      'Tipo de banheiro': qualBanheiro,
      'Tipo de banheiro(Outros)': descBanheiro,
      //Page 4
      'Senta na cadeira de rodas durante o transporte?': descSenta,
      'O usuário usa transporte público/privado com regularidade?': usaTransporte,
      'Reside com alguém?': descReside,
      'Residência': tipoResidencia,
      'Entrada': tipoEntrada,
      'Banheiro': acessibilidadeBanheiro,
      'Área de convivência': acessibilidadeArea,
      'Portas': acessibilidadePorta,
      //Page 5
      'A cadeira de rodas atende às necessidades do usuário?':atendeNecessidadeStr,
      'A cadeira de rodas atende às condições do ambiente do usuário?':atendeCondicoesStr,
      'A cadeira de rodas é adequada e oferece suporte postural?':seguraStr,
      'A cadeira de rodas é segura e durável?':adequadaStr,
      'A almofada oferece alívio adequado da pressão (se o usuário corre risco de desenvolver úceras/feridas)?':ofereceAlivioStr,
      //Page 6
      'Lateralidade manual':lateralidadeManual,
      'Condição visual':condicaoVisual,
      'Condição auditiva':condicaoAuditiva,
      'Condição cognitiva':condicaoCognitiva,
      'Expressão':expressao,
      'Recepção':recepcao,
      //Page 7
      'Possui Sistema de Comunicação Suplementar ou Alternativa?':sistemaSuplementar,
      'Condição psicossocial e comportamental':condicaoPsico,
      'Condição respiratória':condicaoResp,
      'Condição respiratória(Condição severa)':condSeveraStr,
      'Equipamentos respiratórios':eqpRespiratorio,
      'Presença de dor':presencaDor,
      'Úlceras': ulcera,
      'Possui úlcera(detalhes)': possuiUlcera,
      //Page 8
      'Alimentação':alimentacao,
      'Vestir-se / despir-se':vestirse,
      'Banho':banho,
      'Higiêne pessoal':higiene,
      'Controle vesical':controleVesical,
      'Controle intestinal':controleIntestinal,
      'Condição neuromotora':condMotora,
      'Reflexos':reflexo,
      'Déficit neurológico':deficit,
      //Page 9
      'Tônus Muscular': tonus,
      //Page 10
      'Joelho direito': joelhoDireito,
      'Joelho esquerdo': joelhoEsquerdo,
      'Postura': postura,

      'Hora da requisição': hour,
      'UID' : uid,
    };
  }

}