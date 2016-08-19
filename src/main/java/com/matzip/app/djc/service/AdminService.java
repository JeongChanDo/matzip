package com.matzip.app.djc.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.matzip.app.commons.MongoCommonsDao;
import com.matzip.app.djc.domain.LogBean;

@Service
public class AdminService {

	@Autowired
	MongoCommonsDao mongoCommonsDao;
	
	public List<LogBean> getLogAboutId(String id){
		return mongoCommonsDao.getLogAboutId(id);
	}
	
	
	public List<LogBean> getThirtyLogs(int number){
		return mongoCommonsDao.getThirtyLogs(number);
	}
	
	public List<LogBean> getThirtySearchedLogs(String keyword,int number, int i){
		return mongoCommonsDao.getThirtySearchedLogs(keyword,number, i);
	}
	
	public void adminPageNo1RequestProcess(HttpServletRequest request){
		mongoCommonsDao.adminPageNo1RequestProcess(request);
	}
	
}
