package com.pe.colegio.util;

import java.util.Map;

public class Util {

	public static Object getValueFromKey(Map<String,String> hm, String key) {
		
		for (Map.Entry<String, String> entry : hm.entrySet()){				
			if(entry.getKey().equals(key))
			{					
		        return entry.getValue();
			}
		}
		
		return null;
	}
}
