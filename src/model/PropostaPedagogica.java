package model;

public class PropostaPedagogica {
    private int id;
    private String area;
    private String objetivos;
    private String metodologias;
    private RecursosPedagogicos recursos;

    public PropostaPedagogica(String area, String objetivos, String metodologias, RecursosPedagogicos recursos) {
        this.area = area;
        this.objetivos = objetivos;
        this.metodologias = metodologias;
        this.recursos = recursos;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getObjetivos() {
        return objetivos;
    }

    public void setObjetivos(String objetivos) {
        this.objetivos = objetivos;
    }

    public String getMetodologias() {
        return metodologias;
    }

    public void setMetodologias(String metodologias) {
        this.metodologias = metodologias;
    }

    public RecursosPedagogicos getRecursos() {
        return recursos;
    }

    public void setRecursos(RecursosPedagogicos recursos) {
        this.recursos = recursos;
    }

    public void adicionarAoPlano(PlanoAEE plano, PropostaPedagogica proposta){
        plano.adicionarProposta(proposta);
    }
}
