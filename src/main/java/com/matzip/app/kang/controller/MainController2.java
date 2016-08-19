package com.matzip.app.kang.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.matzip.app.ktu.service.KangNMapService;


@Controller
public class MainController2 {
	
	
	@Autowired
	private KangNMapService kangNMapService;
	
	@RequestMapping(value={"areaSearch"}, method=RequestMethod.GET)
	public String index(HttpServletRequest request, Model model){
		return kangNMapService.index(request, model);
	}
	
	@RequestMapping(value={"roadView"}, method=RequestMethod.GET)
	public String loadView(String name, Model model){
		return kangNMapService.loadView(name, model);
	}


}