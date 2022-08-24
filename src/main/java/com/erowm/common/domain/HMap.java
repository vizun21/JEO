package com.erowm.common.domain;

import java.io.Serializable;
import java.util.*;

public class HMap implements Cloneable, Serializable {
	private Map<String, Object> map = new LinkedHashMap<>();

	public HMap() { super(); }

	public void set(Map<String, Object> map) {
		try {
			this.putAll(map);
		} catch (Exception e) {
		}
	}

	public void put(String key, Object value) {
		map.put(key, value);
	}

	public void putAll(Map<? extends String, ? extends Object> m) {
		map.putAll(m);
	}

	public void putRequestAll(Map<? extends String, ? extends String[]> m) {
		Iterator<String> keys = (Iterator<String>) m.keySet().iterator();
		while (keys.hasNext()) {
			String key = keys.next();
			String[] values = m.get(key);
			map.put(key, values[0]);
		}
	}

	public Map<String, Object> getMap() {
		return map;
	}

	public String getString(String key) {
		return map.get(key).toString();
	}

	public int getInt(String key) {
		return Integer.parseInt(this.getString(key));
	}

	public List<String> getList(String key) {
		return (List<String>) map.get(key);
	}

	public String remove(String key) {
		if (!map.containsKey(key)) return null;
		return map.remove(key).toString();
	}

}
