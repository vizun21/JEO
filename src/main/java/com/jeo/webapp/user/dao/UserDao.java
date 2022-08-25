package com.jeo.webapp.user.dao;

import com.jeo.common.dao.AbstractDao;
import com.jeo.common.domain.LoginDTO;
import com.jeo.common.domain.LoginVO;
import com.jeo.user.domain.User;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class UserDao extends AbstractDao {
	private static String namespace = "user.user";

	public int userRegist(Map<String, Object> map) {
		return insert(namespace + ".userRegist", map);
	}

	public int ceoRegist(Map<String, Object> map) {
		return insert(namespace + ".ceoRegist", map);
	}

	public <T> T userItem(Map<String, Object> map) {
		return selectOne(namespace + ".userList", map);
	}

	public <T> List<T> userList(Map<String, Object> map) {
		return selectList(namespace + ".userList", map);
	}

	public int userDelete(Map<String, Object> map) {
		return delete(namespace + ".userDelete", map);
	}

	public int ceoDelete(Map<String, Object> map) {
		return delete(namespace + ".ceoDelete", map);
	}

	public LoginVO userLogin(LoginDTO dto) {
		return selectOne(namespace + ".userLogin", dto);
	}

	public LoginVO userTransform(LoginDTO dto) {
		return selectOne(namespace + ".userTransform", dto);
	}

	public int login(Map<String, Object> map) {
		return update(namespace + ".login", map);
	}

	public int userApproval(Map<String, Object> map) {
		return update(namespace + ".userApproval", map);
	}


	public <T> List<T> userPage(Map<String, Object> map) {
		return selectList(namespace + ".userPage", map);
	}

	public int userModify(Map<String, Object> map) {
		return update(namespace + ".userModify", map);
	}

	public int userChangePassword(Map<String, Object> map) {
		return update(namespace + ".userChangePassword", map);
	}

	public User selectUser(Map<String, Object> map) {
		return selectOne(namespace + ".selectUser", map);
	}

	public int updateUser(User user) {
		return update(namespace + ".updateUser", user);
	}
}
