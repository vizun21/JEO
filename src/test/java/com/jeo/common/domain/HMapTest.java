package com.jeo.common.domain;

import org.junit.Test;

import java.util.HashMap;
import java.util.Map;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

public class HMapTest {
	@Test
	public void putRequestAll() {
		Map<String, String[]> map = new HashMap<>();
		String[] user_id = {"vizun21"};
		String[] user_name = {"최인호", "최한나"};

		map.put("user_id", user_id);
		map.put("user_name", user_name);
		HMap hmap = new HMap();
		hmap.putRequestAll(map);

		assertThat(hmap.getString("user_id"), is("vizun21"));
		assertThat(hmap.getString("user_name"), is("최인호"));
	}
}
