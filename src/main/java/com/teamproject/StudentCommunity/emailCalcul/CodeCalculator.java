package com.teamproject.StudentCommunity.emailCalcul;

import java.util.Random;

public class CodeCalculator {
	
	Random random = new Random();
	StringBuilder key = new StringBuilder("");

	
	public String codeCalculator() {
		
		for(int i = 0; i<3; i++) {
			
			int index = random.nextInt(25)+65;
			int numIndex = random.nextInt(10);
			//key += (char)index;
			key.append((char)index);
			key.append(numIndex);
		}
		
		return key.toString();
	}

}
