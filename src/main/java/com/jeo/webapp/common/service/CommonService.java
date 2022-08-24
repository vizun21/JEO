package com.jeo.webapp.common.service;

import com.jeo.webapp.common.dao.CommonDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommonService {
	@Autowired CommonDao commonDao;
}
