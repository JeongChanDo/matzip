package com.matzip.app.ktu.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.matzip.app.ktu.dao.KangNMapDao;
import com.matzip.app.ktu.domain.MatZipBean;


@Service
public class KangNMapServiceImpl implements KangNMapService {
	
	@Autowired
	private KangNMapDao kangNMapDao;

	@Override
	public String index(HttpServletRequest request, Model model) {

		List<MatZipBean> bean = kangNMapDao.matZipList();
		MatZipBean hanBean = kangNMapDao.matZipHanSearch();
		MatZipBean chaBean = kangNMapDao.matZipChaSearch();
		MatZipBean bunBean = kangNMapDao.matZipBunSearch();
		MatZipBean japBean = kangNMapDao.matZipJapSearch();
		MatZipBean etcBean = kangNMapDao.matZipEtcSearch();
		MatZipBean westBean = kangNMapDao.matZipWestSearch();
		
		model.addAttribute("bean", bean);
		model.addAttribute("hanBean", hanBean);
		model.addAttribute("chaBean", chaBean);
		model.addAttribute("bunBean", bunBean);
		model.addAttribute("japBean", japBean);
		model.addAttribute("etcBean", etcBean);
		model.addAttribute("westBean", westBean);
		return "areaSearch";
	}

	@Override
	public String loadView(String name,Model model) {
		
		
		String paramName = kangNMapDao.loadView(name);
		
		
		model.addAttribute("paramName",paramName);
		return "aaaaaa";
	}
	
	
}
