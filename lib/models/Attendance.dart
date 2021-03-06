
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
      'Ocupa????o Atual': ocupacao,
      'Diagn??stico m??dico': diagAttendance,
      //Page 2
      'Queixa principal': queixaPrincipal,
      'Hist??rico atual e pregresso da doen??a': historicoAtual,
      'J?? realizou cirurgia?': qualCirurgia,
      'Faz uso de medica????o?': medicacao,
      'Processo da doen??a': processoDoenca,
      'Qual motivo da avalia????o?': motivoAvaliacao,
      //Page 3
      'Onde o usu??rio utilizar?? a cadeira de rodas?': usoCadeira,
      'Distancia percorrida por dia': distanciaPercorrida,
      'Hora de uso da cadeira de rodas por dia': horaUtilizada,
      'Quando fora da cadeira de rodas, onde o usu??rio senta ou deita?': qualAssento,
      'Quando fora da cadeira de rodas, onde o usu??rio senta ou deita?(Outros)': descAssento,
      'Como o usu??rio senta ou deita (posi????o e superf??cie)': comoSenta,
      'Tipo de banheiro': qualBanheiro,
      'Tipo de banheiro(Outros)': descBanheiro,
      //Page 4
      'Senta na cadeira de rodas durante o transporte?': descSenta,
      'O usu??rio usa transporte p??blico/privado com regularidade?': usaTransporte,
      'Reside com algu??m?': descReside,
      'Resid??ncia': tipoResidencia,
      'Entrada': tipoEntrada,
      'Banheiro': acessibilidadeBanheiro,
      '??rea de conviv??ncia': acessibilidadeArea,
      'Portas': acessibilidadePorta,
      //Page 5
      'A cadeira de rodas atende ??s necessidades do usu??rio?':atendeNecessidadeStr,
      'A cadeira de rodas atende ??s condi????es do ambiente do usu??rio?':atendeCondicoesStr,
      'A cadeira de rodas ?? adequada e oferece suporte postural?':seguraStr,
      'A cadeira de rodas ?? segura e dur??vel?':adequadaStr,
      'A almofada oferece al??vio adequado da press??o (se o usu??rio corre risco de desenvolver ??ceras/feridas)?':ofereceAlivioStr,
      //Page 6
      'Lateralidade manual':lateralidadeManual,
      'Condi????o visual':condicaoVisual,
      'Condi????o auditiva':condicaoAuditiva,
      'Condi????o cognitiva':condicaoCognitiva,
      'Express??o':expressao,
      'Recep????o':recepcao,
      //Page 7
      'Possui Sistema de Comunica????o Suplementar ou Alternativa?':sistemaSuplementar,
      'Condi????o psicossocial e comportamental':condicaoPsico,
      'Condi????o respirat??ria':condicaoResp,
      'Condi????o respirat??ria(Condi????o severa)':condSeveraStr,
      'Equipamentos respirat??rios':eqpRespiratorio,
      'Presen??a de dor':presencaDor,
      '??lceras': ulcera,
      'Possui ??lcera(detalhes)': possuiUlcera,
      //Page 8
      'Alimenta????o':alimentacao,
      'Vestir-se / despir-se':vestirse,
      'Banho':banho,
      'Higi??ne pessoal':higiene,
      'Controle vesical':controleVesical,
      'Controle intestinal':controleIntestinal,
      'Condi????o neuromotora':condMotora,
      'Reflexos':reflexo,
      'D??ficit neurol??gico':deficit,
      //Page 9
      'T??nus Muscular': tonus,
      //Page 10
      'Joelho direito': joelhoDireito,
      'Joelho esquerdo': joelhoEsquerdo,
      'Postura': postura,

      'Hora da requisi????o': hour,
      'UID' : uid,
    };
  }

}