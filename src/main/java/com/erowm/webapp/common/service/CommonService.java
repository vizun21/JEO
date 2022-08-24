package com.erowm.webapp.common.service;

import com.erowm.webapp.common.dao.CommonDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommonService {
	@Autowired CommonDao commonDao;
}
