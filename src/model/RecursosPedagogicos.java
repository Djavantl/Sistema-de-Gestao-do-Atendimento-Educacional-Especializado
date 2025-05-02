package model;

import java.util.Scanner;

public class RecursosPedagogicos {
    private int id;
    private boolean Atitudinal;
    private boolean conscientizacaoSobreAcessibilidade;
    private boolean auxilioOrientacaoMobilidade;

    private boolean FisicoArquitetonico;
    private boolean usoCadeiraDeRodas;
    private boolean auxilioTranscricaoEscrita;
    private boolean mesaAdaptadaCadeiraDeRodas;
    private boolean usoDeMuleta;
    private boolean outrosFisicoArquitetonico;

    private boolean Comunicacaoeinformacao;
    private boolean comunicacaoAlternativa;
    private boolean tradutorInterprete;
    private boolean leitorTranscritor;
    private boolean interpreteOralizador;
    private boolean guiaInterprete;
    private boolean materialDidaticoBraille;
    private boolean materialDidaticoTextoAmpliado;
    private boolean materialDidaticoRelevo;
    private boolean leitorDeTela;
    private boolean fonteTamanhoEspecifico;

    private boolean Pedagogica;
    private boolean adaptacaoDidaticaAulasAvaliacoes;
    private boolean materialDidaticoAdaptado;
    private boolean usoTecnologiaAssistiva;
    private boolean tempoEmpregadoAtividadesAvaliacoes;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String outrosEspecificado;

    public int getId() { return id; }

    public void setId(int id) { this.id = id; }

    public boolean isAtitudinal() { return Atitudinal; }

    public void setAtitudinal(boolean atitudinal) { Atitudinal = atitudinal; }

    public boolean isConscientizacaoSobreAcessibilidade() { return conscientizacaoSobreAcessibilidade; }

    public void setConscientizacaoSobreAcessibilidade(boolean conscientizacaoSobreAcessibilidade) { this.conscientizacaoSobreAcessibilidade = conscientizacaoSobreAcessibilidade; }

    public boolean isAuxilioOrientacaoMobilidade() { return auxilioOrientacaoMobilidade; }

    public void setAuxilioOrientacaoMobilidade(boolean auxilioOrientacaoMobilidade) { this.auxilioOrientacaoMobilidade = auxilioOrientacaoMobilidade; }

    public boolean isFisicoArquitetonico() { return FisicoArquitetonico; }

    public void setFisicoArquitetonico(boolean fisicoArquitetonico) { FisicoArquitetonico = fisicoArquitetonico; }

    public boolean isUsoCadeiraDeRodas() { return usoCadeiraDeRodas; }

    public void setUsoCadeiraDeRodas(boolean usoCadeiraDeRodas) { this.usoCadeiraDeRodas = usoCadeiraDeRodas; }

    public boolean isAuxilioTranscricaoEscrita() { return auxilioTranscricaoEscrita; }

    public void setAuxilioTranscricaoEscrita(boolean auxilioTranscricaoEscrita) { this.auxilioTranscricaoEscrita = auxilioTranscricaoEscrita; }

    public boolean isMesaAdaptadaCadeiraDeRodas() { return mesaAdaptadaCadeiraDeRodas; }

    public void setMesaAdaptadaCadeiraDeRodas(boolean mesaAdaptadaCadeiraDeRodas) { this.mesaAdaptadaCadeiraDeRodas = mesaAdaptadaCadeiraDeRodas; }

    public boolean isUsoDeMuleta() { return usoDeMuleta; }

    public void setUsoDeMuleta(boolean usoDeMuleta) { this.usoDeMuleta = usoDeMuleta; }

    public boolean isOutrosFisicoArquitetonico() { return outrosFisicoArquitetonico; }

    public void setOutrosFisicoArquitetonico(boolean outrosFisicoArquitetonico) { this.outrosFisicoArquitetonico = outrosFisicoArquitetonico; }

    public boolean isComunicacaoeinformacao() { return Comunicacaoeinformacao; }

    public void setComunicacaoeinformacao(boolean comunicacaoeinformacao) { Comunicacaoeinformacao = comunicacaoeinformacao; }

    public boolean isComunicacaoAlternativa() { return comunicacaoAlternativa; }

    public void setComunicacaoAlternativa(boolean comunicacaoAlternativa) { this.comunicacaoAlternativa = comunicacaoAlternativa; }

    public boolean isTradutorInterprete() { return tradutorInterprete; }

    public void setTradutorInterprete(boolean tradutorInterprete) { this.tradutorInterprete = tradutorInterprete; }

    public boolean isLeitorTranscritor() { return leitorTranscritor; }

    public void setLeitorTranscritor(boolean leitorTranscritor) { this.leitorTranscritor = leitorTranscritor; }

    public boolean isInterpreteOralizador() { return interpreteOralizador; }

    public void setInterpreteOralizador(boolean interpreteOralizador) { this.interpreteOralizador = interpreteOralizador; }

    public boolean isGuiaInterprete() { return guiaInterprete; }

    public void setGuiaInterprete(boolean guiaInterprete) { this.guiaInterprete = guiaInterprete; }

    public boolean isMaterialDidaticoBraille() { return materialDidaticoBraille; }

    public void setMaterialDidaticoBraille(boolean materialDidaticoBraille) { this.materialDidaticoBraille = materialDidaticoBraille; }

    public boolean isMaterialDidaticoTextoAmpliado() { return materialDidaticoTextoAmpliado; }

    public void setMaterialDidaticoTextoAmpliado(boolean materialDidaticoTextoAmpliado) { this.materialDidaticoTextoAmpliado = materialDidaticoTextoAmpliado; }

    public boolean isMaterialDidaticoRelevo() { return materialDidaticoRelevo; }

    public void setMaterialDidaticoRelevo(boolean materialDidaticoRelevo) { this.materialDidaticoRelevo = materialDidaticoRelevo; }

    public boolean isLeitorDeTela() { return leitorDeTela; }

    public void setLeitorDeTela(boolean leitorDeTela) { this.leitorDeTela = leitorDeTela; }

    public boolean isFonteTamanhoEspecifico() { return fonteTamanhoEspecifico; }

    public void setFonteTamanhoEspecifico(boolean fonteTamanhoEspecifico) { this.fonteTamanhoEspecifico = fonteTamanhoEspecifico; }

    public boolean isPedagogica() { return Pedagogica; }

    public void setPedagogica(boolean pedagogica) { Pedagogica = pedagogica; }

    public boolean isAdaptacaoDidaticaAulasAvaliacoes() { return adaptacaoDidaticaAulasAvaliacoes; }

    public void setAdaptacaoDidaticaAulasAvaliacoes(boolean adaptacaoDidaticaAulasAvaliacoes) { this.adaptacaoDidaticaAulasAvaliacoes = adaptacaoDidaticaAulasAvaliacoes; }

    public boolean isMaterialDidaticoAdaptado() { return materialDidaticoAdaptado; }

    public void setMaterialDidaticoAdaptado(boolean materialDidaticoAdaptado) { this.materialDidaticoAdaptado = materialDidaticoAdaptado; }

    public boolean isUsoTecnologiaAssistiva() { return usoTecnologiaAssistiva; }

    public void setUsoTecnologiaAssistiva(boolean usoTecnologiaAssistiva) { this.usoTecnologiaAssistiva = usoTecnologiaAssistiva; }

    public boolean isTempoEmpregadoAtividadesAvaliacoes() { return tempoEmpregadoAtividadesAvaliacoes; }

    public void setTempoEmpregadoAtividadesAvaliacoes(boolean tempoEmpregadoAtividadesAvaliacoes) { this.tempoEmpregadoAtividadesAvaliacoes = tempoEmpregadoAtividadesAvaliacoes; }

    public String getOutrosEspecificado() { return outrosEspecificado; }

    public void setOutrosEspecificado(String outrosEspecificado) { this.outrosEspecificado = outrosEspecificado; }

    public void recursosAtitudinal (boolean Atitudinal){
        Scanner scanner = new Scanner(System.in);
        if (Atitudinal == true) {
            System.out.println("Necessidade de conscientização sobre acessibilidade?");
            setConscientizacaoSobreAcessibilidade(scanner.nextLine().equalsIgnoreCase("sim"));

            System.out.println("Auxílio para orientação e mobilidade?");
            setAuxilioOrientacaoMobilidade(scanner.nextLine().equalsIgnoreCase("sim"));
        } else {
            System.out.println("Certo. Sem ajuda Atitudinal.");
        }

    }
    public void recursosFisicoArquitetonico(boolean fisicoArquitetonico) {
        Scanner scanner = new Scanner(System.in);
        if (fisicoArquitetonico == true) {
            System.out.println("Uso de cadeira de rodas?");
            setUsoCadeiraDeRodas(scanner.nextLine().equalsIgnoreCase("sim"));

            System.out.println("Auxílio para transcrição por dificuldade motora na escrita?");
            setAuxilioTranscricaoEscrita(scanner.nextLine().equalsIgnoreCase("sim"));

            System.out.println("Mesa adaptada para cadeira de rodas?");
            setMesaAdaptadaCadeiraDeRodas(scanner.nextLine().equalsIgnoreCase("sim"));

            System.out.println("Uso de muleta?");
            setUsoDeMuleta(scanner.nextLine().equalsIgnoreCase("sim"));

            System.out.println("Outros recursos físico-arquitetônicos?");
            boolean outros = scanner.nextLine().equalsIgnoreCase("sim");
            setOutrosFisicoArquitetonico(outros);

            if (outros) {
                System.out.println("Especifique os outros recursos físico-arquitetônicos:");
                setOutrosEspecificado(scanner.nextLine());
            }
        } else {
            System.out.println("Certo. Sem ajuda físico-arquitetônica.");
        }
    }

    public void recursosComunicacaoEInformacao(boolean comunicacaoEInformacao) {
        Scanner scanner = new Scanner(System.in);
        if (comunicacaoEInformacao == true) {
            System.out.println("Uso de comunicação alternativa?");
            setComunicacaoAlternativa(scanner.nextLine().equalsIgnoreCase("sim"));

            System.out.println("Necessidade de tradutor/intérprete de Libras?");
            setTradutorInterprete(scanner.nextLine().equalsIgnoreCase("sim"));

            System.out.println("Leitor ou transcritor?");
            setLeitorTranscritor(scanner.nextLine().equalsIgnoreCase("sim"));

            System.out.println("Intérprete oralizador?");
            setInterpreteOralizador(scanner.nextLine().equalsIgnoreCase("sim"));

            System.out.println("Guia-intérprete?");
            setGuiaInterprete(scanner.nextLine().equalsIgnoreCase("sim"));

            System.out.println("Material didático em Braille?");
            setMaterialDidaticoBraille(scanner.nextLine().equalsIgnoreCase("sim"));

            System.out.println("Material didático com texto ampliado?");
            setMaterialDidaticoTextoAmpliado(scanner.nextLine().equalsIgnoreCase("sim"));

            System.out.println("Material didático em relevo?");
            setMaterialDidaticoRelevo(scanner.nextLine().equalsIgnoreCase("sim"));

            System.out.println("Uso de leitor de tela?");
            setLeitorDeTela(scanner.nextLine().equalsIgnoreCase("sim"));

            System.out.println("Fonte em tamanho específico?");
            setFonteTamanhoEspecifico(scanner.nextLine().equalsIgnoreCase("sim"));
        } else {
            System.out.println("Certo. Sem ajuda de comunicação e informação.");
        }
    }

    public void recursosPedagogicos(boolean pedagogica) {
        Scanner scanner = new Scanner(System.in);
        if (pedagogica == true) {
            System.out.println("Adaptação didática durante aulas ou avaliações?");
            setAdaptacaoDidaticaAulasAvaliacoes(scanner.nextLine().equalsIgnoreCase("sim"));

            System.out.println("Material didático adaptado?");
            setMaterialDidaticoAdaptado(scanner.nextLine().equalsIgnoreCase("sim"));

            System.out.println("Uso de tecnologia assistiva durante aulas ou avaliações?");
            setUsoTecnologiaAssistiva(scanner.nextLine().equalsIgnoreCase("sim"));

            System.out.println("Tempo adicional para realização de atividades e avaliações?");
            setTempoEmpregadoAtividadesAvaliacoes(scanner.nextLine().equalsIgnoreCase("sim"));
        } else {
            System.out.println("Certo. Sem ajuda pedagógica.");
        }
    }
}
