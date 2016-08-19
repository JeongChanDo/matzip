package com.matzip.app.ktu.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface KangNMapService {
	public String index(HttpServletRequest request, Model model);
	
	public String loadView(String name, Model model);
}
