package com.jeo.webapp.user.service;

import com.jeo.common.config.Define;
import com.jeo.common.domain.HMap;
import com.jeo.webapp.comp.service.CompService;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.Map;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"/config/spring/application-context.xml", "/config/spring/security-context.xml"})
public class UserServiceTest {
	@Autowired UserService userService;
	@Autowired CompService compService;
	HMap param1 = new HMap();
	HMap param2 = new HMap();

	@Before
	public void setUp() {
		param1.put("comp_type", "P");
		param1.put("comp_reg_numb_1", "418");
		param1.put("comp_reg_numb_2", "01");
		param1.put("comp_reg_numb_3", "88316");
		param1.put("comp_name", "이소프트");
		param1.put("user_id", "test_user");
		param1.put("user_pw", "qwer1234");
		param1.put("user_name", "최인호");
		param1.put("user_email", "vizun21@hanmail.net");
		param1.put("user_tel", "");
		param1.put("user_mobile", "010-3495-1580");
		param1.put("user_reg_numb_1", "660131");
		param1.put("user_reg_numb_2", "1111111");

		param2.put("comp_type", "C");
		param2.put("comp_reg_numb_1", "123");
		param2.put("comp_reg_numb_2", "12");
		param2.put("comp_reg_numb_3", "12312");
		param2.put("comp_name", "테스트사업장");
		param2.put("user_id", "test_user1");
		param2.put("user_pw", "qwer1234");
		param2.put("user_name", "홍길동");
		param2.put("user_email", "test_user1@hanmail.net");
		param2.put("user_tel", "010-1234-5678");
		param2.put("user_mobile", "010-1234-5678");
		param2.put("user_reg_numb_1", "950101");
		param2.put("user_reg_numb_2", "1111111");
	}

	@Test
	public void registCompAndUser() {
		deleteCompAndUserAll();
		assertThat(getCompCount(), is(0));

		compService.compUserRegist(param1);
		assertThat(getCompCount(), is(1));

		compService.compUserRegist(param2);
		assertThat(getCompCount(), is(2));
	}

	@Test(expected = DuplicateKeyException.class)
	public void userOverlapTest() {
		deleteCompAndUserAll();
		assertThat(getCompCount(), is(0));

		compService.compUserRegist(param1);
		assertThat(getCompCount(), is(1));

		param2.put(Define.USER_ID, param1.getString(Define.USER_ID));
		compService.compUserRegist(param2);
		assertThat(getCompCount(), is(1));
	}

	private int getCompCount() {
		List<Map> list = compService.compList(new HMap());
		return list.size();
	}

	private void deleteCompAndUserAll() {
		List<Map> list = compService.compList(new HMap());
		for (Map map : list) {
			HMap param = new HMap();
			param.put(Define.COMP_CODE, map.get(Define.COMP_CODE));
			List<Map> users = userService.userList(param);
			for (Map user : users) {
				param.put(Define.USER_ID, user.get(Define.USER_ID));
				userService.ceoDelete(param);
				userService.userDelete(param);
			}
			compService.compDelete(param);
		}
	}

}
