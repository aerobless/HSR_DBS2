package exercise01;
public class Angestellter {
	private int persNr;
	private String name;
	private int salaer;

	public Angestellter(int persNr, String name, int salaer) {
		this.persNr = persNr;
		this.name = name;
		this.salaer = salaer;
	}

	public int getPersNr() {
		return persNr;
	}

	public void setPersNr(int persNr) {
		this.persNr = persNr;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getSalaer() {
		return salaer;
	}

	public void setSalaer(int salaer) {
		this.salaer = salaer;
	}

	@Override
	public String toString() {
		return persNr + "/" + name + "/" + salaer;
	}
}