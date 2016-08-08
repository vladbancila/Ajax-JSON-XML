package service;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import domain.Masina;

public class Service {

	private static List<Masina> masini = new ArrayList<Masina>();

	static {

		masini.add(new Masina("Maserati", "Quattro Porte", 100000.00));
		masini.add(new Masina("Audi", "R8", 70000.00));
		masini.add(new Masina("Ferrari", "Enzo", 300000.00));
		masini.add(new Masina("Lamborghini", "Veneno", 1500000.00));
	}

	public static String getMasiniJSON(){
		
		ObjectMapper mapper = new ObjectMapper();
		
		try {
			
			String json = mapper.writeValueAsString(masini);
			System.out.println(json);
			return json;
			
		} catch (JsonProcessingException e) {
			
			e.printStackTrace();
			return null;
		}
		
	}
	
}






