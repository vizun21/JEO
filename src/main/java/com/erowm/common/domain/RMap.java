package com.erowm.common.domain;

import java.util.ArrayList;
import java.util.LinkedHashMap;

public class RMap extends LinkedHashMap<Object, Object> {
	public Object put(Object key, Object value) {
		if (value.getClass().equals(ArrayList.class))
			return super.put(key.toString().toLowerCase(), value);
		else
			return super.put(key.toString().toLowerCase(), String.valueOf(value));
	}
}