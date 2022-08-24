package com.jeo.webapp.user.join.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
public class UserJoinController {
	@RequestMapping(value = "/user/join/comp", method = RequestMethod.GET)
	public void joinCompGET(Map map, HttpServletRequest request) {
	}

	@RequestMapping(value = "/user/join/person", method = RequestMethod.GET)
	public void joinPersonGET(Map map, HttpServletRequest request) {
	}
}
