package model;

import java.util.ArrayList;
import java.util.List;

public class DeficienciaMultipla extends Deficiencia {
    private List<Deficiencia> deficienciasCombinadas = new ArrayList<>();

    public DeficienciaMultipla(String descricao) {
        super(descricao, "Múltipla");
    }

    public void adicionarDeficiencias(Deficiencia def) {
        deficienciasCombinadas.add(def);
    }

    public void definirAdaptacoes() {
        for (Deficiencia deficiencia : deficienciasCombinadas) {
            deficiencia.definirAdaptacoes();
            getAdaptacoes().addAll(deficiencia.getAdaptacoes());
        }
    }
}

