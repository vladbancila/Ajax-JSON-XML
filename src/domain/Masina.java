package domain;

public class Masina {

	private int id;
	private String marca;
	private String model;
	private double pret;
	
	private static int counter = 0;
	
	public Masina(String marca, String model, double pret) {
		super();
		this.id = ++counter;
		this.marca = marca;
		this.model = model;
		this.pret = pret;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMarca() {
		return marca;
	}

	public void setMarca(String marca) {
		this.marca = marca;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public double getPret() {
		return pret;
	}

	public void setPret(double pret) {
		this.pret = pret;
	}

	@Override
	public String toString() {
		return "Masina [id=" + id + ", marca=" + marca + ", model=" + model + ", pret=" + pret + "]";
	}
	
	
	
}
